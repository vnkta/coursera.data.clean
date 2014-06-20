---
title: "README"
author: "Ivan S."
date: "Tuesday, June 19, 2014"
output: html_document
---

## Coursera "Getting and Cleaning Data" Project

### Summary

This document describes the steps taken in 'run_analysis.R' program to go from the raw data to the final tidy data set ready for analysis. More detais about the source of data, the data itself, the variables and transformations and the resuting data set can be found in the supporting document 'CodeBook.md'. 

### Important note

The script included relies on additional R package "data.table". The script does include a code for checking whether you have it installed, downloads and installs it if not and loading it.
However this has been tested only on Windows 7 x64 machine. In case you expirience problems with the scrpipt, please install manually the 'data.table' package. 

Apart from this, there are no other pre-requisites and the script shoud work out of the box, including downloading and unzipping the data. 

### What does the script do ?

01. Loads the needed data.table package (before that checks whether it is installed and attempts to installed if it isn't)

02. Creates a short list of files from the raw data, which needs to be read. (Not all of the data included in the raw data zip file are needed for the puppose of this excercise)

03. Reads all the needed data into a list consisting of data.tables

04. Sets clean names of the variables

05. Merges the 'subject_train', 'x_train' and 'y_train' into a Training data set. Similariliy creates a Test data set. Afterwards appends both data set into a single data set containing data on all subjects.

06. Filters out variables that are of no interest, i.e. such that are not related to mean and standard deviation values.

07. Recodes the activity from codes into meaningful descriptive labels. 

08. Produces a second, tidy data set with all the average values per subject and per activity.

09. Exports the final tidy data set into a txt file called "tidy.dataset.txt"

You can use the tidy data in R by reading it with read.table("tidy.dataset.txt") command.

### Enjoy !

