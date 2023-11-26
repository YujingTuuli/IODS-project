# Yujing He
# 26 Nov 2023
# Data Wrangling _ “Human development” and “Gender inequality”

# Read the data
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

# Explore the datasets: see the structure and dimensions of the data. Create summaries of the variables.
str(hd)
dim(hd)
summary(hd)
str(gii)
dim(gii)
summary(hd)

# Look at the meta files and rename the variables with (shorter) descriptive names.
colnames(hd)
hd <- rename(hd, 
             "hdi_rank" = 1, 
             "country" = 2,
             "hdi_index" = 3, 
             "exp_life" = 4, 
             "exp_educ" = 5, 
             "mean_educ" = 6, 
             "gni" = 7, 
             "gni_minus_hdi_rank" = 8)

colnames(gii)
gii <- rename(gii, 
              "gender_eq_rank" = 1, 
              "country" = 2, 
              "gender_eq_rate" = 3, 
              "mort_ratio" = 4, 
              "birth_rate" = 5, 
              "parliam_perc" = 6, 
              "edu_f" = 7, 
              "edu_m" = 8, 
              "labo_f" = 9, 
              "labo_m" = 10)

# Mutate the “Gender inequality” data and create two new variables. The first 
# new variable should be the ratio of female and male populations with secondary 
# education in each country (i.e., Edu2.F / Edu2.M). The second new variable 
# should be the ratio of labor force participation of females and males in each 
# country (i.e., Labo.F / Labo.M).
gii_mut <- mutate(gii, edu_ratio = edu_f / edu_m, labo_ratio = labo_f / labo_m)

# Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets (Hint: inner join). The joined data 
# should have 195 observations and 19 variables. Call the new joined data "human" 
# and save it in your data folder (use write_csv() function from the readr package).
human <- inner_join(hd, gii_mut, by = "country")
dim(human)
write.csv(human, "data/human.csv")












