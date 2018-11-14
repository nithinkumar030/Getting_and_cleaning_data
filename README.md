# Getting_and_cleaning_data
//run_analysis.R script details - 
1. First download data set from the UCI cloud repo -
   "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
   and uncompress it
2. Read the activity  and labels  
3. Read the features first and filter  only the mean and std deviation as wanted features 
4. Select the wanted features and its names as measurement.
5. Extract the wanted features ,activity and subject of the train sets
6. Extract the wanted features ,activity and subject of the test sets
7. Merge the train and test datasets as combined datasets
8. Calculate the average for each combined dataset features with Activity and SubjectNumber melted in to form a tidyDataSet
