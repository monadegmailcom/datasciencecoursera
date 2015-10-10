library(dplyr)

# read data frame
nei <- readRDS("summarySCC_PM25.rds")

# group data by year
by_year <- group_by(nei, year)

# summarize emission per year
total <- summarize( by_year, total = sum(Emissions))

# plot 
plot(total)

# save to png
dev.copy(png, file="plot1.png")
dev.off()