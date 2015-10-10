library(dplyr)

# read data frame
nei <- readRDS("summarySCC_PM25.rds")

# group data by year
by_year <- group_by(nei, year)

# filter Baltimore City data
balt <- filter( by_year, fips=="24510")

# summarize emission per year
total <- summarize( balt, total = sum(Emissions))

# plot 
plot(total)

# save to png
dev.copy(png, file="plot2.png")
dev.off()