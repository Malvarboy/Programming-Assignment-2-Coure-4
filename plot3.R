# PROGRAMMING ASSIGNMENT 2 OF COURSE 4

# DATA SCIENCE COURSE OF JOHN HOPKINS


# Generate Plot 3

########################################
# Load libraries
########################################

library(tidyverse)
library(ggplot2)


########################################
# Read the data files
########################################

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


########################################
# Filter data for Baltimore
########################################

baltimore_2 <- nei %>% filter(fips == "24510") %>% group_by(year, type) %>% 
        summarise(total = sum(Emissions))
g <- ggplot(baltimore_2, aes(x = year, y = total))

########################################
# Create and save the png file
########################################


png("plot3.png",width = 480, height = 480)
g + geom_line() + ggtitle("Total PM2.5 Emissions in Baltimore by Type Per Year") +
        ylab("Emissions (tons)") + facet_wrap(~type) + 
        theme(plot.title = element_text(hjust = 0.5))
dev.off()