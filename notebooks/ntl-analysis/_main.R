# Syria Economic Monitor
# Nighttime Lights Analysis: Main Script

# PARAMETERS
# Whether to download and mosaic nighttime light data from the BlackMarble 
# archive. Instead of re-downloaded and re-processing the data, pre-processed
# data for Syria can be found here:
# https://datacatalog.worldbank.org/int/data/dataset/0063879/syria__night_time_lights
DOWNLOAD_NTL <- F

# Filepaths --------------------------------------------------------------------
#### Root paths
if(Sys.info()[["user"]] == "robmarty"){
  git_dir  <- "~/Documents/Github/syria-economic-monitor"
  #data_dir <- "~/Documents/Github/syria-economic-monitor/data"
  data_dir <- file.path("~", "Dropbox", "World Bank", "Side Work", "Syria Economic Monitor",
                        "data")
} 

#### From root
#ntl_dir     <- file.path(git_dir, "notebooks", "ntl-analysis")
figures_dir <- file.path(git_dir, "reports", "figures")

ntl_bm_dir  <- file.path(data_dir, "NTL BlackMarble")
gas_flare_dir  <- file.path(data_dir, "Global Gas Flaring")
gadm_dir  <- file.path(data_dir, "GADM")
eq_intensity_dir <- file.path(data_dir, "Earthquake Intensity")
unocha_dir <- file.path(data_dir, "UNOCHA")
figures_dir <- file.path(git_dir, "reports", "figures")

# Packages and functions -------------------------------------------------------
## R packages
library(dplyr)
library(readr)
library(purrr)
library(rgdal)
library(rgeos)
library(sp)
library(sf)
library(raster) #install.packages('raster', repos='https://rspatial.r-universe.dev')
library(ggplot2)
library(exactextractr)
library(lubridate)
library(tidyr)
library(ggtheme)
library(ggpubr)
library(leaflet)
library(leaflet.extras)
library(h3jsr)
library(readxl)
library(janitor)
library(glcm)
library(httr)

## User written script to facilitating downloading black marble NTL data
source("https://raw.githubusercontent.com/ramarty/download_blackmarble/main/R/download_blackmarble.R")

# Scripts ----------------------------------------------------------------------
RUN_SCRIPTS <- F

if(RUN_SCRIPTS){
  
  # Download black marble nighttime lights data into monthly rasters 
  # for Syria.
  # NOTE: Requires a bearer token from NASA. To aquire, see documentation here:
  # https://github.com/ramarty/download_blackmarble
  if(DOWNLOAD_NTL) source(file.path(ntl_dir, "01_download_black_marble.R"))
  
  # Clean dataset of gas flaring locations; produces a dataset of gas flaring
  # locations in Syria
  source(file.path(ntl_dir, "01_clean_gas_flaring_data.R"))
  
  # Produce a map of nighttime lights, using the latest month of data
  source(file.path(ntl_dir, "02_map_ntl_latest.R"))
  
  # Produce maps showing locations with increases, decreases, and no change
  # in nighttime lights, using different start and end years
  source(file.path(ntl_dir, "02_maps_of_ntl_changes.R"))
  
  # Produce a figure showing trends in nighttime lights at the Governorate level,
  # showing trends using (1) all lights, (2) lights just in gas flaring locations,
  # and (3) lights excluding gas flaring locations
  source(file.path(ntl_dir, "02_trends_in_ntl.R"))
  
}






