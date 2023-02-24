# Reading and Viewing Data ------------------------------------------------------------
# Load in packages and data at the top of the script

library('tidyverse')

anorexia_df <- read_csv('data/anorexia.csv') # getwd() shows your working directory

# use setwd() to set working directory

weight_df <- read_csv('data/weight.csv')
# to check this data frame, just type the data frame name into the console

print(weight_df, 
      n = 15) # to specify the number of fows displayed in the console

glimpse(weight_df) # columns are transposed as rows, so that more info will be displayed

summary(weight_df) # this displays summarized stats of each variable in the data frame

summarise(weight_df, 
          avg_weight = mean(weight), 
          avg_height = mean(height))



# split apply combine operation 
summarise(group_by(weight_df, gender), 
          avg_weight = mean(weight), 
          avg_height = mean(height))

# can group by multiple variables at the same time
summarise(group_by(weight_df, gender, race), 
          avg_weight = mean(weight), 
          avg_height = mean(height))











