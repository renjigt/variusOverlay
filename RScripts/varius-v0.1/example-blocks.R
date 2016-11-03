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

# This sample program computes and plots the probability of error versus
# frequency curves for each of the 15 units on a 45nm ev6-like core with
# a randomly-generated systematic variation profile.

source('spatial-blocks.R')
source('delay.R')

T <- 273+70    # 70 Degrees Celsius constant temperature for all units
VDD <- 1       # 1 Volt supply for all units

# Frequencies at which to evaluate error rates
CLK_FREQS <- seq(0.8, 1.2, length.out=500)
CLK_PERIODS <- 1 / CLK_FREQS


# Read the ev6 90nm core floorplan and scale it down to 45nm using ideal
# scaling
flp <- floorplan_read("data/ev6.flp", 0.5)

# Annotate each unit with its logic type (eg. memory, combinational logic,
# or a mix of teh two)
flp['Icache',  'type'] <- 'memory'
flp['Dcache',  'type'] <- 'memory'
flp['Bpred',   'type'] <- 'mixed'
flp['DTB',     'type'] <- 'memory'
flp['FPAdd',   'type'] <- 'logic'
flp['FPReg',   'type'] <- 'memory'
flp['FPMul',   'type'] <- 'logic'
flp['FPMap',   'type'] <- 'mixed'
flp['IntMap',  'type'] <- 'mixed'
flp['IntQ',    'type'] <- 'mixed'
flp['IntReg',  'type'] <- 'memory'
flp['IntExec', 'type'] <- 'logic'
flp['FPQ',     'type'] <- 'mixed'
flp['LdStQ',   'type'] <- 'mixed'
flp['ITB',     'type'] <- 'memory'

# Annotate each memory or mixed unit with the number of lines in the SRAM
# and the number of bits read on each access
flp['Icache', 'nlines'] <- 512    ; flp['Icache', 'linesz'] <- 32
flp['Dcache', 'nlines'] <- 512    ; flp['Dcache', 'linesz'] <- 32
flp['Bpred',  'nlines'] <- 2048   ; flp['Bpred',  'linesz'] <- 32
flp['DTB',    'nlines'] <- 64     ; flp['DTB',    'linesz'] <- 24
flp['FPReg',  'nlines'] <- 64+32  ; flp['FPReg',  'linesz'] <- 32
flp['FPMap',  'nlines'] <- 32     ; flp['FPMap',  'linesz'] <- 7
flp['IntMap', 'nlines'] <- 32     ; flp['IntMap', 'linesz'] <- 8
flp['IntQ',   'nlines'] <- 32     ; flp['IntQ',   'linesz'] <- 20
flp['IntReg', 'nlines'] <- 128+32 ; flp['IntReg', 'linesz'] <- 32
flp['FPQ',    'nlines'] <- 24     ; flp['FPQ',    'linesz'] <- 18
flp['LdStQ',  'nlines'] <- 48     ; flp['LdStQ',  'linesz'] <- 36
flp['ITB',    'nlines'] <- 64     ; flp['ITB',    'linesz'] <- 24

# Generate a map of spatially-correlated Vt and Leff variation superimposed
# on the floorplan
flp <- cbind(flp, floorplan_systvar(flp))

# Iterate over all units, plotting the error rates
first <- TRUE
for(unit in row.names(flp)) {
  # For convenience, extract relevant data for this unit into local vars
  type <- flp[unit, 'type']
  Leff <- flp[unit, 'L']
  Vt <- flp[unit, 'Vt']
  nlines <- flp[unit, 'nlines']
  linesz <- flp[unit, 'linesz']
  
  # Use the appropriate model (memory, logic, or mixed) to find the error
  # rate of the current unit
  if(type == 'logic') {
    Pe <- 1 - cdf_D_varlogic(Leff, Vt, T, VDD, CLK_PERIODS)
  } else if(flp[unit, 'type'] == 'memory') {
    Pe <- 1 - cdf_D_varmem(Leff, Vt, T, VDD, linesz, nlines, CLK_PERIODS)
  } else if(flp[unit, 'type'] == 'mixed') {
    Pe <- 1 - cdf_D_varmixed(Leff, Vt, T, VDD, linesz, 0.5, CLK_PERIODS)
  }
  
  # Plot the resulting error rate versus frequency curve
  if(first) {
    plot(CLK_FREQS, log10(Pe), t='l', ylim=c(-16, 0))
    first <- FALSE
  } else {
    lines(CLK_FREQS, log10(Pe))
  }
}
