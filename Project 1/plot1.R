## Exploratory Data Analysis - Project 1 - plot1.R

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

## Create the labels for the plot
xaxis <- "Global Active Power (kilowatts)"
yaxis <- "Frequency"
title <- "Global Active Power"

## Plot Global_active power for the isolated range
png("plot1.png")

## Create histogram using the isolated data and labels
hist(powerrange$Global_active_power, col = 'red', main = title, xlab = xaxis, ylab = yaxis)

## Close the graphics device
dev.off()