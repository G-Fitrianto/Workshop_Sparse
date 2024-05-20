install.packages(c("sf", "sp", "raster", "terra"))

# library(sp)
library(raster)
library(sf)
library(terra)


landscan_22 <- raster("E:/LANDSCAN DATA/2022/landscan-global-2022.tif")  # Data available at https://landscan.ornl.gov/
plot(landscan_22)

ina_shp      <- shapefile("D:/SHAPEFILES/INA_GADM/gadm41_IDN_2.shp")     # You can download at gadm.org
ina_shp      <- st_read("D:/SHAPEFILES/INA_GADM/gadm41_IDN_2.shp")


ina_crop     <- crop(landscan_22, ina_shp)
ina.mask     <- mask(ina_crop, ina_shp, rasterize=T)

# my.color  <- colorRampPalette(c("#FFCFFF","#FF99FF","#FF3333", "#CC0000", "#660000", "#330000"))

plot(ina.mask)

jogja_shp      <- ina_shp[ina_shp$NAME_1 == "Yogyakarta",]
sleman_shp     <- ina_shp[ina_shp$NAME_2 == "Sleman",]
yogya_shp      <- ina_shp[ina_shp$NAME_2 == "Kota Yogyakarta",]
kulonprogo_shp <- ina_shp[ina_shp$NAME_2 == "Kulon Progo",]

jogja_crop_22 <- crop(ina_crop, jogja_shp)
jogja_mask_22 <- mask(jogja_crop_22, jogja_shp)

sleman_crop_22 <- crop(ina_crop, sleman_shp)
sleman_mask_22 <- mask(sleman_crop_22, sleman_shp)

yogya_crop_22 <- crop(ina_crop, yogya_shp)
yogya_mask_22 <- mask(yogya_crop_22, yogya_shp)

kprogo_crop_22 <- crop(ina_crop, kulonprogo_shp)
kprogo_mask_22 <- mask(kprogo_crop_22, kulonprogo_shp)
# ------------------------ #
plot(jogja_mask_22, main="D.I Yogyakarta Gridded Population Counts (2022)")
# ------------------------ #
dim(jogja_mask_22)
jogja_rows  <- dim(jogja_mask_22)[1]
jogja_cols  <- dim(jogja_mask_22)[2]

jogja_22_mat <- matrix(jogja_mask_22$landscan.global.2022@data@values,
                       ncol = jogja_cols, nrow = jogja_rows, byrow = T)

plot(raster(jogja_22_mat))

# Descriptive Statistics
jogja_22_mean <- mean(jogja_22_mat, na.rm=T)
jogja_22_min  <- min(jogja_22_mat, na.rm=T)
jogja_22_max  <- max(jogja_22_mat, na.rm=T)
jogja_22_sd   <- sd(jogja_22_mat, na.rm=T)

hist(jogja_22_mat)
boxplot(jogja_22_mat)

# ----------------------------- #
install.package("webshot2")
library(webshot2)

setwd("E:/Workshop GIS/")

output_dir  <- "E:/Workshop GIS/Records/"
file_format <- "png"
col_fun <- colorRampPalette(c("lightpink", "darkred"), space = "Lab")
persp3d(jogja_22_mat, col = col_fun(100), alpha = 0.5, title=FALSE, zlab = "Height")
movie3d(spin3d(axis = c(0,0,1), rpm = 10), duration=6,  type = "png", dir = "E:/Workshop GIS/Records/")

# Create a GIF animation
library(magick)
list.files(path='E:/Workshop GIS/New Folder/', pattern = '*.png', full.names = TRUE) %>% 
  image_read() %>% # reads each path file
  image_join() %>% # joins image
  image_animate(fps=4) %>% # animates, can opt for number of loops
  image_write("E:/Workshop GIS/New Folder/Spinning Animation.gif") # write to current dir

# ----------------------------- #
# Global and Local Spatial Autocorrelation Test
install.package("spdep")
library(spdep)

jogja_coords <- coordinates(jogja_mask_22)
jogja_nb     <- cell2nb(nrow = jogja_rows, ncol = jogja_cols)
jogja_listw  <- nb2listw(jogja_nb, style = "W")

jogja_mat    <- jogja_22_mat
jogja_mat[is.na(jogja_mat)] <- mean(jogja_mat, na.rm = T)
jogja_moran  <- moran.test(c(jogja_mat), jogja_listw)

moran.plot(c(jogja_mat), jogja_listw)

jogja.l_test <- localmoran(c(jogja_22_mat), jogja_listw)

na.locat     <- which(is.na(c(jogja_22_mat)))
jogja.l_test[na.locat,1] <- NA
jogja.l_test[na.locat,5] <- NA

plot(raster(matrix(jogja.l_test[,1], ncol = jogja_cols, nrow = jogja_rows)),
     main="Plot Local Moran's I")
plot(raster(matrix(jogja.l_test[,5], ncol = jogja_cols, nrow = jogja_rows)),
     main="Significance Test -- p-values")


# ------------------------ #
# For Elevation Data
# Data available at https://earthexplorer.usgs.gov/

gmted_data_1 <- raster("E:/GMTED2010/GMTED2010 7_5arc/10s090e_20101117_gmted_dsc075.tif")
gmted_data_2 <- raster("E:/GMTED2010/GMTED2010 7_5arc/10s090e_20101117_gmted_max075.tif")
gmted_data_3 <- raster("E:/GMTED2010/GMTED2010 7_5arc/10s090e_20101117_gmted_mea075.tif")
gmted_data_4 <- raster("E:/GMTED2010/GMTED2010 7_5arc/10s090e_20101117_gmted_med075.tif")
gmted_data_5 <- raster("E:/GMTED2010/GMTED2010 7_5arc/10s090e_20101117_gmted_min075.tif")
gmted_data_6 <- raster("E:/GMTED2010/GMTED2010 7_5arc/10s090e_20101117_gmted_std075.tif")

jogja_gmted_crop  <- crop(gmted_data_3, jogja_shp)
jogja_gmted_mask  <- mask(jogja_gmted_crop, jogja_shp)

sleman_crop_gmted <- crop(gmted_data_3, sleman_shp)
sleman_mask_gmted <- mask(sleman_crop_gmted, sleman_shp)

yogya_crop_gmted  <- crop(gmted_data_3, yogya_shp)
yogya_mask_gmted  <- mask(yogya_crop_gmted, yogya_shp)

kprogo_crop_gmted <- crop(gmted_data_3, kulonprogo_shp)
kprogo_mask_gmted <- mask(kprogo_crop_gmted, kulonprogo_shp)


# ------------------------ #
install.packages("ggplot2")
library(ggplot2)

plot(jogja_mask_22)
plot(st_geometry(jogja_shp), add=T)

plot(sleman_mask_22)
plot(st_geometry(sleman_shp), add=T)
mean(na.omit(sleman_mask_22@data@values))
sd(na.omit(sleman_mask_22@data@values))

plot(yogya_mask_22)
plot(st_geometry(yogya_shp), add=T)
mean(na.omit(yogya_mask_22@data@values))
sd(na.omit(yogya_mask_22@data@values))

plot(kprogo_mask_22)
plot(st_geometry(kulonprogo_shp), add=T)
mean(na.omit(kprogo_mask_22@data@values))
sd(na.omit(kprogo_mask_22@data@values))

# ------------------------ #
plot(jogja_gmted_mask)
plot(st_geometry(jogja_shp), add=T)

plot(sleman_mask_gmted)
plot(st_geometry(sleman_shp), add=T)
mean(na.omit(sleman_mask_gmted@data@values))
sd(na.omit(sleman_mask_gmted@data@values))

plot(yogya_mask_gmted)
plot(st_geometry(yogya_shp), add=T)
mean(na.omit(yogya_mask_gmted@data@values))
sd(na.omit(yogya_mask_gmted@data@values))

plot(kprogo_mask_gmted)
plot(st_geometry(kulonprogo_shp), add=T)
mean(na.omit(kprogo_mask_gmted@data@values))
sd(na.omit(kprogo_mask_gmted@data@values))

# ------------------------ #
install.packages("spatialreg")
library(spatialreg)
model1 <- lagsarlm(c(jogja_22_mat)~1,
                   listw = jogja_listw, zero.policy = T)

summary(model1)