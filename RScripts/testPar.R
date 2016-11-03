#import packages
library(foreach)
#library(doParallel)
library(doMC)

#number of iterations
iters<-100

#setup parallel backend to use 8 processors
#cl<-makeCluster(8)
#registerDoParallel(cl)
registerDoMC(8)

#start time
strt<-Sys.time()

#loop
ls<-foreach(icount(iters)) %dopar% {
  
  to.ls<-rnorm(1e6)
  to.ls<-summary(to.ls)
  to.ls
  
}

print(Sys.time()-strt)
#stopCluster(cl)
