# data.R - DESC
# ss3om_mse/data.R

# Copyright (c) WUR, 2023.
# Author: Iago MOSQUEIRA (WMR) <iago.mosqueira@wur.nl>
#
# Distributed under the terms of the EUPL-1.2


library(icesTAF)
mkdir("data")

library(ss3om)
library(mse)

source("utilities.R")

# - SET base case run

mkdir("data/run")
cp("boot/data/*", "data/run/")

# RUN ss3 in data/run

# - SETUP grid of alternative runs

mkdir("data/grid")

sce <- list(
  # Natural mortality multiplier, MG_parms["NatM_p_*_Fem_GP_1",]
  M=c(0.8, 1, 1.2),
  # steepness, SR_parms["SR_BH_steep",]
  steepness=c(0.725, 0.775, 0.825)
  )

grid <- setss3grid(sce)

# RUN ss3 in grid/*
# linux $ ls -d */ | parallel -j4 --progress cd {} '&&' ss3 '&&' packss3run

# - LOAD results

# RUN

run <- readFLSss3(dir="data/run", range=c(minfbar=3, maxfbar=7))

# BUILD OM

om <- loadOM(dir="data/grid")

oem <- loadOEM(dir="data/grid")

results <- loadRES(dir="data/grid")




# SAVE

save(run, om, file="data/data.rda", compress="xz")
