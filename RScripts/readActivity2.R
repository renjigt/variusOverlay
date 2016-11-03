setwd("/home/thomasr/workspace/remote_LARGE/floor/branch/5.0/run/ArtificialTraceScripts/RScripts")
presDir = getwd()

getActivity <- function()
{
	sm0_act <-read.csv("./sm0_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm1_act <-read.csv("./sm1_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm2_act <-read.csv("./sm2_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm3_act <-read.csv("./sm3_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm4_act <-read.csv("./sm4_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm5_act <-read.csv("./sm5_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm6_act <-read.csv("./sm6_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm7_act <-read.csv("./sm7_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm8_act <-read.csv("./sm8_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm9_act <-read.csv("./sm9_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm10_act <-read.csv("./sm10_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm11_act <-read.csv("./sm11_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm12_act <-read.csv("./sm12_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm13_act <-read.csv("./sm13_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm14_act <-read.csv("./sm14_activity.log", header = TRUE, sep="\t", row.names=NULL)
	sm15_act <-read.csv("./sm15_activity.log", header = TRUE, sep="\t", row.names=NULL)
	maxlength = min(
		length(sm0_act$time.c.Prec.),length(sm1_act$time.c.Prec.),length(sm2_act$time.c.Prec.),
		length(sm3_act$time.c.Prec.),length(sm4_act$time.c.Prec.),length(sm5_act$time.c.Prec.),
		length(sm6_act$time.c.Prec.),length(sm7_act$time.c.Prec.),length(sm8_act$time.c.Prec.),
		length(sm9_act$time.c.Prec.),length(sm10_act$time.c.Prec.),length(sm11_act$time.c.Prec.),
		length(sm12_act$time.c.Prec.),length(sm13_act$time.c.Prec.),length(sm14_act$time.c.Prec.),
		length(sm15_act$time.c.Prec.)
		)
  	print (maxlength)
  
	resFrame = data.frame(
		sm0=sm0_act[0:maxlength,],sm1=sm1_act[0:maxlength,],sm2=sm2_act[0:maxlength,],
		sm3=sm3_act[0:maxlength,],sm4=sm4_act[0:maxlength,],sm5=sm5_act[0:maxlength,],
		sm6=sm6_act[0:maxlength,],sm7=sm7_act[0:maxlength,],sm8=sm8_act[0:maxlength,],
		sm9=sm9_act[0:maxlength,],sm10=sm10_act[0:maxlength,],sm11=sm11_act[0:maxlength,],
		sm12=sm12_act[0:maxlength,],sm13=sm13_act[0:maxlength,],sm14=sm14_act[0:maxlength,],
		sm15=sm15_act[0:maxlength,]
		)
	resFrame <- subset(resFrame,select= -c(sm1.time.c.Prec.,sm2.time.c.Prec.,sm3.time.c.Prec.,sm4.time.c.Prec.,sm5.time.c.Prec.,sm6.time.c.Prec.,sm7.time.c.Prec.,sm8.time.c.Prec.,sm9.time.c.Prec.,sm10.time.c.Prec.,sm11.time.c.Prec.,sm12.time.c.Prec.,sm13.time.c.Prec.,sm14.time.c.Prec.,sm15.time.c.Prec.))
	return(resFrame)
	
}
# move to folder above RScripts
setwd("../")
setwd("./ArtificialTraceScripts/500Samples/")

setwd("activityLogs_NQU")
NQU_ACT = getActivity()
setwd("../activityLogs_CP")
#CP_ACT = getActivity()
setwd("../activityLogs_WP")
# WP_ACT = getActivity()
setwd("../activityLogs_LIB")
# LIB_ACT = getActivity()
setwd("../activityLogs_AES")
#AES_ACT = getActivity()
setwd("../activityLogs_BFS")
BFS_ACT = getActivity()
setwd("../activityLogs_RAY")
#RAY_ACT = getActivity()
setwd("../activityLogs_STO")
# STO_ACT = getActivity()
setwd("../activityLogs_NN")
# NN_ACT = getActivity()
setwd("../activityLogs_LPS")
#LPS_ACT = getActivity()

# max_rf = max(rf_act, na.rm = TRUE)
# max_front = max(front_act, na.rm = TRUE)
# max_shmem = max(shmem_act, na.rm = TRUE)
# # max_l1r = max(l1r_act, na.rm = TRUE)
# # max_l1w = max(l1w_act, na.rm = TRUE)
# max_l1 = max(l1, na.rm = TRUE)
# max_ic = max(ic_act, na.rm = TRUE)
# max_tc = max(tc_act, na.rm = TRUE)
# max_cc = max(cc_act, na.rm = TRUE)
# max_sp = max(sp_act, na.rm = TRUE)
# max_sf = max(sf_act, na.rm = TRUE)

setwd(presDir)
