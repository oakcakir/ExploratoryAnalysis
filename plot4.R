library(tidyverse)
library(lubridate)
library(gridExtra)


data <- read_delim("household_power_consumption.txt",delim = ";")

data_1 <- lapply(data$Date,dmy)
data_1 <- unlist(data_1)
data_1 <- as.Date(data_1, origin = "1970-01-01")
data$Date <- data_1
data_filtered <- data %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")

Date_Time <- with(data_filtered, ymd(Date) + hms(Time))
data_filtered$Date_Time <- Date_Time

data_filtered$Date_Time <- as.POSIXct(data_filtered$Date_Time)
require(gridExtra)


p1 <- ggplot(aes(x = Date_Time, y = Global_active_power), data = data_filtered) + geom_line() + labs(x = "",y = "Global Active Power") + scale_x_datetime(date_labels = "%a",date_breaks = "1 day") +
    theme(panel.background = element_rect(fill = "white", colour= "black",size = 0.5), 
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(size = 0.5, linetype = "solid", colour = "black"))                                                                                                                                                                                                                 

p2 <- ggplot(aes(x = Date_Time, y = Voltage), data = data_filtered) + geom_line() + labs(x = "",y = "Voltage") + scale_x_datetime(date_labels = "%a",date_breaks = "1 day") +
    theme(panel.background = element_rect(fill = "white", colour= "black",size = 0.5), 
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(size = 0.5, linetype = "solid", colour = "black")) 

p3 <- ggplot() + geom_line(aes(x = Date_Time, y = Sub_metering_1, color = "Sub_metering_1"), data = data_filtered) +
    geom_line(aes(x = Date_Time, y = Sub_metering_2, color = "Sub_metering_2"), data = data_filtered) +
    geom_line(aes(x = Date_Time, y = Sub_metering_3, color = "Sub_metering_3"), data = data_filtered) +
    labs(x = "",y = "Energy sub metering") + scale_x_datetime(date_labels = "%a",date_breaks = "1 day") +
    theme(legend.justification = c("right", "top"),
          legend.position = c(0.95, 0.98),
          panel.background = element_rect(fill = "white", colour= "black",size = 0.5),
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(size = 0.5, linetype = "solid", colour = "black"), 
          legend.key = element_rect(fill = "white")) + 
    scale_color_manual("",values = c("Sub_metering_1" = "black", "Sub_metering_2" = "red", "Sub_metering_3" = "blue")) 

p4 <- ggplot(aes(x = Date_Time, y = Global_reactive_power), data = data_filtered) + geom_line() + labs(x = "",y = "Global Reactive Power") + scale_x_datetime(date_labels = "%a",date_breaks = "1 day") +
    theme(panel.background = element_rect(fill = "white", colour= "black",size = 0.5), 
          panel.border = element_blank(),
          panel.grid.major = element_blank(),
          panel.grid.minor = element_blank(),
          axis.line = element_line(size = 0.5, linetype = "solid", colour = "black")) 



grid.arrange(p1, p2, p3, p4, ncol=2)
dev.copy(png, file = "plot4.png")
dev.off()

