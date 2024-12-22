# CodeBook for Tidy Dataset

## Title: Tidy Dataset of the UCI HAR Dataset  
This dataset summarizes the Human Activity Recognition (HAR) dataset by calculating the average of each variable for each activity and each subject.

---

## Source Data  
- The original dataset is the **UCI HAR Dataset** provided by the University of California, Irvine.  
  - **Dataset Description**: Measurements of smartphone sensor data (accelerometer and gyroscope) collected from 30 participants performing six activities.  
  - **Source URL**: [UCI HAR Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones)

---

## Transformation Process

1. **File Download and Extraction**:  
   - The dataset was downloaded from the provided URL and extracted into a local directory.

2. **Merging Training and Test Sets**:  
   - Training and test datasets were read from their respective files (`train` and `test` folders).
   - The datasets were merged to create a single dataset, `finaldata`.

3. **Extracting Relevant Variables**:  
   - Variables with **mean()** and **std()** in their names were identified and extracted to focus on measurements of mean and standard deviation.

4. **Adding Descriptive Activity Names**:  
   - Activity IDs were replaced with descriptive names (e.g., "WALKING", "SITTING") using the `activity_labels` file.

5. **Labelling Variables with Descriptive Names**:  
   - Abbreviations in variable names were replaced with descriptive terms:
     - Prefix `t` → `Time`  
     - Prefix `f` → `Frequency`  
     - `Acc` → `Accelerometer`, `Gyro` → `Gyroscope`, `Mag` → `Magnitude`  
     - `mean()` → `Mean`, `std()` → `STD`

6. **Creating a Tidy Dataset**:  
   - The final tidy dataset was created by grouping data by `subjectID` and `activityType`, and calculating the average of each variable for each group.

---

## Dataset Structure

1. **Dimensions**:  
   - The tidy dataset contains **180 rows** (30 subjects × 6 activities) and **68 columns**.

2. **Columns**:  
   - **`subjectID`**: Identifier for each subject (range: 1–30).  
   - **`activityType`**: Descriptive activity name (e.g., "WALKING", "LAYING").  
   - **Sensor Measurements**: Averages of sensor variables for each subject and activity. Examples:  
     - `TimeBodyAccelerometer-Mean-X`: Mean value of the body acceleration signal along the X-axis.  
     - `FrequencyBodyGyroscope-STD-Z`: Standard deviation of the body gyroscope signal along the Z-axis.

---

## Variable Naming Conventions

- **`Time` and `Frequency`**: Denote signals in the time or frequency domain.  
- **`Body` and `Gravity`**: Distinguish between body motion and gravitational components.  
- **`Accelerometer` and `Gyroscope`**: Denote sensor types.  
- **`Mean` and `STD`**: Indicate the computed mean or standard deviation.  
- **Axis (`-X`, `-Y`, `-Z`)**: Denote the direction of measurements.

---

## Sample Data (First 5 rows)

| subjectID | activityType | TimeBodyAccelerometer-Mean-X | TimeBodyAccelerometer-Mean-Y | ... | FrequencyBodyGyroscope-STD-Z |
|-----------|--------------|-----------------------------|-----------------------------|-----|-----------------------------|
| 1         | WALKING      | 0.2773308                  | -0.0173838                 | ... | -0.9796410                  |
| 1         | WALKING_UPSTAIRS | 0.2554617              | -0.0239531                 | ... | -0.9925200                  |
| 1         | WALKING_DOWNSTAIRS | 0.2891883            | -0.0099185                 | ... | -0.9853020                  |
| 1         | SITTING      | 0.2612376                  | -0.0013083                 | ... | -0.9872820                  |
| 1         | STANDING     | 0.2789176                  | -0.0161376                 | ... | -0.9876020                  |

---

## File Output

- The tidy dataset is saved in the file `tidy_dataset.txt`.  
- Format: Plain text, tab-delimited, without row names.  
- To read the file:
  ```R
  tidy_data <- read.table("tidy_dataset.txt", header = TRUE)
