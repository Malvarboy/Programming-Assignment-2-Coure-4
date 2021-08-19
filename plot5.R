# PROGRAMMING ASSIGNMENT 2 OF COURSE 4

# DATA SCIENCE COURSE OF JOHN HOPKINS


# Generate Plot 5

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
# Filter SCC data that contains 'Mobile - On-Road' and
# subset the NEI data
########################################

motor_vehicles <- scc %>% filter(str_detect(EI.Sector, "Mobile - On-Road")) # get all SCC data  with 'Mobile - On-Road'
motor_vehicles_ <- nei$SCC %in% motor_vehicles$SCC # check scc that are Mobile On Road
filtered_nei <- nei[motor_vehicles_,] # subset data
filtered_nei_baltimore <- filtered_nei %>% filter(fips == "24510") # subset by Baltimore
by_year <- filtered_nei_baltimore %>%  group_by(year) %>% summarise(total = sum(Emissions))
to_plot <- by_year$total
names(to_plot) <- by_year$year


########################################
# Create and save the png file
########################################


png("plot5.png",width = 480, height = 480)
barplot(to_plot, main = 'Total PM2.5 Emissions from Motor Vehicles in Baltimore by Year', xlab = 'year'
        , ylab = 'emissions (tons)')
dev.off()