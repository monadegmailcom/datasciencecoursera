corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  # initialize data vector accumulating values from all files specified by id 
  vs <- numeric( 0 )
  # iterate all files 
  for (i in 1:332)
  {
    # evaluate file path
    file <- paste0(directory, "/", formatC(i, flag="0", width=3), ".csv")
    # read data frame
    data <- read.csv( file, colClasses=c(NA, "numeric", "numeric", NA) )
    # extract column vectors
    sul <- data$sulfate
    nit <- data$nitrate
    # get complete cases
    good <- complete.cases(sul, nit)
    # do not take data that miss the threshold
    if (sum(good) <= threshold)
      next
    # append correlation result
    vs <- append( vs, cor(sul,nit,use="complete.obs"))
  }
  # return result
  vs
}