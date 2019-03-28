# setting working directory
setwd('/Users/calypso/Documents/JHRcourse/Exploratory Analysis')
# getting file from UCLA Irving website
download.file('https://archive.ics.uci.edu/ml/machine-learning-databases/00235/...
              household_power_consumption.zip',
              'household_power_consumption.zip')
#unziping downloaded folder
unzip('household_power_consumption.zip')
# viewing unlisted files
list.files()
# loading table
a <- read.csv(file = 'household_power_consumption.txt',
              header = T,
              sep = ';',
              dec = '.',
              na.strings = '?'
)
# Transformed ? symbols into NA. It considers both " " and ?
sum(is.na(a))

#subsetting data.
x <- a[(a$Date=="1/2/2007" | a$Date=="2/2/2007" ), ]

# You may find it useful to convert the Date and Time variables to Date/Time classes 
# in R using  strptime()
x$Date <- as.Date(x$Date, "%d/%m/%Y") #tranforming date first
dateTime <- paste(x$Date, x$Time) # pasting time and date toghether
x$dateTime <- as.POSIXct(dateTime) # transforming into POSIXlt

# Graphic with 3 lines 
par(mfrow=c(2,2))
plot(x$Global_active_power ~ x$dateTime,
     type="l",
     ylab="Global Active Power",
     xlab="")
plot(x$Voltage ~ x$dateTime,
     type="l",
     ylab="Voltage",
     xlab="datetime")
with(x, {
  plot(Sub_metering_1 ~ dateTime,
       type='l',
       ylab = 'Energy sub metering',
       xlab='')
  lines(Sub_metering_2~dateTime, col='red')
  lines(Sub_metering_3~dateTime, col='blue')
}) 
plot(x$Global_reactive_power ~ x$dateTime,
     type="l",
     xlab="datetime")
# extracting to working directory
dev.copy(png, file='plot4.png', height=480, width=480)
dev.off()


