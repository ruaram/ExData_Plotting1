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

## Convert to numeric
power_consumption$Sub_metering_1 <- as.numeric(as.character(power_consumption$Sub_metering_1))
power_consumption$Sub_metering_2 <- as.numeric(as.character(power_consumption$Sub_metering_2))
power_consumption$Sub_metering_3 <- as.numeric(as.character(power_consumption$Sub_metering_3))
power_consumption$Voltage <- as.numeric(as.character(power_consumption$Voltage))
power_consumption$Global_reactive_power <- as.numeric(as.character(power_consumption$Global_reactive_power))
power_consumption$Global_active_power <- as.numeric(as.character(power_consumption$Global_active_power))


## make call to the png device driver 
png(file="plot4.png",width=480,height=480)

par(mfrow=c(2,2), mar=c(4,4,1,1) , oma=c(0,0,2,0))
plot(power_consumption$DateTime, power_consumption$Global_active_power, type = "l", ylab = "Global Active Power", xlab="")
plot(power_consumption$DateTime, power_consumption$Voltage, type = "l", ylab = "Voltage", xlab="DateTime")
plot(power_consumption$DateTime, power_consumption$Sub_metering_1, type = "l", ylab="Energy sub metering", xlab="")
lines(power_consumption$DateTime, power_consumption$Sub_metering_2, type = "l", col="red")
lines(power_consumption$DateTime, power_consumption$Sub_metering_3, type = "l", col="blue")
legend("topright",lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot(power_consumption$DateTime, power_consumption$Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab="DateTime")


## close the device stream
dev.off()
