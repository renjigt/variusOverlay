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
library('geoR')
library('RandomFields')


# Initialize random number generator
set.seed(1)


# Read a HotSpot-formatted floorplan from the given file.  Scale the
# dimensions of all units by "scale_factor".  Note that the the scaled
# floorplan units must match the units of PHI (in global.R) in order
# to generate accurate spatial variation maps using the floorplan.
floorplan_read <- function(flp_file_name, scale_factor=1)
{
    tmp <- read.table(flp_file_name, row.names=1,
                      col.names=c('unit', 'width', 'height', 'left_x',
                                  'bottom_y'))
    tmp * scale_factor
}

# Return a data frame listing the coordinates of the centroid of each unit
# in the floorplan "flp".
floorplan_centroids <- function(flp)
{
    data.frame(x_center = flp[,'left_x'] + flp[,'width'] / 2,
               y_center = flp[,'bottom_y'] + flp[,'height'] / 2,
               row.names=attr(flp, 'row.names'))
}

# Return a data frame listing the area of each unit in the floorplan "flp"
floorplan_unit_areas <- function(flp)
{
    data.frame(area = flp[,'width'] * flp[,'height'],
               row.names=attr(flp, 'row.names'))
}

# Return a data frame giving the mean Vt and Leff values for each unit in
# the floorplan "flp".
floorplan_systvar <- function(flp)
{
    centroids <- floorplan_centroids(flp)
    systmap <- grf(grid=centroids, cov.pars=c(1, PHI),
                   cov.model='spherical')$data
    data.frame(Vt = VT0 + systmap * SIGMA_VT_SYS,
               L = 1 + systmap * SIGMA_L_SYS,
               row.names=attr(flp, 'row.names'))
}
