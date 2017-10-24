####################################################################################################
# Coursera Course4 - Week 4 Assigment 
# File : Plot_4.r - 
# #Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?
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

# Changing column header for SCC
colnames(SCC) <- gsub("\\.","_",colnames(SCC))

# Identifying SCC codes for coal
coal_scc <- sqldf("select SCC ,Short_Name,EI_Sector from SCC where EI_Sector like '%Coal%'")
## Calculate Total emissions by year for coal
tot_coal <- sqldf("select year , sum(Emissions) total_emission from NEI x , coal_scc y where x.SCC = y.SCC group by year order by year")

png('plot4.png', width = 480, height = 480)
barplot(tot_coal$total_emission,names.arg = tot_coal$year,xlab = "Year",ylab = "Total Emissions (tons)",main = "PM2.5 Total emissions for Coal combustion sources" )
dev.off()
#

