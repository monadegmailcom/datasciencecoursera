library(dplyr)

# read data frame
nei <- readRDS("summarySCC_PM25.rds")

# group data by year
by_year <- group_by(nei, year)

# filter Baltimore City data
balt <- filter( by_year, fips=="24510")

# read scc data
scc <- readRDS("Source_Classification_Code.rds")

# filter veh related emissons
scc <- filter(scc, grepl("Veh", Short.Name))$SCC
sub <- filter(balt, SCC %in% scc)

# summarize emission per year
total <- summarize( sub, total = sum(Emissions))

# plot 
plot(total)

# save to png
dev.copy(png, file="plot5.png")
dev.off()