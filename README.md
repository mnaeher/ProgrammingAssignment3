# ProgrammingAssignment3
John Hopkins University

# Getting and Cleaning Data - Course Project

## Overview
This repository contains the files required for the course project of the "Getting and Cleaning Data" course, part of the Data Science Foundations R Specialization by Johns Hopkins University. The project focuses on cleaning and organizing a dataset into a tidy format.

---

## Repository Structure

---

## Files

### 1. `run_analysis.R`
This R script performs the following steps:
1. **Downloads the dataset**: Downloads and unzips the UCI HAR Dataset from the provided URL.
2. **Merges the datasets**: Combines the training and test datasets into one unified dataset.
3. **Extracts specific measurements**: Retains only the measurements on the mean and standard deviation for each measurement.
4. **Labels the data**: Assigns descriptive activity names and appropriately labels the dataset with descriptive variable names.
5. **Creates a tidy dataset**: Groups data by activity and subject and calculates the average of each variable.

### 2. `CodeBook.md`
The CodeBook provides:
- Detailed explanations of variables and their transformations.
- The processes applied to clean and tidy the dataset.
- Descriptions of the final dataset structure.

### 3. `tidy_dataset.txt`
This file contains the final tidy dataset, where each row represents the average of each variable for each activity and each subject.

---

## Dataset Description
The original dataset is the **UCI HAR Dataset** (Human Activity Recognition Using Smartphones Dataset). It contains sensor data (accelerometer and gyroscope) collected from 30 subjects performing six activities while wearing a smartphone on their waist.

### Activities:
- WALKING
- WALKING_UPSTAIRS
- WALKING_DOWNSTAIRS
- SITTING
- STANDING
- LAYING

### Variables:
- Time and frequency domain signals.
- Mean and standard deviation of sensor measurements.

For more information, refer to the original dataset description: [UCI HAR Dataset](https://archive.ics.uci.edu/ml/datasets/human+activity+recognition+using+smartphones).

---

## Acknowledgments
- Johns Hopkins University for the course.
- The UCI Machine Learning Repository for providing the dataset.
- Original dataset authors: Anguita, Reyes, et al.

