source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("leaflet");
libraryRequireInstall("jsonlite");
####################################################

################### Actual code ####################
map <- leaflet(data = Values);
map <- addProviderTiles(map, providers$CartoDB.Positron);
map <- addTopoJSON(map, topojson = read_json("E:/Temp/Demo/Demo/assets/groningen-veld.json"), weight = 1, color = "grey", fillOpacity = 0.3, group = 'Groningen veld');
map <- addCircles(map, lng = ~ longitude, lat = ~ latitude, popup = ~ paste("Locatie:", locatie, "<br>", "Magnitude:", magnitude));
map <- addLayersControl(map, overlayGroups = c("Groningen veld"), options = layersControlOptions(collapsed = FALSE));
map <- hideGroup(map, "Groningen veld")
map <- setView(map, lng = 6.8, lat = 53.3, zoom = 9);
####################################################

############# Create and save widget ###############
internalSaveWidget(map, 'out.html');
####################################################
