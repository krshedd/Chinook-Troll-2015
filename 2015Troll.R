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
# 5) Resummarize 2009-2014

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
#### Clean workspace; dget objects ####
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

AllYearTroll2015_18RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec18, groupnames = GroupNames18,
                          maindir="BAYES/Output/AllYearTroll_2015",
                          mixvec = c("EWintNISISO_2015", "EWintNO_2015", "LWintNISISO_2015", "LWintNO_2015", "SpringNI_2015", "SpringNO_2015", "SpringSI_2015", "SpringSO_2015", "SumRet1NISISO_2015", "SumRet1NO_2015"),
                          catchvec = c(3297, 20841, 5417, 21113, 12780, 22464, 17769, 711, 40157, 124454), 
                          newname = "StratifiedAllYearTroll2015_90percentCI_18RG", priorname = "", nchains = 5)

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

AllYearTroll2015_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2015",
                          mixvec = c("EWintNISISO_2015", "EWintNO_2015", "LWintNISISO_2015", "LWintNO_2015", "SpringNI_2015", "SpringNO_2015", "SpringSI_2015", "SpringSO_2015", "SumRet1NISISO_2015", "SumRet1NO_2015"),
                          catchvec = c(3297, 20841, 5417, 21113, 12780, 22464, 17769, 711, 40157, 124454), 
                          newname = "StratifiedAllYearTroll2015_90percentCI_8RG", priorname = "", nchains = 5)


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

objects2dput <- c("AllYearTroll2015_18RG_StratifiedEstimatesStats",
                  "AllYearTroll2015_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
SEAK15estimatesobjects <- list.files(path = "Estimates objects", recursive = FALSE, pattern = "_8RG_Stratified")
SEAK15estimatesobjects <- SEAK15estimatesobjects[10:13]
SEAK15estimatesobjects

invisible(sapply(SEAK15estimatesobjects, function(objct) {assign(x = unlist(strsplit(x = objct, split = ".txt")), value = dget(file = paste(getwd(), "Estimates objects", objct, sep = "/")), pos = 1) })); beep(2)
str(EWintTroll2015_8RG_StratifiedEstimatesStats)

Troll2015_8RG_StratifiedEstimatesStats <- list("EWintAllQuad_2015" = EWintTroll2015_8RG_StratifiedEstimatesStats$Stats,
                                               "LWintAllQuad_2015" = LWintTroll2015_8RG_StratifiedEstimatesStats$Stats,
                                               "SpringAllQuad_2015" = SpringTroll2015_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet1AllQuad_2015" = SumRet1Troll2015_8RG_StratifiedEstimatesStats$Stats)
dput(x = Troll2015_8RG_StratifiedEstimatesStats, file = "Estimates objects/Troll2015_8RG_StratifiedEstimatesStats.txt")

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### 2014 8RG Driver Stock Resummarization ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Pulled a fresh harvest report from MTA lab website to get "up to date" harvest numbers
# Copied all relevant BAYES files into one location

setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK14")
dir.create("BAYES/Output/AllYearTroll_2014")

# Need a new groupvec of length 27, not 26, because Chilkat was broken out of NSEAK
paste(readClipboard(), collapse = ", ")

AllYearTroll2014_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = c(1, GroupVec8), groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2014",
                          mixvec = c("EWintNISISO.2014", "EWintNO.2014", "LWintNISISO.2014", "LWintNO.2014", "SpringNI.2014", "SpringNO.2014", "SpringSI.2014", "SpringSO.2014", "SumRet1NISISO.2014", "SumRet1NO.2014", "SumRet2NISISO.2014", "SumRet2NO.2014"),
                          catchvec = c(3602, 10669, 6974, 35289, 7702, 22393, 11215, 1238, 41323, 158108, 24365, 31288), 
                          newname = "StratifiedAllYearTroll2014_90percentCI_8RG", priorname = "", nchains = 5)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# dir.create("Estimates objects")
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("AllYearTroll2014_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
  dput(x = get(obj), file = paste0("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15/Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs AllQuad
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK14")

EWintTroll2014_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = c(1, GroupVec8), groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2014/",
                          mixvec = c("EWintNISISO.2014", "EWintNO.2014"), catchvec = c(3602, 10669), 
                          newname = "StratifiedEWint2014_90percentCI_8RG", priorname = "", nchains = 5)

LWintTroll2014_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = c(1, GroupVec8), groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2014",
                          mixvec = c("LWintNISISO.2014", "LWintNO.2014"), catchvec = c(6974, 35289), 
                          newname = "StratifiedLWint2014_90percentCI_8RG", priorname = "", nchains = 5)

SpringTroll2014_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = c(1, GroupVec8), groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2014",
                          mixvec = c("SpringNI.2014", "SpringNO.2014", "SpringSI.2014", "SpringSO.2014"), catchvec = c(7702, 22393, 11215, 1238), 
                          newname = "StratifiedSpring2014_90percentCI_8RG", priorname = "", nchains = 5)

SumRet1Troll2014_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = c(1, GroupVec8), groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2014",
                          mixvec = c("SumRet1NISISO.2014", "SumRet1NO.2014"), catchvec = c(41323, 158108), 
                          newname = "StratifiedSumRet12014_90percentCI_8RG", priorname = "", nchains = 5)

SumRet2Troll2014_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = c(1, GroupVec8), groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2014",
                          mixvec = c("SumRet2NISISO.2014", "SumRet2NO.2014"), catchvec = c(24365, 31288), 
                          newname = "StratifiedSumRet22014_90percentCI_8RG", priorname = "", nchains = 5)


Troll2014_8RG_StratifiedEstimatesStats <- list("EWintAllQuad_2014" = EWintTroll2014_8RG_StratifiedEstimatesStats$Stats,
                                               "LWintAllQuad_2014" = LWintTroll2014_8RG_StratifiedEstimatesStats$Stats,
                                               "SpringAllQuad_2014" = SpringTroll2014_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet1AllQuad_2014" = SumRet1Troll2014_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet2AllQuad_2014" = SumRet2Troll2014_8RG_StratifiedEstimatesStats$Stats)
dput(x = Troll2014_8RG_StratifiedEstimatesStats, file = "Estimates objects/Troll2014_8RG_StratifiedEstimatesStats.txt")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### 2013 8RG Driver Stock Resummarization ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Pulled a fresh harvest report from MTA lab website to get "up to date" harvest numbers
# Copied all relevant BAYES files into one location

setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK13")
dir.create("BAYES/Output/AllYearTroll_2013")

paste(readClipboard(), collapse = ", ")

AllYearTroll2013_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2013",
                          mixvec = c("EWintNISISO.2013", "EWintNO.2013", "LWintNISISO.2013", "LWintNO.2013", "SpringNI.2013", "SpringNO.2013", "SpringSI.2013", "SumRet1NISISO.2013", "SumRet1NO.2013"),
                          catchvec = c(2569, 5619, 7946, 10414, 11073, 16502, 9733, 30361, 54289), 
                          newname = "StratifiedAllYearTroll2013_90percentCI_8RG", priorname = "", nchains = 5)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# dir.create("Estimates objects")
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("AllYearTroll2013_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
  dput(x = get(obj), file = paste0("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15/Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs AllQuad
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK13")

EWintTroll2013_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2013/",
                          mixvec = c("EWintNISISO.2013", "EWintNO.2013"), catchvec = c(2569, 5619), 
                          newname = "StratifiedEWint2013_90percentCI_8RG", priorname = "", nchains = 5)

LWintTroll2013_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2013",
                          mixvec = c("LWintNISISO.2013", "LWintNO.2013"), catchvec = c(7946, 10414), 
                          newname = "StratifiedLWint2013_90percentCI_8RG", priorname = "", nchains = 5)

SpringTroll2013_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2013",
                          mixvec = c("SpringNI.2013", "SpringNO.2013", "SpringSI.2013"), catchvec = c(11073, 16502, 9733), 
                          newname = "StratifiedSpring2013_90percentCI_8RG", priorname = "", nchains = 5)

SumRet1Troll2013_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2013",
                          mixvec = c("SumRet1NISISO.2013", "SumRet1NO.2013"), catchvec = c(30361, 54289), 
                          newname = "StratifiedSumRet12013_90percentCI_8RG", priorname = "", nchains = 5)


Troll2013_8RG_StratifiedEstimatesStats <- list("EWintAllQuad_2013" = EWintTroll2013_8RG_StratifiedEstimatesStats$Stats,
                                               "LWintAllQuad_2013" = LWintTroll2013_8RG_StratifiedEstimatesStats$Stats,
                                               "SpringAllQuad_2013" = SpringTroll2013_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet1AllQuad_2013" = SumRet1Troll2013_8RG_StratifiedEstimatesStats$Stats)
dput(x = Troll2013_8RG_StratifiedEstimatesStats, file = "Estimates objects/Troll2013_8RG_StratifiedEstimatesStats.txt")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### 2012 8RG Driver Stock Resummarization ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Pulled a fresh harvest report from MTA lab website to get "up to date" harvest numbers
# Copied all relevant BAYES files into one location

setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK12")
dir.create("BAYES/Output/AllYearTroll_2012")

paste(readClipboard(), collapse = ", ")

AllYearTroll2012_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2012",
                          mixvec = c("EWintNISISO.2012", "EWintNO.2012", "LWintNISISO.2012", "LWintNO.2012", "SpringNI.2012", "SpringNO.2012", "SpringSI.2012", "SumRet1NISISO.2012", "SumRet1NO.2012", "SumRet2NISISO.2012", "SumRet2NO.2012"),
                          catchvec = c(4119, 6566, 9005, 28212, 6274, 11466, 7031, 27286, 34338, 20056, 53914), 
                          newname = "StratifiedAllYearTroll2012_90percentCI_8RG", priorname = "", nchains = 5)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# dir.create("Estimates objects")
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("AllYearTroll2012_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
  dput(x = get(obj), file = paste0("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15/Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs AllQuad
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK12")

EWintTroll2012_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2012/",
                          mixvec = c("EWintNISISO.2012", "EWintNO.2012"), catchvec = c(4119, 6566), 
                          newname = "StratifiedEWint2012_90percentCI_8RG", priorname = "", nchains = 5)

LWintTroll2012_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2012",
                          mixvec = c("LWintNISISO.2012", "LWintNO.2012"), catchvec = c(9005, 28212), 
                          newname = "StratifiedLWint2012_90percentCI_8RG", priorname = "", nchains = 5)

SpringTroll2012_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2012",
                          mixvec = c("SpringNI.2012", "SpringNO.2012", "SpringSI.2012"), catchvec = c(6274, 11466, 7031), 
                          newname = "StratifiedSpring2012_90percentCI_8RG", priorname = "", nchains = 5)

SumRet1Troll2012_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2012",
                          mixvec = c("SumRet1NISISO.2012", "SumRet1NO.2012"), catchvec = c(27286, 34338), 
                          newname = "StratifiedSumRet12012_90percentCI_8RG", priorname = "", nchains = 5)

SumRet2Troll2012_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Output/AllYearTroll_2012",
                          mixvec = c("SumRet2NISISO.2012", "SumRet2NO.2012"), catchvec = c(20056, 53914), 
                          newname = "StratifiedSumRet22012_90percentCI_8RG", priorname = "", nchains = 5)


Troll2012_8RG_StratifiedEstimatesStats <- list("EWintAllQuad_2012" = EWintTroll2012_8RG_StratifiedEstimatesStats$Stats,
                                               "LWintAllQuad_2012" = LWintTroll2012_8RG_StratifiedEstimatesStats$Stats,
                                               "SpringAllQuad_2012" = SpringTroll2012_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet1AllQuad_2012" = SumRet1Troll2012_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet2AllQuad_2012" = SumRet2Troll2012_8RG_StratifiedEstimatesStats$Stats)
dput(x = Troll2012_8RG_StratifiedEstimatesStats, file = "Estimates objects/Troll2012_8RG_StratifiedEstimatesStats.txt")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### 2011 8RG Driver Stock Resummarization ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Pulled a fresh harvest report from MTA lab website to get "up to date" harvest numbers
# Copied all relevant BAYES files into one location

setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK11")
dir.create("BAYES/Troll/Output/AllYearTroll_2011")

paste(readClipboard(), collapse = ", ")

AllYearTroll2011_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2011",
                          mixvec = c("EWintNISISO.2011", "EWintNO.2011", "LWintNISISO.2011", "LWintNO.2011", "SpringNI.2011", "SpringNO.2011", "SpringSI.2011", "SumRet1NISISO.2011", "SumRet1NO.2011", "SumRet2NISISO.2011", "SumRet2NO.2011"),
                          catchvec = c(4890, 7977, 9385, 28574, 8859, 17531, 12546, 40714, 80202, 13364, 16372), 
                          newname = "StratifiedAllYearTroll2011_90percentCI_8RG", priorname = "", nchains = 5)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# dir.create("Estimates objects")
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("AllYearTroll2011_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
  dput(x = get(obj), file = paste0("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15/Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs AllQuad
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK11")

EWintTroll2011_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2011/",
                          mixvec = c("EWintNISISO.2011", "EWintNO.2011"), catchvec = c(4890, 7977), 
                          newname = "StratifiedEWint2011_90percentCI_8RG", priorname = "", nchains = 5)

LWintTroll2011_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2011",
                          mixvec = c("LWintNISISO.2011", "LWintNO.2011"), catchvec = c(9385, 28574), 
                          newname = "StratifiedLWint2011_90percentCI_8RG", priorname = "", nchains = 5)

SpringTroll2011_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2011",
                          mixvec = c("SpringNI.2011", "SpringNO.2011", "SpringSI.2011"), catchvec = c(8859, 17531, 12546), 
                          newname = "StratifiedSpring2011_90percentCI_8RG", priorname = "", nchains = 5)

SumRet1Troll2011_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2011",
                          mixvec = c("SumRet1NISISO.2011", "SumRet1NO.2011"), catchvec = c(40714, 80202), 
                          newname = "StratifiedSumRet12011_90percentCI_8RG", priorname = "", nchains = 5)

SumRet2Troll2011_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2011",
                          mixvec = c("SumRet2NISISO.2011", "SumRet2NO.2011"), catchvec = c(13364, 16372), 
                          newname = "StratifiedSumRet22011_90percentCI_8RG", priorname = "", nchains = 5)


Troll2011_8RG_StratifiedEstimatesStats <- list("EWintAllQuad_2011" = EWintTroll2011_8RG_StratifiedEstimatesStats$Stats,
                                               "LWintAllQuad_2011" = LWintTroll2011_8RG_StratifiedEstimatesStats$Stats,
                                               "SpringAllQuad_2011" = SpringTroll2011_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet1AllQuad_2011" = SumRet1Troll2011_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet2AllQuad_2011" = SumRet2Troll2011_8RG_StratifiedEstimatesStats$Stats)
dput(x = Troll2011_8RG_StratifiedEstimatesStats, file = "Estimates objects/Troll2011_8RG_StratifiedEstimatesStats.txt")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### 2010 8RG Driver Stock Resummarization ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Pulled a fresh harvest report from MTA lab website to get "up to date" harvest numbers
# Copied all relevant BAYES files into one location

setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK10")
dir.create("BAYES/Troll/Output/AllYearTroll_2010")

cat(paste(list.dirs(path = "BAYES/Troll/Output/AllYearTroll_2010", recursive = FALSE, full.names = FALSE), collapse = "\", \""))
paste(readClipboard(), collapse = ", ")  # Harvest data came from "Reformat Pivot" tab in V:\Analysis\1_SEAK\Chinook\Mixture\SEAK15\BAYES\Output\AllYearTroll_2015\Troll Harvest 2009-2015.xlsx

AllYearTroll2010_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2010",
                          mixvec = c("EarlyWinterNISISO.2010", "EarlyWinterNO.2010", "LateWinterNISISO.2010", "LateWinterNO.2010", "SpringNI.2010", "SpringNO.2010", "SpringSI.2010", "SummerR1NISISO.2010", "SummerR1NO.2010", "SummerR2NISISO.2010", "SummerR2NO.2010"),
                          catchvec = c(4255, 4460, 6623, 27198, 7517, 10258, 10789, 18643, 56069, 22025, 26430), 
                          newname = "StratifiedAllYearTroll2010_90percentCI_8RG", priorname = "", nchains = 5)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# dir.create("Estimates objects")
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("AllYearTroll2010_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
  dput(x = get(obj), file = paste0("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15/Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs AllQuad
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK10")

EWintTroll2010_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2010/",
                          mixvec = c("EarlyWinterNISISO.2010", "EarlyWinterNO.2010"), catchvec = c(4255, 4460), 
                          newname = "StratifiedEWint2010_90percentCI_8RG", priorname = "", nchains = 5)

LWintTroll2010_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2010",
                          mixvec = c("LateWinterNISISO.2010", "LateWinterNO.2010"), catchvec = c(6623, 27198), 
                          newname = "StratifiedLWint2010_90percentCI_8RG", priorname = "", nchains = 5)

SpringTroll2010_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2010",
                          mixvec = c("SpringNI.2010", "SpringNO.2010", "SpringSI.2010"), catchvec = c(7517, 10258, 10789), 
                          newname = "StratifiedSpring2010_90percentCI_8RG", priorname = "", nchains = 5)

SumRet1Troll2010_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2010",
                          mixvec = c("SummerR1NISISO.2010", "SummerR1NO.2010"), catchvec = c(18643, 56069), 
                          newname = "StratifiedSumRet12010_90percentCI_8RG", priorname = "", nchains = 5)

SumRet2Troll2010_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2010",
                          mixvec = c("SummerR2NISISO.2010", "SummerR2NO.2010"), catchvec = c(22025, 26430), 
                          newname = "StratifiedSumRet22010_90percentCI_8RG", priorname = "", nchains = 5)


Troll2010_8RG_StratifiedEstimatesStats <- list("EWintAllQuad_2010" = EWintTroll2010_8RG_StratifiedEstimatesStats$Stats,
                                               "LWintAllQuad_2010" = LWintTroll2010_8RG_StratifiedEstimatesStats$Stats,
                                               "SpringAllQuad_2010" = SpringTroll2010_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet1AllQuad_2010" = SumRet1Troll2010_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet2AllQuad_2010" = SumRet2Troll2010_8RG_StratifiedEstimatesStats$Stats)
dput(x = Troll2010_8RG_StratifiedEstimatesStats, file = "Estimates objects/Troll2010_8RG_StratifiedEstimatesStats.txt")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### 2009 8RG Driver Stock Resummarization ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Pulled a fresh harvest report from MTA lab website to get "up to date" harvest numbers
# Copied all relevant BAYES files into one location

setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK09")
dir.create("BAYES/Troll/Output/AllYearTroll_2009")

cat(paste(list.dirs(path = "BAYES/Troll/Output/AllYearTroll_2009", recursive = FALSE, full.names = FALSE), collapse = "\", \""))
paste(readClipboard(), collapse = ", ")  # Harvest data came from "Reformat Pivot" tab in V:\Analysis\1_SEAK\Chinook\Mixture\SEAK15\BAYES\Output\AllYearTroll_2015\Troll Harvest 2009-2015.xlsx

# Note: Instead of using "SummerR1NISISO", "SummerR1NO", "SummerR2NISISO", "SummerR2NO" (356 baseline with 25 RGs), 
# I used "SumRet1NISI_2009", "SumRet1NOSO_2009", "SumRet2NISI_2009", "SumRet2NOSO_2009" (357 baseline with 26 RGs, compatible with other mixtures)

AllYearTroll2009_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2009",
                          mixvec = c("EarlyWinterNISISO", "EarlyWinterNO", "LateWinterNISISO", "LateWinterNO", "SpringNI.2009", "SpringNO.2009", "SpringSI.2009", "SumRet1NISI_2009", "SumRet1NOSO_2009", "SumRet2NISI_2009", "SumRet2NOSO_2009"),
                          catchvec = c(2711, 2800, 3794, 15584, 7790, 16629, 8162, 4112, 80463, 1796, 31216), 
                          newname = "StratifiedAllYearTroll2009_90percentCI_8RG", priorname = "", nchains = 5)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Dput files
# dir.create("Estimates objects")
# Grab estimates objects and dput in "Estimates objects"
objects2dput <- c("AllYearTroll2009_8RG_StratifiedEstimatesStats")

invisible(sapply(objects2dput, function(obj) {
  dput(x = get(obj), file = paste0("Estimates objects/", obj, ".txt"))
  dput(x = get(obj), file = paste0("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK15/Estimates objects/", obj, ".txt"))
})); rm(objects2dput)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 8RGs AllQuad
setwd("V:/Analysis/1_SEAK/Chinook/Mixture/SEAK09")

EWintTroll2009_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2009/",
                          mixvec = c("EarlyWinterNISISO", "EarlyWinterNO"), catchvec = c(2711, 2800), 
                          newname = "StratifiedEWint2009_90percentCI_8RG", priorname = "", nchains = 5)

LWintTroll2009_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2009",
                          mixvec = c("LateWinterNISISO", "LateWinterNO"), catchvec = c(3794, 15584), 
                          newname = "StratifiedLWint2009_90percentCI_8RG", priorname = "", nchains = 5)

SpringTroll2009_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2009",
                          mixvec = c("SpringNI.2009", "SpringNO.2009", "SpringSI.2009"), catchvec = c(7790, 16629, 8162), 
                          newname = "StratifiedSpring2009_90percentCI_8RG", priorname = "", nchains = 5)

SumRet1Troll2009_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2009",
                          mixvec = c("SumRet1NISI_2009", "SumRet1NOSO_2009"), catchvec = c(4112, 80463), 
                          newname = "StratifiedSumRet12009_90percentCI_8RG", priorname = "", nchains = 5)

SumRet2Troll2009_8RG_StratifiedEstimatesStats <- 
  StratifiedEstimator.GCL(groupvec = GroupVec8, groupnames = GroupNames8,
                          maindir="BAYES/Troll/Output/AllYearTroll_2009",
                          mixvec = c("SumRet2NISI_2009", "SumRet2NOSO_2009"), catchvec = c(1796, 31216), 
                          newname = "StratifiedSumRet22009_90percentCI_8RG", priorname = "", nchains = 5)


Troll2009_8RG_StratifiedEstimatesStats <- list("EWintAllQuad_2009" = EWintTroll2009_8RG_StratifiedEstimatesStats$Stats,
                                               "LWintAllQuad_2009" = LWintTroll2009_8RG_StratifiedEstimatesStats$Stats,
                                               "SpringAllQuad_2009" = SpringTroll2009_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet1AllQuad_2009" = SumRet1Troll2009_8RG_StratifiedEstimatesStats$Stats,
                                               "SumRet2AllQuad_2009" = SumRet2Troll2009_8RG_StratifiedEstimatesStats$Stats)
dput(x = Troll2009_8RG_StratifiedEstimatesStats, file = "Estimates objects/Troll2009_8RG_StratifiedEstimatesStats.txt")


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Clean workspace; dget objects and estimates objects ####
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
#### Create Annual summary tables ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Get objects
SEAK15estimatesobjects <- list.files(path = "Estimates objects", recursive = FALSE, pattern = "AllYearTroll")
SEAK15estimatesobjects <- SEAK15estimatesobjects[-7]
SEAK15estimatesobjects

invisible(sapply(SEAK15estimatesobjects, function(objct) {assign(x = unlist(strsplit(x = objct, split = ".txt")), value = dget(file = paste(getwd(), "Estimates objects", objct, sep = "/")), pos = 1) })); beep(2)

# Dget all estimates stats
# dir.create("Estimates tables")
SEAK15estimatesobjects <- sapply(SEAK15estimatesobjects, function(objct) {unlist(strsplit(x = objct, split = ".txt"))})

AllYearTroll2009_2015_8RG_StratifiedEstimatesStats <- setNames(object = sapply(SEAK15estimatesobjects, function(yr) {get(yr)$Stats}, simplify = FALSE), nm = 2009:2015)
dput(x = AllYearTroll2009_2015_8RG_StratifiedEstimatesStats, file = "Estimates objects/AllYearTroll2009_2015_8RG_StratifiedEstimatesStats.txt")

# Get publication names
GroupNames26Pub <- readClipboard()
dput(x = GroupNames26Pub, file = "Objects/GroupNames26Pub.txt")

GroupNames8Pub <- unique(readClipboard())
GroupNames8Pub <- GroupNames8Pub[c(1:3, 5:8, 4)]
dput(x = GroupNames8Pub, file = "Objects/GroupNames8Pub.txt")

# Reformat estimates stats
AllYearTroll2009_2015_8RG_StratifiedEstimatesStats_Formatted <- sapply(AllYearTroll2009_2015_8RG_StratifiedEstimatesStats, function(yr) {
  matrix(data = yr[, 1:5], nrow = 8, ncol = 5, dimnames = list(GroupNames8Pub, c("Mean", "SD", "Median", "5%", "95%")))
}, simplify = FALSE)

# Dump a quick spreadsheet
require(xlsx)
sapply(2009:2015, function(yr) {
  write.xlsx(x = AllYearTroll2009_2015_8RG_StratifiedEstimatesStats_Formatted[[paste0(yr)]], file = "Estimates tables/AllYearTroll2009_2015_8RG_StratifiedEstimatesStats_Formatted.xlsx", col.names = TRUE, row.names = TRUE, sheetName = paste(yr, "Annual Troll 8 Driver"), append = TRUE)
})

# Get annual sample sizes
AllYearTroll2009_2015_SampleSizes <- setNames(object = as.numeric(readClipboard()), nm = 2009:2015)
dput(x = AllYearTroll2009_2015_SampleSizes, file = "Objects/AllYearTroll2009_2015_SampleSizes.txt")

# Create fully formatted spreadsheat
EstimatesStats <- AllYearTroll2009_2015_8RG_StratifiedEstimatesStats_Formatted
SampSizes <- AllYearTroll2009_2015_SampleSizes

for(yr in 2009:2015) {
  
  TableX <- matrix(data = "", nrow = 11, ncol = 7)
  TableX[1, 3] <- paste0("AY ", yr, " All Quadrants (n=", SampSizes[paste0(yr)], ")")
  TableX[2, 6] <- "90% CI"
  TableX[3, 2:7] <- c("Reporting Group", colnames(EstimatesStats[[paste0(yr)]]))
  TableX[4:11, 1] <- 1:8
  TableX[4:11, 2] <- rownames(EstimatesStats[[paste0(yr)]])
  TableX[4:11, 3:7] <- formatC(x = EstimatesStats[[paste0(yr)]], digits = 3, format = "f")
  
  write.xlsx(x = TableX, file = "Estimates tables/AllYearTroll2009_2015_8RG_StratifiedEstimatesStats_FormattedPretty.xlsx",
             col.names = FALSE, row.names = FALSE, sheetName = paste(yr, "Annual Troll 8 Driver"), append = TRUE)
  
}


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Create 2015 summary tables ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Get objects
SEAK15estimatesobjects <- list.files(path = "Estimates objects", recursive = FALSE, pattern = "_8RG")
SEAK15estimatesobjects <- SEAK15estimatesobjects[-grep(pattern = "AllYearTroll", x = SEAK15estimatesobjects)]
SEAK15estimatesobjects

invisible(sapply(SEAK15estimatesobjects, function(objct) {assign(x = unlist(strsplit(x = objct, split = ".txt")), value = dget(file = paste(getwd(), "Estimates objects", objct, sep = "/")), pos = 1) })); beep(2)


# Dget all estimates stats
SEAK15estimatesobjects <- unlist(lapply(SEAK15estimatesobjects, function(objct) {unlist(strsplit(x = objct, split = ".txt"))}))

Troll2015_8RG_EstimatesStats <- list(
  "EWintNO_2015" = EWintTroll2015_8RG_EstimatesStats[["EWintNO_2015"]],
  "EWintAllQuad_2015" = EWintTroll2015_8RG_StratifiedEstimatesStats$Stats,
  "LWintNO_2015" = LWintTroll2015_8RG_EstimatesStats[["LWintNO_2015"]],
  "LWintAllQuad_2015" = LWintTroll2015_8RG_StratifiedEstimatesStats$Stats,
  "SpringNO_2015" = SpringTroll2015_8RG_EstimatesStats[["SpringNO_2015"]],
  "SpringSI_2015" = SpringTroll2015_8RG_EstimatesStats[["SpringSI_2015"]],
  "SpringAllQuad_2015" = SpringTroll2015_8RG_StratifiedEstimatesStats$Stats,
  "SumRet1NO_2015" = SumRet1Troll2015_8RG_EstimatesStats[["SumRet1NO_2015"]],
  "SumRet1AllQuad_2015" = SumRet1Troll2015_8RG_StratifiedEstimatesStats$Stats
  )
dput(x = Troll2015_8RG_EstimatesStats, file = "Estimates objects/Troll2015_8RG_EstimatesStats.txt")
Troll2015_8RG_EstimatesStats <- dget(file = "Estimates objects/Troll2015_8RG_EstimatesStats.txt")

# Reformat estimates stats
Troll2015_8RG_EstimatesStats_Formatted <- sapply(Troll2015_8RG_EstimatesStats, function(yr) {
  matrix(data = yr[, 1:5], nrow = 8, ncol = 5, dimnames = list(GroupNames8Pub, c("Mean", "SD", "Median", "5%", "95%")))
}, simplify = FALSE)

Troll2015PubNames <- setNames(object = c("Northern Outside Quadrant",
                                         "All Quadrants",
                                         "Northern Outside Quadrant",
                                         "All Quadrants",
                                         "Northern Outside Quadrant",
                                         "Southern Inside Quadrant",
                                         "All Quadrants",
                                         "Northern Outside Quadrant",
                                         "All Quadrants"), 
                              nm = names(Troll2015_8RG_EstimatesStats_Formatted))
Troll2015_SampleSizes <- setNames(object = as.numeric(readClipboard()), 
                                  nm = names(Troll2015_8RG_EstimatesStats_Formatted))

# Create fully formatted spreadsheat
EstimatesStats <- Troll2015_8RG_EstimatesStats_Formatted
SampSizes <- Troll2015_SampleSizes

for(mix in names(EstimatesStats)) {

  TableX <- matrix(data = "", nrow = 11, ncol = 7)
  TableX[1, 3] <- paste(Troll2015PubNames[mix], "(n=", SampSizes[mix], ")")
  TableX[2, 6] <- "90% CI"
  TableX[3, 2:7] <- c("Reporting Group", colnames(EstimatesStats[[mix]]))
  TableX[4:11, 1] <- 1:8
  TableX[4:11, 2] <- rownames(EstimatesStats[[mix]])
  TableX[4:11, 3:7] <- formatC(x = EstimatesStats[[mix]], digits = 3, format = "f")
  
  write.xlsx(x = TableX, file = "Estimates tables/Troll2015_8RG_StratifiedEstimatesStats_FormattedPretty.xlsx",
             col.names = FALSE, row.names = FALSE, sheetName = paste(mix, " Troll 8 Driver"), append = TRUE)
  
}

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
#### Create 2015 HeatMaps ####
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# dir.create("Figures")

# Create layout
layoutmat <- matrix(c(9,1,2,11,
                      9,3,4,11,
                      9,5,6,11,
                      9,7,8,11,
                      12,10,10,13), ncol=4,nrow=5,byrow=T)
SEAKTrollLayout <- layout(layoutmat,widths=c(0.25,1,1,0.25),heights=c(1,1,1,1,0.25))
layout.show(SEAKTrollLayout)

# Set color ramp
library('lattice')
WhiteRedColPalette <- colorRampPalette(colors=c("white","red"))
WhiteRedcol <- level.colors(x=seq(from=0,to=1,by=0.01), at = seq(from=0,to=1,by=0.01), col.regions = WhiteRedColPalette(100))

# Mixture names
mixnames <- names(EstimatesStats)[-6]

# Create list object with by RG stock comps
HeatmapEstimates <- sapply(GroupNames8Pub, function(RG) {
  matrix(data = sapply(mixnames, function(mix) {EstimatesStats[[mix]][RG, "Mean"] }),
         nrow = 2, ncol = 4, dimnames = list(c("NO", "AllQuad"), c("EWint", "LWint", "Spring", "SumRet1"))
  )
}, simplify = FALSE)
zmax <- max(sapply(HeatmapEstimates, max))
dput(x = HeatmapEstimates, file = "Estimates objects/HeatmapEstimates.txt")
HeatmapEstimates <- dget(file = "Estimates objects/HeatmapEstimates.txt")

# Stratify across AY for FDS report
sapply(HeatmapEstimates, function(RG) {mean(RG["AllQuad", ])})
TrollHarvest2015 <- as.numeric(readClipboard())
StockSpecificAnnualTrollHarvest2015 <- sapply(HeatmapEstimates, function(RG) {sum(RG["AllQuad", ] * TrollHarvest2015)} )
sort(StockSpecificAnnualTrollHarvest2015, decreasing = TRUE)
100 - (StockSpecificAnnualTrollHarvest2015["Other"] / sum(StockSpecificAnnualTrollHarvest2015)) * 100


Testing <- matrix(c(seq(from = 0, to = zmax, length.out = 102), seq(from = 0, to = zmax, length.out = 102)), nrow = 2, ncol = 102, byrow = T)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Plot: Can't do a nested layout, writing out as pdf then pasting in other pdf

# GroupNames8Pub2 <- GroupNames8Pub
# GroupNames8Pub2[3] <- "West Vancouver"
# dput(x = GroupNames8Pub2, file = "Objects/GroupNames8Pub2.txt")
names(HeatmapEstimates) <- GroupNames8Pub2


# pdf("Figures/2015TrollByFisheryQuadrant.pdf", family = "Times", width = 6.5, height = 6.5, title = "2015 Troll By Fishery and Quadrant")
png("Figures/2015TrollByFisheryQuadrant.png", family = "Times", width = 6.5, height = 6.5, units = "in", res = 300)
# x11(width = 6.5, height = 6.5)
par(xaxt = "n", yaxt = "n", omi = rep(0.1, 4), mar = rep(0.1, 4), family = 'serif')
layout(layoutmat,widths=c(0.3,1,1,0.25),heights=c(1,1,1,1,0.4))

## Loop through Reporting Group plots
sapply(GroupNames8Pub2, function(RG) {
  image(t(HeatmapEstimates[[RG]])[, c("AllQuad", "NO")], zlim = c(0, zmax), col = WhiteRedcol, xlab = "", ylab = "", breaks = seq(from = 0, to = zmax, length.out = 102), useRaster = TRUE)
  abline(h = 0.5, lwd = 2, col = 'grey')
  abline(v = c(0.175, 0.5, 0.83), lwd= 2 , col = 'grey')
  abline(h = c(-0.5, 1.5), v = c(-0.17, 1.17),lwd = 5, col = 'black')
  text(labels = RG, cex = 2, adj = c(0, 0.5), x = -0.1, y = 1)
})

## Plot 10 - Y-axis label
plot.new()
text(labels = "Quadrant", cex = 3, srt = 90, x = 0.3, y = 0.5, adj = c(0.5, 0))
text(labels = "NO", cex = 2, x = 0.99, y = c(0.97, 0.7, 0.43, 0.16), adj = c(1, 0.5))
text(labels = "All", cex = 2, x = 0.99, y = c(0.97, 0.7, 0.43, 0.16) - 0.135, adj = c(1, 0.5))

## Plot 11 - X-axis label
plot.new()
text(labels = "Fishery", cex = 3, adj = c(0.5, 0.5), x = 0.5, y = 0.35)
text(labels = "EW", cex = 2, adj = c(0.5, 0.5), x = c(0.04, 0.57), y = 0.8)
text(labels = "LW", cex = 2, adj = c(0.5, 0.5), x = c(0.04 + 0.125, 0.57 + 0.13), y = 0.8)
text(labels = "SP", cex = 2, adj = c(0.5, 0.5), x = c(0.04 + 0.255, 0.57 + 0.27), y = 0.8)
text(labels = "SU1", cex = 2, adj = c(0.5, 0.5), x = c(0.04 + 0.385, 0.57 + 0.4), y = 0.8)

## Plot 13 - Legend
image(Testing, col = WhiteRedcol, xlab = "", ylab = "", breaks = seq(from = 0, to = zmax, length.out = 102))
text(labels = "0%", cex = 2.8, adj = c(0.5, 0.5), x = 0.5, y = 0.03)
text(labels = "50%", cex = 2.8, adj = c(0.5, 0.5), x = 0.5, y = 0.98)
abline(h = c(-0.005,  1.005),  v  =  c(-0.5,  1.5), lwd = 5, col = 'black')
dev.off()
dev.off()
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
