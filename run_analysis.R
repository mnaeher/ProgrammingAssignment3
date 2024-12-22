library(dplyr)

# Set the working directory
path <- getwd()  # Set the working directory
file_url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
file_name <- file.path(path, "UCI_HAR_Dataset.zip")  # Path for the downloaded file
unzip_dir <- file.path(path, "UCI_HAR_Dataset")  # Target folder for unzipping

# Check if the file has already been downloaded
if (!file.exists(file_name)) {
  message("Downloading the file...")
  download.file(file_url, destfile = file_name, method = "curl")  # Download the file
  message("Download completed!")
} else {
  message("The file already exists in the working directory.")
}

# Unzip the file
if (!dir.exists(unzip_dir)) {  # Check if the target folder already exists
  message("Unzipping the file...")
  unzip(file_name, exdir = unzip_dir)  # Unzip into the target folder
  message("Unzipping completed!")
} else {
  message("The files have already been unzipped.")
}

# 1. Merge the training and test datasets

# 1.1 Define the data directory
data_dir <- file.path(unzip_dir, "UCI HAR Dataset")

# 1.1 Reading files

# 1.1.1 Reading training datasets
x_train <- read.table(file.path(data_dir, "train", "X_train.txt"))
y_train <- read.table(file.path(data_dir, "train", "y_train.txt"))
subject_train <- read.table(file.path(data_dir, "train", "subject_train.txt"))

# 1.1.2 Reading test datasets
x_test <- read.table(file.path(data_dir, "test", "X_test.txt"))
y_test <- read.table(file.path(data_dir, "test", "y_test.txt"))
subject_test <- read.table(file.path(data_dir, "test", "subject_test.txt"))

# 1.1.3 Reading feature vector
features <- read.table(file.path(data_dir, "features.txt"))
features
# 1.1.4 Reading activity labels
activity_labels <- read.table(file.path(data_dir, "activity_labels.txt"))

# 1.2 Assigning variable names
colnames(x_train) <- features[, 2]
colnames(y_train) <- "activityID"
colnames(subject_train) <- "subjectID"

colnames(x_test) <- features[, 2]
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"

colnames(activity_labels) <- c("activityID", "activityType")

# 1.3 Merging all datasets into one set
alltrain <- cbind(y_train, subject_train, x_train)
alltest <- cbind(y_test, subject_test, x_test)
finaldata <- rbind(alltrain, alltest)

# 2. Extract measurements on the mean and standard deviation for each measurement

# Identify columns with "mean()" or "std()" in their names
mean_std_columns <- grep("mean\\(\\)|std\\(\\)", features[, 2], value = TRUE)

# Add "activityID" and "subjectID" to the list of selected columns
selected_columns <- c("activityID", "subjectID", mean_std_columns)

# Extract only these columns from the final dataset
finaldata_mean_std <- finaldata %>%
  select(activityID, subjectID, contains("mean()"), contains("std()"))

# 3. Add descriptive activity names to the dataset
finaldata_mean_std <- finaldata_mean_std %>%
  left_join(activity_labels, by = "activityID")

# 4. Appropriately label the data set with descriptive variable names

# Replace abbreviations with full descriptive names
names(finaldata_mean_std) <- gsub("^t", "Time", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("^f", "Frequency", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("Acc", "Accelerometer", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("Gyro", "Gyroscope", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("Mag", "Magnitude", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("BodyBody", "Body", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("-mean\\(\\)", "-Mean", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("-std\\(\\)", "-STD", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("-freq\\(\\)", "-Frequency", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("angle", "Angle", names(finaldata_mean_std))
names(finaldata_mean_std) <- gsub("gravity", "Gravity", names(finaldata_mean_std))

# 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject

# Group by subjectID and activityType and calculate the mean for each variable
tidy_dataset <- finaldata_mean_std %>%
  group_by(subjectID, activityType) %>%
  summarise_all(mean)

# Save the tidy dataset to a file
write.table(tidy_dataset, file = "tidy_dataset.txt", row.names = FALSE)
