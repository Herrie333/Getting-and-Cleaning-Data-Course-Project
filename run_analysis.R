##Load required packages
library(dplyr)
library(tidyr)

## Assign assignment zip file to a variable
zip_file <- "Coursera_DS3_Final.zip"

## Check if file exists
if (!file.exists(zip_file)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
## Download file if it does not exists  
  download.file(fileURL, zip_file, method="curl")
}

## Checking if folder exists
if (!file.exists("UCI HAR Dataset")) {
## Exctract zip file in Working Directory
  unzip(zip_file)
}

## Read text files into data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_lables <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

## Read text files from "test" folder into seperate data frames
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

## Read text files from "train" folder into seperate data frames
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")


## 1 - Merge training and tests data sets
X_axis <- rbind(X_train, X_test)
Y_axis <- rbind(y_train, y_test)
Subjects <- rbind(subject_train, subject_test)

## Combine the two tables
Combined_Table <- cbind(Subjects, Y_axis, X_axis)

## 2 - Extract Mean and STD Deviation for measurements
T_Data <- select(Combined_Table, subject, code, contains("mean"), 
                   contains("std"))

## 3 - Rename Activities
T_Data$code <- activity_lables[T_Data$code, 2]

## 4 - Re-name columns
names(T_Data)[2] = "Action"
names(T_Data)<-gsub("tBodyAcc", "Body Acceleration Time ", names(T_Data))
names(T_Data)<-gsub("-Gyro", " Gyro ", names(T_Data))
names(T_Data)<-gsub("BodyGyro", "Body Gyro ", names(T_Data))
names(T_Data)<-gsub("BodyBody", "Body ", names(T_Data))
names(T_Data)<-gsub("Mag", "Magnitude", names(T_Data))
names(T_Data)<-gsub("^t", "Time ", names(T_Data))
names(T_Data)<-gsub("^f", "Freq. ", names(T_Data))
names(T_Data)<-gsub("-mean()", "Mean", names(T_Data))
names(T_Data)<-gsub("-std()", "STD", names(T_Data))
names(T_Data)<-gsub("-freq()", "Frequency", names(T_Data))
names(T_Data)<-gsub("angle", "Angle", names(T_Data))
names(T_Data)<-gsub("tGravity", "Gravity Time ", names(T_Data))

##5 - Create a new tidy data set with averages
Data_Average <- T_Data %>%
  group_by(subject, Action) %>%
  summarise_all(mean)
# View(Data_Average)


## Write final output text file
write.table(Data_Average, "Output.txt", row.name=FALSE)