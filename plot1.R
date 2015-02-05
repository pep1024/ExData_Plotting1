# Draw plot 1 of project 1 EDA course
Sys.setlocale( category = "LC_TIME", "English")

# Read data_file from URL if it does not exist
if(!file.exists("household_power_consumption.txt")) {
  temp <- tempfile()
  download.file("https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip", temp)
  power_consumption <- read.table(unz(temp, "household_power_consumption.txt"),
    stringsAsFactors = FALSE, header = TRUE, sep = ";", dec = ".", na.strings = "?")
  unlink(temp) 
} else {
  power_consumption <- read.table(file = "household_power_consumption.txt",
    stringsAsFactors = FALSE, header = TRUE, sep = ";", dec = ".", na.strings = "?")
}

# Convert date and time to a new field
power_consumption$complete_date_time <- 
  strptime(paste(power_consumption$Date, power_consumption$Time), "%d/%m/%Y %H:%M:%S")

# Subset the whole data set to the range of interest
condition <- as.Date(power_consumption$complete_date_time) == as.Date('2007-02-01') |
  as.Date(power_consumption$complete_date_time) == as.Date('2007-02-02')
power_set <- power_consumption[condition, ]

# Plot 1
png("plot1.png", width = 480, height = 480, units = "px")

hist(x = power_set$Global_active_power, 
  xlab = "Global Active Power (kilowatts)",
  col =  "red",
  main = "Global Active Power")

dev.off()
