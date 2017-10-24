####################################################################################################
# Coursera Course4 - Week 4 Assigment 
# File : Plot_3.r - 
# Of the polluting type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999-2008
# Created : Sudipto Mitra
# Files 
# - "Source_Classification_Code.rds" - This table provides a mapping from the SCC digit strings 
#                                      in the Emissions table to the actual name of the PM2.5 source.
# - "summarySCC_PM25.rds" - This file contains a data frame with all of the PM2.5 emissions data
#                           for 1999, 2002, 2005, and 2008.
#######################################################################################################
library(sqldf) 
library(ggplot2)
# Reading the RDS Files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate Total emissions by year
tot_type <- sqldf("select year, type, sum(Emissions) total_emission from NEI where fips = '24510' group by year ,type order by type,year")

png('plot3.png', width = 480, height = 480)

#g <- ggplot(tot_type,aes(year,total_emission,color = type))
#g + geom_line(size = 1) + labs (x = "Year" , Y = "Total emissions (ton)") + ggtitle("PM2.5 Emission for different pollution sources in Baltimore City")
ggplot(tot_type, aes(x=year, y=total_emission, colour=type)) + geom_line(size = 1) + labs(x ="Year",y="Total emissions (ton)") + ggtitle("PM2.5 Emission for different pollution sources in Baltimore City")
dev.off()

