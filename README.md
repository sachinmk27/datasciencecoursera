To run the script, please place the script in the same directory as the 'UCI HAR Dataset'. And, then source it. If you need to run the script again, then you might have set the working directory to the original path( to  before running this script).

Working of the script:

The script starts off by reading the txt files in test directory, the variables created are:
s_test - for subject id
x_test - 561 feature values
y_test - activity number

Now, it reads the features.txt and activity_labels.txt into features and labels respectively.

And, as above, the process for train directory is repeated. This time, the variables created are s_train,x_train, and y_train.

Now, the script joins the test and train data suing rbind() function seperately for each case i.e. s_total, x_total and y_total.

Now, names are given to s_total and x_total using names() function and the features dataset for x_total.

In order to get the colnames for feature variables containing only mean and std, the script uses grep() function. Note that, the script uses ".*mean.*" and ".*std.*" as its regular expressions, hence the feature variables which had 'meanFreq' are also included, hence the data set will have 79 + 2 columns.

Next, the script runs a for loop to generate the descriptive names as required, it uses the sub() function to find and replace certain strings in the column names.

y_total <- labels[y_total[,1],2]
This script uses the above statement, to assign the activity numbers their respective activity labels
Now, the script subsets the x_total dataframe  using the re_colnames_index vector which was generated before.

Finally, it creates the data_set using data.frame() function.

And, using the aggregate() function, the tidy data set is created. In order to subset the data_set, the script uses negative indexes, and it aggregates based on the 'Subject' and "Activity' variable, using the 'mean' function.

Finally, it generates a text file names TidyDataSet in the 'UCI HAR Dataset' directory. To read this file in R,
use 
f <- read.table("TidyDataSet.txt",header=T,sep=" ")

