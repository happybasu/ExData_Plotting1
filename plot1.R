# Reading Data into R
power = read.table("household_power_consumption.txt",sep=";", header = T)

# Formatting the Data into the correct classes

powerFormat = power
powerFormat[,3:9]=lapply(powerFormat[,3:9],as.character)
powerFormat[,3:9]=lapply(powerFormat[,3:9],as.numeric)
library(lubridate)
powerFormat[,1] = dmy(powerFormat$Date)
powerFormat[,2] = hms(powerFormat$Time)

# Subsetting for 2007-02-01 and 2007-02-02

powerSubset = powerFormat[powerFormat$Date == ymd("2007-02-01") | powerFormat$Date == ymd("2007-02-02"),]

#create Histogram of Global Active Power and save it to a file

png(file = "plot1.png")
hist(powerSubset$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
