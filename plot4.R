## Exploratory Data Analysis: Course Project 1
## https://class.coursera.org/exdata-011/human_grading/view/courses/973505/assessments/3/submissions

## Load required packages
if (!require("data.table")) {
  install.packages("data.table")
}
require("data.table")

## Download and decompress data & record date of download
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("household_power_consumption.txt")) {
  download.file(fileURL, destfile="dataset.zip")
  date.downloaded = date()
  message("Decompressing data ...")
  unzip("dataset.zip")
  message("Data decompressed.")
}

## Read data into memory, format dates & select data for dates of interest
message("Reading data ...")
dataset <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")
dataset$Date <- as.Date(dataset$Date, format="%d/%m/%Y")
dataset <- subset(dataset, Date >= "2007-02-01" & Date <= "2007-02-02")

## Merge date and time into one variable
dataset$DateTime <- strptime(paste(dataset$Date, dataset$Time), "%Y-%m-%d %H:%M:%S")

## Plot 4
par(mfrow=c(2,2), mar=c(4,4,2,1))
# plot 4a
plot(dataset$DateTime, dataset$Global_active_power, type="l", xlab="", ylab="Global Active Power")
# plot 4b
plot(dataset$DateTime, dataset$Voltage, type="l", xlab="datetime", ylab="Voltage")
# plot 4c
plot(dataset$DateTime, dataset$Sub_metering_1, type="l", xlab="", ylab = "Energy Sub Metering", col="grey")
points(dataset$DateTime, dataset$Sub_metering_2, type="l", col="red")
points(dataset$DateTime, dataset$Sub_metering_3, type="l", col="blue")
points(dataset$DateTime, dataset$Sub_metering_2, type="l", col="red")
legend("topright", col=c("grey", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2, bty="n") #bty suppresses box around legend; lty line type; lwd line width
#plot 4d
plot(dataset$DateTime, dataset$Global_reactive_power, type = "l", xlab="datetime", ylab="Global_reactive_power", ylim=c(0, 0.5))
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()