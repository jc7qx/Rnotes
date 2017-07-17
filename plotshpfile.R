library(ggplot2)
library(maptools)
library(dplyr)
library(foreign)

#read tw shapefile
twvmap <- readShapePoly("/Users/mac/Dropbox/GIS/twVilliage/VILLAGE_MOI_1051214.shp")
map <- fortify(twvmap)

#read tw shx file
twdbf <- read.dbf("/Users/mac/Dropbox/GIS/twVilliage/VILLAGE_MOI_1051214.dbf")

#get county map with names
i=0
t = list()
for (c in twdbf$COUNTYNAME){
  if ((c %in% c("臺北市"))){
    t = c(t , paste(as.character(i),".1", sep=''))
    i = i+1
  } else{
    i = i+1
  }
}

#get data from the shapefile
tmap <- map %>% filter(group %in% t)

ggtwmap <- ggplot(data=tmap)+
  geom_polygon(aes(x=long, y=lat, fill=id , group=group),col="white")+
#  coord_flip(ylim = c(25.11, 25.16), xlim = c(121.72, 121.77))
#  scale_x_continuous(limits=c(121.72, 121.77))+
#  scale_y_continuous(limits=c(25.11, 25.16))
#  xlim(121.72, 121.77)+ylim(25.11, 25.16)
  #coord_cartesian(xlim=c(121.72, 121.77),ylim=c(25.11, 25.16))+
    
  theme(axis.text.x = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks = element_blank())+
    guides(fill=FALSE)+
  coord_fixed(1.0)
ggtwmap
