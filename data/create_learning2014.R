# Yujing He 10.11.2023 data wrangling exercises

## Read the full learning2014 data
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(learning2014)
str(learning2014)
# Output: the data consist of 183 observations of 60 variables. Apart from the variable "gender" in character format, the other variables are in integer format.

## Create an analysis dataset with the variables gender, age, attitude, deep, stra, surf and points by combining questions in the learning2014 data
# 1. combining questions (variables) in the learning2014 data
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
deep_columns <- select(learning2014, one_of(deep_questions))
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
surface_columns <- select(learning2014, one_of(surface_questions))
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
strategic_columns <- select(learning2014, one_of(strategic_questions))

# 2. Scale all combination variables to the original scales (by taking the mean)
learning2014$deep <- rowMeans(deep_columns)
learning2014$surf <- rowMeans(surface_columns)
learning2014$stra <- rowMeans(strategic_columns)

# 3. choose a handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")
learning2014_1 <- select(learning2014, one_of(keep_columns))

# 4. Exclude observations where the exam points variable is zero
learning2014_2 <- filter(learning2014_1, Points > 0)
dim(learning2014_2) # The data then have 166 observations and 7 variables
str(learning2014_2)

# 5. Save the analysis dataset to the ‘data’ folder
write_csv(learning2014_2, "learning2014.csv")
learning2014 <- read_csv("data/learning2014.csv")
str(learning2014)
head(learning2014)
