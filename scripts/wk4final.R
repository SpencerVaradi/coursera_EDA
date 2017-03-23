NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

a <- tapply(NEI$Emissions, NEI$year, sum)

png("graphs/wk4_1.png")
plot(names(a), a,type = "l", main = "Total PM2.5 From All Sources", xlab = "Year", ylab = "PM2.5")
dev.off()
# Emissions have decreased

# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

baltNEI <- NEI[NEI$fip == "24510", ]
a <- tapply(baltNEI$Emissions, baltNEI$year, sum)

png("graphs/wk4_2.png")
plot(names(a),a, type = "l", main = "Baltimore City, Maryland Total PM2.5", ylab = "PM2.5", xlab = "Year")
dev.off()
# Emissions initially rose in 2005 but the falling trend continued in 2008

# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

baltNEI <- NEI[NEI$fip == "24510", ]
a <- aggregate(baltNEI$Emissions, by = list(baltNEI$year, baltNEI$type), sum)
names(a) <- c("year","type","Emissions")

png("graphs/wk4_3.png")
qplot(year, Emissions, data = a, col = type, geom = c("point", "line"),
      main = "Baltimore City PM2.5 emission by type between 1999 and 2008",
      xlab = "Year")
dev.off()
# Non-road, Nonpoint, and On-Road have decreased while Point has increased

# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

combSCCs <- SCC$SCC[grepl("Coal", SCC$SCC.Level.Three) | grepl("Coal", SCC$SCC.Level.Three)]
# combSCCs <-  SCC$SCC[SCC$EI.Sector == "Fuel Comb - Electric Generation - Coal"]

x <- NEI[NEI$SCC %in% combSCCs,]
a <- aggregate(x$Emissions, by = list(x$year), sum)
names(a) <- c("year","Emissions")

png("graphs/wk4_4.png")
qplot(year, Emissions, data = a, geom = c("point", "line"), xlab = "Year",
      main = " US coal combustion related emissions between 1999 and 2008")
dev.off()
# Coal combustion has steeply declined from 2006 to 2008

# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

unique(SCC$EI.Sector)
unique(SCC$Short.Name[grep("Motor Vehicle", SCC$Short.Name)])
# motSCCs <- SCC$SCC[grep("Motor", SCC$Short.Name)]
motSCCs <- SCC$SCC[SCC$SCC.Level.One == "Mobile Sources"]
x <- baltNEI[baltNEI$SCC %in% motSCCs,]
a <- aggregate(x$Emissions, by = list(x$year), sum)
names(a) <- c("year","Emissions")

png("graphs/wk4_5.png")
qplot(year, Emissions, data = a, geom = c("point", "line"),
      main = "Emissions from Mobile Sources in Baltimore City from 1999 to 2008",
      xlab = "Year")
dev.off()
# Emissions from mobile sources steeply fell from 2000 to 2002 and then slighly rose through 2005 and 2008

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

png("graphs/wk4_6.png")
qplot(year, Emissions, data = a, col = city, geom = c("point", "line"),
      main = "Baltimore City and LA Emissions from Mobile Sources 1999-2008 (Z-scores)",
      xlab = "Year")
dev.off()

# Baltimore City decrease in emissions is more dynamic than LA while LA emissions increased but stabalized

#packs <- installed.packages()
#write.csv(packs, file = "packs.csv")
