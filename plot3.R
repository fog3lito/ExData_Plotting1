#load the data
data <- read.table("C:/Users/Desktop/household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors = FALSE)
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
png("C:/Users/Desktop/plot3.png", width = 480, height = 480)
# plot the graph with the added lines
plot(subset_data$combined_time_numeric, subset_data$Sub_metering_1, type = "l",xaxt = "n", xlab = "", ylab = "Energy sub metering")
lines(subset_data$combined_time_numeric, subset_data$Sub_metering_2, col = "red")
lines(subset_data$combined_time_numeric, subset_data$Sub_metering_3, col = "blue")
#legend and ticks
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty = 1)
axis(1, at = tick_locations,labels = label_names)
dev.off()
