## Getting and Cleaning Data Project


The cleanup script (run_analysis.R) does the following:
 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive activity names. 
 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## run_analysis.R

### Download and create the dataset
Run the script, source("run_analysis.R")" 

1. This will download the datafile (UCI HAR dataset) and required package (plyr)

2. Read train dataset ie. subject_train.txt, x_train.txt, y_train.txt 

3. Read test dataset ie. subject_test.txt, x_test.txt , y_test.txt

4. Read features data set features.txt 

5. Merge the train and test datasets

    1. get the mean and std deviation columns  
    2. add the subject and activity columns 
    3. remove all unwanted columns
    4. add column names (features) to the dataset
    5. aggregate the data to get the mean values 
    6. remove all unwanted columns
    7. write the clean data to file
    

### Cleaned Data

The tidy data set contains the average of each variable for each activity and each subject. 