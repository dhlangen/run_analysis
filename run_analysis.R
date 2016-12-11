require(dplyr)
require(tidyr)
require(reshape2)


##reads original test and training data, plus feature and label descriptions into variables
test_data <- read.table("UCI HAR Dataset/test/X_test.txt", header = FALSE)
testLabels <- read.table("UCI HAR Dataset/test/Y_test.txt", header = FALSE)
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", header = FALSE)
train_data <- read.table("UCI HAR Dataset/train/X_train.txt", header = FALSE)
trainLabels <- read.table("UCI HAR Dataset/train/Y_train.txt", header = FALSE)
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", header = FALSE)
features<- read.table("UCI HAR Dataset/features.txt", header = FALSE)

##combines feature columns to match names in the features txt file
##then changes the column names to the feature names
features <- features %>% unite(V3, c(1, 2), sep = " ")
featurenames <- features$V3
colnames(test_data) <- featurenames
colnames(train_data) <- featurenames

##adds columns for activity name and subject and a column that labels all rows
##as test or train
test_data$subject <- testSubjects$V1
test_data$activity <- testLabels$V1
test_data$group <- rep_len('test', length(test_data[ ,1]))
train_data$subject <- trainSubjects$V1
train_data$activity <- trainLabels$V1
train_data$group <- rep_len('train', length(train_data[ ,1]))

## Merges the train and test datasets into one
combined_data <- suppressMessages(full_join(train_data, test_data))

## Replaces activity numbers with desctriptive labels
combined_data$activity <- gsub("1", "walking", combined_data$activity)  
combined_data$activity <- gsub("2", "walking_upstairs", combined_data$activity)  
combined_data$activity <- gsub("3", "walking_downstairs", combined_data$activity)
combined_data$activity <- gsub("4", "sitting", combined_data$activity)           
combined_data$activity <- gsub("5", "standing", combined_data$activity)
combined_data$activity <- gsub("6", "laying", combined_data$activity) 

## Finds all variable names that relate to mean and standard deviation, and creates a new
## dataframe using those variables
selectColumns <- c("subject", "activity", grep("-std()|-mean()", featurenames, value = TRUE))
smaller <- combined_data[ ,colnames(combined_data) %in% selectColumns]


## melts columns into two variables and aggregates means for each variable grouped by activity and subject
## also assigns descriptive variable names to measurement type and signal avg
## removes leading numbers from variable names because the leading numbers are not necessary
smaller_melted <- melt(smaller, id = c("subject", "activity"))
final_data <- smaller_melted %>% aggregate(value~activity + subject + variable, data = ., mean) %>% 
    transmute(activity = activity, subject = subject, measurement_type = variable, signal_avg = value)
final_data$measurement_type <- gsub("^[0-9]+ ", "", final_data$measurement_type)

## writes final data into text file
write.table(final_data, "run_analysis.txt")

