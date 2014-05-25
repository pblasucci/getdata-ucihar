getdata-ucihar
====================

Peer reviewed project for 'Getting and Cleaning Data' course (port of the Coursera Data Science Specialization)

--------------------

This repo contains the source files and R code necessary to transform the 'Human Activity Recognition Using Smartphones Data Set',
which is dispersed over several files, into a single file containing averages for a subset of the total available data. Please
note: the R code (located in run_analysis.R) expects all of the source data set files to be in the same working directory
(along-side the script). Additionally, the file names are expected to match _exactly_ as laid out in the following table

The files in this repo are as follows:

1.  activity_labels.txt  -  a dictionary mapping activity identifers to textual labels
*   features.txt         -  a list of textual measurements, where each line names one column of data
*   README.md            -  this file
*   run_analysis.R       -  an R function which returns a data frame containing the calculated data
*   subject_test.txt     -  a subset of the subject identifers, one per line
*   subject_train.txt    -  a subset of the subject identifers, one per line
*   UCIHAR_CodeBook.md   -  a detailed overview of the data set returned from the R script
*   X_test.txt           -  a subset of the measurements taken
*   X_train.txt          -  a subset of the measurements taken
*   Y_test.txt           -  a subset of the activities associated to the measurements taken
*   Y_train.txt          -  a subset of the activities associated to the measurements taken

--------------------

### About the average calculations

The subset of data chosen is all average (mean) and standard deviation measures. Please note: this excludes "mean frequency" measures.
An average is calculated on each of 66 measures per-activity per-user resulting in a final data set of 180 rows of 68 values each.

For full details of each observed variable please consult the codebook included in this repository.

Addional (technical) notes are available inside run_analysis.R
