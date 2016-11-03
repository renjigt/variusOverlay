library(data.table)
# library(foreach)
# library(doParallel)
# SRC = "~/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/sensitivity/threshold/S/"
# SRC = "~/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/baseline"
SRC="./"

# BENCHES = list("WP","RAY","NN","MUM","LIB","BFS","AES","NQU","STO","CP","LPS")
# BENCHES = list("WP","RAY","NN","MUM","LIB","BFS","AES","NQU","STO","LPS")
BENCHES = list("NQU","AES","RAY","STO","LPS","CP","BFS","MUM","NN","LIB","WP")
# BENCHES = list("NQU","AES", "RAY")
j = 1
meanPow = c()
energy = c()
cat(SRC)
cat("\n")
cat("BENCH,Power(W),Energy(J),Runtime(s)\n")
for(i in 1:length(BENCHES)){
# foreach(i =1:length(BENCHES)) %dopar% {
  DIR = paste(SRC,BENCHES[[i]], sep="/")
  
  IFILE= paste(DIR,"totalCurrent.log", sep="/")
  VFILE= paste(DIR,"spice.out", sep="/")
  Vtrace <- fread(VFILE, header=TRUE, sep=",", showProgress=FALSE)
  Itrace <- fread(IFILE, header=TRUE, sep=",", showProgress=FALSE)
  Vnom = 1.1
  Ptrace <- Itrace$Total * ((Vtrace$MinV^2)/1.1)
  meanPow[j] <- mean(Ptrace)
  last = length(Vtrace$Time)
  energy[j] <- meanPow[j] * Vtrace$Time[last]
  cat(sprintf("%3s,%8.5f,%8.5e,%8.5e\n",BENCHES[[j]], meanPow[j], energy[j], Vtrace$Time[last]))
  j = j + 1
}
