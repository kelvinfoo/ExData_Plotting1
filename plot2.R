plot2 <- function() {
  
  ## Get the column classes by reading in the first 5 rows
  cols <- read.table("household_power_consumption.txt", sep=";", header=T, nrows=5, stringsAsFactors=F)
  classes <- sapply(cols, class)
  
  ## Reading the table with column classes specified speeds up the process
  dat <- read.table("household_power_consumption.txt", sep=";", colClasses=classes, na.strings="?", header=T)
  
  ## Read data from selected dates and merge into a single DateTime column
  subst <- dat[dat$Date %in% c("1/2/2007", "2/2/2007"),]
  subst["DateTime"] <- paste(subst$Date, subst$Time)
  
  ## Covert the DateTime column into POSIXlt format and remove the redundant Date/Time columns
  subst$DateTime <- strptime(subst$DateTime, "%d/%m/%Y %H:%M:%S")
  subst$Date <- subst$Time <- NULL
  
  ## Draw the graph and copy the screen output into a PNG file
  plot(subst$DateTime, subst$Global_active_power, type = "l", xlab="", ylab="Global Active Power (kilowatts)")
  
  ## COpy screen to PNG file.
  dev.copy(png, file="plot2.png")
  dev.off()
}