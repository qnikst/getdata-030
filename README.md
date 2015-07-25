Reamde
=======


This is script for getting and clearing the 
[Human Activity Recognition Using Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
data from [1]. This script will download data and prepares a cleared files, with
human readable column names, and average for each value.
 
Installing and running
----------------------

In order to run this script you need [R]() and [dplyr]() package to
be installed in your system. In order to install R, please use your
package manager. 'dplyr' library could be installed by running R
```
install.packages("dplyr")
```

In order to run script you could either run it from commant propmt:

```
admin@localhost $ R --vanilla < run_analysis.R
```

or by loading R and sourcing script using command `source("run_analysis.R")`

Description of data
-------------------

Data contains different measurements of human activities. We are interested
in means and standard deviation. As a result columns that contain `mean()`
and `std()` in their names were chosen.

Result
-----------------------

As a result of running a script you'll get downloaded data, and output
files:

  * 'result.txt' - contains cleared data;
  * 'result.avg.txt' - contains average for each activity and subject.

For the column meaning you can refer to CodeBook.md file

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013. 
