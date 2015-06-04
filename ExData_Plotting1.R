library(dplyr)
#read in household data
hh<-read.table("/Users/Cherry/Downloads/household_power_consumption.txt", header=TRUE, sep=";")
hh<-tbl_df(hh)
names(hh)
dim(hh)

# subset hh for only 2007-02-01 or 2007-02-02
hh1<-subset(hh, Date=="1/2/2007" | Date=="2/2/2007")
hh1$Date<-as.character(as.Date(hh1$Date,"%d/%m/%Y"))
hh1$Time<-as.character(hh1$Time)
hh1<-within(hh1, {datetime=format(as.POSIXct(paste(Date, Time)),"%Y/%m/%d %H:%M:%S")})
hh1$datetime<-as.POSIXct(hh1$datetime)
head(hh1$datetime)
hh1$Global_active_power<-as.numeric(hh1$Global_active_power)

# plot 1
par(mar=c(4,4,2,2))
par(mfrow=c(1,1))
hh1$Global_active_power_kw<-hh1$Global_active_power/500
hist(hh1$Global_active_power_kw, main="Global Active Power", xlab="Gobal Active Power (kilowatts)", ylab="Frequency",col="red")

# plot 2
table(hh1$day)
plot(hh1$datetime,hh1$Global_active_power_kw,type='l', xlab='', ylab='Global Active Power (kilowatts)')

# plot 3
hh1$Sub_metering_1<-as.numeric(hh1$Sub_metering_1)
hh1$Sub_metering_2<-as.numeric(hh1$Sub_metering_2)
hh1$Sub_metering_3<-as.numeric(hh1$Sub_metering_3)
plot(hh1$datetime, hh1$Sub_metering_1,type='n',xlab='', ylab='Energy sub metering')
lines(hh1$datetime, hh1$Sub_metering_1, col='black')
lines(hh1$datetime, hh1$Sub_metering_2, col='red')
lines(hh1$datetime, hh1$Sub_metering_3, col='blue')
legend("topright", lty=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_2'))

# plot 4
par(mfcol=c(2,2))

plot(hh1$datetime,hh1$Global_active_power_kw,type='l', xlab='', ylab='Global Active Power (kilowatts)')

plot(hh1$datetime, hh1$Sub_metering_1,type='n',xlab='', ylab='Energy sub metering')
lines(hh1$datetime, hh1$Sub_metering_1, col='black')
lines(hh1$datetime, hh1$Sub_metering_2, col='red')
lines(hh1$datetime, hh1$Sub_metering_3, col='blue')
legend("topright", border='white',lty=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_2'))

hh1$Voltage<-as.numeric(hh1$Voltage)
plot(hh1$datetime, hh1$Voltage, type='n', xlab='datetime', ylab='Voltage')
lines(hh1$datetime, hh1$Voltage)

hh1$Global_reactive_power<-as.numeric(hh1$Global_reactive_power)
plot(hh1$datetime, hh1$Global_reactive_power, type='n', xlab='datetime', ylab='Global_reactive_power')
lines(hh1$datetime, hh1$Global_reactive_power)

