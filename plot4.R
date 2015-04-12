#Create directory for data and png
if (!file.exists("MyPlots"))
{
  dir.create("MyPlots")
}

#Download and unzip data
if (!file.exists("./MyPlots/household_power_consumption.txt"))
{
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "./MyPlots/MyData.zip")
  unzip("./MyPlots/MyData.zip", exdir = "./MyPlots")
}

#Read data
f <- read.table("./MyPlots/household_power_consumption.txt", sep = ";",  header = TRUE, na.strings = "?")
#Awful idea but now I want to sleep
ff <- subset(f, f$Date == "1/2/2007" )
ff <- rbind(ff,subset(f, f$Date == "2/2/2007" ))
ff$DateTime <- strptime(paste(ff$Date, ff$Time), "%d/%m/%Y %H:%M:%S")

#Create a plot 

par(mfrow = c(2,2))

#1
with(ff, plot(DateTime, Global_active_power
                      , type = "l"
                      , ylab = "Global Active Power (kilowatts)"
                      , xlab = ""))
#2
with(ff, plot(DateTime, Voltage
                      , type = "l"
                      , xlab = "datetime"))
#3
with(ff, plot(DateTime, Sub_metering_1, type = "l"
                      , ylab = "Energy sub metering"
                      , xlab = ""))
with(ff, lines(DateTime, Sub_metering_2, col = "red"))
with(ff, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1
       , col = c("black", "red", 'blue')
       , legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       , cex = 0.6
       , text.width = 65000 #I don`t think that it is a good method
       ,bty = "n") 

#4
with(ff, plot(DateTime, Global_reactive_power
              , type = "l"
              , xlab = "datetime"))

#Save to png
dev.copy(png, file = "./MyPlots/plot4.png")
dev.off()