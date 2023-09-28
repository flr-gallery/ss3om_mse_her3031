# model.R - DESC
# /home/mosqu003/FLR/gallery/MSE/ss3om_mse_her3031/model.R

# Copyright (c) WUR, 2023.
# Author: Iago MOSQUEIRA (WMR) <iago.mosqueira@wur.nl>
#
# Distributed under the terms of the EUPL-1.2


library(icesTAF)
mkdir("model")

library(mse)

# fwd(F=0)

f0 <- fwd(om, fbar=FLQuant(0, dimnames=list(year=2023:2042)))

# SAVE

save(f0, file="model/model.rda", compress="xz")
