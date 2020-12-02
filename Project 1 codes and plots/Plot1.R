library(data.table)
library(dplyr)
library(lubridate)

#reading data from text file
data<-read.delim("./exdata_data_household_power_consumption/household_power_consumption.txt"
                 ,sep = ";")

#filter and replace the old data based on date between "1/2/2007" to "2/2/2007"
data<-filter(data, Date %in% c("1/2/2007","2/2/2007"))

#Covert global_active_power from char to numeric and store in variable GlobalActivePower
GlobalActivePower<-as.numeric(data$Global_active_power)

#Open graphic device in png and setting the file name and height and width for pixels
png("plot1.png", height= 480, width = 480)

#plot histogram of GlobalActivePower variable
hist(GlobalActivePower, col ="red", main = "Global Active Power", 
     xlab ="Global Active Power (kilowatts)")

#close the graphic device
dev.off()