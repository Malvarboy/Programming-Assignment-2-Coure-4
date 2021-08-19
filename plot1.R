# PROGRAMMING ASSIGNMENT 2 OF COURSE 4

# DATA SCIENCE COURSE OF JOHN HOPKINS


# Generate Plot 1

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
# Group Emissions data by year
########################################

by_year <- nei %>% group_by(year) %>% summarise(total = sum(Emissions))
to_plot <- by_year$total
names(to_plot) <- by_year$year

########################################
# Create and save the png file
########################################


png("plot1.png",width = 480, height = 480)
barplot(to_plot, main = 'Total PM2.5 Emissions by Year', xlab = 'year'
     , ylab = 'emissions (tons)')
dev.off()