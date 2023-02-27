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

residuals(m1)

hist(residuals(m1), 50) # check the symmetry of the histogram

summary(m1)$coefficients

confint(m1)

 
m2 <- lm(weight ~ height + age, 
         data = weight_df)
summary(m2)

hist(residuals(m2), 50)

anova(m1, m2)

m3 <- glm(I(gender == 'Male') ~ height, 
          data = weight_df,
          family = binomial)
summary(m3)

anova(m3, test = 'Chisq') # not including the f-test 

m3_null <- glm(I(gender == 'Male') ~ 1, 
          data = weight_df,
          family = binomial)

anova(m3_null, m3, test = 'Chisq' )

m4 <- lm(weight ~ gender, data = weight_df)


# oneway anova ------------------------------------------------------------

data('PlantGrowth')

m5 <- lm(weight ~ group,
         data = PlantGrowth)

anova(m5)

m6 <- aov(weight ~ group,
          data = PlantGrowth) # aov and lm are one and the same
summary(m6)

TukeyHSD(m6)



# twoway anova ------------------------------------------------------------

data("ToothGrowth")

m7 <- lm(len ~ supp * factor(dose), data = ToothGrowth)
library(car)

Anova(m7)
Anova(m7, type = 'III')
