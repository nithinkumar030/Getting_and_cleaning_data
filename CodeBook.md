activityLabels -> contains datatable of labels and activities
features -> contains datatable index  and features (featurenames)
wantedFeatures -> contains filtered output of feature rows containing only mean and std dev
measurements -> contains dataframe wanted features without '[()]'  along with feature indices

tractivities -> training data of activity
trsubjects -> training data of subjectNumbers
tr-> combined  training data of wanted features(mean and std dev).

ttactivities -> test data of activity
ttsubjects -> test data of subjectNumbers
tt-> combined  test data of wanted features(mead and std dev).

combined - > contained combined train and test sets of average of wanted features 
(features with mean and std deviation) along with melted activity and SubjectNumber as factors

