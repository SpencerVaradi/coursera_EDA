utilData_raw <- read.table("data/household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)
utilData <- utilData_raw

utilData$Date <- as.Date(utilData$Date, "%d/%m/%Y")
utilData<- utilData[utilData$Date >= as.Date("2007-02-01") & utilData$Date <= as.Date("2007-02-02"),]


train <- sample_n(utilData, 20)

as.POSIXct(paste(train$Date, train$Time), format = "%Y-%m-%d %H:%M:%S")

utilData$DateTime <- as.POSIXct(paste(utilData$Date, utilData$Time), format = "%Y-%m-%d %H:%M:%S")
utilData$Global_active_power <- as.numeric(utilData$Global_active_power)

# Plot 1
# Histogram of Global_active_power
png(file = "graphs/plot1.png")
hist(utilData$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()


# Plot 2
png(file = "graphs/plot2.png")
plot(utilData$DateTime,utilData$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")
dev.off()

#Plot 3
png(file = "graphs/plot3.png")

plot(utilData$DateTime,utilData$Sub_metering_1, type = "l", xlab = NA, ylab = "Energy sub metering")
lines(utilData$DateTime,utilData$Sub_metering_2, type = "l", xlab = NA, col = "red")
lines(utilData$DateTime,utilData$Sub_metering_3, type = "l", xlab = NA, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1,1))

dev.off()

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
