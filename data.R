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

# - SET base case run

mkdir("data/run")
cp("boot/data/*", "data/run/")

# RUN ss3 in data/run

# - LOAD om

run <- readFLomss3('data/run/')

# - RUN hindcast

hin <- propagate(run, 500)

srdevs <- rlnormar1(500, 0, sdlog=sqrt(yearVars(residuals(sr(run)))),
  rho=rho(residuals(sr(run))), years=2000:2022)

om <- fwd(hin, sr=rec(run), deviances=srdevs,
  catch=catch(run)[, ac(2000:2022)])

# CHECK

ssb(run)[,'2022']
iterMeans(ssb(om)[,'2022'])
iterMedians(ssb(om)[,'2022'])

# SET future 

futdevs <- rlnormar1(500, 0, sdlog=sqrt(yearVars(residuals(sr(run)))),
  rho=rho(residuals(sr(run))), years=2023:2042)

om <- fwdWindow(om, end=2042, deviances=futdevs)

# - LOAD OEM

# SAVE

save(om, file="data/data.rda", compress="xz")
