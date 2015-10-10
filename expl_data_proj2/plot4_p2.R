library(dplyr)

# read data frame
nei <- readRDS("summarySCC_PM25.rds")

# group data by year
by_year <- group_by(nei, year)

# read scc data
scc <- readRDS("Source_Classification_Code.rds")

# filter coal related emissons
scc <- filter(scc, grepl("Coal", Short.Name))$SCC
sub <- filter(by_year, SCC %in% scc)

# summarize emission per year
total <- summarize( sub, total = sum(Emissions))

# plot 
plot(total)

# save to png
dev.copy(png, file="plot4.png")
dev.off()