####################################################################################################
# Coursera Course4 - Week 4 Assigment 
# File : Plot_1.r - 
#Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.
# Created : Sudipto Mitra
# Files 
# - "Source_Classification_Code.rds" - This table provides a mapping from the SCC digit strings 
#                                      in the Emissions table to the actual name of the PM2.5 source.
# - "summarySCC_PM25.rds" - This file contains a data frame with all of the PM2.5 emissions data
#                           for 1999, 2002, 2005, and 2008.
#######################################################################################################
library(sqldf) 
# Reading the RDS Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate Total emissions by year
tot_em <- sqldf("select year, sum(Emissions) total_emission from NEI group by year order by year")

png('plot1.png', width = 480, height = 480)
barplot(tot_em$total_emission, names.arg=tot_em$year, xlab="Year", ylab="Total Emission (tons)", main="PM2.5 Total emissions in US")
dev.off()

