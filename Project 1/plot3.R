## Exploratory Data Analysis - Project 1 - plot3.R

## This script plots power data from the date range 2007-02-01 to 2007-02-02

## Read in the data to be plotted
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## Re-cast the "Date" variable as type Date
powerdata$Date <- as.Date(strptime(powerdata$Date, "%d/%m/%Y"))

## Isolate the desired date range
powerrange <- powerdata[powerdata$Date == "2007-02-01" | powerdata$Date == "2007-02-02",]

## Release the greater data set from memory
rm(powerdata)

## Re-cast the desired variables as numeric so it can be plotted
powerrange$Sub_metering_1 <- as.numeric(as.character(powerrange$Sub_metering_1))
powerrange$Sub_metering_2 <- as.numeric(as.character(powerrange$Sub_metering_2))
powerrange$Sub_metering_3 <- as.numeric(as.character(powerrange$Sub_metering_3))

## Re-caste the "Time" variable so it can be plotted (use strptime, POSIXlt, POSIXt to faciliate conversion)
powertime <- strptime(powerrange$Time, format = "%H:%M:%S")
powertime <- powertime$hour + powertime$min/60 + powertime$sec/3600
powerrange$Time <- (powertime/24) + as.numeric(powerrange$Date == "2007-02-02") 

## Create the labels and legend for the plot 
yaxis <- "Energy sub metering"
powerlegend <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legendcolors <- c("black", "red", "blue")

## Plot Sub_metering_1 for the isolated range
png("plot3.png")
plot(powerrange$Time, powerrange$Sub_metering_1, type = 'l', xlab = '', ylab = yaxis, xaxt = 'n')

## Add and additional line for Sub_metering_2
lines(powerrange$Time, powerrange$Sub_metering_2, col = "red")

## Add and additional line for Sub_metering_2
lines(powerrange$Time, powerrange$Sub_metering_3, col = "blue")

## Add the axis labels that were supressed in the previous plot() arguments
axis(1,0:2,c("Thu", "Fri", "Sat"))

## Add the legend to the graph
legend("topright", lty = 1, legend = powerlegend, col = legendcolors)

## Close the graphics device
dev.off()