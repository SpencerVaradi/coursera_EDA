utilData_raw <- read.table("data/household_power_consumption.txt", header = TRUE, sep=";", stringsAsFactors = FALSE)
utilData <- utilData_raw

utilData$Date <- as.Date(utilData$Date, "%d/%m/%Y")
utilData<- utilData[utilData$Date >= as.Date("2007-02-01") & utilData$Date <= as.Date("2007-02-02"),]

utilData$DateTime <- as.POSIXct(paste(utilData$Date, utilData$Time), format = "%Y-%m-%d %H:%M:%S")

numCols <- c("Global_active_power", "Global_reactive_power","Voltage",
             "Sub_metering_1","Sub_metering_2","Sub_metering_3")

for (col in numCols){
  utilData[,col] <- as.numeric(utilData[,col])
}


# Will overwrite cleaned data file
# saveRDS(utilData, "data/utilData.rds")
