summary <- function(UFO.data) {
  UFO.data <- as.data.frame(UFO.data, stringAsFactors = FALSE)
  result <- list()
  #get the state in both US and Canada with the most UFO sighting
  UFO.data.USA <- filter(UFO.data, Country == "USA")
  UFO.data.CANADA <- filter(UFO.data, Country == "CANADA")
  USA.State.freq <- filter(as.data.frame(table(UFO.data.USA$State), stringsAsFactors = FALSE), Freq != 0)
  CANADA.State.freq <-filter(as.data.frame(table(UFO.data.CANADA$State), stringsAsFactors = FALSE), Freq != 0)
  USA.State.freq <- arrange(USA.State.freq, Freq)
  max.sighting.USA <- USA.State.freq$Var1[nrow(USA.State.freq)]
  CANADA.State.freq <- arrange(CANADA.State.freq, Freq)
  max.sighting.CANADA <- CANADA.State.freq$Var1[nrow(CANADA.State.freq)]
  
  #sort the types of shapes by ascending order by occurance
  UFO.shape <- as.data.frame(table(UFO.data$Shape), stringsAsFactors = FALSE)
  UFO.shape <- arrange(UFO.shape, Freq)
  sorted.shape <- UFO.shape$Var1
  
  #get the most frequent time of UFO sighting in the morning(AM)
  UFO.data.am <- filter(UFO.data, AM.PM == "AM")
  UFO.time.am <- as.data.frame(table(UFO.data.am$Time), stringsAsFactors = FALSE)
  UFO.time.am <- arrange(UFO.time.am, Freq)
  frequent.time.am <- UFO.time.am$Var1[nrow(UFO.time.am)]
  
  #get the most frequent time of UFO sighting at night(PM)
  UFO.data.pm <- filter(UFO.data, AM.PM == "PM")
  UFO.time.pm <- as.data.frame(table(UFO.data.pm$Time), stringsAsFactors = FALSE)
  UFO.time.pm <- arrange(UFO.time.pm, Freq)
  frequent.time.pm <- UFO.time.pm$Var1[nrow(UFO.time.pm)]
  result <- list(result,State.USA = max.sighting.USA, State.CANADA = max.sighting.CANADA, shapes.order = sorted.shape, most.frequent.am = frequent.time.am, most.frequent.pm = frequent.time.pm)
  return (result)
}