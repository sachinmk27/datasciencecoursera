I checked for missing values in the data, since there wasnt any I proceeded.

In data_set ( the data.frame created before using aggregate) 10299 X 81

While extracting features for mean and std, i chose to extract those with meanFreq too, thats why the number is 79+2(81 

columns) instead of being lesser. 

Variables:
Subject - is the volunteer number
Activity - the type of activity..standing,sitting etc
and the rest 79 are the feature measurement variables, like Avg_Time_Body_Acceleration_mean_Xaxis

format is : Time/Frequency_domain, motion, mean/std, axis direction

The tidy data set, dimensions are 180 * 81,
