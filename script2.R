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

# use 'n'
summarise(weight_df, 
          avg_weight = mean(weight), 
          avg_height = mean(height),
          n = n())

# this is more applicable to use 'n' when you are grouping 
summarise(group_by(weight_df, gender, race), 
          avg_weight = mean(weight), 
          avg_height = mean(height),
          n = n())


# dplyr verbs -------------------------------------------------------------

# * select
# * rename
# * slice 
# * filter
# * mutate 
# * arrange 


######## select (deals with colums)
select(weight_df,
       gender,
       height,
       weight) # no manipulation of data, just selecting variables to display

select(weight_df,
       contains('eight'))

select(weight_df,
       starts_with('w'), 
       starts_with('h'))

select(weight_df,
       ends_with('t'))

select(weight_df,
       gender:weight)

select(weight_df,
       5:8)



######### rename (deals with columns)

rename(weight_df,
       id = subjectid,
       sex = gender)

Weight_new <- rename(weight_df,
                     id = subjectid,
                     sex = gender)


####### Slice (deals with rows)

slice(weight_df,
      100:105) # rows 100 to 105

slice(weight_df,
      c(10:20, 100:105)) # rows 10 to 20 and 100 to 105

slice(weight_df,
      -(1:3)) # remove rows 1 to 3 (clipping)


######### filter (deals with rows)

filter(weight_df,
       height > 180)

filter(weight_df,
       height > 180,
       gender == 'Male')

filter(weight_df,
       height > 180,
       gender == 'Female')

filter(weight_df,
       (height > 180) &
         (gender == 'Female'))

filter(weight_df,
       height > 180 |
         gender == 'Female')


######## Mutate (add or modify variables)

mutate(weight_df,
       tall = height >= 180)

mutate(weight_df,
       height = height/100)

mutate(weight_df,
       tall = height >= 180,
       height = height/100)


####### arrange 

arrange(weight_df,
        height) # sorting by height in ascending order 

arrange(weight_df,
        desc(height)) # sorting by height in a descending order 

arrange(weight_df,
        age,
        height)


# Pipe function -----------------------------------------------------------

# ctrl + shift + m

# %>% 

x <- c(3, 4, 7)
sqrt(x)
mean(log(sqrt(x))) # nested function

x %>% 
  sqrt() # equiv to sqrt(x)

x %>% 
  sqrt() %>% 
  log() %>% 
  mean() # does the same thing as the nested function above


# using pipe
weight_df %>% 
  select(gender,
         height,
         weight) %>% 
  filter(height > 180)


# ggplot ------------------------------------------------------------------

ggplot(weight_df,
       aes(x = height, y = weight)
)

# layer
ggplot(weight_df,
       aes(x = height, y = weight)
) +
  geom_point()

# chnage the size of data points
ggplot(weight_df,
       aes(x = height, y = weight)
) +
  geom_point(size = 0.5)

# map colour onto gender
ggplot(weight_df,
       aes(x = height, 
           y = weight, 
           colour = gender)
) +
  geom_point(size = 0.5)


# to get a line of best fit
ggplot(weight_df,
       aes(x = height, y = weight)
) +
  geom_point(size = 0.5) +
  stat_smooth(method = 'lm') # 'lm' means linear model


# to remove the standard error shading around the line
ggplot(weight_df,
       aes(x = height, y = weight)
) +
  geom_point(size = 0.5) +
  stat_smooth(method = 'lm', se = FALSE)


# creates two lines of best fit
ggplot(weight_df,
       aes(x = height, 
           y = weight,
           colour = gender)
) +
  geom_point(size = 0.5) +
  stat_smooth(method = 'lm', 
              se = FALSE)

# extend the lines of best fit to fill the graph
ggplot(weight_df,
       aes(x = height, 
           y = weight,
           colour = gender)
) +
  geom_point(size = 0.5) +
  stat_smooth(method = 'lm', 
              se = FALSE,
              fullrange = TRUE)

# change the theme
ggplot(weight_df,
       aes(x = height, 
           y = weight,
           colour = gender)
) +
  geom_point(size = 0.5) +
  stat_smooth(method = 'lm', 
              se = FALSE,
              fullrange = TRUE) +
  theme_classic()


ggplot(weight_df,
       aes(x = height, 
           y = weight,
           colour = gender)
) +
  geom_point(size = 0.5) +
  stat_smooth(method = 'lm', 
              se = FALSE,
              fullrange = TRUE) +
  theme_classic()


# Histograms --------------------------------------------------------------

ggplot(weight_df,
       aes(x = height,)
) +
  geom_histogram()


ggplot(weight_df,
       aes(x = height,)
) +
  geom_histogram(binwidth = 2)



ggplot(weight_df,
       aes(x = height,)
) +
  geom_histogram(binwidth = 2,
                 colour = 'white') # specifies colour of the border

# stacked histogram
ggplot(weight_df,
       aes(x = height,
           fill = gender)
) +
  geom_histogram(binwidth = 2,
                 colour = 'white')

# two bars per bin
ggplot(weight_df,
       aes(x = height,
           fill = gender)
) +
  geom_histogram(binwidth = 2,
                 position = 'dodge',
                 colour = 'white')


ggplot(weight_df,
       aes(x = height,
           fill = gender)
) +
  geom_histogram(binwidth = 2,
                 position = 'identity',
                 colour = 'white')


ggplot(weight_df,
       aes(x = height,
           fill = gender)
) +
  geom_histogram(binwidth = 2,
                 alpha = 0.75, # alpha is transparency
                 position = 'identity',
                 colour = 'white')


# Boxplot -----------------------------------------------------------------

ggplot(weight_df,
       aes(x = gender,
           y = height)
) + 
  geom_boxplot()

# adjust width of boxes
ggplot(weight_df,
       aes(x = gender,
           y = height)
) + 
  geom_boxplot(width = 0.5)

# adjust width of outliers
ggplot(weight_df,
       aes(x = gender,
           y = height)
) + 
  geom_boxplot(width = 0.5,
               outlier.size = 0.5)
