# Project Description #
#######################
# The purpose of this project is to demonstrate your ability to collect, work with, 
# and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
# You will be graded by your peers on a series of yes/no questions related to the project. 
# You will be required to submit: 
  # 1) a tidy data set as described below, 
  # 2) a link to a Github repository with your script for performing the analysis, and 
  # 3) a code book that describes the variables, the data, and any transformations 
    #  or work that you performed to clean up the data called CodeBook.md. 
    #  You should also include a README.md in the repo with your scripts. 
    #  This repo explains how all of the scripts work and how they are connected.  
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
  # http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# Here are the data for the project:  
  # https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
#######################
  
# run_analysis.R #
##################
# You should create one R script called run_analysis.R that does the following:
# Appropriately label the data set with descriptive variable names. 
# Merge the training and the test sets to create one data set.
# Extract only the measurements on the mean and standard deviation for each measurement. 
##################

# Load packages

  library(dplyr)
  library(genefilter)

# Load test data
  # https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
  # TEST
  X_test <- read.table("./GettingCleaningData/project/UCI HAR Dataset/test/X_test.txt",
                      header = T, sep = "", quote = "")
  y_test <- read.table("./GettingCleaningData/project/UCI HAR Dataset/test/y_test.txt",
                       header = T, sep = "", quote = "")
  subject_test <- read.table("./GettingCleaningData/project/UCI HAR Dataset/test/subject_test.txt",
                             header = T, sep = "", quote = "")
  # TRAIN
  X_train <- read.table("./GettingCleaningData/project/UCI HAR Dataset/train/X_train.txt",
                       header = T, sep = "", quote = "")
  y_train <- read.table("./GettingCleaningData/project/UCI HAR Dataset/train/y_train.txt",
                       header = T, sep = "", quote = "")
  subject_train <- read.table("./GettingCleaningData/project/UCI HAR Dataset/train/subject_train.txt",
                             header = T, sep = "", quote = "")

# Create test dataset

  mean <- rowMeans(X_test)  # across all 561 cols
  sd <- rowSds(X_test)      # across all 561 cols
  xtst <- data.frame(mean, sd)
  xtst <- cbind(xtst,subject_test)
  xtst <- cbind(xtst,y_test)

  xtst <- tbl_df(xtst)
  xtst <- 
    xtst %>% 
    mutate(set = "test") %>%
    select(set, subject = X2, activity_label = X5, mean, sd)

  xtst$set <- as.factor(xtst$set)
  xtst$subject <- as.factor(xtst$subject)
  xtst$activity_label <- as.factor(xtst$activity_label)

# Create train dataset

  mean <- rowMeans(X_train)  # across all 561 cols
  sd <- rowSds(X_train)      # across all 561 cols
  xtrn <- data.frame(mean, sd)
  xtrn <- cbind(xtrn,subject_train)
  xtrn <- cbind(xtrn,y_train)
  
  xtrn <- tbl_df(xtrn)
  xtrn <- 
    xtrn %>% 
    mutate(set = "train") %>%
    select(set, subject = X1, activity_label = X5, mean, sd)
  
  xtrn$set <- as.factor(xtrn$set)
  xtrn$subject <- as.factor(xtrn$subject)
  xtrn$activity_label <- as.factor(xtrn$activity_label)

# Put them together
  df <- rbind(xtst, xtrn)

##################
# Use descriptive activity names to name the activities in the data set
##################

  activity_labels <- read.table("./GettingCleaningData/project/UCI HAR Dataset/activity_labels.txt",
                                header = F, sep = "", quote = "")
  
  activity_labels <-
    activity_labels %>%
      select(activity_label = V1, activity = V2)
  
  activity_labels$activity_label <- as.factor(activity_labels$activity_label)
  
  df <- left_join(df, activity_labels)
  df$activity_label <- NULL

#write.csv(df, "./GettingCleaningData/project/UCI_HAR_meansd.csv")

##################  
# Create a second, independent tidy data set with the average of each variable for each activity and each subject. 
##################  
df_agg <-
df %>%
  group_by(activity, subject) %>%
  summarize(mean = mean(mean), 
            sd = mean(sd)) %>%
  arrange(activity, subject, mean, sd)

write.table(df_agg, "./GettingCleaningData/project/UCI_HAR_summary.txt",
            row.name=FALSE)
