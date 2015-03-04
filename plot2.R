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
# The content in columns Data and Time is a character type. Add an extra column 'DateTime' to the table as a result of concatenation
# of columns Date and Time and converting it into R's datetime field
subdata[, DateTime:=as.POSIXct(strptime(paste(Date,Time), "%d/%m/%Y %H:%M:%S"))]
# set png device
png("plot2.png")
# plot into png device
with(subdata, {
  plot(DateTime,as.numeric(Global_active_power), type="n", ylab="Global Active Power (kilowatts)", xlab="")
  lines(DateTime, as.numeric(Global_active_power), type="l")
})
# close the png device
dev.off()