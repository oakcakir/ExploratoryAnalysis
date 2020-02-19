library(tidyverse)
library(lubridate)


data <- read_delim("household_power_consumption.txt",delim = ";")

data_1 <- lapply(data$Date,dmy)
data_1 <- unlist(data_1)
data_1 <- as.Date(data_1, origin = "1970-01-01")
data$Date <- data_1
data_filtered <- data %>%
    filter(Date == "2007-02-01" | Date == "2007-02-02")

hist(data_filtered$Global_active_power, xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power", col = "red")
dev.copy(png, file = "plot1.png")
dev.off()
