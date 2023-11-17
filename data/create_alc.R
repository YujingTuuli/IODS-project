# Yujing He
# 17 Nov 2023
# Data Wrangling _ Student Performance Data (incl. Alcohol consumption).

# Read data and explore the structure and dimensions of the data.
library(readr)
student_mat <- read.csv("data/student-mat.csv",sep = ";" , header = TRUE)
student_por <- read.csv("data/student-por.csv",sep = ";" , header = TRUE)
str(student_mat)
str(student_por)
dim(student_mat)
dim(student_por)

#Join the two data sets and explore the structure and dimensions of the joined data.

library(dplyr)
## give the columns that vary in the two data sets
free_cols <- c("failures", "paid", "absences", "G1", "G2","G3")
## the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(student_por), free_cols)
## join the two data sets by the selected identifiers
math_por <- inner_join(student_mat, student_por, by = join_cols, suffix = c(".math", ".por"))
## Explore the structure and dimensions of the joined data.
str(math_por)
dim(math_por)

#Get rid of the duplicate records in the joined data set.

## print out the column names of 'math_por'
colnames(math_por) # 39 columns
## create a new data frame with only the joined columns
alc <- select(math_por, all_of(join_cols)) # 27 columns
## print out the columns not used for joining (those that varied in the two data sets)
free_cols
varied <- select(math_por, starts_with(free_cols)) # 12 columns
## for every column name not used for joining...
for(col_name in free_cols) {
  # select two columns from 'math_por' with the same original name
  two_cols <- select(math_por, starts_with(col_name))
  # select the first column vector of those two columns
  first_col <- select(two_cols, 1)[[1]]
  # then, enter the if-else structure!
  # if that first column vector is numeric...
  if(is.numeric(first_col)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[col_name] <- round(rowMeans(two_cols))
  } else { # else (if the first column vector was not numeric)...
    # add the first column vector to the alc data frame
    alc[col_name] <- first_col
  }
}
## glimpse at the new combined data
glimpse(alc)

# Create a new column 'alc_use' to the joined data then use 'alc_use' to create a new logical column 'high_use'.

## define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
## define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# Glimpse and save the data.

glimpse(alc)
write_csv(alc, "data/create_alc.csv")







