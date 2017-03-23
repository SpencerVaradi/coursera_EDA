# 6. Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?
laNEI <- NEI[NEI$fip == "06037" &  NEI$SCC %in% motSCCs, ]

laVbalNEI <- NEI[(NEI$fip == "06037" | NEI$fip == "24510") &  (NEI$SCC %in% motSCCs) &
                   !is.na(NEI$Emissions), ]
otherThing <- as.numeric(scale(laVbalNEI$Emissions))

thing <- by(laVbalNEI$Emissions, laVbalNEI$fips, function(x){
  unlist(as.numeric(scale(x)))})
newThing <- unlist(c(thing[1:2]))
laVbalNEI$Emissions_Scaled <- newThing

laVbalNEI$city <- unlist(lapply(laVbalNEI$fips, function(x){
  switch(x, "06037" = "LA", "24510" = "Baltimore City")}
))

a <- aggregate(laVbalNEI$Emissions_Scaled, by = list(laVbalNEI$year,laVbalNEI$city), mean)
names(a) <- c("year","city","Emissions")

png("plot6.png")
qplot(year, Emissions, data = a, col = city, geom = c("point", "line"),
      main = "Baltimore City and LA Emissions from Mobile Sources 1999-2008 (Z-scores)",
      xlab = "Year")
dev.off()

# Baltimore City decrease in emissions is more dynamic than LA while LA emissions increased but stabalized