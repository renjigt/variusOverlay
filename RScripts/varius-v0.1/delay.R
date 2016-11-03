# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Authors: Brian Greskamp, Smruti Sarangi, Radu Tedorescu, Jun Nakano


source('global.R')
library('stats')
library('numDeriv')


#######################################################################
###################### Tuning and configuration #######################
#######################################################################


USE_FAST_MAX <- TRUE         # If TRUE, use fast analytical approximation for
                             # distribution of the max of N IID Gaussians
                             # (RECOMMENDED)
LOGIC_PATH_WIRE_FRAC <- 0.35 # The fraction of logic delay that is due to
                             # wire delay (unaffected by transistor variation)
MEM_PATH_LOGIC_FRAC <- 0.35  # The fraction of SRAM read time that is logic
                             # (decode + mux) dominated
FO4_PER_STAGE <- 16          # Number of FO4 gate delays per stage
# Mean and standard deviation of critical path delay for a pure logic
# stage with *no* process variation.  Derived from the RAZOR multiplier
# experimental data
D_LOGIC <- list(mean=0.849, sd=0.019)


#######################################################################
###################### Logic delay computations #######################
#######################################################################


# CDF of delay distribution for a logic stage in the presence of process
# variation evaluated at clock periods t_R
cdf_D_varlogic <- function(L_sys, Vt_sys, T, Vdd, t_R)
{
    cdf(D_varlogic, t_R, L_sys, Vt_sys, T, Vdd)
}

# Delay distribution for a pure logic stage in the presence of variation
D_varlogic <- function(L_sys, Vt_sys, T, Vdd)
{
    LOGIC_PATH_LOGIC_FRAC <- 1 - LOGIC_PATH_WIRE_FRAC

    eta <- gate_delay(L_sys, Vt_sys, T, Vdd)
    extra <- D_extra(L_sys, Vt_sys, T, Vdd)
    mean <- LOGIC_PATH_LOGIC_FRAC * (eta * D_LOGIC$mean + extra$mean) +
            LOGIC_PATH_WIRE_FRAC * D_LOGIC$mean
    sd   <- LOGIC_PATH_LOGIC_FRAC * (eta * D_LOGIC$sd + extra$sd) +
            LOGIC_PATH_WIRE_FRAC * D_LOGIC$sd
    list(mean=mean, sd=sd)
}

# The logic delay variation due to random within-unit parameter variation
D_extra <- function(L_sys, Vt_sys, T, Vdd)
{
    f <- function(vec) { gate_delay(vec[1], vec[2], T, Vdd) }
    tmp <- D_f_norm(f, means=c(L_sys, Vt_sys),
                       sds=c(SIGMA_L_RAND, SIGMA_VT_RAND))
    list(mean=(tmp$mean - gate_delay(L_sys, Vt_sys, T, Vdd)) * FO4_PER_STAGE,
         sd=tmp$sd / sqrt(FO4_PER_STAGE))
}

# Compute *normalized* delay for a logic cell.  A cell at nominal supply
# voltage (VDD0), temperature (T0), length (1), and Vt (VT0) has a delay of 1.
gate_delay <- function(L_eff, Vth, T, Vdd)
{
    gate_delay_abs <- function(L_eff, Vth, T, Vdd)
    {
        (Vdd * L_eff * T^MOBIL) /
        (Vdd - (Vth + DVT_DT * (T - T0)))^ALPHA
    }
    gate_delay_abs(L_eff, Vth, T, Vdd) / gate_delay_abs(VDD0, VT0, T0, VDD0)
}


#######################################################################
###################### SRAM delay computations ########################
#######################################################################


# CDF of delay distribution for a memory stage having <N_l> lines of <linesz>
# bits each in the presence of process variation evaluated at clock
# periods t_R
cdf_D_varmem <- function(L_sys, Vt_sys, T, Vdd, linesz, N_l, t_R)
{
    cdf <- cdf(D_var_rd, t_R, L_sys, Vt_sys, T, Vdd, linesz)
    ifelse(cdf >= (N_l-1)/N_l, 1, cdf)
}

# Delay distribution for access time to a single SRAM line in the
# presence of proces variation
D_var_rd <- function(L_sys, Vt_sys, T, Vdd, linesz)
{
    MEM_PATH_MEM_FRAC <- 1 - MEM_PATH_LOGIC_FRAC
    
    line <- D_varline(L_sys, Vt_sys, Vdd, linesz)
    logic <- D_varlogic(L_sys, Vt_sys, T, Vdd)
    mean <- MEM_PATH_LOGIC_FRAC * logic$mean + MEM_PATH_MEM_FRAC * line$mean
    sd <- sqrt((MEM_PATH_LOGIC_FRAC * logic$sd)**2 +
               (MEM_PATH_MEM_FRAC * line$sd)**2)
    list(mean=mean, sd=sd)
}

# Distribution of sensing delay for a single SRAM line in the presence
# of process variation
D_varline <- function(L_sys, Vt_sys, Vdd, linesz)
{
    tmp <- D_varcell(L_sys, Vt_sys, Vdd)
    D_max_norm_iid(tmp$mean, tmp$sd, linesz)
}

# Distribution of sensing time for a single bit line in the presence of
# process variation in the access and storage cell transistors
D_varcell <- function(L_sys, Vt_sys, Vdd)
{
    f <- function(vec) { 1 / I_dsat_AXR(vec[1], vec[2], vec[3], vec[4], Vdd) }
    D_f_norm(f, means=c(L_sys, L_sys, Vt_sys, Vt_sys),
                sds=c(SIGMA_L_RAND, SIGMA_L_RAND, SIGMA_VT_RAND, SIGMA_VT_RAND))
}

# Bitline drive current normalized to the drive current of a nominal SRAM
# cell
I_dsat_AXR <- function(L_AXR, L_NR, Vth_AXR, Vth_NR, Vdd)
{
    I_dsat_AXR_abs(L_AXR, L_NR, Vth_AXR, Vth_NR, Vdd) /
        I_dsat_AXR_abs(1, 1, VT0, VT0, VDD0)
}

# Unscaled bitline drive current (arbitrary units)
I_dsat_AXR_abs <- function(L_AXR, L_NR, Vth_AXR, Vth_NR, Vdd)
{
    # Transistor current equations from ALPHA-power law
    I_dsat_AXR <- function(V_R) { (1/L_AXR) * (Vdd - V_R - Vth_AXR)^ALPHA }
    I_dlin_NR <- function(V_R)  { (1/L_NR) * (Vdd - Vth_NR)^(ALPHA/2) * V_R }
    
    # Find V_R such that I_dsat_AXR(V_R) = I_dlin_NR(V_R)
    root_f <- function(V_R) { I_dsat_AXR(V_R) - I_dlin_NR(V_R) }
    EPSILON <- 1e-4
    min_V_R <- Vth_NR + EPSILON
    max_V_R <- Vdd - Vth_AXR - EPSILON
    V_R <- uniroot(root_f, lower=min_V_R, upper=max_V_R)$root
    I_dsat_AXR(V_R)
}


#######################################################################
################# Mixed unit delay computations #######################
#######################################################################


# CDF of delay distribution for a mixed logic-and-memory stage having
# lines of <linesz> bits each in the presence of process variation evaluated
# clock periods t_R.  Assume that <logic_frac> is the fraction of the delay
# due to the logic components in the unit
cdf_D_varmixed <- function(L_sys, Vt_sys, T, Vdd, linesz, logic_frac, t_R)
{
    cdf(D_varmixed, t_R, L_sys, Vt_sys, T, Vdd, linesz, logic_frac)
}

# Delay distribution for a mixed logic-and-memory stage having
# lines of <linesz> bits each assuming that <logic_frac> is the fraction
# of the delay due to the logic components in the unit
D_varmixed <- function(L_sys, Vt_sys, T, Vdd, linesz, logic_frac, t_R)
{
    mem_frac <- 1 - logic_frac
    mem <- D_var_rd(L_sys, Vt_sys, T, Vdd, linesz)
    logic <- D_varlogic(L_sys, Vt_sys, T, Vdd)
    list(mean = mem_frac*mem$mean + logic_frac*logic$mean,
         sd = sqrt((mem_frac*mem$sd)**2 + (logic_frac*logic$sd)**2))
}


#######################################################################
################ Transforms on Random Variables #######################
#######################################################################


# Return the mean and sd of the max of n unit-normal variables each having
# (mean, sd).
D_max_norm_iid <- function(mean, sd, n)
{
    if(USE_FAST_MAX) {
        D_max_norm_iid_fast(mean, sd, n)
    } else {
        D_max_norm_iid_mc(mean, sd, n)
    }
}

# Find (mu, sd) of max of n IID Gaussians by fitting a Gumbel distribution
# and take its mean and sd.  This approximation comes from Enrique Castillo
# in "Extreme Value and Related Models with Applications in Engineering and
# Science"
D_max_norm_iid_fast <- function(mean, sd, n)
{
    GAMMA <- 0.57721566 # Euler-Mascheroni constant
    b <- qnorm(1 - 1/n, mean=mean, sd=sd)
    a <- qnorm(1 - 1/(n* exp(1)), mean=mean, sd=sd) - b
    mean <- b + a*GAMMA
    var <- pi**2 * a**2 / 6
    list(mean=mean, sd=sqrt(var), mode=b)
}

# Find (mu, sd) of max of n IID Gaussians by brute force Monte Carlo
# simulation
D_max_norm_iid_mc <- function(mean, sd, n)
{
    NSAMPLES <- 10000
    x <- array(NA, NSAMPLES)
    for(i in 1:NSAMPLES) {
        x[i] <- max(rnorm(n, mean=mean, sd=sd))
    }
    list(mean=mean(x), sd=sd(x))
}

# Find the mean and sd of a function f of independent normal random variables
# X1..Xn having means[1..n] and sds[1..n].  I am pretty sure that f must be
# at least monotonic
D_f_norm <- function(f, means, sds)
{
    list(mean = f(means) + sum(diag(hessian(f, means)) * sds^2 / 2),
         sd   = sqrt(sum(grad(f, means)^2 * sds^2)))
}

# Compute the cumulative distribution function of D(...) at points t_R
cdf <- function(D, t_R, ...)
{
    D <- D(...)
    pnorm(t_R, mean=D$mean, sd=D$sd)
}


#######################################################################
################### Diagnostics and Regressions #######################
#######################################################################


# Evaluates the mean and sd of a function of unit normals using the analytical
# Taylor expantion method and brute-force Monte Carlo.  Return both results
# for comparison
verify_D_f_norm <- function()
{
    NSAMPLES <- 100000
    # A reasonably nasty test function
    TEST_F <- function(vec) {
        (vec[1] + 3)**2 + (vec[3] + 4) * (vec[2] + 5)
    }
    
    print('Evaluating with Monte Carlo (unit normal args)')
    samples <- array(NA, NSAMPLES)
    for(i in 1:NSAMPLES) {
        vec <- rnorm(3, mean=0, sd=1)
        samples[i] <- TEST_F(vec)
    }
    print('Evaluating analytically (unit normal args)')
    an <- D_f_norm(TEST_F, c(0,0,0), c(1,1,1))
    list(mean.mc=mean(samples), sd.mc=sd(samples),
         mean.an=an$mean, an.sd=an$sd)
}
