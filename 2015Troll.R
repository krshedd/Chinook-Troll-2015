#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Resummarization of 2015 Chinook Troll Mixtures ####
# Kyle Shedd Mon Jul 31 17:20:06 2017
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
date()

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Introduction ####
# The goal of this script is to re-summarize Chinook salmon mixtures from SEAK
# commercial troll harvest from 2015. Results have been provided to 26 fine-
# scale, 17 medium-scale, and 4 course-scale groups. The intent here is to
# modify the 17RG to 18RG to include NSEAK as a group (appear at >5% in sport
# mixtures), and to summarize to 8 "driver stock" RGs. The baseline used was
# GAPS 3.0 containing 357 populations grouped in 26RGs characterized by 13
# uSats.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Specific Objectives ####
# This script will:
# 1) Import 2015 troll objects
# 2) Resummarize BAYES results from .BOT files
# 3) Generate plots and tables of results
# 4) Explore new figure ideas

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Initial Setup ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15")
load("2015Troll.RData")

# Grab important objects (i.e. groupnames and groupvecs) and dput in "Objects"
objects2dput <- c("GAPSLoci", 
                  "GAPSLoci_reordered", 
                  "GroupNames17", 
                  "GroupNames26", 
                  "GroupNames4", 
                  "GroupVec17", 
                  "GroupVec26RG_357", 
                  "GroupVec4", 
                  "WinterTrollMix2015",
                  "SpringTrollMix2015",
                  "SummerTrollMix2015")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Objects/", obj, ".txt"))
}))


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# All Strata
c(WinterTrollMix2015, SpringTrollMix2015, SummerTrollMix2015)

# How strata were defined previously for stratified estimator

# StratEstEWint2015_26RG <- StratifiedEstimator.GCL(groupvec=c(1:26), groupnames=GroupNames26, maindir="V:\\Analysis\\1_SEAK\\Chinook\\Mixture\\SEAK15\\BAYES\\Output\\EWint_2015",
#                                                   mixvec=c("EWintNISISO_2015","EWintNO_2015"), catchvec=c(3297,20841), newname="TotalAreaEWint2015_90percentCI", priorname="", nchains=5)
# 
# StratEstLWint2015_26RG <- StratifiedEstimator.GCL(groupvec=c(1:26), groupnames=GroupNames26, maindir="V:\\Analysis\\1_SEAK\\Chinook\\Mixture\\SEAK15\\BAYES\\Output\\LWint_2015",
#                                                   mixvec=c("LWintNISISO_2015","LWintNO_2015"), catchvec=c(5342,21088), newname="TotalAreaLWint2015_90percentCI", priorname="", nchains=5)
# 
# StratEstSpring2015_26RG <- StratifiedEstimator.GCL(groupvec=c(1:26), groupnames=GroupNames26, maindir="V:\\Analysis\\1_SEAK\\Chinook\\Mixture\\SEAK15\\BAYES\\Output\\Spring_2015",
#                                                    mixvec=c("SpringNI_2015","SpringNO_2015","SpringSI_2015","SpringSO_2015"), catchvec=c(12780,22464,17769,711), newname="TotalAreaSpring2015_90percentCI", priorname="", nchains=5)
# 
# StratEstSumRetOne2015_26RG <- StratifiedEstimator.GCL(groupvec=c(1:26), groupnames=GroupNames26, maindir="V:\\Analysis\\1_SEAK\\Chinook\\Mixture\\SEAK15\\BAYES\\Output\\SumRet1_2015",
#                                                       mixvec=c("SumRet1NISISO_2015","SumRet1NO_2015"), catchvec=c(40157,124454), newname="TotalAreaSumRetOne2015_90percentCI", priorname="", nchains=5)

