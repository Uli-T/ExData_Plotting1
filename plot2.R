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

## Plot 2
par(mfrow=c(1,1))
plot(dataset$DateTime, dataset$Global_active_power, type="l", xlab="DateTime", ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
