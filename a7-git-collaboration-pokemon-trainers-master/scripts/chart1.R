chart_1_func <- function(df) {
  map.df <- filter(map_data("worldHires"), lat>=25, lat<=83, long>=-141, long<=-52)
  
  mynamestheme <- theme(plot.title = element_text(family = "Helvetica", face = "bold", size = (15)), 
                        legend.title = element_text(colour = "steelblue",  face = "bold.italic", family = "Helvetica"), 
                        legend.text = element_text(face = "italic", colour="steelblue4",family = "Helvetica"), 
                        axis.title = element_text(family = "Helvetica", size = (10), colour = "steelblue4"),
                        axis.text = element_text(family = "Courier", colour = "cornflowerblue", size = (10)))
  
  result <- ggplot() + geom_polygon(data = map.df, 
                                    aes(x = long, y = lat, group = group), 
                                    fill = "white", 
                                    color = "black") +
    geom_point(data = df, aes(x = lng, y = lat, col = Shape), size = 0.3) + 
    guides(color = guide_legend(override.aes =
                                  list(size = 2, alpha = 1))) +
    mynamestheme +
    labs(title = 'UFO Sightings Locations Throughout US and Canada',
         x = 'longitude', y = 'latitude')
  return(result)
}