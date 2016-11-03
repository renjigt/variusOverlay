library(ggplot2)
library(RColorBrewer)
library(foreach)
library(doParallel)
library(utils)
details.mat <- matrix(Sys.info())
SRCDIR = "~/workspace/remote_LARGE"
if(substring(details.mat[4],1,4)=="arch")
  SRCDIR = "~/WORK"
TRACEDIR = paste(SRCDIR, "/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/",sep="")
# TRACEDIR = SRCDIR + "/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/"
#FILENAME = paste(TRACEDIR, "BFS_ori/spice.out",sep="")
FILENAME = paste(TRACEDIR, "BFS/spice.out",sep="")
spice <- read.delim(FILENAME)
# spice <- read.delim("~/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/BFS/spice.out")
# melt_spice <- melt(spice,id=c("Time"))
# d <- ggplot(melt_spice, aes(x=time, y=value)) + geom_line()
# ggsave
# g <-
# ggplot(spice,aes(x=spice$time)) + 
#   geom_line(aes(y=spice$sm0min)) + 
#   geom_line(aes(y=spice$sm1min))
start = 1.5e-6
end = 1.8e-6
# plot(spice$time,spice$minV,col="red",type="l",xlim=c(start,end))
# lines(spice$time, spice$sm0min,col = "green",xlim=c(start,end))
cols <-brewer.pal(16,"Set3")

g <- ggplot(spice,aes(spice$time)) +
  geom_line(aes(y=spice[,(1+2)]),col=cols[1]) +
  geom_line(aes(y=spice[,(2+2)]),col=cols[2]) +
  geom_line(aes(y=spice[,(3+2)]),col=cols[3]) +
  geom_line(aes(y=spice[,(4+2)]),col=cols[4]) +
  geom_line(aes(y=spice[,(5+2)]),col=cols[5]) +
  geom_line(aes(y=spice[,(6+2)]),col=cols[6]) +
  geom_line(aes(y=spice[,(7+2)]),col=cols[7]) +
  geom_line(aes(y=spice[,(8+2)]),col=cols[8]) +
  geom_line(aes(y=spice[,(9+2)]),col=cols[9]) +
  geom_line(aes(y=spice[,(10+2)]),col=cols[10]) +
  geom_line(aes(y=spice[,(11+2)]),col=cols[11]) +
  geom_line(aes(y=spice[,(12+2)]),col=cols[12]) +
  geom_line(aes(y=spice[,(13+2)]),col=cols[13]) +
  geom_line(aes(y=spice[,(14+2)]),col=cols[14]) +
  geom_line(aes(y=spice[,(15+2)]),col=cols[15]) +
  geom_line(aes(y=spice[,(16+2)]),col=cols[16])

# gy <- g 
# foreach(i=1:16) %do% {
#   gy = gy + geom_line(aes(y=spice[,(i+2)]),col=cols[i])
# }

# g <- g + gy
# g <- g + geom_line(aes(y=spice$minV), color="red")
# g <- g + geom_line(aes(y=spice$sm0min),color="green")
g <- g + xlim(start,end)
g <- g + xlab("Time (s)")
g <- g + ylab("Absolute Voltage (V)")
