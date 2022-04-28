# tnelections2019

An R package that contains the data for the 2019 Tunisian general election and can compute the results given the threshold provided.

## How to install 

simply paste the following code in your R console :

`devtools::install_github(bennour007/tnelections2019)`

## How to use 

You have 2 options in this regards :

1. You can use the raw data(just votes for each party in each voting area) that I compiled using other resources in the `votesandseats` dataset. You can use it to make your own data-viz and functions.

2. You can use the `results()` function to investigate the results directly. this function takes `votesandseats` as data argument, and a `t` as a threshold.


Cheers!
