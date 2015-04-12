plot4 <- function() {
  
  ## Get the column classes by reading in the first 5 rows
  cols <- read.table("household_power_consumption.txt", sep=";", header=T, nrows=5, stringsAsFactors=F)
  classes <- sapply(cols, class)
  
  ## Reading the table with column classes specified speeds up the process
  dat <- read.table("household_power_consumption.txt", sep=";", colClasses=classes, na.strings="?", 
                    header=T)
  
  ## Read data from selected dates and merge into a single DateTime column
  subst <- dat[dat$Date %in% c("1/2/2007", "2/2/2007"),]
  subst["DateTime"] <- paste(subst$Date, subst$Time)
  
  ## Covert the DateTime column into POSIXlt format and remove the redundant Date/Time columns
  subst$DateTime <- strptime(subst$DateTime, "%d/%m/%Y %H:%M:%S")
  subst$Date <- subst$Time <- NULL
  
  ## Set the base plots
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))	
  
  ## Draw the graphs with specified parameters
  ## Reduced the legend's text size using cex=0.7 and removed its border using bty="n"
  with(subst, {
    plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
    plot(DateTime, Voltage, type="l", xlab="datetime", ylab="Voltage")
    plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(DateTime, Sub_metering_2, type="l", col="red")
    points(DateTime, Sub_metering_3, type="l", col="blue")
    legend("topright", xjust=1, lty=1, col=c("black", "red", "blue"), cex=0.7, legend=c
           ("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty="n")
    plot(DateTime, Global_reactive_power, type="l", xlab="datetime")
  })
  
  ## Copy screen to PNG file. 
  dev.copy(png, file="plot4.png")
  dev.off()
}