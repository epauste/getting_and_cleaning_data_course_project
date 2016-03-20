#-----------------------------------------------------------------------------------------------------------
# Coursera Getting and Cleaning Data - Course Project
# script: run_analysis.R
# 
# Overview ( steps ):
#     You should create one R script called run_analysis.R that does the following.
#
#            1: Merges the training and the test sets to create one data set.
#            2: Extracts only the measurements on the mean and standard deviation for each measurement.
#            3: Uses descriptive activity names to name the activities in the data set
#            4: Appropriately labels the data set with descriptive variable names.
#            5: From the data set in step 4, creates a second, independent tidy data set with the average
#               of each variable for each activity and each subject.
#-----------------------------------------------------------------------------------------------------------

# remove setwd when finished
setwd("C:/Users/paul/repos/getting_and_cleaning_data/getting_and_cleaning_data_course_project")

library("dplyr")

if(!file.exists("./data")){ dir.create("./data")}
if(!file.exists("./data/getdata_projectfiles_UCI HAR Dataset.zip")) {
      data_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
      download.file(data_url,destfile="./data/getdata_projectfiles_UCI HAR Dataset.zip")
}
unzip(zipfile = "./data/getdata_projectfiles_UCI HAR Dataset.zip", exdir = "./data", overwrite = TRUE )



 
# load all required datasets into tables via dplyr
#
activity_labels   <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/activity_labels.txt"))
features          <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/features.txt"))
subject_test      <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/test/subject_test.txt"))
X_test            <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/test/X_test.txt"))
Y_test            <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/test/Y_test.txt"))
subject_train     <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/train/subject_train.txt"))
X_train           <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/train/X_train.txt"))
Y_train           <- dplyr::tbl_dt(read.table("./data/UCI HAR Dataset/train/Y_train.txt"))

# create more descriptive labels in the loaded data tables
#
activity_labels   <- dplyr::rename(activity_labels, activity_id = V1, activity_description = V2)
features          <- dplyr::rename(features       , feature_id = V1,  feature_description  = V2)


subject_test      <- dplyr::rename(subject_test,    subject_id = V1)
Y_test            <- dplyr::rename(Y_test,          activity_id = V1)
colnames(X_test)  <- as.character(features$feature_description)  # must coerve to char as it is of type factor

subject_train     <- dplyr::rename(subject_train,   subject_id = V1)
Y_train           <- dplyr::rename(Y_train,         activity_id = V1)
colnames(X_train) <- as.character(features$feature_description)  # must coerve to char as it is of type factor

# combine the columns for the test and training datasets respectively, then merge both into a new merged dataset
# final merge will be a rowbind as same data columns in both data tables
#
training_ds <- subject_train %>%
      dplyr::bind_cols(X_train, Y_train )

testing_ds  <- subject_test %>%
      dplyr::bind_cols(X_test, Y_test )

merged_ds <- training_ds %>% 
      dplyr::bind_rows(testing_ds)

# set the activity labels in merged_ds from corresponding activity_labels data table
#
merged_ds$activity <- as.factor(merged_ds$activity)
levels(merged_ds$activity) <- activity_labels$activity_description

# subset on activity, subject and all the measurements containing the mean and standard deviation for each measurement.
# Note that th mean and std text follow camel case notation in the headers, hence leaving as is.
# 
tidy_ds <- merged_ds %>%
      select(one_of("subject_id", "activity"), contains("Mean",ignore.case = TRUE), contains("std",ignore.case = TRUE)) %>%
      group_by(activity, subject_id) %>%
      summarise_each(funs(mean)) %>%
      arrange(activity, subject_id) 

# output the tidy dataset as a csv file 
#
write.table( x = tidy_ds, file = "./tidy_ds.txt", sep = ',', row.names = FALSE)





