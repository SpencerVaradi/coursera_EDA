
# If you want, run the cleaning from this config file.
# But, that will take a little bit since it is subsetted after reading file
# Cleaned data is in an RDS file loaded below
# source("scripts/wk1_config.R")

utilData <- readRDS("data/utilData.rds")

#Plot 3
png(file = "graphs/plot3.png")

plot(utilData$DateTime,utilData$Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering")
lines(utilData$DateTime,utilData$Sub_metering_2, type = "l", xlab = NA, col = "red")
lines(utilData$DateTime,utilData$Sub_metering_3, type = "l", xlab = NA, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1,1))

dev.off()
