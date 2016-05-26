## This file, plot4.R does two things.
## 1. Reads in the data
## 2. Plots the plot4.png file.

library(lubridate)

# First download the data if haven't before.
fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("data.zip")){
  download.file(fileUrl, "data.zip")
  unzip("data.zip")
}

# Read in data but quickly subset only the data from 2007-02-01 and 2007-02-02 (2 days)
# and then remove the rest.
dt<-read.table("household_power_consumption.txt", header = TRUE, sep=";")
dt$Date<-as.Date(dt$Date, "%d/%m/%Y")
data<-dt[year(dt$Date)==2007 & month(dt$Date)==2 & (day(dt$Date)==1 | day(dt$Date)==2),]
rm(dt)

# The columns are read in as factors so change to numerics for plotting.
# And change the time to a time format.
#data$Time<-strptime(data$Time,format = "%H:%M:%S")
data[,3]<-as.numeric(data[,3])
data[,4]<-as.numeric(data[,4])
data[,5]<-as.numeric(data[,5])
data[,6]<-as.numeric(data[,6])
data[,7]<-as.numeric(data[,7])
data[,8]<-as.numeric(data[,8])
data[,9]<-as.numeric(data[,9])

# Convert the watts to kilowatts
data$Global_active_power<-data$Global_active_power/1000

# Make a new column that has the full combined date and time
data$fullDate<-paste(data$Date,data$Time)
data$fullDate<-as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Save the plot to a png file.
png(filename = "plot4.png", width = 480, height = 480)

# Prepare for 4 plots in one.
par(mfrow=c(2,2))

# Upper left plot
with(data,plot(fullDate,Global_active_power, xlab="",
               ylab="Global Active Power", type = "l") )

# Upper right plot
with(data,plot(fullDate,Voltage,type="l",xlab="datetime"))

# Lower left plot
with(data,plot(fullDate,Sub_metering_1, xlab="",
               ylab="Energy sub metering", type = "l") )
with(data,lines(fullDate,Sub_metering_2, col="red"))
with(data,lines(fullDate,Sub_metering_3, col="blue"))
legend(x="topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , col=c("black","red","blue"), lwd=2, text.font=0.5, cex=0.64)

# Lower right plot
with(data,plot(fullDate,Global_reactive_power,type="l",xlab="datetime"))

# Close the device
dev.off()
