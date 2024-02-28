library(tidyverse)
library(NHSRdatasets)
library(NHSRplotthedots)

# example of comment for a function

# classic dataframe with awful date format


data <- data.frame(
  month_name = c('Jan', 'Feb', 'Jun', 'Apr', 'May', 'Sep', 'Aug'),
  year = c(2022,2022,2022,2023,2023,2023,2023)
)

data

#' @title Converts date to period end date
#'
#' This function takes a data frame containing 'year' and 'month_name' columns and converts them to a new 'period' column representing the last day of the specified month.
#'
#' @param data A data frame containing 'year' (integer) and 'month_name' (character) columns.
#'
#' @return The modified data frame with a new 'period' column of type 'Date' representing the last day of the specified month.
#'
#' @examples
#' # Example data
#' data <- data.frame(year = c(2023, 2023, 2024), month_name = c("January", "February", "March"))
#'
#' # Convert date to period end date
#' data_with_period <- date_convert(data)
#'
#' # Print the modified data frame
#' print(data_with_period)
#'
#' @export
date_convert <- function (data){
  data <- data |>
    mutate (period = paste0(year,'-', month_name, '-01'),
            period = as.Date(period, format="%Y-%b-%d"),
            period = ceiling_date(period, "month") - days(1) ) 
  
  data
}

date_convert(data)


# another example - just commenting line by line
dat <- ae_attendances

Here's the R code with comments:


# Filter the data based on specific criteria:
dat <- dat %>%
  # Select rows where 'org_code' is 'RF4'
  filter(org_code == 'RF4') %>%
  # Select rows where 'period' is after '2017-10-01'
  filter(period > '2017-10-01') %>%
  # Select rows where 'type' is either '1' or '2'
  filter(type %in% c('1', '2'))

# Call the ptd_spc function with filtered data and specific parameters:
p <- ptd_spc(dat,
  # Specify the date field in the data for the plot
  date_field = period,
  # Specify the value field in the data to be plotted
  value_field = attendances,
  # Specify the field to use for faceting the plot (optional)
  facet_field = type)

# Call the ptd_create_ggplot function with customized options:
ptd_create_ggplot(p,
  # Hide icons on the plot
  icons_position = "none",
  # Adjust point size
  point_size = 2,
  # Allow y-axis to scale dynamically (optional)
  fixed_y_axis_multiple = FALSE,
  # Format the x-axis dates (Month-Year)
  x_axis_date_format = "%b-%y"
) +

# Add labels
labs(
  # Set y-axis label
  y = "Number of attendances",
  # Remove x-axis label (if not needed)
  x = ""
) +

# Apply minimal theme for clean aesthetics
theme_minimal() +

# Hide legend
theme(legend.position = "none")



