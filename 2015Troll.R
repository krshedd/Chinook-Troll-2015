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
# load("2015Troll.RData")

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
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Clean workspace; dget .gcl objects and Locus Control ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
rm(list = ls(all = TRUE))
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15")

# This sources all of the new GCL functions to this workspace
source("C:/Users/krshedd/Documents/R/Functions.GCL.R")
source("H:/R Source Scripts/Functions.GCL_KS.R")

## Get objects
SEAK15objects <- list.files(path = "Objects", recursive = FALSE)
SEAK15objects <- SEAK15objects[!SEAK15objects %in% c("sillys_sport.txt", "sillys_sportD8&11.txt", "sillys_troll.txt")]
SEAK15objects

invisible(sapply(SEAK15objects, function(objct) {assign(x = unlist(strsplit(x = objct, split = ".txt")), value = dget(file = paste(getwd(), "Objects", objct, sep = "/")), pos = 1) })); beep(2)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### New RG Vectors ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 18RG = 17RG with NSEAK broken out (i.e. all sport/troll stocks that are ever >5% in mixtures)
GroupNames17; GroupVec17

GroupNames18 <- c("NSEAK", GroupNames17)
dput(x = GroupNames18, file = "Objects/GroupNames18.txt")

GroupVec18 <- GroupVec17 + 1
GroupVec18[3] <- 1
dput(x = GroupVec18, file = "Objects/GroupVec18.txt")

# 8 "Driver Stock" RGs
GroupNames8 <- c("SEAK/TBR", "NCBC", "WCVI", "SThompson", "WACoast", "IntColSuFa", "ORCoast", "Other")
dput(x = GroupNames8, file = "Objects/GroupNames8.txt")

GroupVec8 <- c(rep(1, 7), rep(2, 3), 3, rep(8, 4), 4, 8, 5, rep(8, 4), 6, rep(7, 2), 8)
dput(x = GroupVec8, file = "Objects/GroupVec8.txt")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Resummarize Estimates to New RGs ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
### All Strata
c(WinterTrollMix2015, SpringTrollMix2015, SummerTrollMix2015)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 18RGs
EWintTroll2015_18RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                               maindir = "BAYES/Output/EWint_2015", 
                               mixvec = WinterTrollMix2015[1:2], prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)

LWintTroll2015_18RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                               maindir = "BAYES/Output/LWint_2015", 
                               mixvec = WinterTrollMix2015[3:4], prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)

SpringTroll2015_18RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                               maindir = "BAYES/Output/Spring_2015", 
                               mixvec = SpringTrollMix2015, prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)

SumRet1Troll2015_18RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                               maindir = "BAYES/Output/SumRet1_2015", 
                               mixvec = SummerTrollMix2015[1:2], prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs
EWintTroll2015_8RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                               maindir = "BAYES/Output/EWint_2015", 
                               mixvec = WinterTrollMix2015[1:2], prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)

LWintTroll2015_8RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                               maindir = "BAYES/Output/LWint_2015", 
                               mixvec = WinterTrollMix2015[3:4], prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)

SpringTroll2015_8RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                               maindir = "BAYES/Output/Spring_2015", 
                               mixvec = SpringTrollMix2015, prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)

SumRet1Troll2015_8RG_EstimatesStats <- 
  CustomCombineBAYESOutput.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                               maindir = "BAYES/Output/SumRet1_2015", 
                               mixvec = SummerTrollMix2015[1:2], prior = "",
                               ext = "RGN", nchains = 5, burn = 0.5, alpha = 0.1, PosteriorOutput = FALSE)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# dir.create("Estimates objects")
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("EWintTroll2015_18RG_EstimatesStats", 
                  "LWintTroll2015_18RG_EstimatesStats", 
                  "SpringTroll2015_18RG_EstimatesStats", 
                  "SumRet1Troll2015_18RG_EstimatesStats", 
                  "EWintTroll2015_8RG_EstimatesStats", 
                  "LWintTroll2015_8RG_EstimatesStats", 
                  "SpringTroll2015_8RG_EstimatesStats", 
                  "SumRet1Troll2015_8RG_EstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Resummarize Stratified Estimates to New RGs ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 18RGs
EWintTroll2015_18RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                          maindir="BAYES/Output/EWint_2015",
                          mixvec = c("EWintNISISO_2015", "EWintNO_2015"), catchvec = c(3297, 20841), 
                          newname = "StratifiedEWint2015_90percentCI_18RG", priorname = "", nchains = 5)

LWintTroll2015_18RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                          maindir="BAYES/Output/LWint_2015",
                          mixvec = c("LWintNISISO_2015", "LWintNO_2015"), catchvec = c(5417, 21113), 
                          newname = "StratifiedLWint2015_90percentCI_18RG", priorname = "", nchains = 5)

SpringTroll2015_18RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                          maindir="BAYES/Output/Spring_2015",
                          mixvec = c("SpringNI_2015", "SpringNO_2015", "SpringSI_2015", "SpringSO_2015"), catchvec = c(12780, 22464, 17769, 711), 
                          newname = "StratifiedSpring2015_90percentCI_18RG", priorname = "", nchains = 5)

SumRet1Troll2015_18RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                          maindir="BAYES/Output/SumRet1_2015",
                          mixvec = c("SumRet1NISISO_2015", "SumRet1NO_2015"), catchvec = c(40157, 124454), 
                          newname = "StratifiedSumRet12015_90percentCI_18RG", priorname = "", nchains = 5)
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs
EWintTroll2015_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/EWint_2015",
                          mixvec = c("EWintNISISO_2015", "EWintNO_2015"), catchvec = c(3297, 20841), 
                          newname = "StratifiedEWint2015_90percentCI_8RG", priorname = "", nchains = 5)

LWintTroll2015_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/LWint_2015",
                          mixvec = c("LWintNISISO_2015", "LWintNO_2015"), catchvec = c(5417, 21113), 
                          newname = "StratifiedLWint2015_90percentCI_8RG", priorname = "", nchains = 5)

SpringTroll2015_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/Spring_2015",
                          mixvec = c("SpringNI_2015", "SpringNO_2015", "SpringSI_2015", "SpringSO_2015"), catchvec = c(12780, 22464, 17769, 711), 
                          newname = "StratifiedSpring2015_90percentCI_8RG", priorname = "", nchains = 5)

SumRet1Troll2015_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/SumRet1_2015",
                          mixvec = c("SumRet1NISISO_2015", "SumRet1NO_2015"), catchvec = c(40157, 124454), 
                          newname = "StratifiedSumRet12015_90percentCI_8RG", priorname = "", nchains = 5)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("EWintTroll2015_18RG_StratifiedEstimatesStats", 
                  "LWintTroll2015_18RG_StratifiedEstimatesStats", 
                  "SpringTroll2015_18RG_StratifiedEstimatesStats", 
                  "SumRet1Troll2015_18RG_StratifiedEstimatesStats", 
                  "EWintTroll2015_8RG_StratifiedEstimatesStats", 
                  "LWintTroll2015_8RG_StratifiedEstimatesStats", 
                  "SpringTroll2015_8RG_StratifiedEstimatesStats", 
                  "SumRet1Troll2015_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
})); rm(objects2dput)
