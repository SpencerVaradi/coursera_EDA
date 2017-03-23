# 4. Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

combSCCs <- SCC$SCC[grepl("Coal", SCC$SCC.Level.Three) | grepl("Coal", SCC$SCC.Level.Three)]
# combSCCs <-  SCC$SCC[SCC$EI.Sector == "Fuel Comb - Electric Generation - Coal"]

x <- NEI[NEI$SCC %in% combSCCs,]
a <- aggregate(x$Emissions, by = list(x$year), sum)
names(a) <- c("year","Emissions")

png("plot4.png")
qplot(year, Emissions, data = a, geom = c("point", "line"), xlab = "Year",
      main = " US coal combustion related emissions between 1999 and 2008")
dev.off()
# Coal combustion has steeply declined from 2006 to 2008