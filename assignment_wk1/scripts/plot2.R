
# If you want, run the cleaning from this config file.
# But, that will take a little bit since it is subsetted after reading file
# Cleaned data is in an RDS file loaded below
# source("scripts/wk1_config.R")

utilData <- readRDS("data/utilData.rds")

# Plot 2
png(file = "graphs/plot2.png")
plot(utilData$DateTime,utilData$Global_active_power, type = "l", xlab = NA, ylab = "Global Active Power (kilowatts)")
dev.off()
