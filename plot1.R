## This file, plot1.R does two things.
## 1. Reads in the data
## 2. Plots the plot1.png file.

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
data[,3]<-as.numeric(data[,3])
data[,4]<-as.numeric(data[,4])
data[,5]<-as.numeric(data[,5])
data[,6]<-as.numeric(data[,6])
data[,7]<-as.numeric(data[,7])
data[,8]<-as.numeric(data[,8])
data[,9]<-as.numeric(data[,9])

# Convert the watts to kilowatts
data$Global_active_power<-data$Global_active_power/1000

# Save the plot to a png file.
png(filename = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red")
# Close the device
dev.off()
