Node.js command prompt
I'd like to create a custom visual with R and the leaflet package.

I have a simple R script that is working just fine in RStudio:

library(leaflet)

map <- leaflet()
map <- addProviderTiles(map, providers$CartoDB.Positron)
map <- setView(map, lng = 14.46, lat = 50.07, zoom = 1)

htmlwidgets::saveWidget(map, "map.html")

When you open map.html in a browser, you see a map of the world. You can zoom and pan. Everything is working properly.

Then I got this example custom visual working: https://github.com/microsoft/PowerBI-visuals/blob/master/RVisualTutorial/CreateRHTML.md
In order to achieve this I had to make some changes to visual.ts and pbiviz.json (see https://github.com/microsoft/PowerBI-visuals/issues/562 and https://community.powerbi.com/t5/Developer/Custom-Visual-pbiviz-package-error/m-p/725439#M19802).
Also, I noticed that you *must* add a data field, even if it is not used by the custom visual. If you don't do this, nothing gets rendered.
I was able to make a small alteration to script.R (changing the main title) and make it show up in Power BI.

Next step was to change the code in script.R into:
`
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
`
This works! However you must first add data to your project before you add the custom visual. Otherwise you get an error.

I noticed that the leaflet and jsonlite packages was missing from dependencies.json. Shouldn't I add them manually?
