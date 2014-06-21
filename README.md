TidyData
========

Doug's course project for the Johns Hopkins' Getting and Cleaning Data Course
_____

### Introduction
This project consists of three files:
```
run_analysis.R (a script file)

CodeBook.md (the data dictionary)

README.md (this help file)
```
The `run_analysis.R` script is desgined to help process the data gathered 
in the Human Activity Recognition (HAR) Using Smartphones experiment 
(Anguita, D. et.al., 2012) by combining key data elements into a "Tidy" package for
preliminary analysis.

### Input
The data files associated with the UCI HAR study

### Output
A comma separated (CSV) text file containing the tidy version of the data named:
`tidy_dataset.txt`


### Description
This script uses a copy of the HAR Dataset residing in a local directory named:

`UCI HAR Dataset`

To obtain a copy of the dataset, please visit one of the links listed below in the "Sources" section of this page/document.

The script loads the individual files of the dataset into tables that are combined and anotated according to the three main priciples of Tidy Data (Wickham, H., submitted) as follows:

1. Each variable forms a column
2. Each observation forms a row
3. Each type of observational unit forms a table

The script then generates a tidy file containing a subset of the original dataset ready for further analysis (see the Codebook.md file for details). The observations in this subset reveal the average readings for each actvity of each subject in the original study.




#### Sources 
- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
- https://sites.google.com/site/smartlabunige/software-datasets/har-dataset





_____
#### References  

Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. **Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine.** *International Workshop of Ambient Assisted Living* (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
         
Hadley Whickham. **Tidy Data.** *The Journal of Statistical Software* Submitted. Available at: https://docs.google.com/viewer?url=http://vita.had.co.nz/papers/tidy-data.pdf
