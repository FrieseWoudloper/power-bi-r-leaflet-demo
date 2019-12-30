source('./r_files/flatten_HTML.r')

############### Library Declarations ###############
libraryRequireInstall("leaflet");
libraryRequireInstall("jsonlite");
####################################################

################### Actual code ####################
brtAchtergrondkaart <- paste0("http://geodata.nationaalgeoregister.nl/",
                              "tiles/service/wmts/brtachtergrondkaart/",
                              "EPSG:3857/{z}/{x}/{y}.png");
veld <- paste0("https://gist.githubusercontent.com/FrieseWoudloper/",
               "fcf4546a064ac7c12198119086601eca/raw/",
               "37c4511d6a48cc1acee54818322278a55e26052b/",
               "groningen-veld.json");
map <- leaflet(data = Values);
map <- addTiles(map, 
                urlTemplate = brtAchtergrondkaart, 
                attribution = "Kaartgegevens &copy; Kadaster", 
                options = tileOptions(minZoom = 6, maxZoom = 18));			
map <- addTopoJSON(map, 
                   topojson = read_json(veld), 
				   weight = 1, color = "grey", 
				   fillOpacity = 0.3, 
				   group = 'Groningen veld');
map <- addCircles(map, 
                  lng = ~ longitude, 
				  lat = ~ latitude, 
				  popup = ~ paste("Locatie:", 
				  locatie, "<br>", "Magnitude:", 
				  magnitude));	
map <- addLayersControl(map, 
                        overlayGroups = c("Groningen veld"), 
						options = layersControlOptions(collapsed = FALSE));
map <- hideGroup(map, "Groningen veld");
map <- fitBounds(map, 
                 lng1 = max(Values$longitude), lat1 = max(Values$latitude),
                 lng2 = min(Values$longitude), lat2 = min(Values$latitude));
####################################################

############# Create and save widget ###############
internalSaveWidget(map, 'out.html');
####################################################