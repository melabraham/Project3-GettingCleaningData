##Install required packages   

if(!is.element("plyr", installed.packages()[,1])){ 
    install.packages("plyr") 
} 
 
library(plyr) 

## download and unzip the datafile 
file <- "datafile.zip"

if(!file.exists(file)){ 

    ##Downloads the data file 
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",file, mode = "wb") 
    unzip(file, files=NULL) 
    
} 


##read the train dataset 

d_train = read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header=FALSE) 
d_train[,562] = read.csv("UCI HAR Dataset/train/y_train.txt", sep="", header=FALSE) 
d_train[,563] = read.csv("UCI HAR Dataset/train/subject_train.txt", sep="", header=FALSE) 


##read the test dataset 

d_test = read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header=FALSE) 
d_test[,562] = read.csv("UCI HAR Dataset/test/y_test.txt", sep="", header=FALSE) 
d_test[,563] = read.csv("UCI HAR Dataset/test/subject_test.txt", sep="", header=FALSE) 
 
##read activity labels

d_activityLabels = read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header=FALSE) 

# Read features and make the feature names better suited for R with some substitutions 

d_features = read.csv("UCI HAR Dataset/features.txt", sep="", header=FALSE)
d_features[,2] = gsub('-mean', 'Mean', d_features[,2]) 
d_features[,2] = gsub('-std', 'Std', d_features[,2]) 
d_features[,2] = gsub('[-()]', '', d_features[,2]) 
 

# Merge training and test sets together 
Dataset = rbind(d_train, d_test) 

#features used for col names when creating train and test data sets 
d_columns <- grep(".*Mean.*|.*Std.*", d_features[,2]) 
d_features <- d_features[d_columns,] 
d_columns <- c(d_columns, 562, 563)


## Load the data sets 
d_dataset <- Dataset[,d_columns]


# Add the column names (features) to dataset 

colnames(d_dataset) <- c(d_features$V2, "Activity", "Subject") 
colnames(d_dataset) <- tolower(colnames(d_dataset)) 


## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive activity names
d_dataset$activity <- factor(d_dataset$activity, levels=d_activityLabels$V1, labels=d_activityLabels$V2) 

##Extracts only the measurements on the mean and standard deviation for each measurement.  
dataset1 <- d_dataset[,c(1,2,grep("std", colnames(d_dataset)), grep("mean", colnames(d_dataset)))] 

# save dataset1 to a csv file
write.csv(dataset1, "dataset1.csv", sep="\t") 

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.  
dataset2 <- ddply(d_dataset,.(activity,subject),numcolwise(mean))

# Adds "_avg" to colnames 
colnames(dataset2)[-c(1:2)] <- paste(colnames(dataset2)[-c(1:2)], "_avg", sep="") 

# Save tidy dataset2  
write.csv(dataset2,"tidy.csv", sep="\t") 
