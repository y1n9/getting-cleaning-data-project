Getting and Cleaning Data: Course Project
=========================================

Introduction
------------
This repository contains the submissions required for the Coursera course "Getting and Cleaning data" course project.
It include 3 files:

	1) README.md - Describes the contents of the repo
	2) run_analysis.R - R script that generates the tidy data set from the "Human Activity Recognition Using Smartphones Data Set"
	3) CodeBook.md - A code book that describes the variables, the data, and any transformations or work performed to clean up the data

run_analysis.R
--------------
The run_analysis.R script generates a tidy data set from the "Human Activity Recognition Using Smartphones Data Set" obtained here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.
This script does the following:

    1. Merges the training and the test sets to create one data set
    2. Extracts only the measurements on the mean and standard deviation for each measurement
    3. Uses descriptive activity names to name the activities in the data set
    4. Appropriately labels the data set with descriptive variable names
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

CodeBook.md
-----------
A code book that describes the variables, the data, and any transformations or work performed to clean up the data. More details can be found in CodeBook.md. 