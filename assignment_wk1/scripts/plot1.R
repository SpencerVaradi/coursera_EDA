
# If you want, run the cleaning from this config file.
# But, that will take a little bit since it is subsetted after reading file
# Cleaned data is in an RDS file loaded below
# source("scripts/wk1_config.R")

utilData <- readRDS("data/utilData.rds")

# Plot 1
# Histogram of Global_active_power
png(file = "graphs/plot1.png")
hist(utilData$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red")
dev.off()

