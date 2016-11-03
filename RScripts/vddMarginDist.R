setwd('~/workspace/remote_LARGE/floor/branch/5.0/run/RScripts/')
presDir = getwd()
setwd("./varius-v0.1")
source("./spatial-grid.R")
setwd(presDir)
source("./scratch/plotHeatMap.R")

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

# vddMarginDist <- function(){
  
  source("./generate_margin_map.R")
  source("./test_min.R")
  numSMs = 16
  smN = c(0:(numSMs - 1))
  listData = c()
  minvdd = 0.5
  maxvdd = 1.1
  minF = 0.99 * 772e6
  maxF = 1.01 * 772e6
  mu <- 0.30
  N <- 80
  targetFreq = 772e6
  tDelay = 1 / targetFreq
  a = 1.1
  maxVdd_ck = maxvdd - 0.100
  a_ck = 1.1
#   Ck = tDelay / (maxVdd_ck/((maxVdd_ck - mu) ^ a_ck))
  # Ck = 8.465001e-10
  Ck = 8.053767223e-10 # this value allows for 1.0V max_droop at least 
  Ck = 7.953767223e-10 # this value allows for 1.0V max_droop at least
  setwd(presDir)
  vdds <- seq(minvdd,maxvdd,0.006)
  m_droop = list()
  index = 1
  m_titles = list()
  dev.new()
      # par(mar=c(5,4,4,4))
      # par(oma =c(0,0,1,0), mfrow=c(2,2))
  par(mfrow = c(2, 4),     # 2x2 layout
        oma = c(2, 2, 2, 0), # two rows of text at the outer left and bottom margin
        mar = c(1, 1, 2 ,1), # space for one row of text at ticks and to separate plots
        mgp = c(1, 0.2, 0),    # axis label at 2 rows distance, tick labels at 1 row
        xpd = NA)
  # par(mfrow = c(1,1))  
# allow content to protrude into outer margin (and beyond)
#   for (sigma in c(0.03,0.05)) {
    for (sigma in c(0.05)) {
    # for (phi in c(0.0,0.1,0.2,0.5)) {
#     for (phi in c(0.0,0.05,0.1,0.15)) {
        for (phi in c(0.15)) {     
      deltaWIDsys <- get_deltaWIDsys(N,sigma*mu,phi)
      P <- mu+deltaWIDsys
#       image.plot(P, zlim=c(0.15,0.45), cex = 1.5)
#       overlay_layout_rect()
#       title(paste("VTH distribution: sigma=",sigma,"phi=",phi))
      mmap <-generate_margin_map( vth_matrix = P,vdd_array = vdds, a_ = a, sigma_ = sigma, phi_ = phi, tDelay_ = tDelay, Ck_ = Ck)
      m_droop[[index]] <- get_min_droop_tolerated(Ndim=N, MAT=mmap)
      m_titles[[index]] <- paste("sigma=",sigma,"phi=",phi)
      d<-data.frame(smN = smN, threshold = m_droop[[index]])
      listData[[index]] = c(d)
      index = index + 1
    }
    
    mtext("Minimum Voltage Required", outer = TRUE, side=3)  

  }
filename <- sprintf("variationMap.pdf")
# dev.copy2pdf(file=filename)
# dev.off()
# dev.new()
filename <- sprintf("variationHist.pdf")
# pdf(filename, width = 16/2.54, height =9/2.54, useDingbats=FALSE)
par(mfrow = c(2,4),     # 2x2 layout
    oma = c(2, 2, 2, 0), # two rows of text at the outer left and bottom margin
    mar = c(2, 2, 2 ,2), # space for one row of text at ticks and to separate plots
    mgp = c(1, 0.2, 0),    # axis label at 2 rows distance, tick labels at 1 row
    xpd = NA)            # allow content to protrude into outer margin (and beyond)
  for(i in 1:length(m_titles)){
    h <- hist(m_droop[[i]], breaks=10, plot = F)
    plot(h, freq=TRUE, ylab='Count', col = "gray", main="",
         xlab='Minimum VDD Required',xlim=c(0.85,1.05), ylim=c(0,6))
    box()
    title(m_titles[[i]])
  }

# dev.copy2pdf(file=filename)
# }
# dev.off()
# dev.new()
for(i in c(1:length(listData))){
  barplot(as.data.frame(listData[i])$threshold, 
          ylim = c(0.85,1), 
          beside=TRUE, 
          xpd = FALSE,
          names = as.data.frame(listData[i])$smN,
          xlab="SM#",
          ylab ="Minimum VDD Required")  
  box()
  title(m_titles[[i]])
}
# dev.off()