# Code Book

## Data Source:
Human Activity Recognition Using Smartphones Dataset  
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Variables

- **subject**: ID of the subject who performed the activity (1 to 30)
- **activity**: Descriptive activity name (e.g., WALKING, SITTING, etc.)
- The remaining variables are the average of each measurement on mean and standard deviation, for each activity and subject.

## Transformations

- Merged training and test sets.
- Selected columns with mean() or std().
- Replaced activity codes with descriptive names.
- Cleaned up variable names for readability.
- Used dplyr to compute the average for each variable per subject/activity.

## Units
All measurements are normalized and unitless.
