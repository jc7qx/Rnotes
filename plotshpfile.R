library(ggplot2)
library(maptools)
library(dplyr)
library(foreign)

twvmap <- readShapePoly("../VILLAGE_MOI_1051214.shp")
map <- fortify(twvmap)

twdbf <- read.dbf("../VILLAGE_MOI_1051214.dbf")

i=0
t = list()
for (c in twdbf$COUNTYNAME){
  if ((c %in% c("高雄市","臺南市","屏東縣"))){
    t = c(t , paste(as.character(i),".1", sep=''))
    i = i+1
  } else{
    i = i+1
  }
}

tmap <- map %>% filter(group %in% t)

ggtwmap <- ggplot(data=tmap, aes(x=long, y=lat, group=group))+
  geom_polygon()
print(ggtwmap)