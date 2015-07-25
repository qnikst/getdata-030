# Author: Vershilov Alexander
# License: Public Domain
#
# This is a script for clearing Human Activity Recognition Using Smartphones data
# for more information about data see Readme.md. This file loads data if it does
# not exists gathers traing and test datasets renames and combines data.
# As an output following files will be generated:
#
#   result.txt     - table with data
#   result.avg.txt - table with averages of all measurements
#
# If you need to change links to download or output file names you can change
# contants in Constants section of this file.

library(dplyr)

# Constants
data.path = "data"
data.link = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
archive.name = "Dataset.zip"
archive.path = file.path(data.path,"UCI HAR Dataset")
output.data  = "result.txt"
output.avg   = "result.avg.txt"

###############################################################################
# Download data
###############################################################################

# Create data directory
if (! dir.exists(data.path)) {
    dir.create(data.path)
}

# Download dataset file
if (! file.exists(file.path(data.path,"Dataset.zip"))) {
    if (grepl("Windows", sessionInfo()$running)) {
        download.file( data.link, destfile = file.path(data.path, archive.name));
    } else {
        download.file( data.link, destfile = file.path(data.path, archive.name)
                     , method="curl");
    }
}

# Unzip archive
if (! dir.exists(archive.path)) {
    unzip(file.path(data.path,archive.name), exdir=data.path)
}

###############################################################################
# Prepare data
###############################################################################

# Get information about names
# Types of activity
labels.data    <- read.table(file.path(archive.path, "activity_labels.txt"))
labels.list    <- labels.data$V2
# Types of measurements
features.data  <- read.table(file.path(archive.path, "features.txt"))
# We are interested only in mean and std measurements, please refer to Readme
# for additional explanation.
pattern = "mean\\(\\)|std\\(\\)"
features.names   <- c(as.character(features.data$V2), "activity", "subject")

# Prepare test data
test.data.x <- read.table(file.path(archive.path, "test", "X_test.txt"))
test.data.y <- read.table(file.path(archive.path, "test", "y_test.txt"))
test.data.subject <- read.table(file.path(archive.path, "test", "subject_test.txt"))
test.data   <- cbind(test.data.x, test.data.y, test.data.subject)
names(test.data) <- features.names

# Prepare train data
train.data.x <- read.table(file.path(archive.path, "train", "X_train.txt"))
train.data.y <- read.table(file.path(archive.path, "train", "y_train.txt"))
train.data.subject <- read.table(file.path(archive.path, "train", "subject_train.txt"))
train.data   <- cbind(train.data.x, train.data.y, train.data.subject)
names(train.data) <- features.names

# Combine data
sum.data <- rbind(test.data, train.data)

# Clean data by leaving columns that we are interested in
features.matched <- c(as.character((features.data[grep(pattern,features.data$V2),])$V2), "activity","subject")
result.data <- sum.data[,names(sum.data) %in% features.matched]
result.data$activity <- labels.list[result.data$activity]

# Rename fields to human readable form.
renameField <- function (x) {
  x <- gsub("-",".",x)
  x <- gsub("^t","Time.",x)
  x <- gsub("^f","Freq.",x)
  x <- gsub("\\(\\)","",x)
  x
}

names(result.data) <- renameField(names(result.data))
write.table(result.data,output.data,row.names=FALSE)
result.data %>% group_by(activity,subject) %>% summarise_each(funs(mean)) %>% write.table(.,output.avg, row.names=FALSE)
