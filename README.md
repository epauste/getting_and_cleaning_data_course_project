---
title: "README"
author: "Paul Stewart"
date: "March 20, 2016"
output: 
  html_document: 
    number_sections: yes
    toc: yes
---

```{r setup, include=FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

# Getting and Cleaning Data Course Project Overview

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. 

The goal is to prepare tidy data that can be used for later analysis. 

You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 

      1) a tidy data set as described below, 
      2) a link to a Github repository with your script for performing the analysis, and 
      3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
      You should also include a README.md in the repo with your scripts. 
      This repo explains how all of the scripts work and how they are connected.

## Project Data Source Information 

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Project R Script Requirements

You should create one R script called run_analysis.R that does the following.

      1: Merges the training and the test sets to create one data set.
      2: Extracts only the measurements on the mean and standard deviation for each measurement.
      3: Uses descriptive activity names to name the activities in the data set
      4: Appropriately labels the data set with descriptive variable names.
      5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    

# Script and files Descriptions 

The following files are included 

      README.md       - This README document      
      codebook.md     - Defintions of data and variables for tidy dataset  
      run_analysis.R  - R script tht produces the tidy dataet
      tidy_ds.txt     - tidy dataset output in CSV format


# Execution Procedure

The primary step to follow is to execute run_analysis.R
When this is executed the following events will occur

      1:  Current working directory will be used as the base directory
      2:  A data directory will be created if it does not already exist
      3:  Zip archive https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
          will be downloaded if this does not exist
      4:  Zip archives contents wil be extacted in the data directory. 
          This will created the following structure ( note only files used in this project mentioned below )
             ./data/
                   UCI HAR Dataset/
                         activity_labels.txt
                         features.txt  
                         features_info.txt  
                         README.txt
                         test/
                               subject_test.txt  
                               X_test.txt  
                               y_test.txt
                         train/
                               subject_train.txt  
                               X_train.txt  
                               y_train.txt
          For explanation of files, see the codebook.md file
      5:  load following files into tables ( activity_labels.txt, features.txt, subject_test.txt, X_test.txt,
          y_test.txt, subject_train.txt, X_train.txt, y_train.txt )
      6:  Create / Add descriptive names for above table columns
      7:  create new table (testing_ds)  from binding columns of subject_test.txt, X_test.txt, y_test.txt
      8:  create new table (training_ds) from binding columns of subject_train.txt, X_train.txt, y_train.txt
      9:  create new table (merged_ds) from binding rows of training_ds and testing_ds
      10: set descriptive factor levels for activity column
      11: subset dataset to contain activity, subject_id, and all columns that reference mean or std in 
          column name
      12: group subset by activity and subject_id, and take average across included variables 
      13: output dataset tidy_ds as tidy_ds.txt as a csv file in the current working directory
      

# Dependencies

The R script run_analysis.R has the following dependencies

      library(dplyr)
      
dplyr must be installed before execution of analysis_run.R.
At successful installation, all other dependencies will be loaded automatically



