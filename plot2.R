# Reading Data into R
power = read.table("household_power_consumption.txt",sep=";", header = T)

# Formatting the Data into the correct classes
powerFormat = power
powerFormat[,3:9]=lapply(powerFormat[,3:9],as.character)
powerFormat[,3:9]=lapply(powerFormat[,3:9],as.numeric)

# Merge Date and Time into a new Column
powerFormat$Date_Time = paste(powerFormat$Date, powerFormat$Time, sep = " ")

# Format Date_Time Column
library(lubridate)
powerFormat$Date_Time = dmy_hms(powerFormat$Date_Time)
powerFormat[,1] = dmy(powerFormat$Date)
powerFormat[,2] = hms(powerFormat$Time)

# Subsetting for 2007-02-01 and 2007-02-02
powerSubset = powerFormat[powerFormat$Date == ymd("2007-02-01") | powerFormat$Date == ymd("2007-02-02"),]

#create Global Active Power plot and save it to a file
png(file = "plot2.png")
with(powerSubset,plot(Date_Time,Global_active_power, col = "white", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(powerSubset,lines(Date_Time,Global_active_power))
dev.off()
