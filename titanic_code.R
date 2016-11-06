library(dplyr)
library(tidyr)

titanic_raw <- read.csv("titanic_original.csv", header=TRUE, na.strings = c("", " ", "NA"))
titanic_raw$embarked[is.na(titanic_raw$embarked)] <- "S"
titanic_raw$age[is.na(titanic_raw$age)] <- mean(titanic_raw$age, na.rm=TRUE)

#Discussion (Part 2.2): The simple answer is to use the median, however,
#the mean and median are fairly close, so that would not make a big difference. The distribution is skewed right a bit,
#so the median might be a better choice. Another option is sampling: create a distribution of known ages and randomly
#sample them to fill in the missing values. This will hopefully create an overall distribution with similar characteristics
#to the original known values. Another way is to simply leave those values as unknown, and acknowledge that 
#any data gleaned from the "age" column only applies to those people whose ages are known. However, all these options are based
#on one possibly flawed assumption: that the distribution of NA ages is similar to the distribution of known ages.
#Without further context, it is not possible to prove or disprove that assumption, and time constraints may not 
#allow us to perform that research. 

#A better, but more time consuming way, would be to research the Titanic sinking and find out if there are any characteristics 
#of the NA values that would make it more likely for their ages to be unknown. Maybe those who did not survive were more likely
#to have their ages be unknown, which would skew the ages higher, since those who died were more often older and male,
#because the women and children went first. The NA values could then be randomly populated using that data. If this project
#was for a academic project, that would be more feasible, since the likely goal would be to provide historical context, and 
#the required research could be done. However, in the fast-paced world of commercial data science, the necessary
#time may not be available, so quick fixes like using the mean or median may be good enough. 

#TL;DR version: Median, random sampling, leave as NA, do background historical research. 

#Discussion (4.1): Possibly, though survivability due to cabin number has a lot of possible factors, including class, 
#location forward/back, location port/starboard, location central/outer hull, and whether or not the occupant was in their
#cabin at the time of the crash. Cabin location can probably be predicted to some degree based on fare and class, but
#that ignores the other variables like location. 

titanic1 <- mutate(titanic_raw, has_cabin_number = ifelse(is.na(titanic_raw$cabin), 0, 1))

write.csv(titanic1, file="titanic_clean.csv")
