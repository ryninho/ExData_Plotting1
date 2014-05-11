# Set working directory
# setwd("<insert your working directory here>")

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



png(filename = "plot4.png", width = 480, height = 480)

par(mfrow = c(2,2))

# global active power plot (upper left)

# create empty plot
plot(
  x = hpc$datetime,
  y = hpc$Global_active_power,
  type = "n",
  ylab = "Global Active Power (kilowatts)",
  xlab = NA
)

# connect the invisible points with a line
lines(
  x = hpc$datetime,
  y = hpc$Global_active_power,
  type = 'l'
)

# voltage plot (upper right)

# create empty plot
plot(
  x = hpc$datetime,
  y = hpc$Voltage,
  type = "n",
  ylab = "Voltage",
  xlab = "datetime"
)

# connect the invisible points with a line
lines(
  x = hpc$datetime,
  y = hpc$Voltage,
  type = 'l'
)


# sub metering plot (lower left)

# create empty plot
plot(
  y = hpc$Sub_metering_1,
  x = hpc$datetime,
  type = "n",
  ylab = "Energy sub metering",
  xlab = NA
)

# add a line for each sub metering metric
lines(
  x = hpc$datetime,
  y = hpc$Sub_metering_1,
  type = 'l',
  col = "black"
)

lines(
  x = hpc$datetime,
  y = hpc$Sub_metering_2,
  type = 'l',
  col = "red"
)

lines(
  x = hpc$datetime,
  y = hpc$Sub_metering_3,
  type = 'l',
  col = "blue"
)

# add legend

legend("topright",
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       bty = "n"
)


# global reactive power plot (lower right)

# create empty plot
plot(
  x = hpc$datetime,
  y = hpc$Global_reactive_power,
  type = "n",
  ylab = "Global_reactive_power",
  xlab = "datetime"
)

# connect the invisible points with a line
lines(
  x = hpc$datetime,
  y = hpc$Global_reactive_power,
  type = 'l'
)


dev.off()
