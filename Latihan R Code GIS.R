install.packages(c("osmdata", "maps","ggmap", "mapdata")) 
library(maps) 
library(ggmap) 
library(mapdata) 
library(osmdata) 

place    <- c("Yogyakarta") 
ll.place <- opq(place) %>% add_osm_feature(key = "place") %>% osmdata_sf()
place.x  <- ll.place$osm_points$geometry[[1]][1] 
place.y  <- ll.place$osm_points$geometry[[1]][2]

plot.new() 
map("world", fill=TRUE, col="white", bg="lightblue", ylim=c(-60, 90), 
    mar=c(0,0,0,0)) 
points(place.x,place.y, col="red", pch=16) 

# Get the Indonesia map using the 'maps' package
map("world", regions = "Indonesia", fill = TRUE, col = "lightblue", 
    bg = "white")
points(place.x,place.y, col="red", pch=16) 

## Alternative Code
# Get map data for Indonesia from the 'maps' package
indonesia_map <- map_data("worldHires", "Indonesia")

# Plot the map using ggplot2
ggplot() +
  geom_polygon(data = indonesia_map, aes(x = long, y = lat, group = group),
               fill = "lightgreen", color = "black") +
  coord_fixed(1.3) +
  theme_minimal() +
  ggtitle("Map of Indonesia")

## ----------------------------------- ##
## Alternative Code

install.packages("rnaturalearth")
install.packages("rnaturalearthdata")

library(rnaturalearth)
library(rnaturalearthdata)

# Get the Indonesia map using rnaturalearth
indonesia <- ne_countries(scale = "medium", returnclass = "sf")

# Filter to show only Indonesia
indonesia_map <- indonesia[indonesia$name == "Indonesia", ]

# Plot the map using ggplot2
ggplot(data = indonesia_map) +
  geom_sf(fill = "green", color = "black") + # Fill with green and border with black
  coord_sf(xlim = c(95, 141), ylim = c(-11, 6)) + # Longitude and latitude limits for Indonesia
  theme_minimal() + # Clean theme
  labs(title = "Map of Indonesia", 
       x = "Longitude", 
       y = "Latitude")