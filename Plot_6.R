####################################################################################################
# Coursera Course4 - Week 4 Assigment 
# File : Plot_6.r - 
# For Baltimore & Los Angeles  how has vehicular emissions changed  from 1999-2008?
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

# Identifying SCC codes for vehuclar pollution
vehicle_scc <- sqldf("select SCC ,Short_Name,EI_Sector from SCC where EI_Sector like '%Vehicle%'")
## Calculate Total emissions by year for vehicle for Baltimore & Los Angeles
tot_vehicle <- sqldf("select year , sum(Emissions) total_emission,fips from NEI x , vehicle_scc y where x.SCC = y.SCC and fips in ('24510','06037') group by year,fips order by year,fips")

png('plot6.png', width = 480, height = 480)

ggplot(tot_vehicle, aes(x=year, y=total_emission, color = fips)) + geom_line(size = 1) + labs(x="Year", y="Total PM2.5 emissions (tons)") + ggtitle("PM2.5 emissions from Motor vehicle in Baltimore and LA")+scale_colour_discrete(name  ="Cities",
                                                                                                                                                                                                                                    breaks=c("24510", "06037"),
                                                                                                                                                                                                                                    labels=c("Baltimore", "LA"))

dev.off()


