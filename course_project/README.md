## How the script works

The *run_analysis.R* script containes the *run_analysis()* function that reads in the data and writes back a tidy data set. It has to be run in the directory containing the *UCI HAR Dataset* data directory. It uses the *dplyr* library package.
Following steps are performed:
  - read the *features.txt* data table and filter all variables containing *mean* or *std*.
  - read the *activity_labels.txt* vector.
  - for the *test* and *train* data read the *x*, *y* and *subject* data and perform following substeps:
      - read *y* data and replace label indices by label names
      - read *subject* data
      - read *x* data
      - select the filtered *features* variables from *x* data
      - rename the *x* variables so they do not contain special characters that confuse *R*  
      - add *subject* column and *activity* column from *y* data
  - join the test and train data resulting from the previous step
  - group data by activity and subject
  - summarise each variable by mean
  - write the data table
