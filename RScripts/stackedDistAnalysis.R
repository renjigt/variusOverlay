library(Hmisc)
library(data.table)

presDir = getwd()
setwd("/home/thomasr/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/RScripts")
if(exists("m_droop")==FALSE) {
    source("vddMarginDist.R")
}
source("power_plot.R")
setwd(presDir)
ROOT = "~/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/500Samples"
#C1N = "sensitivity/serialization"
#C1N = "sensitivity/rampUp"
C1N = "sensitivity/threshold"
C1NB = "baseline"
C1 = paste(ROOT, C1N , sep ="/")
LEAF_DIR = "AA"
SRC_DIR = paste(C1,LEAF_DIR, sep="/")
SRC_BASE_DIR = paste(ROOT, C1NB , sep ="/")
PLOTTITLE = paste(C1N, LEAF_DIR, sep="/");

# title(title_plot, outer = TRUE)
BENCH = "BFS"
# BENCH = "CP"

PDF_SAVE_DIR = "./"
PDF_SAVE_DIR = paste(PDF_SAVE_DIR, BENCH, sep ="/")
PDF_SAVE_DIR = paste(PDF_SAVE_DIR, "stacked", sep ="_")
PDF_NAME = paste(PDF_SAVE_DIR, ".pdf", sep ="") 
cat(PDF_NAME)
dev.new()
pdf(PDF_NAME, width=16, height= 10)

colors = c("green", "cyan","blue", "red")
# par(mfrow=c(2,1))
m <- matrix(c(1,2,3),nrow = 3,ncol = 1,byrow = TRUE)
# layout(mat = m,heights = c(0.4,0.4,0.2))
layout(mat = m,heights = c(0.44,0.44,0.09))
par(mar=c(0,5,0,7),cex=2)
# layout(matrix(c(1,2),2,1))
if(BENCH == "BFS"){
    if(exists("BFS_volts")==FALSE) {
        file = paste(SRC_DIR, BENCH, sep="/")
        file = paste(file, "spice.out", sep="/")
        BFS_volts <- fread(file)
    }
    if(exists("BFS_volts_base")==FALSE){
        file = paste(SRC_BASE_DIR, BENCH, sep="/")
        file = paste(file, "spice.out", sep="/")
        BFS_volts_base <- fread(file)
    }
    par(mar=c(0,5,1,7),cex=2)
    power_plot(BFS_volts_base, BENCH, colors, TRUE) 
    par(mar=c(0,5,0,7),cex=2)
    power_plot(BFS_volts, BENCH, colors, FALSE)     
}else if(BENCH == "CP"){
    if(exists("CP_volts")==FALSE) {
        file = paste(SRC_DIR, BENCH, sep="/")
        file = paste(file, "spice.out", sep="/")
        CP_volts <- fread(file)
    }
    if(exists("CP_volts_base")==FALSE){
        file = paste(SRC_BASE_DIR, BENCH, sep="/")
        file = paste(file, "spice.out", sep="/")
        CP_volts_base <- fread(file)
    }
    par(mar=c(0,5,1,7),cex=2)
    power_plot(CP_volts_base, BENCH, colors, top=TRUE) 
    par(mar=c(0,5,0,7),cex=2)
    power_plot(CP_volts, BENCH, colors,top=FALSE)     
}

legend(x="topleft", horiz = FALSE,
        col=c(colors[1],colors[2]),
        legend=c("Benchmark' Vdd",
        "Min. Safe Vdd"),
        lty=1, lw=10,cex = 1.2,bty="n")
    

dev.off()
# dev.copy2pdf(file = PDF_NAME)
# par(fig = c(0, 1, 0, 1), oma = c(0, 0, 0, 2), mar = c(0, 0, 0, 0), new = TRUE)
# plot(0, 0, type = "n", bty = "n", xaxt = "n", yaxt = "n")
# legend("bottom", c("count","count%", "mean V/G"), xpd = TRUE, horiz = TRUE, inset = c(0,0), bty = "n", col =c("gray", "red", "blue"), cex = 0.7)