# PROGRAMMING ASSIGNMENT 2 OF COURSE 4

# DATA SCIENCE COURSE OF JOHN HOPKINS


# Generate Plot 6

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
filtered_nei_2cities <- filtered_nei %>% filter(fips == "24510" | fips == "06037") # subset by Baltimore or Los Angeles


########################################
# Group and Summarise data based on the 
# cumulative percentage change from 1999-2000
########################################

by_year_city <- filtered_nei_2cities %>%  
        group_by(year, fips) %>% 
        summarise(total = sum(Emissions))

# Compute year by year change
by_year_city <- by_year_city%>%
        group_by(fips) %>%
        arrange(year) %>%
        mutate(pct.chg = (total - lag(total))/lag(total))
by_year_city['pct.chg'][is.na(by_year_city['pct.chg'])] <- 0

# Compute cumulative change since 1999 with 1999 based level of 100
by_year_city <- by_year_city %>% 
        group_by(fips) %>% 
        arrange(year) %>% 
        mutate(pct.chg.1999 = cumprod(1+ pct.chg) * 100)

by_year_city['fips'][by_year_city['fips'] == "06037"] <- "Los Angeles"
by_year_city['fips'][by_year_city['fips'] == "24510"] <- "Baltimore"

 

########################################
# Create and save the png file
########################################

g <- ggplot(by_year_city, aes(x = year, y = pct.chg.1999))

png("plot6.png",width = 480, height = 480)
g + geom_line() + ggtitle("Comparison of Cumulatve Change in Motor Vehicle PM2.5 Emissions in
\nBaltimore and Los Angeles from 1999-2008: 1999 as Base Year (100)") +
        ylab('Cumulative Change from 1999 Level (1999 Level = 100)') + facet_wrap(~fips) +
        theme(plot.title = element_text(hjust = 0.5))
dev.off()