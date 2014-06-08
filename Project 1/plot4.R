## Exploratory Data Analysis - Project 1 - plot4.R

## This script plots power data from the date range 2007-02-01 to 2007-02-02

## Read in the data to be plotted
powerdata <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

## Re-cast the "Date" variable as type Date
powerdata$Date <- as.Date(strptime(powerdata$Date, "%d/%m/%Y"))

## Isolate the desired date range
powerrange <- powerdata[powerdata$Date == "2007-02-01" | powerdata$Date == "2007-02-02",]

## Release the greater data set from memory
rm(powerdata)

## Re-cast the Global_active_power variable as numeric so it can be plotted
powerrange$Global_active_power <- as.numeric(as.character(powerrange$Global_active_power))

## Re-cast the Voltage variable as numeric so it can be plotted
powerrange$Voltage <- as.numeric(as.character(powerrange$Voltage))

## Re-cast the Sub_metering variables as numeric so they can be plotted
powerrange$Sub_metering_1 <- as.numeric(as.character(powerrange$Sub_metering_1))
powerrange$Sub_metering_2 <- as.numeric(as.character(powerrange$Sub_metering_2))
powerrange$Sub_metering_3 <- as.numeric(as.character(powerrange$Sub_metering_3))

## Re-cast the Global_reactive_power variable as numeric so it can be plotted
powerrange$Global_reactive_power <- as.numeric(as.character(powerrange$Global_reactive_power))

## Re-caste the "Time" variable so it can be plotted (use strptime, POSIXlt, POSIXt to faciliate conversion)
powertime <- strptime(powerrange$Time, format = "%H:%M:%S")
powertime <- powertime$hour + powertime$min/60 + powertime$sec/3600
powerrange$Time <- (powertime/24) + as.numeric(powerrange$Date == "2007-02-02") 

## Create the labels and legend for the Sub_metering plot 
yaxis1 <- "Global Active Power (kilowatts)"
xaxis2 <- "datetime"
yaxis2 <- "Voltage"
yaxis3 <- "Energy sub metering"
powerlegend3 <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
legendcolors3 <- c("black", "red", "blue")
xaxis4 <- "datetime"
yaxis4 <- "Global_reactive_power"

## Draw 4 graphs on the same plot
png("plot4.png")
par(mfrow = c(2,2))

### GRAPH 1
#### Plot Global_active_power for the isolated range
plot(powerrange$Time, powerrange$Global_active_power, type = 'l', xlab = '', ylab = yaxis1, xaxt = 'n')

#### Add the axis labels that were supressed in the previous plot() arguments
axis(1,0:2,c("Thu", "Fri", "Sat"))

### GRAPH 2 
#### Plot Voltage for the isolated range
plot(powerrange$Time, powerrange$Voltage, type="l", xlab = xaxis2, ylab = yaxis2, xaxt="n")

#### Add the axis labels that were supressed in the previous plot() arguments
axis(1,0:2,c("Thu","Fri","Sat"))

### GRAPH 3
#### Plot Sub_metering_1 for the isolated range
plot(powerrange$Time, powerrange$Sub_metering_1, type = 'l', xlab = '', ylab = yaxis3, xaxt = 'n')

#### Add and additional line for Sub_metering_2
lines(powerrange$Time, powerrange$Sub_metering_2, col = "red")

#### Add and additional line for Sub_metering_2
lines(powerrange$Time, powerrange$Sub_metering_3, col = "blue")

#### Add the axis labels that were supressed in the previous plot() arguments
axis(1,0:2,c("Thu", "Fri", "Sat"))

#### Add the legend to the graph
legend("topright", lty = 1, bty = 'n', legend = powerlegend3, col = legendcolors3)

### Graph 4
#### Plot Global_reactive_power for the isolated range
plot(powerrange$Time, powerrange$Global_reactive_power, type = "l", xlab = xaxis4, ylab = yaxis4, xaxt="n")

#### Add the axis labels that were supressed in the previous plot() arguments
axis(1,0:2,c("Thu", "Fri", "Sat"))

## Close the graphics device
dev.off()