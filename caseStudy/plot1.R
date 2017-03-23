# 1. Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

a <- tapply(NEI$Emissions, NEI$year, sum)

png("plot1.png")
plot(names(a), a,type = "l", main = "Total PM2.5 From All Sources", xlab = "Year", ylab = "PM2.5")
dev.off()
# Emissions have decreased