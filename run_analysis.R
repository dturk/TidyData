# This "run_analysis.R" script is desgined to help process the data gathered 
# in the Human Activity Recognition (HAR) Using Smartphones experiment 
# (Anguita, D. et.al.) by combining key data elements into a "Tidy" package for
# preliminary analysis.
#
# This script uses a copy of the HAR Dataset residing in a local directory named:
#       "UCI HAR Dataset"
#

## It first gathers the collect, work with, and clean a data set. The goal is 
## to prepare tidy data that can be used for later analysis. 

# Sources: 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
# https://sites.google.com/site/smartlabunige/software-datasets/har-dataset

# Cited:  Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and 
#         Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones 
#         using a Multiclass Hardware-Friendly Support Vector Machine. 
#         International Workshop of Ambient Assisted Living (IWAAL 2012). 
#         Vitoria-Gasteiz, Spain. Dec 2012

####
# set paths to the data files
path <- "./UCI HAR Dataset/"
test_path <- paste0(path, "test/")
train_path <- paste0(path, "train/")

####
# load the raw data into tables
sub_test_tbl <- read.table(paste0(test_path, "subject_test.txt"))
x_test_tbl <- read.table(paste0(test_path, "X_test.txt"))
y_test_tbl <- read.table(paste0(test_path, "y_test.txt"))
sub_train_tbl <-read.table(paste0(train_path, "subject_train.txt"))
x_train_tbl <- read.table(paste0(train_path, "X_train.txt"))
y_train_tbl <- read.table(paste0(train_path, "y_train.txt"))

####
# Label the column headings 
#  (Note: we just lable the columns for now to avoid accidental 
#  sorting problems)
names(sub_test_tbl) <- "subject"
names(sub_train_tbl) <- "subject"
names(y_test_tbl) <- "activity"
names(y_train_tbl) <- "activity"

# load variable names from the features.txt file
features_raw <- read.table(paste0(path, "features.txt"))

# clean names to avoid syntactic conflicts
features <- make.names(features_raw[,2], unique = TRUE)
# get rid of repeated periods in labels
features <- gsub("..", "", features, fixed=TRUE)

names(x_test_tbl) <- features
names(x_train_tbl) <- features

####
# 1. Merge the training and the test sets to create one data set.

# start by combining all column data with x sets first so that features
#   line up with the labels for easier column selection.

test_tbl <- cbind(x_test_tbl, sub_test_tbl, y_test_tbl)
train_tbl <- cbind(x_train_tbl, sub_train_tbl, y_train_tbl)

super_tbl <- rbind(train_tbl, test_tbl)

####
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement.  Note: only actual measurements are considered and 
#    not the aggregated means of frequencies or pattern estimates.

# locate the column numbers of the desired columns
mean_cols <- grep("mean()",features_raw[,2], fixed=TRUE)
std_cols <- grep("std()",features_raw[,2], fixed=TRUE)

# select only the desired columns moving the subject and activity columns
#   to the begining for easier manipulation
extracted_tbl <- subset(super_tbl,,c(562:563, mean_cols, std_cols))

####
# 3. Uses descriptive activity names to name the activities in the data set
#  Note: names were gathered from README.MD file and are displayed using
#  camelCase notation for both consistency and ease of reading.
#  For more information on camelCase see: http://c2.com/cgi/wiki?CamelCase
activities <- factor(c("walking", "walkingUpStairs", "walkingDownStairs", 
                       "sitting", "standing", "laying"))
extracted_tbl$activity <- factor(extracted_tbl$activity,,activities)

####
# 4. Appropriately labels the data set with descriptive variable names. 
#  Completed before step 1. and during step 3. above

# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject. 
library("plyr")
library("reshape2")

sub_act_tbl <- arrange(extracted_tbl, subject, activity)
#tail (sub_act_tbl[,1:4])

melted_tbl <- melt(sub_act_tbl, id=c("subject","activity"))
tidy_tbl <- dcast(melted_tbl, ... ~ variable, mean)

# Output a text file containing the CSV tidy table
write.table(tidy_tbl, "tidy_dataset.txt", row.names=FALSE, sep = ",")

## Q.E.D

