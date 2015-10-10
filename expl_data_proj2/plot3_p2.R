library(dplyr)
library(ggplot2)

# read data frame
nei <- readRDS("summarySCC_PM25.rds")

# group data by year
by_year_type <- group_by( nei, year, type)

# filter Baltimore City data
balt <- filter( by_year_type, fips=="24510")

# summarize emission per year
total <- summarize( balt, total = sum(Emissions))

# plot log data for comparable values
qplot(
  year, 
  log(total), 
  data=total, 
  geom=c("point", "smooth"), 
  color=type)

# save to png
dev.copy(png, file="plot3.png")
dev.off()