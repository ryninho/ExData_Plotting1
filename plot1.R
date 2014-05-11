# Set working directory
setwd("<insert your working directory here>")

# Get files from web
download.file(
  url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  destfile = "Electric power consumption.zip"
)

# "We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than 
# reading in the entire dataset and subsetting to those dates."

library(sqldf)

hpc <- read.csv.sql(
  file = "household_power_consumption.txt",
  sql = "SELECT * from file WHERE Date = '1/2/2007' OR Date = '2/2/2007'",
  sep=";"
)

# create datetime field from Date, Time
hpc$datetime <- strptime(
  paste(
    hpc$Date, hpc$Time, sep=" "
    ), 
  format="%d/%m/%Y %H:%M:%S"
)




# Plot 1

png("plot1.png",w = 480, h = 480)

par(mfrow = c(1,1))

hist(
  x = hpc$Global_active_power,
  breaks = 16,
  col = "red",
  main = "Global Active Power",
  xlab = "Global Active Power (kilowatts)"
)


dev.off()
