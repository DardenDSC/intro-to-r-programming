# Intro To R Programming<img src="https://www.r-project.org/logo/Rlogo.png" width="200px" align="right" />
A repository of containing one script ([`script.R`](script.R)) that is a guide to beginning 
to code in the R programming language. The script covers how to read data, assign 
data to variables, analyze data, and plot data all using a Spotify user's songs played 
history that is in [`song-data.csv`](song-data.csv).

## Table of Contents
 - [Following Along](#following-along)
 - [Installing R and RStudio](#installing-r-and-rstudio)
 - [Installing R Packages](#installing-r-packages)
 - [The Data](#the-data)
 - [Resources to Learn R](#resources-to-learn-r)
 - [Source](#source)
 
### Following Along

The best way to learn R is to try it out for yourself. After downloading the R and 
RStudio software, open up RStudio and start pasting it to see what it does. For this 
session: 
 - Download the R script, [`script.R`](script.R)
 - Download the data [`song-data.csv`](song-data.csv)
 - Open up RStudio, click File -> Open File then locate the script
 - Start by copy/pasting the code from the script into the R Console window and see what it does. 

Keep reading for more information on how to set up your computer with R and RStudio.
 
### Installing R and RStudio
First, you can install R by going to https://cloud.r-project.org. You should see 
the options to download for Linux, Mac, or Windows. Follow the command prompts on your 
screen just like you would install any other software.

Next, you should install RStudio. Wait, Why should I install RStudio too?  

When you installed R, you only installed the software. It is hard to code directly to the software, so 
RStudio is an interface (other software) that makes it easier to write R code and 
execute it. Go to https://www.rstudio.com/products/rstudio/download/#download and 
pick the installer for your operating system. Again, follow the prompts like you would 
install any other software on your computer. 

If you have trouble installing R or RStudio, contact a member of the Darden Data Science 
club to help you by emailing us at: DataScienceClub@darden.virginia.edu

### Installing R Packages
R uses "packages" of functions that people develop to that make it easier to read, 
format, and analyze data without writing many many lines of detailed code in order 
to do very simple tasks. We will use the **tidyverse** package to help perform the 
analysis of Spotify song data. Before using the package it must be installed by running 
the following command in the RStudio console.

```
install.packages("tidyverse")
```

### The Data
The data contains 3,274 records on the songs played and 6 attributes about the songs. 
The attributes cover the basic data captured when playing a song on Spotify, such as 
the time played, track name, etc. Below are the data definitions: 

Variable | Data Type | Data Definition
---|---|---------
played_at | datetime | The date and time that the song was played
track_name | character | The name of the song played
explicit | logical | A `TRUE`/`FALSE` value indicating whether or not the song lyrics were the explicit version. `TRUE` means, yes, it was the explicit version
duration_ms | double | The length of the song played in milliseconds
type | character | One of three values indicating where the song was played from (`playlist`, `artist`, or `album`)
playlist_url | character | The URL of the Spotify playlist that the song was on. If missing, then the song was not played from a playlist.

### Resources to Learn R
Once you've installed R and RStudio you may want to review some materials 
to understand how to use it. The article [R basics, workspace and working directory, RStudio projects](http://stat545.com/block002_hello-r-workspace-wd-project.html) provides a 
very good introduction to using R.

The best book to learn R programming in called R for Data Science. It is available 
for free online at: http://r4ds.had.co.nz

### Source
The data was taken from a blog that Tamas Szilagyi wrote about analyzing his 
spotify listening history: http://tamaszilagyi.com/blog/analyzing-my-spotify-listening-history/

[Top](#intro-to-r-programming)
