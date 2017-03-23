# 5. How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

unique(SCC$EI.Sector)
unique(SCC$Short.Name[grep("Motor Vehicle", SCC$Short.Name)])
# motSCCs <- SCC$SCC[grep("Motor", SCC$Short.Name)]
motSCCs <- SCC$SCC[SCC$SCC.Level.One == "Mobile Sources"]
x <- baltNEI[baltNEI$SCC %in% motSCCs,]
a <- aggregate(x$Emissions, by = list(x$year), sum)
names(a) <- c("year","Emissions")

png("plot5.png")
qplot(year, Emissions, data = a, geom = c("point", "line"),
      main = "Emissions from Mobile Sources in Baltimore City from 1999 to 2008",
      xlab = "Year")
dev.off()
# Emissions from mobile sources steeply fell from 2000 to 2002 and then slighly rose through 2005 and 2008