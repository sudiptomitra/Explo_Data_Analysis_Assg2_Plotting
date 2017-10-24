####################################################################################################
# Coursera Course4 - Week 4 Assigment 
# File : Plot_5.r - 
# For Baltimore  has vehicular emissions changed  from 1999-2008?
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

# Changing column header for SCC
colnames(SCC) <- gsub("\\.","_",colnames(SCC))

# Identifying SCC codes for Vehicle
vehicle_scc <- sqldf("select SCC ,Short_Name,EI_Sector from SCC where EI_Sector like '%Vehicle%'")
## Calculate Total emissions by year for vehicle for Baltimore City
tot_vehicle <- sqldf("select year , sum(Emissions) total_emission from NEI x , vehicle_scc y where x.SCC = y.SCC and fips = '24510' group by year order by year")

png('plot5.png', width = 480, height = 480)
barplot(tot_vehicle$total_emission, names.arg=tot_vehicle$year, xlab="Year", ylab="Total Emission (tons)", main= "PM2.5 Total emissions from Vehicular sources for Baltimore City" )
dev.off()


