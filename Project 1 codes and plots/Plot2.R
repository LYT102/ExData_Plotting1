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

#Covert global_active_power from char to numeric and store in variable GlobalActivePower
GlobalActivePower<- as.numeric(data$Global_active_power)

#Open graphic device in png and setting the file name and height and width for pixels
png(filename = "Plot2.png", height = 480, width = 480)

#Plot datatime againts GlobalActivePower in line 
plot(datetime,GlobalActivePower, type = "l", ylab = "Global Active Power (kilowatts)" )

#Close graphic device
dev.off()