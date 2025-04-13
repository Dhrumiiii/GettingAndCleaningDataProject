library(dplyr)

# Read feature names and activity labels
features <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/features.txt", col.names = c("index", "feature"))
activities <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Training data
x_train <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt", col.names = features$feature)
y_train <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/y_train.txt", col.names = "activity")
subject_train <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

# Test data
x_test <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt", col.names = features$feature)
y_test <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/y_test.txt", col.names = "activity")
subject_test <- read.table("C:/Users/DHRUMI/Downloads/getdata_projectfiles_UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")

# Merge data
x_all <- rbind(x_train, x_test)
y_all <- rbind(y_train, y_test)
subject_all <- rbind(subject_train, subject_test)
merged_data <- cbind(subject_all, y_all, x_all)

# Extract only mean and std measurements
selected_columns <- grepl("mean\\(\\)|std\\(\\)", features$feature)
selected_data <- merged_data[, c(TRUE, TRUE, selected_columns)]

# Use descriptive activity names
selected_data$activity <- activities[selected_data$activity, 2]

# Label data with descriptive variable names
names(selected_data) <- gsub("^t", "Time", names(selected_data))
names(selected_data) <- gsub("^f", "Frequency", names(selected_data))
names(selected_data) <- gsub("Acc", "Accelerometer", names(selected_data))
names(selected_data) <- gsub("Gyro", "Gyroscope", names(selected_data))
names(selected_data) <- gsub("Mag", "Magnitude", names(selected_data))
names(selected_data) <- gsub("BodyBody", "Body", names(selected_data))
names(selected_data) <- gsub("\\.\\.", "", names(selected_data))
names(selected_data) <- gsub("\\.", "", names(selected_data))

# Create tidy dataset with average of each variable for each activity and subject
tidy_data <- selected_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Write to file
write.table(tidy_data, "C:/Users/DHRUMI/Downloads/tidy_dataset.txt", row.names = FALSE)

