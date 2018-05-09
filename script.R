
# how to install a package (only need to install packages once) ----------------

# Run "install.packages("PACKAGE_NAME_HERE") to install an R package
# You should only run this command the first time you want to install a package.
# A package is a collection of R functions that make it easier to write your own code
install.packages('tidyverse')

# For example, the tidyverse package is a set of functions that make it 
# easier to read, format, and analyze data without writing many many lines 
# of detailed code to do very simple things. In other words, it abstracts away the 
# heavy lifting of data analysis! That's why we want to load it!


# how to load a package (need to load a each new R session) --------------------

# Run "library(PACKAGE_NAME)" to load a package. You must load the package every 
# time that you open up R (start a new session) so that the functions become available
# for use to use during the session. 
library(tidyverse)

# Here we will also install and load other packages for making it easier to 
# read, write, and manipulate JSON formatted data, along with date/time data
library(jsonlite)
library(lubridate)


# reading in data --------------------------------------------------------------

# Read the CSV (comma-seperated values) file called "song-data.csv" from our project folder
# The dataset actually comes from a blog that someone wrote about analyzing their 
# spotify listening history: http://tamaszilagyi.com/blog/analyzing-my-spotify-listening-history/

# The command "read_csv()" will read the data and assign it to an object called "df_tracks"
# The " <- " operator means take the result from the right-hand side and put it into a 
# variable by the name of what is on the left-hand side of the operator.
df_tracks <- read_csv("song-data.csv")

# an example where variable is not assigned (just printed to console) ----------

# You don't always have to assign data to a variable. If you don't include the 
# assignment operator, the result will just print it in the Console window.
df_tracks

# the origin of the data (its raw form) ----------------------------------------

# The data from the Spotify API provides a more complex type of data called JSON (JavaScript Object notation)
# data. In case you are interested That data can also be read into the R environment. 
df_tracks_raw <- fromJSON("https://raw.githubusercontent.com/mtoto/mtoto.github.io/master/data/2017-06-02-spotifyR/spotify_tracks_2017-06-30.json")

# The "head()" function lets you peak at only the first 6 rows of the data so that 
# you aren't overwhelmed when the entire dataset is printed to the Console window.
head(df_tracks_raw)

# For now, let's work with the simpler "df_tracks" variable. You can remove the "df_tracks_raw" 
# object from the R environment using the "rm()" command. Or you can just ignore that the 
# variable even exists. If you run the code below it will remove it. It's better to keep your 
# environment clear of objects you're not using. They take up your computer's RAM during the session.
rm(df_tracks_raw)


# figuring out the rows and columns of a dataset -------------------------------

# R is typically used to store data in a "tabular" format. In other words, a format 
# that keeps the data in a rectangle shape of rows and columns. There are functions 
# in R specifically designed to measure the data.
# For example, "nrow(OBJECT_NAME_HERE))" will tell you the number of rows in your data
nrow(df_tracks)
# "ncol(OBJECT_NAME_HERE))" will tell you the number of columns
ncol(df_tracks)
# "dim(OBJECT_NAME_HERE)" will tell you the dimensions (rows and columns!)
dim(df_tracks)


# referencing specific data points using their indices -------------------------

# Because R is typically based on rectangles which are a collection of rows and columns
# you can reference specific parts of the rectangle using "indices". The indices are the 
# row and column numbers that point to a specific value.
# For example, to reference the 1st row, 3rd column, you just need to put that information 
# in square brackets separated by a comma next to the object
df_tracks[1,2]

# Rectangular data where the columns have names can be referenced using the dollar sign ("$").
# For example, if you want the 1st observation in the "track_name" column, just put "[1]" on the
# end of the object referencing the column name with a dollar sign, like this:
df_tracks$track_name[1]


# the different data structures in R -------------------------------------------

# In R there are more than just rectangles of data. There are a few data structures: 
#  - Vectors (a collection of values of the same data type, e.g. a bunch of numbers, or a bunch of words)
#  - Lists (a collection of values that could be of different data types, e.g. a bunch of numbers and words)
#  - Matrix (a rectangle of rows and columns of the same data type, e.g. a matrix of all numbers)
#  - Data Frames/Tibbles (a rectangle of rows and columns of different data types, e.g. numbers and words)

# You can check if a variable is a certain type of data structure by using "is.list()", "is.matrix()", "is.data.frame()"
is.vector(df_tracks)
is.data.frame(df_tracks)


# the different data types in R ------------------------------------------------

# In R there are even simpler types of data, they make up a structure: 
#  - Characters - a single letter or words 
#  - Integers - whole numbers (no decimals) from neg infinity to infinity
#  - Numerics or Doubles - real numbers (with decimals) from neg infinity to infinity
#  - Logicals - values that only take on TRUE or FALSE

# You can check if a variable is a certain type of data structure 
is.numeric(3.14)
is.double(3.14)
is.integer(3.14)
y <- as.integer(3.14)
y
is.integer(y)
is.logical(FALSE)
is.logical("FALSE")
is.character("FALSE")


# working with missing data in R -----------------------------------------------

# R keeps track of missing values as well, the absence of a value. 
# The function "is.na()" returns a vector of logical values that indicate whether 
# or not the value in the vector at that position is missing
# For example, if we would like to check the missing values in a column of the 
# dataset we can do it like this: 
head(is.na(df_tracks$playlist_url))

# Note that we've used the head() function to only look at the first 6 values, otherwise 
# we would see the entire vector (one element for each row in the dataset).

# The interesting thing about the logical data type is that R considers FALSE = 0 
# and TRUE = 1 when you convert a vector of logicals to numeric, so if you want to 
# count the number of missing values in the playlist_url column, then all you have 
# to do is calculate the "sum()"
sum(is.na(df_tracks$playlist_url))


# finding the proportion of missing values in a column -------------------------

# A neat trick is that if the FALSE/TRUE values are coded 0/1, then if you take the 
# average, it will represent the proportion of rows that have missing values
# For example, in this dataset, the proportion of rows (observations) that have a 
# missing playlist url is: 
mean(is.na(df_tracks$playlist_url))

# This tells you that 69.64% of the songs played have a missing value for playlist_url. 
# This makes sense because not all songs are going to be played from a playlist.

# This is all very fun exploring different columns, but what about some more complex 
# analyses? Let's say you wanted to determine if the duration of songs is longer or 
# short depending on if it is played from a playlist or an album on Spotify. 
# R has the tools to easily answer this question! Let's first take a look at the syntax. 


# filtering data and counting rows using filter() ------------------------------

# The package called "dplyr" is one of the most important packages in the R programming 
# language. It has an operator called the "pipe" that looks like this: %>%. The pipe 
# operator takes something from the left-hand side and pushes it into the function 
# on the right hand side. The "dplyr" package lets you combine multiple data cleaning 
# operations that flow through a series of pipes in sequence so you can easily follow 
# what's happening to the data. Let me show you a simple example. Let's say you only wanted 
# to return the rows where the the song was played on a playlist and then count the number of 
# rows in that filtered dataset. Just combine the logic like this: 
df_tracks %>% 
  filter(type == "playlist") %>% 
  nrow()

# The "nrow()" function should be familiar. It counts the number of rows in a dataset. 
# The "filter()" function is new. You'll notice that the dataset on the left-hand side 
# of the pipe operator gets "pushed" into the filter function which only returns the 
# rows where type == "playlist", then that result gets pushed again by the second pipe 
# into the nrow function. This is the process I described above where the operations are 
# chained together with the pipe so you can follow the logical flow of the analysis. 


# summarizing data using group_by() and summarize() ----------------------------

# Let's get back to the question about calculating the duration of tracks played on a 
# playlist or an album. The "dplyr" package has the function "group_by()" that will 
# split the data into all the possible values in a column and calculate a summary for 
# each value, such as the average for each song type (playlist or album). That is 
# exactly what we are looking for. Here is the code
df_tracks %>%
  group_by(type) %>% 
  summarize(avg_duration_secs = mean(duration_ms/1000, na.rm=TRUE)) %>%
  mutate(avg_duration_mins = avg_duration_secs / 60)


# how to pull up documentation -------------------------------------------------

# You'll notice that I'm using the mean function again, but including something 
# extra in there that is "na.rm=TRUE". Most functions in R take "arguments". In this 
# case the na.rm argument tells R to remove any missing values before calculating the 
# average since those will mess up the average. If you would like to know more about 
# any function in R all you have to do is type "?function_name()". For example, 
# to learn more about the "mean()" function, I would type the following: 
?mean

# Look over at the lower right side of RStudio. There is the panel that has tabs 
# entitled Files, Plots, Connections, Packages, Help. The Help panel should be 
# showing and the documentation on how to use the mean function should all be there 
# including any arguments like na.rm and how to specify them. The best thing about R
# documentation is that you can easily get to it from within R and they provide examples
# that you can copy/paste to see how they work. If you look at the documentation 
# for the mean function you'll see the example: 
x <- c(0:10, 50)
x
xm <- mean(x)

# You can run it just like that and see what the x variable is and what its mean 
# is when it gets assigned to the variable xm
xm

# You can check that the mean function works correctly by computing the average 
# the long way (the sum of all the numbers divided by the count of numbers)
my_avg <- sum(x)/length(x)
my_avg

my_avg == xm


# a summary of what has been shown so far --------------------------------------

# To summarize you have learned the following:
# - How to install a package using "install.packages()" (only need to install a package once)
# - How to load a package for analysis using "library()" (need to load a package each R session)
# - How to load data using the "read_csv()" function
# - How to assign data to a variable using the assignment operator (" <- "). In this case we called it "df_tracks"
# - How to peak at the first 6 rows of a dataset using the "head()" function
# - Ho to remove a variable using the "rm()" function
# - The different data types in R: character, integer, numeric, logical
# - The different data structures in R: vector, list, matrix, data.frame/tibble
# - How to check the data type of a variable using functions like: "is.vector()", "is.list()", "is.numeric()", "is.data.frame()"
# - How to reference specific data points in a data.frame using indices my_data_frame[1,1] or my_data_frame$column[1]
# - How to assign a value to a variable or just print it to the console window
# - How to pull up the Help documentation using the question mark and function name (e.g. ?mean)
# - How to count rows, columns, dimensions of dataset using "nrow()", "ncol()", or "dim()"
# - How to count the missing values in a column using "sum(is.na())"
# - How to calculate the average using "mean()" and standard deviation with "sd()"
# - How to chain together data operations using the pipe ("%>%")
# - How to summarize data using "filter()", "group_by()", and "summarize()"


# plotting data in R using the ggplot2 package ---------------------------------

# A lot of work in data analysis is formatting the data and computing summary 
# statistics like the ones we've been running, but it is important to supplement 
# that analysis with plots to get a better feel for what's happening in the dataset. 
# For example, let's say we wanted to know the distribution of songs played by the 
# hour of the day. 
df_tracks %>% 
  mutate(played_at = ymd_hms(played_at), 
         hour_played = hour(played_at)) %>%
  ggplot(data=., mapping=aes(hour_played)) +
  geom_histogram(binwidth=1)


# adding more elements to a histogram ------------------------------------------

# What's interesting is there is a peak around 8am and 8pm. The chart does not look 
# very professional, but it is easy to add new trendlines, axis labels, title, etc. 
# If you notice in the code above there is a plus sign ("+") after the ggplot() function. 
# This plus sign only works with ggplots and acts like adding another layer. In the 
# example above we created the plot canvas, then added a histogram to it. In the 
# example below we will add many more features to the canvas.
df_tracks %>% 
  mutate(played_at = ymd_hms(played_at), 
         hour_played = hour(played_at)) %>%
  ggplot(data=., mapping=aes(hour_played)) +
  geom_histogram(aes(fill=..count..), binwidth=1) + 
  geom_density() + 
  xlab("Hour of Day (0-24)") + 
  ylab("Count of Songs Played") + 
  ggtitle("Distribution of Songs Played by Hour of Day") + 
  theme_bw()


# creating a line plot ---------------------------------------------------------

# In the example above we created a histogram, but more typically users want to 
# see a line plot. Let's plot the number of songs played each day and plot them 
# over time to see the trend. The code below looks very complicated, but it is 
# really just a series of layers added to the plot to make it easier to read. Let's 
# walk through the code in steps. 

# Step 1: "mutate()" will convert the timestamp to a datetime datatype in R, then 
#   we determine whether the day was a weekend and truncate the time to just a date. 
# Step 2: "group_by()" and "summarize()" calculates the songs played per day
# Step 3: "ggplot()" creates the canvas specifying the x-axis is date and y-axis is songs played
# Step 4: "geom_line()" adds a line using the data making the size and color of the line 
#   a function of whether or not it is a weekend day. This gives some visual cue as to 
#   when the weekend points are occurring. 
# Step 5: "geom_point()" adds a point at each day so we can further see each point in the line
# Step 6: "scale_color_manual()" specifies how to color the weekend vs. weekday points and line segments
# Step 7: "scale_size_manual()" specifies what the line width should be
# Step 8: "scale_x_date()" specifies how the x-axis should be broken up and displayed
# Step 9: "labs()" specifies the x, y, and legend labels
# Step 10: "ggtitle()" gives the plot a title
# Step 11: "theme_bw()" gives a theme that is minimalist so the chart is easier to read.

df_tracks %>% 
  mutate(played_at = ymd_hms(played_at), 
         weekend_ind = ifelse(wday(played_at) %in% c(6,7), TRUE, FALSE),
         date = as.Date(played_at)) %>%
  group_by(date, weekend_ind) %>%
  summarize(songs_played = length(played_at)) %>%
  ggplot(data=., mapping=aes(x=date, y=songs_played)) +
  geom_line(aes(size = weekend_ind, 
                colour = weekend_ind, group=1), show.legend = FALSE) + 
  geom_point(aes(colour = weekend_ind, group=1)) + 
  scale_color_manual(values = c("#7570b3", "#d95f02"), 
                     labels = c("Weekday", "Weekend")) +
  scale_size_manual(values = c(.7, .7)) +  
  scale_x_date(date_breaks = "1 week", 
               date_labels = "%b-%d", 
               minor_breaks = NULL) +
  labs(x = "Date", 
       y = "Count of Songs Played", 
       col = "Day of Week") + 
  ggtitle("Trend of Songs Played over Time") + 
  theme_bw()


# the different plot types using ggplot2 ---------------------------------------

# Plotting in R is supposed to be easy, but it is definitely a challenge to learn 
# at first given the flexibility. This gives you great power to do literally anything on a plot.
# To help you simplify the most common format is ggplot() + geom_(shape) + labs()
# For example, a simple version of the plot above is: 

summary_data <- df_tracks %>% 
  mutate(played_at = ymd_hms(played_at), 
         date = as.Date(played_at)) %>%
  group_by(date) %>%
  summarize(songs_played = length(played_at))

ggplot(data=summary_data, mapping=aes(x=date, y=songs_played)) +
  geom_line() + 
  labs(x = "Date", 
       y = "Count of Songs Played") 

# As you can see the function "geom_line()" creates a line chart, but there are other 
# types of geoms that create different plot types: 
#  - geom_histogram() = creates histograms
#  - geom_line() = creates line charts
#  - geom_point() = creates scatterplots
#  - geom_bar() = creates bar charts or column charts
#  - geom_smooth() = creates a smooth trend line to scatter plot
#  - geom_boxplot() = creates box-plots

# read R For Data Science ------------------------------------------------------

# The most prolific R programmer, Hadley Wickham, has released a book for free 
# that describes for beginners how to approach data science using R. The book 
# is easy to use and reference. I highly recommend you read it if you intend on 
# learning more on how to code in R. The link is: http://r4ds.had.co.nz

# this script is also available online at: 
#   https://github.com/DardenDSC/intro-to-r-programming/blob/master/script.R
