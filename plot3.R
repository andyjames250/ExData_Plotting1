# Generate multiple time series chart for sub metering
zipUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile = "exdata-data-household_power_consumption.zip"
dataFile = "household_power_consumption.txt"
outputFile = "plot3.png"
if(!file.exists(zipFile)) {
        download.file(url = zipUrl, destfile = zipFile, method = "curl")
}
if(!file.exists(dataFile)) {
        unzip(zipFile)
}
data1 <- read.table(file = dataFile, header = FALSE, sep = ";", 
                    na.strings = "?", nrows = 2880, skip = 66637)
data1Names <- read.table(file = dataFile, header = TRUE, sep = ";", 
                         na.strings = "?", nrows = 1)
colnames(data1) <- colnames(data1Names)
rm(data1Names)
data1$Time <- strptime(x = paste(data1$Date, data1$Time), "%d/%m/%Y %H:%M:%S")
data1$Date <- as.Date(data1$Date, "%d/%m/%Y")
legendText <- colnames(data1[,7:9])
png(filename = outputFile, width = 480, height = 480, bg = "transparent")
plot(data1$Time, data1$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering", col = "black")
points(data1$Time, data1$Sub_metering_2, type = "l", col = "red")
points(data1$Time, data1$Sub_metering_3, type = "l", col = "blue")
legend(x = "topright", legend = legendText, col = c("black", "red", "blue"), 
       lty = 1)
dev.off()