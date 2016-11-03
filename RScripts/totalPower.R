library("ggplot2")
library("reshape")
library("utils")
details <- Sys.info()
details.mat <- as.matrix(details)
setwd("/home/thomasr/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/RScripts")
presDir = getwd()
# change these
BENCH ="BFS/"
START = 2.6e-5
END = 2.7e-5
#END

SRCDIR = "~/workspace/remote_LARGE"
if(substring(details.mat[4],1,4)=="arch")
  SRCDIR = "~/WORK"

TRACEDIR = paste(SRCDIR, "/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/",sep="")
POWER_FILE_NAME = paste(TRACEDIR, BENCH, "totalPower.log",sep="")
SPICE_FILE_NAME = paste(TRACEDIR, BENCH, "spice.out",sep="")


if(exists("totPower")==FALSE){
	tP <- read.delim(POWER_FILE_NAME)
	totPower <- melt(tP, id =c("time"))
	totPower <- rename(totPower, c("variable" = "dieUnit"))
	# totPower$value <- (1.1 - totPower$value) / 1.1 * 100
}
totPower.sub <- subset(totPower, time > START & time < END)
tP.sub <- subset(tP,time > START & time <END)
 gPOWER <- ggplot(totPower.sub , aes(time, value)) +
	geom_line() +
	facet_grid(dieUnit ~., scale = "free_y")
	#scale_y_reverse()

# gPOWER <- ggplot(totPower , aes(dieUnit, value)) +
# 	geom_line() +
# 	geom_violin(alpha=0.5,color="gray")
# 	facet_grid(dieUnit ~.) +



if(exists("spice")==FALSE){
	spice <- read.delim(SPICE_FILE_NAME)
	spice <- melt(spice, id =c("time"))
	spice <- rename(spice, c("variable" = "dieUnit"))
	spice$value <- (1.1 - spice$value) / 1.1 * 100
}
spice.sub <- subset(spice, time > START & time < END)

 gVOLT <- ggplot(spice.sub , aes(time, value)) +
	geom_line() +
	facet_grid(dieUnit ~.) +
	scale_y_reverse()
#	scale_color_brewer()

# gVOLT <- ggplot(spice , aes(dieUnit, value)) +
	# geom_line() +
	# geom_violin(alpha=0.5,color="gray")
	# facet_grid(dieUnit ~.)

plot(gPOWER)
#dev.new()
plot(gVOLT)

library("signal")
# spectrogram Begin
samplingF <- 1/500e-12
cyclePeriod <- 1/(772e6)
# SPG <- specgram(tP$total, Fs = samplingF)
# SPG <- SPG / max(SPG)
# image(t(20* log10(SPG)), axes = FALSE)

# data(wav)  # contains wav$rate, wav$sound
# Fs <- samplingF
# step <- trunc(50*Fs*cyclePeriod)             # one spectral slice every 5 ms
# window <- trunc(60*Fs*cyclePeriod)          # 40 ms data window
# fftn <- 2^ceiling(log2(abs(window))) # next highest power of 2
# spg <- specgram(tP.sub$total, fftn, Fs, window, window-step)
# S <- abs(spg$S[2:(fftn*300e6/Fs),])   # magnitude in range 0<f<=4000 Hz.
# S <- S/max(S)         # normalize magnitude so that max is 0 dB.
# S[S < 10^(-40/10)] <- 10^(-40/10)    # clip below -40 dB.
# S[S > 10^(-3/10)] <- 10^(-3/10)      # clip above -3 dB.
# dev.new()
# image(t(20*log10(S)), col = gray(0:255 / 255))  #, col = gray(0:255 / 255))
