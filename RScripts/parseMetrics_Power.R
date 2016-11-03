presDir = getwd()

benchQuant = 11
df <-data.frame(rf = numeric(benchQuant) ,ic = numeric(benchQuant) ,cc = numeric(benchQuant) ,tc = numeric(benchQuant) ,shrd = numeric(benchQuant) ,sched = numeric(benchQuant) ,ib = numeric(benchQuant) ,sf = numeric(benchQuant) ,sp = numeric(benchQuant) ,fp = numeric(benchQuant), max = numeric(benchQuant))

rownames(df)[1:benchQuant] = c("NQU","AES","LPS","CP","STO","BFS","MUM","NN","LIB","WP","RAY")

calculateMaximumAccessPower <- function(RFP_Power,ICP_Power,CCP_Power,TCP_Power,SHRDP_Power,SCHEDP_Power,IBP_Power,SFUP_Power,SPP_Power,FPUP_Power) {
		units = 11
		rf <- RFP_Power$GPUWattch[which.max(RFP_Power$DELTA)]
		ic <- ICP_Power$GPUWattch[which.max(ICP_Power$DELTA)]
		cc <- CCP_Power$GPUWattch[which.max(CCP_Power$DELTA)]
		tc <- TCP_Power$GPUWattch[which.max(TCP_Power$DELTA)]
		shrd <- SHRDP_Power$GPUWattch[which.max(SHRDP_Power$DELTA)]
		sched <- SCHEDP_Power$GPUWattch[which.max(SCHEDP_Power$DELTA)]
		ib <- IBP_Power$GPUWattch[which.max(IBP_Power$DELTA)]
		sf <- SFUP_Power$GPUWattch[which.max(SFUP_Power$DELTA)]
		sp <- SPP_Power$GPUWattch[which.max(SPP_Power$DELTA)]
		fp <- FPUP_Power$GPUWattch[which.max(FPUP_Power$DELTA)]
		max = rf +ic +cc +tc +shrd +sched +ib +sf +sp +fp
		res = c(rf ,ic ,cc ,tc ,shrd ,sched ,ib ,sf ,sp ,fp, max)
		names(res)= c("rf" ,"ic" ,"cc" ,"tc" ,"shrd" ,"sched" ,"ib" ,"sf" ,"sp" ,"fp" ,"max")
		return(res)
}

# setwd("/home/thomasr/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/RScripts")
setwd("../ArtificialTraceScripts/10000Samples")
source('../RScripts/powerMUM.R')
source('../RScripts/powerNQU.R')
source('../RScripts/powerCP.R')
source('../RScripts/powerBFS.R')
source('../RScripts/powerSTO.R')
source('../RScripts/powerLIB.R')
source('../RScripts/powerWP.R')
source('../RScripts/powerNN.R')
source('../RScripts/powerRay.R')
source('../RScripts/powerAES.R')
source('../RScripts/powerLPS.R')


res = calculateMaximumAccessPower(MUMRFP_Power,MUMICP_Power,MUMCCP_Power,MUMTCP_Power,MUMSHRDP_Power,MUMSCHEDP_Power,MUMIBP_Power,MUMSFUP_Power,MUMSPP_Power,MUMFPUP_Power)
df["MUM",] = res

res = calculateMaximumAccessPower(NQURFP_Power,NQUICP_Power,NQUCCP_Power,NQUTCP_Power,NQUSHRDP_Power,NQUSCHEDP_Power,NQUIBP_Power,NQUSFUP_Power,NQUSPP_Power,NQUFPUP_Power)
df["NQU",] = res

res = calculateMaximumAccessPower(CPRFP_Power,CPICP_Power,CPCCP_Power,CPTCP_Power,CPSHRDP_Power,CPSCHEDP_Power,CPIBP_Power,CPSFUP_Power,CPSPP_Power,CPFPUP_Power)
df["CP",] = res

res = calculateMaximumAccessPower(BFSRFP_Power,BFSICP_Power,BFSCCP_Power,BFSTCP_Power,BFSSHRDP_Power,BFSSCHEDP_Power,BFSIBP_Power,BFSSFUP_Power,BFSSPP_Power,BFSFPUP_Power)
df["BFS",] = res

res = calculateMaximumAccessPower(STORFP_Power,STOICP_Power,STOCCP_Power,STOTCP_Power,STOSHRDP_Power,STOSCHEDP_Power,STOIBP_Power,STOSFUP_Power,STOSPP_Power,STOFPUP_Power)
df["STO",] = res

res = calculateMaximumAccessPower(LIBRFP_Power,LIBICP_Power,LIBCCP_Power,LIBTCP_Power,LIBSHRDP_Power,LIBSCHEDP_Power,LIBIBP_Power,LIBSFUP_Power,LIBSPP_Power,LIBFPUP_Power)
df["LIB",] = res

res = calculateMaximumAccessPower(WPRFP_Power,WPICP_Power,WPCCP_Power,WPTCP_Power,WPSHRDP_Power,WPSCHEDP_Power,WPIBP_Power,WPSFUP_Power,WPSPP_Power,WPFPUP_Power)
df["WP",] = res

res = calculateMaximumAccessPower(NNRFP_Power,NNICP_Power,NNCCP_Power,NNTCP_Power,NNSHRDP_Power,NNSCHEDP_Power,NNIBP_Power,NNSFUP_Power,NNSPP_Power,NNFPUP_Power)
df["NN",] = res

res = calculateMaximumAccessPower(RAYRFP_Power,RAYICP_Power,RAYCCP_Power,RAYTCP_Power,RAYSHRDP_Power,RAYSCHEDP_Power,RAYIBP_Power,RAYSFUP_Power,RAYSPP_Power,RAYFPUP_Power)
df["RAY",] = res

res = calculateMaximumAccessPower(AESRFP_Power,AESICP_Power,AESCCP_Power,AESTCP_Power,AESSHRDP_Power,AESSCHEDP_Power,AESIBP_Power,AESSFUP_Power,AESSPP_Power,AESFPUP_Power)
df["AES",] = res

res = calculateMaximumAccessPower(LPSRFP_Power,LPSICP_Power,LPSCCP_Power,LPSTCP_Power,LPSSHRDP_Power,LPSSCHEDP_Power,LPSIBP_Power,LPSSFUP_Power,LPSSPP_Power,LPSFPUP_Power)
df["LPS",] = res

setwd(presDir)


MUM_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/MUM.log", row.names = NULL)
NQU_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/NQU.log", row.names = NULL)
CP_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/CP.log", row.names = NULL)
BFS_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/BFS.log", row.names = NULL)
STO_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/STO.log", row.names = NULL)
LIB_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/LIB.log", row.names = NULL)
WP_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/WP.log", row.names = NULL)
NN_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/NN.log", row.names = NULL)
RAY_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/RAY.log", row.names = NULL)
AES_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/AES.log", row.names = NULL)
LPS_metric <- read.csv("~/workspace/remote_LARGE/gpgpu-sim/workspace/baselines_GTO_16SM_nF_10000sampF/metric_traces/LPS.log", row.names = NULL)
