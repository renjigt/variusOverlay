library("ggplot2")
library("reshape")
library("utils")
details <- Sys.info()
details.mat <- as.matrix(details)
setwd("/home/thomasr/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/RScripts")
presDir = getwd()
SRCDIR = "~/workspace/remote_LARGE"
if(substring(details.mat[4],1,4)=="arch")
  SRCDIR = "~/WORK"
TRACEDIR = paste(SRCDIR, "/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/",sep="")
# TRACEDIR = SRCDIR + "/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/"
FILENAME = paste(TRACEDIR, "BFS/spice.out",sep="")
# FILENAME = TRACEDIR + "BFS/spice.out"

if(exists("spice")==FALSE){
	spice <- read.delim(FILENAME)
	spice <- melt(spice, id =c("time"))
	spice <- rename(spice, c("variable" = "dieUnit"))
	spice$value <- (1.1 - spice$value) / 1.1 * 100
}
spice.sub <- subset(spice, time > 1e-6 & time < 1.8e-6)

 g <- ggplot(spice.sub , aes(time, value)) +
	geom_line() +
	facet_grid(dieUnit ~.) +
	scale_y_reverse()
#	scale_color_brewer()
# scale_x_continuous(name="Time", limits=c(1.5e-6,1.8e-6))

#g <- ggplot(spice , aes(dieUnit, value)) +
#geom_line() +
#geom_violin(alpha=0.5,color="gray")
# facet_grid(dieUnit ~.) +
# scale_x_continuous(name="Time", limits=c(1.5e-6,1.8e-6)) +

plot(g)
