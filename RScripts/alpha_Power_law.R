library(foreach)
library(doMC)
library(doParallel)
presDir = getwd()
# Delay <- function(Vdd, Vth, alpha, Constant){
# 	# print(Vdd)
#  #  print(Vth)
#  #  print(alpha)
#   print(Constant)
#   d = (Constant * Vdd) / ((Vdd - Vth) ^ alpha)
#   (Constant * Vdd) / ((Vdd - Vth) ^ alpha)
#   # return(d)
#   # d
# }

parallel.delay <-function(vth_val){
  Vdd_List <- seq(0.5,1.0,0.001)
  vddIter <- iter(Vdd_List)
  a = 1.1
  Ck = 8.465001e-10
  print(vth_val)
  delayCol <-
  foreach(vdd_val=vddIter, .combine="c") %do% {
    (Ck * vdd_val) / ((vdd_val - vth_val) ^ a)
  } 
}
# Vdd_List <- seq(0.5,1.0,0.001)
#Vth_List <- seq(0.25,0.35, 0.005)
#Constant = 1
setwd("~/workspace/varius-v0.1")
source("./example-grid.R")
dev.off()
dev.new()
setwd(presDir)
library(foreach)
Vth_List <- sort(unique(c(P)))
# a = 1.1
# Ck = 8.465001e-10


# vdd = Vdd_List[delay_length]
# vth = Vth_List[delay_length_vth]
# count = 1  
#delay_matrix <- matrix(,nrow = delay_length, ncol=delay_length_vth)

# cl<-makeCluster(8)
# registerDoParallel(cl)
registerDoMC(8)
# vddIter <- iter(Vdd_List)
vthIter <- iter(Vth_List)


#  delay_matrix2 <-
# # res <-
# foreach(vth_val=vthIter , .combine="cbind", .export=c("a","C")) %:% 
#  	foreach(vdd_val=vddIter, .combine="c", .export=c("vth_val","a","C")) %dopar% {
#   	    	Delay(Vdd=vdd_val,Vth=vth_val,alpha=a,Constant=Ck)
#   	    	 # to.ls<-rnorm(1e6)
#   			   # to.ls<-summary(to.ls)
#   		}

#
delay_matrix2 <-
foreach(vth_val_par=vthIter , .combine="cbind", .export=c("a","C")) %dopar% {
  parallel.delay(vth_val_par)
}

    
  

# results <-lapply(Vth_List,FUN=parallel.Delay)
#rownames(df) <- Vdd_List
#colnames(df) <- Vth_List

# plot(df$"0.25",col="black",xlim=c(300,500))
# lines(df$"0.30",col="green",xlim=c(300,500))


