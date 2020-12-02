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

#Covert char type to numeric type for all the variable needed for plotting
GlobalActivePower<-as.numeric(data$Global_active_power)
Voltage<-as.numeric(data$Voltage)
Global_reactive_power<-as.numeric(data$Global_reactive_power)
Sub_metering_1<-as.numeric(data$Sub_metering_1)
Sub_metering_2<-as.numeric(data$Sub_metering_2)
Sub_metering_3<-as.numeric(data$Sub_metering_3)

#Open graphic device in png and setting the file name and height and width for pixels
png(filename = "Plot4.png",height = 480, width = 480)

#Setting up the plot location 
par(mfrow=c(2,2))

#plot 1 top left
plot(datetime,GlobalActivePower,type="l",xlab="",ylab= "Global Active Power")

#plot 2 top right
plot(datetime,Voltage,type="l")

#plot 3 bottom left
plot(datetime,Sub_metering_1,type= "n", ylab ="Energy sub metering")
points(datetime,Sub_metering_1, type="l")
points(datetime,Sub_metering_2, type="l",col="red")
points(datetime,Sub_metering_3,type = "l",col="blue")
legend("topright", lty = 1, 
        legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
        col= c("black","red","blue")
      )

#plot 4 bottom right
plot(datetime,Global_reactive_power,type="l")

#close graphic device
dev.off()