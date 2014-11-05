# 

# Read Power Data
#setwd needs to be run to set the directory to the location of the household_power_consumption.txt file
# i.e. setwd('/location/of/file')
powerData <- read.table('household_power_consumption.txt',sep=';',header=TRUE,
                        stringsAsFactors=FALSE)

# subset data for 2007-02-01 and 2007-02-02
powerData <- subset(powerData,Date=="1/2/2007" | Date=="2/2/2007" )

# Combine Date and time  and convert to DateTime format
powerData$DateTime <- paste(powerData$Date,powerData$Time)
powerData$DateTime <- strptime(powerData$DateTime,"%d/%m/%Y %H:%M:%S")

#Convert numeric variable that was read in as character
# No missing values ("?") in 1 & 2 Feb 2007 data 
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
powerData$Sub_metering_3 <- as.numeric(powerData$Sub_metering_3)

powerData$Voltage <- as.numeric(powerData$Voltage)
powerData$Global_reactive_power <- as.numeric(powerData$Global_reactive_power)


#Create a png "device" to store the plot
png(filename = "plot4.png",
    width = 480, height = 480, units = "px")

# 2 by 2 panel
par(mfrow=c(2,2))

#Plot the Date-Time vs Global Active Power
plot(powerData$DateTime,powerData$Global_active_power, type="l",
     ylab="Global Active Power", xlab="")

#Plot the Date-Time vs Voltage
plot(powerData$DateTime,powerData$Voltage, type="l",
     ylab="Voltage", xlab="datetime")

#Plot the Date-Time vs Sub_metering_1
plot(powerData$DateTime,powerData$Sub_metering_1, type="l",
     ylab="Energy sub metering", xlab="")
#Add series for Sub_metering_2
lines(powerData$DateTime,powerData$Sub_metering_2, type="l",col="red")
#Add series for Sub_metering_3
lines(powerData$DateTime,powerData$Sub_metering_3, type="l",col="blue")
#Add legend to top right and remove legend box
legend("topright", legend =c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c(1,2,4), lty=1,
       box.lty=0)

#Plot the Date-Time vs Global Active Power
plot(powerData$DateTime,powerData$Global_reactive_power, type="l",
     ylab="Global_reactive_power", xlab="datetime")

#Turn off the "device" png
dev.off()

## Done :~)
