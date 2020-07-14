# Getting-and-Cleaning-Data-Course-Project
PGA for Getting and Cleaning Data - Week 4

The scipt load the required packeges (dplyr and tidyr).

The script then checks of the required data has been dowloaded or not. If not, the zip file "Coursera_DS3_Final.zip" is downloaded.
After the zip file is download it is extracted (first checked if not already excracted).

All the text files (data) extracted from the zip file is then assigned to data frames.

Running the script, run_analysis.R  does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final data is then written to a text file, "Output.txt"
