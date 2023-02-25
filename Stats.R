library('tidyverse')
weight_df <- read_csv('data/weight.csv')


m1 <- lm(weight ~ height, # the mean of the weight changes as height (predictor 
         #variable) changes
         data = weight_df)

coef(m1) # intercept and slope term are produced
# this says that if you change height by any number of units, you multiply the 
# correlating weight by the number of units increased. (if you change height by 
# 2 cm, the corresponding mean weight would increase by 1.148138 times the weight 
# value of the first height measurement used)
## we assume that weight is normally distributed over height 

sigma(m1) # choose any height, get all the people that are this height,
# see if the weight is normally distributed over this height. We are saying 
# this is a normal distribution. sigma gives you the standard deviation on this
# model, default assumption is that the sd remains the same

summary(m1)

