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


#Create a png "device" to store the plot
png(filename = "plot2.png",
    width = 480, height = 480, units = "px")

#Plot the Date-Time vs Global Active Power
plot(powerData$DateTime,powerData$Global_active_power, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

#Turn off the "device" png
dev.off()

## Done :~)


 

