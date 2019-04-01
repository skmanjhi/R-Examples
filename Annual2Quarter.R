if (require(dplyr) != TRUE) install.packages("dplyr")
library(dplyr)}

# Expand the annual series to quarterly series
# the year variable should be named 'year'
expand_data <- function(x) {
  years <- min(x$year):max(x$year)
  quarters <- 1:4
  grid <- expand.grid(quarter=quarters, year=years)
  x$quarter <- 1
  merged <- grid %>% left_join(x, by=c('year', 'quarter'))
  merged$person <- x$person[1]
  return(merged)
}

# Interpolate the data using approx function
# the variable to be converted should be named 'var1'
# the quarterly values will be in var1_qtr
interpolate_data <- function(data) {
  xout <- 1:nrow(data)
  y <- data$var1
  interpolation <- approx(x=xout[!is.na(y)], y=y[!is.na(y)], xout=xout)
  data$var1_qtr <- interpolation$y
  return(data)
}

# Combine the 2 functions 
Annual_2_Quarter <- function(x) interpolate_data(expand_data(x))


# Example dataset 
annual_data <- data.frame(
  year = c(2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018),         # the year variable should be named 'year'
  var1 = c(1, 2, 3, 5, 7, 6, 9 , 7, 10)                                   # the variable to be converted should be named 'var1'
)

# Test our function
quarterly_data <- Annual_2_Quarter(annual_data)
print(as.data.frame(quarterly_data))
