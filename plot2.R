######################################################################################################
# set work directory if needed
setwd ("C://Users//Yoga2Pro//Downloads")

###################################
# install and load library "lubridate" 
if(!is.element("lubridate", installed.packages()[,1])){
    install.packages("lubridate")
    }
library(lubridate)

# define file source for data input
filename <- "household_power_consumption.txt"
file <- "household_power_consumption.zip"
url <- "http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
data_path <- "household_power_consumption"

# download data zip file to work directory
if(!file.exists(file)){    
	    download.file(url,file, mode = "wb")
	    }

###################################
# reads file
getTable <- function (filename)
		{
			f <- unz(file, filename)
			data <- data.frame()
			data <- read.table(f,header=TRUE,sep=';', na.strings='?', colClasses=c(rep('character', 2),rep('numeric', 7)))
			data    
		}

raw <- getTable(filename=filename)

# subset based on date/time
raw$Date <- dmy(raw$Date)
raw$Time <- hms(raw$Time)
rawsub <- subset(raw, , year(Date) == 2007 & month(Date) == 2 & (day(Date) == 1 | day(Date) == 2))
rawsub$datetime <- rawsub$Date + rawsub$Time
###################################
# output plot to png file
png(filename='plot2.png')
plot(rawsub$datetime, rawsub$Global_active_power,ylab='Global Active Power (kilowatts)', xlab='', type='l')
dev.off()
