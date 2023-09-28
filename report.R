# report.R - DESC
# /home/mosqu003/FLR/gallery/MSE/ss3om_mse_her3031/report.R

# Copyright (c) WUR, 2023.
# Author: Iago MOSQUEIRA (WMR) <iago.mosqueira@wur.nl>
#
# Distributed under the terms of the EUPL-1.2


library(icesTAF)
mkdir("report")

library(mse)

# 
load("data/data.rda")

taf.png("data_omrun.png")
plot(FLStocks(OM=window(stock(om), end=2022), SA=stock(run))) +
  ggtitle("HER SD 30-31, Gulf of Bothnia")
dev.off()

#
load("model/model.rda")

taf.png("model_f0.png")
plot(f0)
dev.off()

