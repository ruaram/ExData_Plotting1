##download file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "power_consumption.zip")

##unzip the file
unzip("power_consumption.zip", list=F)

## read file into a data frame
power_consumption <- read.csv2("household_power_consumption.txt", na.strings="?")

## create an extra field with date and time
power_consumption$DateTime <- as.POSIXct(strptime(paste(power_consumption$Date, power_consumption$Time, sep=" "), "%d/%m/%Y %H:%M:%S"), "UTC")

library("dplyr")

## select the relevant fields
power_consumption <- select(power_consumption, DateTime, Global_active_power, Global_reactive_power,Voltage, Global_intensity, Sub_metering_1,Sub_metering_2, Sub_metering_3)

## set the start and end date
start_time <- as.POSIXct(as.Date("2007-02-01 00:00:00"), "UTC")
end_time <- as.POSIXct(as.Date("2007-02-03 00:00:00"), "UTC")

## filter the data frame using the start and end date
power_consumption <- filter( power_consumption, DateTime >=  start_time, DateTime < end_time)

## Convert Global_active_power to numeric
power_consumption$Global_active_power <- as.numeric(as.character(power_consumption$Global_active_power))

## make call to the png device driver 
png(file="plot2.png",width=480,height=480)

## runs the graphics command
with(power_consumption, plot(DateTime, Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab=""))
## close the device stream
dev.off()
