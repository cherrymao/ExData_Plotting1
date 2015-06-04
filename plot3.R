library(dplyr)
#read in household data
hh<-read.table("/Users/Cherry/Downloads/household_power_consumption.txt", header=TRUE, sep=";")
hh<-tbl_df(hh)


# subset hh for only 2007-02-01 or 2007-02-02
hh1<-subset(hh, Date=="1/2/2007" | Date=="2/2/2007")
hh1$Date<-as.character(as.Date(hh1$Date,"%d/%m/%Y"))
hh1$Time<-as.character(hh1$Time)
hh1<-within(hh1, {datetime=format(as.POSIXct(paste(Date, Time)),"%Y/%m/%d %H:%M:%S")})
hh1$datetime<-as.POSIXct(hh1$datetime)
hh1$Global_active_power<-as.numeric(hh1$Global_active_power)

# plot 3
hh1$Sub_metering_1<-as.numeric(hh1$Sub_metering_1)
hh1$Sub_metering_2<-as.numeric(hh1$Sub_metering_2)
hh1$Sub_metering_3<-as.numeric(hh1$Sub_metering_3)
png("/Users/Cherry/GitHub/ExData_Plotting1/figure/plot3.png", width=480, height=480, units="px")
plot(hh1$datetime, hh1$Sub_metering_1,type='n',xlab='', ylab='Energy sub metering')
lines(hh1$datetime, hh1$Sub_metering_1, col='black')
lines(hh1$datetime, hh1$Sub_metering_2, col='red')
lines(hh1$datetime, hh1$Sub_metering_3, col='blue')
legend("topright", lty=1, col=c('black', 'red', 'blue'), legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_2'))
dev.off()
