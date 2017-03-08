
# If you want, run the cleaning from this config file.
# But, that will take a little bit since it is subsetted after reading file
# Cleaned data is in an RDS file loaded below
# source("scripts/wk1_config.R")

utilData <- readRDS("data/utilData.rds")


# Plot 4
png(file = "graphs/plot4.png")

par(mfrow = c(2,2), mar = c(4.1,4,2,2.5))
with(utilData, {
  # upper left
  plot(utilData$DateTime,utilData$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")

  # upper right
  plot(utilData$DateTime,utilData$Voltage, type = "l", xlab = "datetime", # even thought I think this is just a bug in the instructions
       ylab = "Voltage")


  # Bottom left
  plot(utilData$DateTime,utilData$Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering")
  lines(utilData$DateTime,utilData$Sub_metering_2, type = "l", xlab = NA, col = "red")
  lines(utilData$DateTime,utilData$Sub_metering_3, type = "l", xlab = NA, col = "blue")
  legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
         col = c("black","red","blue"), lty = c(1,1,1), bty = "n")

  # Bottom right
  plot(utilData$DateTime,utilData$Global_reactive_power, type = "l", xlab = "datetime", # even thought I think this is just a bug in the instructions
       ylab = "global_reactive_power")

})

dev.off()