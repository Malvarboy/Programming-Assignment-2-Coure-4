# PROGRAMMING ASSIGNMENT 2 OF COURSE 4

# DATA SCIENCE COURSE OF JOHN HOPKINS


# Generate Plot 4

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
# Filter SCC data that contains 'Coal' and
# subset the NEI data
########################################

coal <- scc %>% filter(str_detect(EI.Sector, "Coal")) # get all SCC data  with 'coal'
uses_coal <- nei$SCC %in% coal$SCC # check scc that uses coal
filtered_nei <- nei[uses_coal,] # subset data
by_year <- filtered_nei %>%  group_by(year) %>% summarise(total = sum(Emissions))
to_plot <- by_year$total
names(to_plot) <- by_year$year


########################################
# Create and save the png file
########################################


png("plot4.png",width = 480, height = 480)
barplot(to_plot, main = 'Total PM2.5 Emissions from Coal in the US by Year', xlab = 'year'
        , ylab = 'emissions (tons)')
dev.off()