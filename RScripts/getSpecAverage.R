SRC = "~/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/500Samples/sensitivity/rampUp/K/"
# BENCHES = list("WP","RAY","NN","MUM","LIB","BFS","AES","NQU","STO","CP","LPS")
# BENCHES = list("WP","RAY","NN","MUM","LIB","BFS","AES","NQU","STO","LPS")
BENCHES = list("NQU","AES","RAY","STO","LPS","CP","BFS","MUM","NN","LIB","WP")
# BENCHES = list("LPS", "AES", "BFS", "NQU", "STO", "CP")
j = 1
savings = c()
for(i in 1:length(BENCHES)){
  DIR = paste(SRC,BENCHES[[i]], sep="/")
  FILE= paste(DIR,"specVoltage.log", sep="/")
  specVoltage <- read.csv(FILE, header=FALSE)
  meanVdd = mean(specVoltage[[2]])
  savings[j] <- ceiling((1.1 - meanVdd) * 1000)
  
  cat(BENCHES[[i]])
  cat(",")
  cat(savings[j])
#   cat("mV\n")
  cat("\n")
  j = j + 1
}
tb <-as.table(setNames(savings, BENCHES))
# dev.new()
barplot(tb, ylab = "VDD reduction (mV)", axes =T)