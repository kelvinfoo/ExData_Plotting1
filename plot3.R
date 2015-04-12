plot3 <- function() {
  
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
  
  ## Draw the graph with specified parameters
  with(subst, {
    plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(DateTime, Sub_metering_2, type="l", col="red")
    points(DateTime, Sub_metering_3, type="l", col="blue")
    points(DateTime, Sub_metering_3, type="l", col="blue")
  })
  
  ## Draw the legend at topright corner with right justification
  legend(cex=0.3,"topright", xjust=1, lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  
  ## Copy screen to PNG file. 
  dev.copy(png, file="plot3.png")
  dev.off()
}