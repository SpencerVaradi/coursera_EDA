# 3. Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

baltNEI <- NEI[NEI$fip == "24510", ]
a <- aggregate(baltNEI$Emissions, by = list(baltNEI$year, baltNEI$type), sum)
names(a) <- c("year","type","Emissions")

png("plot3.png")
qplot(year, Emissions, data = a, col = type, geom = c("point", "line"),
      main = "Baltimore City PM2.5 emission by type between 1999 and 2008",
      xlab = "Year")
dev.off()
# Non-road, Nonpoint, and On-Road have decreased while Point has increased

