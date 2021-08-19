# PROGRAMMING ASSIGNMENT 2 OF COURSE 4

# DATA SCIENCE COURSE OF JOHN HOPKINS


# Generate Plot 2

########################################
# Load libraries
########################################

library(tidyverse)


########################################
# Read the data files
########################################

nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")


########################################
# Filter data for Baltimore
########################################

baltimore <- nei %>% filter(fips == "24510") %>% group_by(year) %>% 
        summarise(total = sum(Emissions))
to_plot <- baltimore$total
names(to_plot) <- baltimore$year

########################################
# Create and save the png file
########################################


png("plot2.png",width = 480, height = 480)
barplot(to_plot, main = 'Total PM2.5 Emissions in Baltimore by Year', 
     xlab = 'year', ylab = 'emissions (tons)')
dev.off()