# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; version 2 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# Authors: Radu Tedorescu, Brian Greskamp, Smruti Sarangi, Jun Nakano


# Functions to generate systematic variation maps with a
# spherical correlation function


source('global.R')
library('geoR')
library('RandomFields')


# Initialize random number generator
set.seed(1)


# Use this function to generate a normal distribution
# with a spherical correlation, as a function of
# the correlation distance phi
# **** Input ****
# N*N - number of points on the grid
# phi - correlation distance relative to the grid width (0..1)
# **** Output ****
# N*N grid, multivariate normal distibution with correlation phi
# mu (mean) = 0
# sigma = 1
get_spherical_map <- function(N,phi=PHI) {
  sim<-grf(N*N,grid="reg",cov.model="spherical",cov.pars=c(1,phi),method="RF")
  sim$data <- (sim$data - mean(sim$data)) / sd(sim$data)
  local <- array(sim$data, dim=c(N,N))
}

# Generate a multivariate normal distribution with a spherical correlation
# characterized by:
# phi - correlation distance
# N*N - number of grid points
# mu,sigma  - of the distribution
generate_normal_varmap <- function(N, mu, sigma, phi){
  local <- get_spherical_map(N,phi)
  map <- mu + mu * local * sigma
  map
}

# Generate delta within-die systematic
# **** Input ****
# N*N - number of points on the grid
# sigma - standard deviation of the distribution with 0 mean 
# phi - correlation distance relative to the grid width (0..1)
# **** Output ****
# deltaWIDsys from:
# P = P0 + deltaD2D + deltaWIDsys + deltaWIDrand
get_deltaWIDsys <- function(N, sigma, phi){
  local <- get_spherical_map(N,phi)
  deltaWIDsys <- local * sigma
  deltaWIDsys
}

# Generate delta die-to-die as a normal distribution of M dies with
#  standard deviation sigma
# **** Input ****
# M - number of dies in the distibution
# sigma - standard deviation of the distribution with 0 mean 
# **** Output ****
# deltaD2D from:
# P = P0 + deltaD2D + deltaWIDsys + deltaWIDrand
get_deltaD2D <- function(M, sigma){
  deltaD2D <- rnorm(M,mean=0,sd=sigma)
  deltaD2D
}
