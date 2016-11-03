presDir = getwd()
# setwd("../10000Samples/activityLogs_CP")
# setwd("../10000Samples/activityLogs_NQU")
# setwd("../10000Samples/activityLogs_LIB")
# setwd("../10000Samples/activityLogs_LPS")
# setwd("../10000Samples/activityLogs_BFS")
# setwd("../10000Samples/activityLogs_AES")
# setwd("../10000Samples/activityLogs_WP")
# setwd("../10000Samples/activityLogs_STO")
# setwd("../10000Samples/activityLogs_NN")
setwd("../")
setwd("./ArtificialTraceScripts/500Samples/activityLogs_NQU")
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

rf_act = c(sm0_act$RF,sm1_act$RF,sm2_act$RF,sm3_act$RF,sm4_act$RF,sm5_act$RF,sm6_act$RF,sm7_act$RF,sm8_act$RF,sm9_act$RF,sm10_act$RF,sm11_act$RF,sm12_act$RF,sm13_act$RF,sm14_act$RF,sm15_act$RF)

front_act = c(sm0_act$FRONT,sm1_act$FRONT,sm2_act$FRONT,sm3_act$FRONT,sm4_act$FRONT,sm5_act$FRONT,sm6_act$FRONT,sm7_act$FRONT,sm8_act$FRONT,sm9_act$FRONT,sm10_act$FRONT,sm11_act$FRONT,sm12_act$FRONT,sm13_act$FRONT,sm14_act$FRONT,sm15_act$FRONT)

shmem_act = c(sm0_act$SHMEM,sm1_act$SHMEM,sm2_act$SHMEM,sm3_act$SHMEM,sm4_act$SHMEM,sm5_act$SHMEM,sm6_act$SHMEM,sm7_act$SHMEM,sm8_act$SHMEM,sm9_act$SHMEM,sm10_act$SHMEM,sm11_act$SHMEM,sm12_act$SHMEM,sm13_act$SHMEM,sm14_act$SHMEM,sm15_act$SHMEM)

l1r_act = c(sm0_act$L1Read,sm1_act$L1Read,sm2_act$L1Read,sm3_act$L1Read,sm4_act$L1Read,sm5_act$L1Read,sm6_act$L1Read,sm7_act$L1Read,sm8_act$L1Read,sm9_act$L1Read,sm10_act$L1Read,sm11_act$L1Read,sm12_act$L1Read,sm13_act$L1Read,sm14_act$L1Read,sm15_act$L1Read)

l1w_act = c(sm0_act$L1Write,sm1_act$L1Write,sm2_act$L1Write,sm3_act$L1Write,sm4_act$L1Write,sm5_act$L1Write,sm6_act$L1Write,sm7_act$L1Write,sm8_act$L1Write,sm9_act$L1Write,sm10_act$L1Write,sm11_act$L1Write,sm12_act$L1Write,sm13_act$L1Write,sm14_act$L1Write,sm15_act$L1Write)

l1 = l1r_act + l1w_act

ic_act = c(sm0_act$ICache,sm1_act$ICache,sm2_act$ICache,sm3_act$ICache,sm4_act$ICache,sm5_act$ICache,sm6_act$ICache,sm7_act$ICache,sm8_act$ICache,sm9_act$ICache,sm10_act$ICache,sm11_act$ICache,sm12_act$ICache,sm13_act$ICache,sm14_act$ICache,sm15_act$ICache)

tc_act = c(sm0_act$TCache,sm1_act$TCache,sm2_act$TCache,sm3_act$TCache,sm4_act$TCache,sm5_act$TCache,sm6_act$TCache,sm7_act$TCache,sm8_act$TCache,sm9_act$TCache,sm10_act$TCache,sm11_act$TCache,sm12_act$TCache,sm13_act$TCache,sm14_act$TCache,sm15_act$TCache)

cc_act = c(sm0_act$CCache,sm1_act$CCache,sm2_act$CCache,sm3_act$CCache,sm4_act$CCache,sm5_act$CCache,sm6_act$CCache,sm7_act$CCache,sm8_act$CCache,sm9_act$CCache,sm10_act$CCache,sm11_act$CCache,sm12_act$CCache,sm13_act$CCache,sm14_act$CCache,sm15_act$CCache)

sp_act = c(sm0_act$SP,sm1_act$SP,sm2_act$SP,sm3_act$SP,sm4_act$SP,sm5_act$SP,sm6_act$SP,sm7_act$SP,sm8_act$SP,sm9_act$SP,sm10_act$SP,sm11_act$SP,sm12_act$SP,sm13_act$SP,sm14_act$SP,sm15_act$SP)

sf_act = c(sm0_act$SFU,sm1_act$SFU,sm2_act$SFU,sm3_act$SFU,sm4_act$SFU,sm5_act$SFU,sm6_act$SFU,sm7_act$SFU,sm8_act$SFU,sm9_act$SFU,sm10_act$SFU,sm11_act$SFU,sm12_act$SFU,sm13_act$SFU,sm14_act$SFU,sm15_act$SFU)


max_rf = max(rf_act, na.rm = TRUE)
max_front = max(front_act, na.rm = TRUE)
max_shmem = max(shmem_act, na.rm = TRUE)
# max_l1r = max(l1r_act, na.rm = TRUE)
# max_l1w = max(l1w_act, na.rm = TRUE)
max_l1 = max(l1, na.rm = TRUE)
max_ic = max(ic_act, na.rm = TRUE)
max_tc = max(tc_act, na.rm = TRUE)
max_cc = max(cc_act, na.rm = TRUE)
max_sp = max(sp_act, na.rm = TRUE)
max_sf = max(sf_act, na.rm = TRUE)

setwd(presDir)
