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


#######################################################################
######################### Physical Constants ##########################
#######################################################################

K <- 1.38065e-23   # Boltzman constant
Q <- 1.6022e-19    # Electron charge


#######################################################################
######################### Process Parameters ##########################
#######################################################################

T0  <- 273 + 80    # Reference temperature (Kelvins)
VDD0 <- 1.1       # Nominal supply voltage
VT0 <- 300e-3      # Nominal threshold voltage
ALPHA <- 1.1       # Alpha power model exponent as in (Vdd-Vth)^alpha
MOBIL <- 1.5       # Carrier mobility exponent as in (T/T0)^(-mobil)
DVT_DT <- -0.5e-3  # Change in VT per Kelvin increase in temperature


## TODO: Remove variation paramteres

#######################################################################
####################### Variation Parameters ##########################
#######################################################################

PHI <- 0.01              # 1cm, as measured by Friedberg
VT_SIGMA_OVER_MU <- 0.09 # <-- Change amount of variation by modifying this
                         #     parameter.  The following constants are derived
                         #     from it.
L_SIGMA_OVER_MU <- VT_SIGMA_OVER_MU / 2

SIGMA_VT_TOTAL <- VT0 * VT_SIGMA_OVER_MU
SIGMA_L_TOTAL <- 1 * L_SIGMA_OVER_MU

SIGMA_VT_RAND <- SIGMA_VT_TOTAL * sqrt(0.5)
SIGMA_L_RAND <- SIGMA_L_TOTAL * sqrt(0.5)

SIGMA_VT_SYS <- SIGMA_VT_RAND
SIGMA_L_SYS <- SIGMA_L_RAND
