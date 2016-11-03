setwd('~/workspace/remote_LARGE/floor/branch/5.0/run/RScripts/')
presDir = getwd()
source("./overlay_layout_rect.R")
library(fields)
library(foreach)
library(doParallel)
generate_margin_map <- function( vth_matrix, vdd_array, a_, sigma_, phi_, tDelay_, Ck_){
  
  presDir = getwd()
  setwd("./CudaBackend")
  source("./gpuAPL.R")
  vths <- sort(unique(c(vth_matrix)))
  maxvth = max(vths)
  maxvdd = max(vdd_array)
  #   Ck_ = tDelay_ / (maxvdd/((maxvdd - maxvth) ^ a_))
  delay_matrix <-apl(vdd_list = vdds, vth_list = vths, alpha = a_, constant = Ck_)
  setwd(presDir)
  df <- as.data.frame(delay_matrix)
  row.names(df) <- vdds
  colnames(df) <- vths
  # source("./myImagePlot.R")
  # myImagePlot(df)
  delayVector <- rep(0.0,length(vths))
  
  registerDoParallel(8)
  
  droopVector <- 
    foreach(i = 1:length(vths),.combine="c") %dopar% {
      vthDelayVec = df[[i]]
      search(colVec = vthDelayVec,maxFreq = maxF, minFreq = minF, vddVec = vdds)
    }
  
  #   marginVdd = (maxvdd - droopVector) * 100
  marginVdd = droopVector
  # par(mar=c(5,4,4,4))
  #   par(mfrow=c(1,1))
  # plot(vths,marginVdd, type="l", xlab=NA, ylab = NA)
  # title(main="tolerance for 772MHz @ 1.2V",xlab="threshold voltage", ylab="tolerated droop %")
  #plot(vths,delayVector, type="l")
  marginMap <- vth_matrix
  
  foreach(i =1:dim(vth_matrix)[1]) %:% 
    foreach(j =1:dim(vth_matrix)[2]) %do% {
      marginIndex = which(vths == vth_matrix[i,j])
      marginMap[i,j] = marginVdd[marginIndex]
    }
  #   dev.new()
  image.plot(marginMap, zlim=c(0.6,1.1), cex = 1.5)
  # image.plot(marginMap, col=topo.colors(160 * 160))
  # plotHeatMap(marginMap)
  # 
  overlay_layout_rect()
  
  title(paste("sigma=",sigma_,"phi=",phi_))
  #   box()
  setwd(presDir)
  return(marginMap)
}
