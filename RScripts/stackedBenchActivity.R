
setwd("/home/thomasr/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/RScripts")
presDir = getwd()

library(plyr)
library(ggplot2)
library(reshape2)
library(doParallel)
registerDoParallel(8)

stacked_plot <-function(molten_unit_power, id){
	c <- ggplot(molten_unit_power, aes(x = Time, y = value, fill = unit)) + 
	geom_bar(stat="identity", position="stack")+ 
	scale_fill_brewer(palette = "Paired") + 
	facet_grid(unit ~ ., scale = "free_y") + 
	theme(legend.position = "none")
	#	filename <- sprintf("sm%d.pdf", id); 
#  	ggsave(file=filename,plot=c)
	dev.new()
	plot(c)
}

power_plot <-function(unit_power, start, end, smID){
	sm0 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM0_FRONT, DIESM0MEM_CC, DIESM0MEM_SHRM0, DIESM0MEM_SHRM1, DIESM0P0_LD, DIESM0P0_SF, DIESM0P0_SP, DIESM0P1_LD, DIESM0P1_SF, DIESM0P0_SP, DIESM0_RF))
	sm1 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM1_FRONT, DIESM1MEM_CC, DIESM1MEM_SHRM0, DIESM1MEM_SHRM1, DIESM1P0_LD, DIESM1P0_SF, DIESM1P0_SP, DIESM1P1_LD, DIESM1P1_SF, DIESM1P0_SP, DIESM1_RF))
	sm2 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM2_FRONT, DIESM2MEM_CC, DIESM2MEM_SHRM0, DIESM2MEM_SHRM1, DIESM2P0_LD, DIESM2P0_SF, DIESM2P0_SP, DIESM2P1_LD, DIESM2P1_SF, DIESM2P0_SP, DIESM2_RF))
	sm3 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM3_FRONT, DIESM3MEM_CC, DIESM3MEM_SHRM0, DIESM3MEM_SHRM1, DIESM3P0_LD, DIESM3P0_SF, DIESM3P0_SP, DIESM3P1_LD, DIESM3P1_SF, DIESM3P0_SP, DIESM3_RF))
# 	sm4 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM4_FRONT, DIESM4MEM_CC, DIESM4MEM_SHRM0, DIESM4MEM_SHRM1, DIESM4P0_LD, DIESM4P0_SF, DIESM4P0_SP, DIESM4P1_LD, DIESM4P1_SF, DIESM4P0_SP, DIESM4_RF))
# 	sm5 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM5_FRONT, DIESM5MEM_CC, DIESM5MEM_SHRM0, DIESM5MEM_SHRM1, DIESM5P0_LD, DIESM5P0_SF, DIESM5P0_SP, DIESM5P1_LD, DIESM5P1_SF, DIESM5P0_SP, DIESM5_RF))
# 	sm6 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM6_FRONT, DIESM6MEM_CC, DIESM6MEM_SHRM0, DIESM6MEM_SHRM1, DIESM6P0_LD, DIESM6P0_SF, DIESM6P0_SP, DIESM6P1_LD, DIESM6P1_SF, DIESM6P0_SP, DIESM6_RF))
# 	sm7 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM7_FRONT, DIESM7MEM_CC, DIESM7MEM_SHRM0, DIESM7MEM_SHRM1, DIESM7P0_LD, DIESM7P0_SF, DIESM7P0_SP, DIESM7P1_LD, DIESM7P1_SF, DIESM7P0_SP, DIESM7_RF))
# 	sm8 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM8_FRONT, DIESM8MEM_CC, DIESM8MEM_SHRM0, DIESM8MEM_SHRM1, DIESM8P0_LD, DIESM8P0_SF, DIESM8P0_SP, DIESM8P1_LD, DIESM8P1_SF, DIESM8P0_SP, DIESM8_RF))
# 	sm9 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM9_FRONT, DIESM9MEM_CC, DIESM9MEM_SHRM0, DIESM9MEM_SHRM1, DIESM9P0_LD, DIESM9P0_SF, DIESM9P0_SP, DIESM9P1_LD, DIESM9P1_SF, DIESM9P0_SP, DIESM9_RF))
# 	sm10 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM10_FRONT, DIESM10MEM_CC, DIESM10MEM_SHRM0, DIESM10MEM_SHRM1, DIESM10P0_LD, DIESM10P0_SF, DIESM10P0_SP, DIESM10P1_LD, DIESM10P1_SF, DIESM10P0_SP, DIESM10_RF))
# 	sm11 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM11_FRONT, DIESM11MEM_CC, DIESM11MEM_SHRM0, DIESM11MEM_SHRM1, DIESM11P0_LD, DIESM11P0_SF, DIESM11P0_SP, DIESM11P1_LD, DIESM11P1_SF, DIESM11P0_SP, DIESM11_RF))
# 	sm12 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM12_FRONT, DIESM12MEM_CC, DIESM12MEM_SHRM0, DIESM12MEM_SHRM1, DIESM12P0_LD, DIESM12P0_SF, DIESM12P0_SP, DIESM12P1_LD, DIESM12P1_SF, DIESM12P0_SP, DIESM12_RF))
# 	sm13 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM13_FRONT, DIESM13MEM_CC, DIESM13MEM_SHRM0, DIESM13MEM_SHRM1, DIESM13P0_LD, DIESM13P0_SF, DIESM13P0_SP, DIESM13P1_LD, DIESM13P1_SF, DIESM13P0_SP, DIESM13_RF))
# 	sm14 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM14_FRONT, DIESM14MEM_CC, DIESM14MEM_SHRM0, DIESM14MEM_SHRM1, DIESM14P0_LD, DIESM14P0_SF, DIESM14P0_SP, DIESM14P1_LD, DIESM14P1_SF, DIESM14P0_SP, DIESM14_RF))
# 	sm15 <- subset(unit_power, Time > start & Time < end,select=c(Time, DIESM15_FRONT, DIESM15MEM_CC, DIESM15MEM_SHRM0, DIESM15MEM_SHRM1, DIESM15P0_LD, DIESM15P0_SF, DIESM15P0_SP, DIESM15P1_LD, DIESM15P1_SF, DIESM15P0_SP, DIESM15_RF))
	sm0 =rename(melt(sm0, id=c("Time")), c(variable="unit"))
	sm1 =rename(melt(sm1, id=c("Time")), c(variable="unit"))
	sm2 =rename(melt(sm2, id=c("Time")), c(variable="unit"))
	sm3 =rename(melt(sm3, id=c("Time")), c(variable="unit"))
# 	sm4 =rename(melt(sm4, id=c("Time")), c(variable="unit"))
# 	sm5 =rename(melt(sm5, id=c("Time")), c(variable="unit"))
# 	sm6 =rename(melt(sm6, id=c("Time")), c(variable="unit"))
# 	sm7 =rename(melt(sm7, id=c("Time")), c(variable="unit"))
# 	sm8 =rename(melt(sm8, id=c("Time")), c(variable="unit"))
# 	sm9 =rename(melt(sm9, id=c("Time")), c(variable="unit"))
# 	sm10 =rename(melt(sm10, id=c("Time")), c(variable="unit"))
# 	sm11 =rename(melt(sm11, id=c("Time")), c(variable="unit"))
# 	sm12 =rename(melt(sm12, id=c("Time")), c(variable="unit"))
# 	sm13 =rename(melt(sm13, id=c("Time")), c(variable="unit"))
# 	sm14 =rename(melt(sm14, id=c("Time")), c(variable="unit"))
# 	sm15 =rename(melt(sm15, id=c("Time")), c(variable="unit"))

	if(smID == 1){stacked_plot(sm0,smID)}
	else
	if(smID == 2){stacked_plot(sm1,smID)}
	else
	if(smID == 3){stacked_plot(sm2,smID)}
	else
	if(smID == 4){stacked_plot(sm3,smID)}
	else
	if(smID == 5){stacked_plot(sm4,smID)}
	else
	if(smID == 6){stacked_plot(sm5,smID)}
	else
	if(smID == 7){stacked_plot(sm6,smID)}
	else
	if(smID == 8){stacked_plot(sm7,smID)}
	else
	if(smID == 9){stacked_plot(sm8,smID)}
	else
	if(smID == 10){stacked_plot(sm9,smID)}
	else
	if(smID == 11){stacked_plot(sm10,smID)}
	else
	if(smID == 12){stacked_plot(sm11,smID)}
	else
	if(smID == 13){stacked_plot(sm12,smID)}
	else
	if(smID == 14){stacked_plot(sm13,smID)}
	else
	if(smID == 15){stacked_plot(sm14,smID)}
	else
	if(smID == 16){stacked_plot(sm15,smID)}
}



setwd("../")
setwd("./ArtificialTraceScripts/500Samples")

readFile <-function(bench_num){
	unitPower=data.frame()
	print(bench_num)
	identity(bench_num)
	if(bench_num==1){return(unit_power <- read.csv("./BFS/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==2){return(unit_power <- read.csv("./NQU/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==3){return(unit_power <- read.csv("./AES/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==4){return(unit_power <- read.csv("./CP/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==5){return(unit_power <- read.csv("./WP/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==6){return(unit_power <- read.csv("./NN/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==7){return(unit_power <- read.csv("./LIB/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==8){return(unit_power <- read.csv("./LPS/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==9){return(unit_power <- read.csv("./STO/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==10){return(unit_power <- read.csv("./RAY/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==11){return(unit_power <- read.csv("./MUM/unitPower.log",header=TRUE,sep="\t"))}
	if(bench_num==12){
	  setwd("../../4SM_ISPASS/")
	  return(unit_power <- read.csv("baseline/cuda_reso_b4t128_ispass/unitCurrent.log",header=TRUE,sep=","))}
}

if(exists("x") == FALSE){
 x<-foreach(i=12) %do% {
 	readFile(i)
 }
}

bench_unit_power = as.data.frame(x[1])

setwd(presDir)
start = 2.5e-6
end = 2.8e-6
foreach(i=1:4) %do% {
  power_plot(bench_unit_power, start, end,i)
}

setwd(presDir)
