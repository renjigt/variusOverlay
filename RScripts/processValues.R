source('./powerMUM.R')
source('./powerNQU.R')
source('./powerCP.R')
source('./powerBFS.R')
source('./powerSTO.R')
source('./powerLIB.R')
source('./powerWP.R')
source('./powerNN.R')
source('./powerRay.R')
source('./powerAES.R')
source('./powerLPS.R')


list_IBP = c(max(LPSIBP_Power$GPUWattch),max(MUMIBP_Power$GPUWattch),max(AESIBP_Power$GPUWattch),max(RAYIBP_Power$GPUWattch),max(NNIBP_Power$GPUWattch),max(WPIBP_Power$GPUWattch),max(LIBIBP_Power$GPUWattch),max(STOIBP_Power$GPUWattch),max(BFSIBP_Power$GPUWattch),max(CPIBP_Power$GPUWattch),max(NQUIBP_Power$GPUWattch))

list_TCP = c(max(LPSTCP_Power$GPUWattch),max(MUMTCP_Power$GPUWattch),max(AESTCP_Power$GPUWattch),max(RAYTCP_Power$GPUWattch),max(NNTCP_Power$GPUWattch),max(WPTCP_Power$GPUWattch),max(LIBTCP_Power$GPUWattch),max(STOTCP_Power$GPUWattch),max(BFSTCP_Power$GPUWattch),max(CPTCP_Power$GPUWattch),max(NQUTCP_Power$GPUWattch))

list_SP = c(max(LPSSPP_Power$GPUWattch),max(MUMSPP_Power$GPUWattch),max(AESSPP_Power$GPUWattch),max(RAYSPP_Power$GPUWattch),max(NNSPP_Power$GPUWattch),max(WPSPP_Power$GPUWattch),max(LIBSPP_Power$GPUWattch),max(STOSPP_Power$GPUWattch),max(BFSSPP_Power$GPUWattch),max(CPSPP_Power$GPUWattch),max(NQUSPP_Power$GPUWattch))

list_SHRD = c(max(LPSSHRDP_Power$GPUWattch),max(MUMSHRDP_Power$GPUWattch),max(AESSHRDP_Power$GPUWattch),max(RAYSHRDP_Power$GPUWattch),max(NNSHRDP_Power$GPUWattch),max(WPSHRDP_Power$GPUWattch),max(LIBSHRDP_Power$GPUWattch),max(STOSHRDP_Power$GPUWattch),max(BFSSHRDP_Power$GPUWattch),max(CPSHRDP_Power$GPUWattch),max(NQUSHRDP_Power$GPUWattch))

list_SFU =c(max(LPSSFUP_Power$GPUWattch),max(MUMSFUP_Power$GPUWattch),max(AESSFUP_Power$GPUWattch),max(RAYSFUP_Power$GPUWattch),max(NNSFUP_Power$GPUWattch),max(WPSFUP_Power$GPUWattch),max(LIBSFUP_Power$GPUWattch),max(STOSFUP_Power$GPUWattch),max(BFSSFUP_Power$GPUWattch),max(CPSFUP_Power$GPUWattch),max(NQUSFUP_Power$GPUWattch))

list_SCHED = c(max(LPSSCHEDP_Power$GPUWattch),max(MUMSCHEDP_Power$GPUWattch),max(AESSCHEDP_Power$GPUWattch),max(RAYSCHEDP_Power$GPUWattch),max(NNSCHEDP_Power$GPUWattch),max(WPSCHEDP_Power$GPUWattch),max(LIBSCHEDP_Power$GPUWattch),max(STOSCHEDP_Power$GPUWattch),max(BFSSCHEDP_Power$GPUWattch),max(CPSCHEDP_Power$GPUWattch),max(NQUSCHEDP_Power$GPUWattch))

list_RF = c(max(LPSRFP_Power$GPUWattch),max(MUMRFP_Power$GPUWattch),max(AESRFP_Power$GPUWattch),max(RAYRFP_Power$GPUWattch),max(NNRFP_Power$GPUWattch),max(WPRFP_Power$GPUWattch),max(LIBRFP_Power$GPUWattch),max(STORFP_Power$GPUWattch),max(BFSRFP_Power$GPUWattch),max(CPRFP_Power$GPUWattch),max(NQURFP_Power$GPUWattch))

list_PIPE = c(max(LPSPIPEP_Power$GPUWattch),max(MUMPIPEP_Power$GPUWattch),max(AESPIPEP_Power$GPUWattch),max(RAYPIPEP_Power$GPUWattch),max(NNPIPEP_Power$GPUWattch),max(WPPIPEP_Power$GPUWattch),max(LIBPIPEP_Power$GPUWattch),max(STOPIPEP_Power$GPUWattch),max(BFSPIPEP_Power$GPUWattch),max(CPPIPEP_Power$GPUWattch),max(NQUPIPEP_Power$GPUWattch))

list_IC = c(max(LPSICP_Power$GPUWattch),max(MUMICP_Power$GPUWattch),max(AESICP_Power$GPUWattch),max(RAYICP_Power$GPUWattch),max(NNICP_Power$GPUWattch),max(WPICP_Power$GPUWattch),max(LIBICP_Power$GPUWattch),max(STOICP_Power$GPUWattch),max(BFSICP_Power$GPUWattch),max(CPICP_Power$GPUWattch),max(NQUICP_Power$GPUWattch))

list_FP = c(max(LPSFPUP_Power$GPUWattch),max(MUMFPUP_Power$GPUWattch),max(AESFPUP_Power$GPUWattch),max(RAYFPUP_Power$GPUWattch),max(NNFPUP_Power$GPUWattch),max(WPFPUP_Power$GPUWattch),max(LIBFPUP_Power$GPUWattch),max(STOFPUP_Power$GPUWattch),max(BFSFPUP_Power$GPUWattch),max(CPFPUP_Power$GPUWattch),max(NQUFPUP_Power$GPUWattch))

list_DC = c(max(LPSDCP_Power$GPUWattch),max(MUMDCP_Power$GPUWattch),max(AESDCP_Power$GPUWattch),max(RAYDCP_Power$GPUWattch),max(NNDCP_Power$GPUWattch),max(WPDCP_Power$GPUWattch),max(LIBDCP_Power$GPUWattch),max(STODCP_Power$GPUWattch),max(BFSDCP_Power$GPUWattch),max(CPDCP_Power$GPUWattch),max(NQUDCP_Power$GPUWattch))

list_CC = c(max(LPSCCP_Power$GPUWattch),max(MUMCCP_Power$GPUWattch),max(AESCCP_Power$GPUWattch),max(RAYCCP_Power$GPUWattch),max(NNCCP_Power$GPUWattch),max(WPCCP_Power$GPUWattch),max(LIBCCP_Power$GPUWattch),max(STOCCP_Power$GPUWattch),max(BFSCCP_Power$GPUWattch),max(CPCCP_Power$GPUWattch),max(NQUCCP_Power$GPUWattch))

maxIBP =max(list_IBP)
maxTCP =max(list_TCP)
maxSP =max(list_SP)
maxSHRD =max(list_SHRD)
maxSFU =max(list_SFU)
maxSCHED =max(list_SCHED)
maxRF =max(list_RF)
maxPIPE =max(list_PIPE)
maxIC =max(list_IC)
maxFP =max(list_FP)
maxDC =max(list_DC)
maxCC =max(list_CC)

maxTotal =maxIBP +maxTCP +maxSP +maxSHRD +maxSFU +maxSCHED +maxRF +maxPIPE +maxIC +maxFP +maxDC +maxCC


list_IBP_pa = c(mean(LPSIBP_Power$Power.Access),mean(MUMIBP_Power$Power.Access),mean(AESIBP_Power$Power.Access),mean(RAYIBP_Power$Power.Access),mean(NNIBP_Power$Power.Access),mean(WPIBP_Power$Power.Access),mean(LIBIBP_Power$Power.Access),mean(STOIBP_Power$Power.Access),mean(BFSIBP_Power$Power.Access),mean(CPIBP_Power$Power.Access),mean(NQUIBP_Power$Power.Access))

list_TCP_pa = c(mean(LPSTCP_Power$Power.Access),mean(MUMTCP_Power$Power.Access),mean(AESTCP_Power$Power.Access),mean(RAYTCP_Power$Power.Access),mean(NNTCP_Power$Power.Access),mean(WPTCP_Power$Power.Access),mean(LIBTCP_Power$Power.Access),mean(STOTCP_Power$Power.Access),mean(BFSTCP_Power$Power.Access),mean(CPTCP_Power$Power.Access),mean(NQUTCP_Power$Power.Access))

list_SP_pa = c(mean(LPSSPP_Power$Power.Access),mean(MUMSPP_Power$Power.Access),mean(AESSPP_Power$Power.Access),mean(RAYSPP_Power$Power.Access),mean(NNSPP_Power$Power.Access),mean(WPSPP_Power$Power.Access),mean(LIBSPP_Power$Power.Access),mean(STOSPP_Power$Power.Access),mean(BFSSPP_Power$Power.Access),mean(CPSPP_Power$Power.Access),mean(NQUSPP_Power$Power.Access))

list_SHRD_pa = c(mean(LPSSHRDP_Power$Power.Access),mean(MUMSHRDP_Power$Power.Access),mean(AESSHRDP_Power$Power.Access),mean(RAYSHRDP_Power$Power.Access),mean(NNSHRDP_Power$Power.Access),mean(WPSHRDP_Power$Power.Access),mean(LIBSHRDP_Power$Power.Access),mean(STOSHRDP_Power$Power.Access),mean(BFSSHRDP_Power$Power.Access),mean(CPSHRDP_Power$Power.Access),mean(NQUSHRDP_Power$Power.Access))

list_SFU_pa =c(mean(LPSSFUP_Power$Power.Access),mean(MUMSFUP_Power$Power.Access),mean(AESSFUP_Power$Power.Access),mean(RAYSFUP_Power$Power.Access),mean(NNSFUP_Power$Power.Access),mean(WPSFUP_Power$Power.Access),mean(LIBSFUP_Power$Power.Access),mean(STOSFUP_Power$Power.Access),mean(BFSSFUP_Power$Power.Access),mean(CPSFUP_Power$Power.Access),mean(NQUSFUP_Power$Power.Access))

list_SCHED_pa = c(mean(LPSSCHEDP_Power$Power.Access),mean(MUMSCHEDP_Power$Power.Access),mean(AESSCHEDP_Power$Power.Access),mean(RAYSCHEDP_Power$Power.Access),mean(NNSCHEDP_Power$Power.Access),mean(WPSCHEDP_Power$Power.Access),mean(LIBSCHEDP_Power$Power.Access),mean(STOSCHEDP_Power$Power.Access),mean(BFSSCHEDP_Power$Power.Access),mean(CPSCHEDP_Power$Power.Access),mean(NQUSCHEDP_Power$Power.Access))

list_RF_pa = c(mean(LPSRFP_Power$Power.Access),mean(MUMRFP_Power$Power.Access),mean(AESRFP_Power$Power.Access),mean(RAYRFP_Power$Power.Access),mean(NNRFP_Power$Power.Access),mean(WPRFP_Power$Power.Access),mean(LIBRFP_Power$Power.Access),mean(STORFP_Power$Power.Access),mean(BFSRFP_Power$Power.Access),mean(CPRFP_Power$Power.Access),mean(NQURFP_Power$Power.Access))

list_PIPE_pa = c(mean(LPSPIPEP_Power$Power.Access),mean(MUMPIPEP_Power$Power.Access),mean(AESPIPEP_Power$Power.Access),mean(RAYPIPEP_Power$Power.Access),mean(NNPIPEP_Power$Power.Access),mean(WPPIPEP_Power$Power.Access),mean(LIBPIPEP_Power$Power.Access),mean(STOPIPEP_Power$Power.Access),mean(BFSPIPEP_Power$Power.Access),mean(CPPIPEP_Power$Power.Access),mean(NQUPIPEP_Power$Power.Access))

list_IC_pa = c(mean(LPSICP_Power$Power.Access),mean(MUMICP_Power$Power.Access),mean(AESICP_Power$Power.Access),mean(RAYICP_Power$Power.Access),mean(NNICP_Power$Power.Access),mean(WPICP_Power$Power.Access),mean(LIBICP_Power$Power.Access),mean(STOICP_Power$Power.Access),mean(BFSICP_Power$Power.Access),mean(CPICP_Power$Power.Access),mean(NQUICP_Power$Power.Access))

list_FP_pa = c(mean(LPSFPUP_Power$Power.Access),mean(MUMFPUP_Power$Power.Access),mean(AESFPUP_Power$Power.Access),mean(RAYFPUP_Power$Power.Access),mean(NNFPUP_Power$Power.Access),mean(WPFPUP_Power$Power.Access),mean(LIBFPUP_Power$Power.Access),mean(STOFPUP_Power$Power.Access),mean(BFSFPUP_Power$Power.Access),mean(CPFPUP_Power$Power.Access),mean(NQUFPUP_Power$Power.Access))

list_DC_pa = c(mean(LPSDCP_Power$Power.Access),mean(MUMDCP_Power$Power.Access),mean(AESDCP_Power$Power.Access),mean(RAYDCP_Power$Power.Access),mean(NNDCP_Power$Power.Access),mean(WPDCP_Power$Power.Access),mean(LIBDCP_Power$Power.Access),mean(STODCP_Power$Power.Access),mean(BFSDCP_Power$Power.Access),mean(CPDCP_Power$Power.Access),mean(NQUDCP_Power$Power.Access))

list_CC_pa = c(mean(LPSCCP_Power$Power.Access),mean(MUMCCP_Power$Power.Access),mean(AESCCP_Power$Power.Access),mean(RAYCCP_Power$Power.Access),mean(NNCCP_Power$Power.Access),mean(WPCCP_Power$Power.Access),mean(LIBCCP_Power$Power.Access),mean(STOCCP_Power$Power.Access),mean(BFSCCP_Power$Power.Access),mean(CPCCP_Power$Power.Access),mean(NQUCCP_Power$Power.Access))

maxIBP_pa =mean(list_IBP_pa)
maxTCP_pa =mean(list_TCP_pa)
maxSP_pa =mean(list_SP_pa)
maxSHRD_pa =mean(list_SHRD_pa)
maxSFU_pa =mean(list_SFU_pa)
maxSCHED_pa =mean(list_SCHED_pa)
maxRF_pa =mean(list_RF_pa)
maxPIPE_pa =mean(list_PIPE_pa)
maxIC_pa =mean(list_IC_pa)
maxFP_pa =mean(list_FP_pa)
maxDC_pa =mean(list_DC_pa)
maxCC_pa =mean(list_CC_pa)

maxTotal_pa =(maxIBP_pa * 656) +(maxTCP_pa * 512) +(maxSP_pa * 512) +(maxSHRD_pa * 512) +(maxSFU_pa * 512) +(maxSCHED_pa *16) +(maxRF_pa * 512) +(maxPIPE_pa * (512+512+512+512+512+16)) +(maxIC_pa * 528) +(maxFP_pa * 512) +(maxDC_pa * 512) +(maxCC_pa * 512)