### This is the stump script to read the data and plot the maps
#library(data.table)
library(dplyr)
library(ggplot2)

## read the data
file.dir <- "/opt/data/temp_prec_1960+.csv.bz2"

# can't use the fread function, it gives me an error: No space left on device
temp <- as.data.frame(read.csv(file.dir,
                            na.strings = c("NA","N/A",""),
                            stringsAsFactors=FALSE))

## filter out North American observations
northAm <- filter(temp, latitude>=5, latitude<=85, longitude>=180, longitude<=310)

## delete the original (large data) from R workspace
rm(temp)

## -------------------- do the following for 1960, 1987, 2014 and temp/precipitation --------------------
northAm1960 <- filter(northAm, as.Date(time) == as.Date('1960-07-01'))
northAm1987 <- filter(northAm, as.Date(time) == as.Date('1987-07-01'))
northAm2014 <- filter(northAm, as.Date(time) == as.Date('2014-07-01'))
rm(northAm)

## select jpg graphics device

## select the correct year - plot longitude-latitude and color according to the temp/prec variable
## I recommend to use ggplot() but you can do something else
## Note: if using ggplot, you may want to add "+ coord_map()" at the end of the plot.  This
## makes the map scale to look better.  You can also pick a particular map projection, look
## the documentation.  (You need 'mapproj' library).

## close the device

jpeg('a6/temp1960.jpg', width = 10, height = 8, units = "in", res = 72)
ggplot(northAm1960) + geom_raster(aes(longitude, latitude, fill = airtemp)) + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank()) + labs(x = NULL, y = NULL, fill = "air temperature in deg C") + 
  ggtitle('Air Temperature 1960') + 
  scale_fill_gradient2(low = "blue", high = "red", mid = "yellow" , midpoint = (max(northAm1960$airtemp, 
  na.rm=T)+min(northAm1960$airtemp, na.rm=T))/2, space = "Lab", 
                       name="air temperature in deg C")
dev.off()

jpeg('a6/temp1987.jpg', width = 10, height = 8, units = "in", res = 72)
ggplot(northAm1987) + geom_raster(aes(longitude, latitude, fill = airtemp)) + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank()) + labs(x = NULL, y = NULL, fill = "air temperature in deg C") + 
  ggtitle('Air Temperature 1987') + 
  scale_fill_gradient2(low = "blue", high = "red", mid = "yellow" , midpoint = (max(northAm1987$airtemp, 
  na.rm=T)+min(northAm1987$airtemp, na.rm=T))/2, space = "Lab", 
                       name="air temperature in deg C")
dev.off()

jpeg('a6/temp2014.jpg', width = 10, height = 8, units = "in", res = 72)
ggplot(northAm2014) + geom_raster(aes(longitude, latitude, fill = airtemp)) + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank()) + labs(x = NULL, y = NULL, fill = "air temperature in deg C") + 
  ggtitle('Air Temperature 2014') + 
  scale_fill_gradient2(low = "blue", high = "red", mid = "yellow" , midpoint = (max(northAm2014$airtemp, 
  na.rm=T)+min(northAm2014$airtemp, na.rm=T))/2, space = "Lab", 
                       name="air temperature in deg C")
dev.off()

jpeg('a6/preci1960.jpg', width = 10, height = 8, units = "in", res = 72)
ggplot(northAm1960) + geom_raster(aes(longitude, latitude, fill = precipitation)) + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank()) + labs(x = NULL, y = NULL, fill = "precipitation in cm") + 
  ggtitle('Precipitation 1960') + 
  scale_fill_gradient2(low = "light blue", high = "dark blue", mid = "blue" , midpoint = (max(northAm1960$precipitation, 
  na.rm=T)+min(northAm1960$precipitation, na.rm=T))/2, space = "Lab", 
                       name="precipitation in cm")
dev.off()

jpeg('a6/preci1987.jpg', width = 10, height = 8, units = "in", res = 72)
ggplot(northAm1987) + geom_raster(aes(longitude, latitude, fill = precipitation)) + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank()) + labs(x = NULL, y = NULL, fill = "precipitation in cm") + 
  ggtitle('Precipitation 1987') + 
  scale_fill_gradient2(low = "light blue", high = "dark blue", mid = "blue" , midpoint = (max(northAm1987$precipitation, 
  na.rm=T)+min(northAm1987$precipitation, na.rm=T))/2, space = "Lab", 
                       name="precipitation in cm")
dev.off()

jpeg('a6/preci2014.jpg', width = 10, height = 8, units = "in", res = 72)
ggplot(northAm2014) + geom_raster(aes(longitude, latitude, fill = precipitation)) + 
  theme(axis.text = element_blank(), 
        axis.ticks = element_blank()) + labs(x = NULL, y = NULL, fill = "precipitation in cm") + 
  ggtitle('Precipitation 2014') + 
  scale_fill_gradient2(low = "light blue", high = "dark blue", mid = "blue" , midpoint = (max(northAm2014$precipitation, 
  na.rm=T)+min(northAm2014$precipitation, na.rm=T))/2, space = "Lab", 
                       name="precipitation in cm")
dev.off()

rm(northAm1960)
rm(northAm1987)
rm(northAm2014)