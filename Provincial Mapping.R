

# -------------------------- #
ina.shp.prov   <- st_read("D:/SHAPEFILES/INA_GADM/gadm41_IDN_1.shp")

ina.shp.prov$NAME_1
growth_prov    <- read.xlsx("E:/BAPPENAS/DATA/2020 Laju Pertumbuhan by Province.xlsx", sheetName = "Flexmonster Pivot Table")

ina.shp.prov$growth2020   <- growth_prov$X2020

png("E:/Workshop Spatial Econometrics/2020_P0/20201_P0_Indonesia.png", width = 1400, height = 1000, units = "px")
plot(ina.shp.prov[,13], main="2020 Semester 1_P0 Indonesia")
dev.off()

png("E:/Workshop Spatial Econometrics/2020_P0/20202_P0_Indonesia.png", width = 1400, height = 1000, units = "px")
plot(ina.shp.prov[,14], main="2020 Semester 2_P0 Indonesia")
dev.off()

png("E:/Workshop Spatial Econometrics/2020_P1/20201_P1_Indonesia.png", width = 1400, height = 1000, units = "px")
plot(ina.shp.prov[,16], main="2020 Semester 1_P1 Indonesia")
dev.off()

png("E:/Workshop Spatial Econometrics/2020_P1/20202_P1_Indonesia.png", width = 1400, height = 1000, units = "px")
plot(ina.shp.prov[,17], main="2020 Semester 2_P1 Indonesia")
dev.off()
