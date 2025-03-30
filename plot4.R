#load the data
data <- read.table("C:/Users/idof8/Desktop/household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
#using only the specific dates
subset_data <- subset(data, Date %in% c("2007-02-01", "2007-02-02"))
# make the subdata numeric
date_numeric <- as.numeric(subset_data$Date)
#making one list of the date and time
time_parts <- strsplit(subset_data$Time, ":")
seconds <- sapply(time_parts, function(x) as.numeric(x[1]) * 3600 + as.numeric(x[2]) * 60 + as.numeric(x[3]))
combined_time_numeric <- date_numeric * 86400 + seconds
subset_data$combined_time_numeric <- combined_time_numeric
#making the ticks on the x axis,assuming each day has the same amount of data
tick_locations <- c(min(subset_data$combined_time_numeric),max(subset_data$combined_time_numeric),mean(subset_data$combined_time_numeric))
label_names <- c("Thu", "Sat", "Fri")
#open png file
png("C:/Users/idof8/Desktop/plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#1
plot(subset_data$combined_time_numeric, subset_data$Global_active_power, type = "l",xlab = "", ylab = "Global Active Power (kilowatts)", xaxt = "n")
axis(1, at = tick_locations,labels = label_names)
#2
plot(subset_data$combined_time_numeric, subset_data$Voltage, type = "l",xlab = "datetime", ylab = "Voltage", xaxt = "n")
axis(1, at = tick_locations,labels = label_names)
#3
plot(subset_data$combined_time_numeric, subset_data$Sub_metering_1, type = "l",xaxt = "n", xlab = "", ylab = "Energy sub metering")
lines(subset_data$combined_time_numeric, subset_data$Sub_metering_2, col = "red")
lines(subset_data$combined_time_numeric, subset_data$Sub_metering_3, col = "blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),  col=c("black","red","blue"), lty = 1, bty = "n")
axis(1, at = tick_locations,labels = label_names)
#4
plot(subset_data$combined_time_numeric, subset_data$Global_reactive_power, type = "l",xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n")
axis(1, at = tick_locations,labels = label_names)

dev.off()
