## Partially reading file and preparing dataset

filename <- "./data/household_power_consumption.txt"

data <- read.table(filename, nrows = 300000, na.strings = "?", sep = ";", header=TRUE) 
                   
data$DateTime = strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
data$Date = NULL
data$Time = NULL

data = subset(data, 
             DateTime > as.POSIXct("2007-02-01", tz="GMT") & DateTime < as.POSIXct("2007-02-03", tz="GMT"))

## Drawing plot

hist(data$Global_active_power, 
     col="red",
     main = "Global Active Power", 
     xlab="Global Active Power (kilowatts)")

# Saving plot

dev.copy(png, file = "plot1.png", width=480, height=480) 
dev.off()
