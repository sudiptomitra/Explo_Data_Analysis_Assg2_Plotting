####################################################################################################
# Coursera Course4 - Week 4 Assigment 
# File : Plot_2.r - 
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question.
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
tot_em <- sqldf("select year, sum(Emissions) total_emission from NEI where fips = '24510' group by year order by year")

png('plot2.png', width = 480, height = 480)
barplot(tot_em$total_emission, names.arg = tot_em$year, xlab = "Year", ylab="Total Emission (tons) for Baltimore City", main = "PM2.5 Total emissions in Baltimore City , Maryland")
dev.off()

