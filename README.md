===============================================================================
Coursera Getting and Cleaning Data Course Project
===============================================================================

run_analyis.R contains all of the R code used to generate the final data set.

It requires the use of the data.tables package which allows for faster reads.

The funtion get.data(var) pulls the file indicated by var from both the
training and test data files. It combines these files verticaly and returns the
resulting data.table.

Lines 14-17 import the subject ids as a data.table with one column 'subject'.
'subject' is set as a factor.

Lines 20-25 import the activity data as a data.table with one column
'activity'. Activity is set as a factor with the labels provided by
'activity_labels.txt'.

Lines 28-29 import the features data and assign column names provided in
'features.txt'.

Lines 36-37 extract those features which include mean data into a new
data.table called 'means'.

Lines 40-41 extract those features which include standard deviation data into a
new data.table called 'stds'.

Lines 44-45 recombine 'means' and 'stds' with 'activity' and 'subject' into a
summary data.table called 'mean.and.standard.deviation'

Lines 48-51 extract the means data from 'mean.and.standard.deviation' and takes
the mean by subject and activity, storing this in a new data.table called
'tidy'.


=============================================
The Github repo contains the following files:
=============================================

README.md

CodeBook.md

run_analysis.R

tidy_data.RData


===========================================
For reference the Github repo also contains
these files from the original data download
===========================================

- 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'y_train.txt': Training labels.

- 'y_test.txt': Test labels.
