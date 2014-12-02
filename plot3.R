library(dplyr)

dataFile <-'data.csv.zip'
dataUrl  <-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'

if(!file.exists(dataFile)){
  download.file(url = dataUrl, destfile = dataFile, method = "curl")
}

data <- read.csv(unzip(dataFile), sep=';', stringsAsFactors=FALSE)

## Subset Data
df <- data %>% filter(Date== '1/2/2007' | Date== '2/2/2007')

## Format Columns
df$Global_active_power<-as.numeric(df$Global_active_power)
df$dateTime<-strptime(paste(df$Date, df$Time), format='%d/%m/%Y %H:%M:%S')
df$Sub_metering_1<-as.numeric(df$Sub_metering_1)
df$Sub_metering_2<-as.numeric(df$Sub_metering_2)
df$Sub_metering_3<-as.numeric(df$Sub_metering_3)
df$Voltage<-as.numeric(df$Voltage)

## Plot
png('plot3.png',width = 480, height = 480)

plot(df$dateTime, df$Sub_metering_1, type='l', xlab='', ylab='Energy sub metering')
lines(df$dateTime, df$Sub_metering_2, col='red')
lines(df$dateTime, df$Sub_metering_3, col='blue')

legend( x="topright", 
        legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
        col=c("black","red","blue"), lwd=1, 
        lty=c(1,1,1),cex=0.8)

dev.off()

