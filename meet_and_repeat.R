# Data wrangling
# Week 6 Dec 9 2023
# Yujing He

# 1. Load the data sets (BPRS and RATS) into R using as the source the GitHub 
# repository of MABS, where they are given in the wide form.

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = T)

# Take a look at the data sets: check their variable names, view the data 
# contents and structures, and create some brief summaries of the variables , 
# so that you understand the point of the wide form data.

names(BPRS)
names(RATS)

str(BPRS)
str(RATS)

summary(BPRS)
summary(RATS)

# 2. Convert the categorical variables of both data sets to factors.

BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# 3. Convert the data sets to long form. Add a week variable to BPRS and a Time 
# variable to RATS.

BPRSL <-  
  pivot_longer(BPRS, 
               cols = -c(treatment, subject),
               names_to = "weeks", values_to = "bprs")  |> 
  mutate(week = as.integer(substr(weeks,5,5))) |> 
  arrange(week)

glimpse(BPRSL)

RATSL <- 
  pivot_longer(RATS, 
               cols = -c(ID, Group), 
               names_to = "WD",
               values_to = "Weight") |>  
  mutate(time = as.integer(substr(WD,3,4))) |> 
  arrange(time)

glimpse(RATSL)

# 4. Take a serious look at the new data sets and compare them with their wide 
# form versions: Check the variable names, view the data contents and structures, 
# and create some brief summaries of the variables. Make sure that you understand 
# the point of the long form data and the crucial difference between the wide and 
# the long forms before proceeding the to Analysis exercise.

names(BPRSL)
str(BPRSL)
summary(BPRSL)

names(RATSL)
str(RATSL)
summary(RATSL)











