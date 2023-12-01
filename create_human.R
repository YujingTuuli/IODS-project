# Yujing He
# Week 4, 26 Nov 2023 
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
library(dplyr)
gii_mut <- mutate(gii, edu_ratio = edu_f / edu_m, labo_ratio = labo_f / labo_m)

# Join together the two datasets using the variable Country as the identifier. 
# Keep only the countries in both data sets (Hint: inner join). The joined data 
# should have 195 observations and 19 variables. Call the new joined data "human" 
# and save it in your data folder (use write_csv() function from the readr package).
library(dplyr)
human <- inner_join(hd, gii_mut, by = "country")
dim(human)
write.csv(human, "data/human.csv")


# Week 5 30 Nov 2023
# Data wrangling
library(tidyverse)
human <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.csv")
)

# 1. Explore the structure and the dimensions of the 'human' data and describe 
# the dataset briefly, assuming the reader has no previous knowledge of it 
# (this is now close to the reality, since you have named the variables yourself).

str(human)
dim(human)

# There are 195 observaions and 19 variables in the human data. The variables 
# are in numerical and character formats. The data is about human development 
# indices which provide different indices for human development for different 
# countries around the world.

# 2. Exclude unneeded variables: keep only the columns matching the following variable 
# names (described in the meta file above):  "Country", "Edu2.FM", "Labo.FM", 
# "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F".

keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", 
          "Mat.Mor", "Ado.Birth", "Parli.F")

human_keep <- select(human, one_of(keep))

# 3. Remove all rows with missing values

human_comp <- data.frame(human_keep, comp = complete.cases(human_keep))
print(human_comp[-1])

human_comp_rmna <- filter(human_comp, comp == "TRUE") 

# 4. Remove the observations which relate to regions instead of countries.

print(human_comp_rmna$Country)

human_rmrg <- filter(human_comp_rmna, Country != "Europe and Central Asia" 
                      & Country != "East Asia and the Pacific" 
                      & Country != "Latin America and the Caribbean" 
                      & Country != "Sub-Saharan Africa" 
                      & Country != "Arab States"
                      & Country != "World" & Country !="South Asia") 

print(human_rmrg$Country)

# 5. The data should now have 155 observations and 9 variables (including the 
# "Country" variable). Save the human data in your data folder. You can overwrite 
# your old ‘human’ data.

human_final <- select(human_rmrg, !comp)
dim(human_final)

write_csv(human_final, "data/human.csv")










