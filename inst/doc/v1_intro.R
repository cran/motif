## ----include = FALSE----------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  dev = "png"
)

## -----------------------------------------------------------------------------
library(motif)
library(stars)
library(sf)
landcover = read_stars(system.file("raster/landcover2015.tif", package = "motif"))

## ----echo=FALSE---------------------------------------------------------------
landcover = droplevels(landcover)
plot(landcover, key.pos = 4, key.width = lcm(5), main = NULL)

## -----------------------------------------------------------------------------
landcover_comp = lsp_signature(landcover, 
                                type = "composition",
                                threshold = 1,
                                normalization = "none")
landcover_comp

## -----------------------------------------------------------------------------
landcover_comp$signature

## ----echo=FALSE---------------------------------------------------------------
stars200 = lsp_add_sf(landcover, window = 200)
landcover = droplevels(landcover)
plot(landcover, key.pos = NULL, reset = FALSE, main = NULL)
plot(st_geometry(stars200), add = TRUE, reset = FALSE)
# st_bbox(stars200)
# st_bbox(landcover)

## -----------------------------------------------------------------------------
landcover_coma = lsp_signature(landcover, type = "coma", window = 200)
landcover_coma

## -----------------------------------------------------------------------------
landcover_coma$signature[[1]]

## -----------------------------------------------------------------------------
ecoregions = read_sf(system.file("vector/ecoregions.gpkg", package = "motif"))

## ----echo=FALSE---------------------------------------------------------------
# https://medialab.github.io/iwanthue/
my_pal = c("#d34359", "#62b93c", "#b75fcf", "#53c069", "#d44295", "#acb939", "#626edd", "#dc9e36", "#8156a8", "#4b8734", "#d98dc7", "#58c096", "#cc542a", "#48bbd2", "#bf814d", "#6686c8", "#968c30", "#a34d78", "#36815b", "#c26963", "#a2b36b", "#6b6829")
plot(ecoregions["id"], main = NULL, col = my_pal, key.pos = 4, key.width = lcm(5))

## -----------------------------------------------------------------------------
landcover_coma_e = lsp_signature(landcover, type = "coma", window = ecoregions["id"])
landcover_coma_e

## -----------------------------------------------------------------------------
landcover_coma_e$signature[[1]]

## -----------------------------------------------------------------------------
landcover_proxy = read_stars(system.file("raster/landcover2015.tif", package = "motif"),
                             proxy = TRUE)


