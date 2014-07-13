## Set locale
Sys.setlocale(category = "LC_ALL", locale = "C")

## Partially reading file and preparing dataset

filename <- "./data/household_power_consumption.txt"

data <- read.table(filename, nrows = 300000, na.strings = "?", sep = ";", header=TRUE) 

data$DateTime = strptime(paste(data$Date, data$Time), format = "%d/%m/%Y %H:%M:%S", tz="GMT")
data$Date = NULL
data$Time = NULL

data = subset(data, 
              DateTime > as.POSIXct("2007-02-01", tz="GMT") & DateTime < as.POSIXct("2007-02-03", tz="GMT"))

# Opening graphics device (I had to use this method because of weird legend issues)

png(file = "plot4.png", width=480, height=480)#, pointsize=1, type="cairo", antialias = "default")

## Drawing plot

par(mfrow=c(2,2))

## top-left plot

with(data, 
     plot(DateTime, 
          Global_active_power, 
          type="l", 
          xlab="", 
          ylab="Global Active Power"))

## top-right plot

with(data, 
     plot(DateTime, 
          Voltage, 
          type="l",
          xlab="datetime"))

## bottom-left plot

with(data, 
     plot(DateTime,
          Sub_metering_1, 
          type="l", 
          xlab="", 
          ylab="Energy sub metering"))

with(data, 
     lines(DateTime,
           Sub_metering_2, 
           col="red"))

with(data, 
     lines(DateTime,
           Sub_metering_3, 
           col="blue"))

legend("topright", 
       lty=1, 
       col=c("black", "blue", "red"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty="n")

# bottom-right plot

with(data, 
     plot(DateTime, 
          Global_reactive_power, 
          type="l",
          xlab="datetime"))

# Closing graphics device
dev.off()

# Reset locale :)
Sys.setlocale(category = "LC_ALL", locale = "")