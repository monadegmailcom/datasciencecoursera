pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  # initialize data vector accumulating values from all files specified by id 
  vs <- numeric( 0 )
  # iterate all files 
  for (i in id)
  {
    # evaluate file path
    file <- paste0(directory, "/", formatC(i, flag="0", width=3), ".csv")
    # read data frame
    data <- read.csv( file, colClasses=c(NA, "numeric", "numeric", NA) )
    # append data to accumulative vector
    vs <- append(vs, data[[pollutant]])
  }
  # evaluate mean of accumulated data
  mean( vs, na.rm = TRUE )
}