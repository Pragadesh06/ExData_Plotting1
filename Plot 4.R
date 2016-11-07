#Reading, naming and subsetting power consumption data
power <- read.table("household_power_consumption.txt",skip=1,sep=";")
names(power) <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
subpower <- subset(power,power$Date=="1/2/2007" | power$Date =="2/2/2007")

# Transforming the Date and Time vars from characters into objects of type Date and POSIXlt respectively
subpower$Date <- as.Date(subpower$Date, format = "%d/%m/%Y")
subpower$Time <- strptime(subpower$Time, format = "%H:%M:%S")
subpower[1:1440,"Time"] <- format(subpower[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subpower[1440:2880,"Time"] <- format(subpower[1440:2880,"Time"],"2007-02-02 %H:%M:%S")

par(mfrow = c(2,2))

png("Plot4.png",width = 480,height = 480)
with(subpower,{
plot(subpower$Time,as.numeric(as.character(subpower$Global_active_power)),type="l",xlab="",ylab="Global Active Power (kilowatts)")
plot(subpower$Time,as.numeric(as.character(subpower$Voltage)),type="l",xlab="datetime",ylab="Voltage")
plot(subpower$Time,subpower$Sub_metering_1,type = "n", xlab = "",ylab = "Energy Sub Metering")
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_1))))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_2)),col= "Red"))
with(subpower,lines(Time,as.numeric(as.character(Sub_metering_3)),col= "blue"))
legend("topright",lty = 1,col = c("black","red","blue"),legend = c("sub_metering_1","sub_metering_2","sub_metering_3"),cex=0.6)
plot(subpower$Time,as.numeric(as.character(subpower$Global_reactive_power)),type="l",xlab="datetime",ylab="Global reActive Power (kilowatts)")
}) 
dev.off()
