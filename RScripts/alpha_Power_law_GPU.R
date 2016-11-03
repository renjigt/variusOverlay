setwd('~/workspace/remote_LARGE/floor/branch/5.0/run/RScripts/')
presDir = getwd()
library(doParallel)
library(fields)
a = 1.1
Ck = 8.465001e-10
setwd("./varius-v0.1")
source("./example-grid.R")
#dev.off()
dev.new()
setwd(presDir)
library(foreach)
vdds <- seq(0.5,1.1,0.006)
vths <- sort(unique(c(P)))
setwd("./CudaBackend")
source("./gpuAPL.R")
maxvth = max(vths)
maxvdd = max(vdds)
targetFreq = 772e6
tDelay = 1 / targetFreq
Ck = tDelay / (maxvdd/((maxvdd - maxvth) ^ a))
#P <- P + 0.1
# vths <- vths + 0.1
delay_matrix <-apl(vdd_list = vdds, vth_list = vths, alpha = a, constant = Ck)
setwd(presDir)
df <- as.data.frame(delay_matrix)
row.names(df) <- vdds
colnames(df) <- vths
source("./myImagePlot.R")
myImagePlot(df)
#df_mat <- data.matrix(df)
#df_heatmap <- heatmap(df_mat, Rowv = NA, Colv = NA, col = cm.colors(356), scale = NULL)
#plot(df_heatmap)
#df <- df[,2:(length(vths) + 1)]

delayVector <- rep(0.0,length(vths))

search<-function(colVec, maxFreq, minFreq, vddVec){
  vddl = length(vddVec)
  index = -1
  vddVal = vddVec[1]
  for(i in 1:vddl){
    if((colVec[i] > minFreq)&(colVec[i] < maxFreq)){
      index = i
      break;
    }      
  }
  if(index != -1)
    vddVal = vddVec[index]
  return(vddVal)
}

minF = 0.99 * targetFreq
maxF = 1.01 * targetFreq
registerDoParallel(8)

delayVector <- 
  foreach(i = 1:length(vths),.combine="c") %dopar% {
    vthDelayVec = df[[i]]
    search(colVec = vthDelayVec,maxFreq = maxF, minFreq = minF, vddVec = vdds)
  }

marginVdd = (maxvdd - delayVector) * 100
par(mar=c(5,4,4,4))
par(mfrow=c(1,1))
plot(vths,marginVdd, type="l", xlab=NA, ylab = NA)
mtitle_a = paste("tolerance for ", targetFreq)
mtitle_b = paste(mtitle_a, " @ nominal VDD= ")
mtitle = paste(mtitle_b, maxvdd)
title(mtitle,xlab="threshold voltage", ylab="tolerated droop %")
#plot(vths,delayVector, type="l")

# par(mfrow=c(1,1))
# plot(vths,marginVdd, type="l", xlab=NA, ylab = NA)
# title(main="tolerance for 772MHz @ 1.2V",xlab="threshold voltage", ylab="tolerated droop %")
#plot(vths,delayVector, type="l")
marginMap <- P

foreach(i =1:dim(P)[1]) %:% 
foreach(j =1:dim(P)[2]) %dopar% {
  marginIndex = which(vths == P[i,j])
  marginMap[i,j] <- marginVdd[marginIndex]
}
image.plot(marginMap)
# title(paste("sigma=",sigma_,"phi=",phi_))
setwd(presDir)

