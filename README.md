# Getting & Cleaning Data Project
## Ryan Thomas 2017


### To Run:
You must be certain that the working directoy containts a "data" folder, inside which is the extracted contents of the data for the project. Do not alter its architecture.

### General Strategy:
* intake data, including the features list
* aggregate partnered data (x to x, y to y, subj to subj) row-wise
* for convenience, do some labeling of columns here
* bind the mini-aggregates together column-wise
* replace activity numbers with labels found in research files
* rename measurement columns with key found in research files
* create new data frame using data.table to take the mean of the entire lot by subject and activity

### On data extraction decisions:
I chose to extract all data that involved a mean or standard deviation in any way, not just the ones that said mean() and std(), this means that the MeanFreq() lot is included in my set. I did this because I felt like the experiments intended for those to be considered "means," so it did not make sense to exclude them due to a minor typography choice. The exception to this philosophy was that I made sure not to include the angle() set despite them including Means, because they took means as arguments rather than presenting the means themselves.

### On Variable Names:
I used the variable names that the researchers themselves used, with some tweaking for readability. They seemed appropriately descriptive to me, after reading through the researchers' ReadMe file. I put some thought into making my own, but after trying a few out I realized that I wasn't adding any clarity, only adding verbosity by doing so.

### Closing Thoughts:
The data.table package is EXTREMELY powerful. I spent 2 hours trying to brute force my way through a solution that took about 5 minutes of effort after doing some research into data.table
