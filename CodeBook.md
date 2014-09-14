Cookbook for tidy dataset
=========================

Data source
-----------
The data used is from the "Human Activity Recognition Using Smartphones Data Set" available here: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

	The data is obtained from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. 

	The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

	The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

	For each record it is provided:

	* Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
	* Triaxial Angular velocity from the gyroscope. 
	* A 561-feature vector with time and frequency domain variables. 
	* Its activity label. 
	* An identifier of the subject who carried out the experiment.
	 variables, the data, and any transformations or work that you performed to clean up the data


Transformations performed to clean up the dataset
-------------------------------------------------
	1. The `trainingData` variable is a dataframe formed by performing column bind on activityId, subjectId and the x covariates from the training data subset. There are 7352 obs of 563 variables.
	2. The `testingData` variable is a dataframe formed by performing column bind on activityId, subjectId and the x covariates from the testing data subset. There are 2947 obs of 563 variables. 
	3. The `trainingData` and `testingData` variables are combined together in `combinedData`. 
	4. Only the columns containing the mean and standard deviation for each measurement for the x covariates are kept from `combinedData`. This is done by keeping columns whose column names contain "activity", "subject", "-mean()" and "-std()".
	5. The column names are labelled with descriptive variable names:
		* prefix *t* was replaced by *time*
		* prefix *f* was replaced by *frequency*
		* *Mag* was replaced by *Magnitude*
		* Brackets were removed
	6. A final dataset was created by aggregating by `activityId` and `subjectId` to get the average of each variable for each activity and each subject. 