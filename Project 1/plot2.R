## Exploratory Data Analysis - Project 1 - plot2.R

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

## Re-caste the "Time" variable so it can be plotted (use strptime, POSIXlt, POSIXt to faciliate conversion)
powertime <- strptime(powerrange$Time, format = "%H:%M:%S")
powertime <- powertime$hour + powertime$min/60 + powertime$sec/3600
powerrange$Time <- (powertime/24) + as.numeric(powerrange$Date == "2007-02-02") 

## Create the labels for the plot 
yaxis <- "Global Active Power (kilowatts)"

## Plot Global_active power for the isolated range
png("plot2.png")
plot(powerrange$Time, powerrange$Global_active_power, type = 'l', ylab = yaxis, xaxt = 'n')

## Add the axis labels that were supressed in the previous plot() arguments
axis(1,0:2,c("Thu", "Fri", "Sat"))

## Close the graphics device
dev.off()