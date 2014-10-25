---
title: "CodeBook"
author: "J. Hagedorn"
date: "Monday, October 13, 2014"
output: html_document
---
## Data: Human Activity Recognition Using Smartphones Dataset v 1.0
The experiments were carried out by Reyes-Ortiz et al. with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, they captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The obtained dataset was randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. See 'features_info.txt' for more details.

## Variables: UCI_HAR_summary.txt

**activity**: The type of activity being performed when the measurement was taken.  Levels are: "LAYING", "SITTING", "STANDING", "WALKING", "WALKING_DOWNSTAIRS" and "WALKING_UPSTAIRS"

**subject**: Each row identifies the unique subject who performed the activity for each window sample. Its range is from 1 to 30.

**mean**: The average of the `mean` value for each combination of activity and subject.  These values are the means of each row in the original dataset (see Data section).  

**sd**: The average of the `sd` value for each combination of activity and subject.  These values are the standard deviations of each row in the original dataset (see Data section). 

## Transformations 
Original data descriptions can be found at the related [UCI Machine Learning repository site](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  The following transformations were performed to clean up the data: 

1. Read test and train dataset from the directory file `./UCI HAR Dataset`.
2. Join test and train datasets.
3. Compute mean and standard deviation across all columns of each row.
4. Join descriptive activity names to activity codes easier interpretation.
5. Aggregate the average of the `mean` and `sd` variables for each activity and subject factor variables.


