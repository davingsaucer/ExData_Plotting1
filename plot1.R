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
x$dateTime <- paste(x$Date, x$Time) # pasting time and date toghether
x$dateTime <- strptime(x$dateTime, "%Y-%m-%d %H:%M:%S") # transforming into POSIXlt

# generating grphic
hist(x$Global_active_power, 
     main="Global Active Power", 
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency",
     col="Red")

## export file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
