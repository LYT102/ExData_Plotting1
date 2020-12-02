library(data.table)
library(dplyr)
library(lubridate)

#reading data from text file
data<-read.delim("./exdata_data_household_power_consumption/household_power_consumption.txt"
                 ,sep = ";")

#filter and replace the old data based on date between "1/2/2007" to "2/2/2007"
data<-filter(data, Date %in% c("1/2/2007","2/2/2007"))

#paste char type of Date and Time in the data and convert it to POSIXlt  using strptime
datetime<-paste(data$Date, data$Time, sep= " ")
datetime<-strptime(datetime, "%d/%m/%Y %H:%M:%S")

#Covert char type to numeric for all the sub metering data
Sub_metering_1<-as.numeric(data$Sub_metering_1)
Sub_metering_2<-as.numeric(data$Sub_metering_2)
Sub_metering_3<-as.numeric(data$Sub_metering_3)

#Open graphic device in png and setting the file name and height and width for pixels
png(filename = "Plot3.png",height=480,width = 480)

#Plot empty plot
plot(datetime,Sub_metering_1,type= "n", ylab ="Energy sub metering")

#adding points for the line plot and color for different varaible 
points(datetime,Sub_metering_1, type="l")
points(datetime,Sub_metering_2, type="l",col="red")
points(datetime,Sub_metering_3,type = "l",col="blue")

#adding legend to describe the variable
legend("topright", lty = 1, 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col= c("black","red","blue")
       )

#Close graphic device
dev.off()
