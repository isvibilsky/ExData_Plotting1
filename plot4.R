# download a file from this location: https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# unzip its content in R working directory
# the code was tested with R version 3.1.2
# load a data.table package
library(data.table)
# fast read of the data file
data <- fread("household_power_consumption.txt", sep=";", na.strings = "?", colClasses=rep("character",9))
# subset data for period 1,2 Feb 2007 required for this course project
subdata <- data[Date %in% c('1/2/2007','2/2/2007')]
# the original data can be removed from the memory
rm(data)
# The content in columns Data and Time is a charachter type. Add an extra column 'DateTime' to the table as a result of concatenation
# of columns Date and Time and converting it into R's datetime field
subdata[, DateTime:=as.POSIXct(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"))]
# set png device
png("plot4.png")
# set a 2x2 grid for 4 plots
par(mfrow = c(2,2))
# plot 1
with(subdata, {
  plot(DateTime,as.numeric(Global_active_power), type="n", ylab="Global Active Power", xlab="")
  lines(DateTime, as.numeric(Global_active_power), type="l")
})
# plot 2
with(subdata, {
  plot(DateTime,as.numeric(Voltage), type="n", ylab="Voltage", xlab="datetime")
  lines(DateTime, as.numeric(Voltage), type="l")
})
# plot 3
with(subdata, {
  plot(DateTime, as.numeric(Sub_metering_1), type="l", ylab="Energy sub metering", xlab="")
  lines(DateTime, as.numeric(Sub_metering_2), type="l", col="red")
  lines(DateTime, as.numeric(Sub_metering_3), type="l", col="blue")
  legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1),  col=c("black","red","blue"), bty="n", adj=0.05)
})
# plot 4
with(subdata, {
  plot(DateTime,as.numeric(Global_reactive_power), type="n", xlab="datetime", ylab="Global_reactive_power")
  lines(DateTime, as.numeric(Global_reactive_power), type="l")
})
# close the png device
dev.off()