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


# Load the model functions
source('spatial-grid.R')

# Setup graphic display 
par(mfrow=c(4,4))
par(mar=c(4,4,4,4))

mu <- 0.30
N <- 80

for (sigma in c(0.03,0.05)) {
  for (phi in c(0.1,0.2,0.5)) {
    deltaWIDsys <- get_deltaWIDsys(N,sigma*mu,phi)
    P <- mu+deltaWIDsys
    image(P,xlab=NULL,ylab=NULL)
    title(paste("sigma=",sigma,"phi=",phi))
    hist(P,breaks=50)
  }
}

## sigma <- 0.06                     
## for (phi in c(0.1)) {
##   deltaWIDsys <- get_deltaWIDsys(N,sigma*mu,phi)
##   distr_deltaD2Dsys <- get_deltaD2D(16,sigma*mu)
##   for (i in 1:16){
##     P <- mu+distr_deltaD2Dsys[i]+deltaWIDsys
##     image(P,xlab=NULL,ylab=NULL)
##     title(paste("mean=",mean(P),"phi=",phi))
##   }
## }

#contour(sim2,levels=seq(100,200,by=10),add=TRUE,col="black",lwd=1)
