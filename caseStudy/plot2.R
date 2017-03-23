# 2. Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.

baltNEI <- NEI[NEI$fip == "24510", ]
a <- tapply(baltNEI$Emissions, baltNEI$year, sum)

png("plot2.png")
plot(names(a),a, type = "l", main = "Baltimore City, Maryland Total PM2.5", ylab = "PM2.5", xlab = "Year")
dev.off()
# Emissions initially rose in 2005 but the falling trend continued in 2008