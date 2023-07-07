# utilities.R - DESC
# /home/mosqu003/FLR/gallery/MSE/ss3om_mse_her3031/utilities.R

# Copyright (c) WUR, 2023.
# Author: Iago MOSQUEIRA (WMR) <iago.mosqueira@wur.nl>
#
# Distributed under the terms of the EUPL-1.2


# setioalbgrid {{{

#' Sets a grid of SS3 model runs for Indian Ocean albacore
#'
#' @param sce [TODO:description]
#' @param dir=paste0 [TODO:description]
#' @param grid_ [TODO:description]
#' @param format(Sys.time [TODO:description]
#' @param base=system.file [TODO:description]
#' @param ext-data/sa/2016 [TODO:description]
#' @param package [TODO:description]
#' @param name [TODO:description]
#' @param from=1 [TODO:description]
#' @param write=TRUE [TODO:description]
#' @param delete=TRUE [TODO:description]
#'
#' @return [TODO:description]
#' @export
#'
#' @examples

setss3grid <- function(sce, dir="data/grid", base="boot/data", name=NULL,
  write=TRUE, delete=TRUE) {

  # EXPAND grid from sce if list
  if(is(sce, "data.frame"))
    grid <- nameGrid(sce)
  else
  	grid <- nameGrid(expand.grid(sce, stringsAsFactors=FALSE))

  if(!write)
    return(grid)

  # SET name
  if(is.null(name)) {
    ctlf <- list.files(base, pattern="\\.ctl")
    datf <- list.files(base, pattern="\\.dat")
  } else {
    ctlf <- paste0(name, ".ctl")
    datf <- paste0(name, ".dat")
  }
 	
  # READ source files
  dats <- SS_readdat_3.30(file.path(base, datf), verbose=FALSE)
  ctls <- SS_readctl_3.30(file=file.path(base, ctlf), use_datlist=T, datlist=dats,
    verbose=FALSE)

  # NAMES in grid
  pars <- names(grid)[!names(grid) %in% c("iter", "id")]

  # CREATE dir
  if(dir.exists(dir))
    if(delete) {
      unlink(dir, recursive = TRUE, force = TRUE)
      dir.create(dir)
    } else  
      stop(paste("folder", dir, "already exists. Delete first."))
	else
    dir.create(dir)

	# SETUP grid
  foreach (i=grid$iter, .errorhandling = "remove") %dopar% {

    dat <- dats
    ctl <- ctls

    row <- which(grid$iter == i)
 
    # M, ctl$MG_parms[c("NatM_p_1_*_GP_1",]
    if("M" %in% pars) {
      ctl$MG_parms[paste0("NatM_p_", 1:6, "_Fem_GP_1"), "INIT"] <- 
      ctl$MG_parms[paste0("NatM_p_", 1:6, "_Fem_GP_1"), "INIT"] * grid[row, "M"]
    }

		# steepness, ctl$SR_parms["SR_BH_steep",]
    if("steepness" %in% pars) {
      ctl$SR_parms["SR_BH_steep", "INIT"] <- grid[row, "steepness"]
    }

    # CREATE dir
    dirname <- file.path(dir, grid[row, "id"])
		dir.create(dirname)

		# COPY unaltered files
		# starter.ss
		file.copy(file.path(base, "starter.ss"),
			file.path(dirname, "starter.ss"))
		
		# forecast.ss
		file.copy(file.path(base, "forecast.ss"),
			file.path(dirname, "forecast.ss"))

		# wtatage.ss
		file.copy(file.path(base, "wtatage.ss"),
			file.path(dirname, "wtatage.ss"))


		# WRITE modified files
		# ctl
    SS_writectl_3.30(ctl, file.path(dirname, ctlf), verbose=FALSE)
		
    # dat
    SS_writedat_3.30(dat, outfile=file.path(dirname, datf), verbose=FALSE)
		}

	invisible(data.table(grid, key="iter"))
} # }}}
