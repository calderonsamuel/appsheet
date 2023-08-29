
<!-- README.md is generated from README.Rmd. Please edit that file -->

# appsheet

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/calderonsamuel/appsheet/branch/main/graph/badge.svg)](https://app.codecov.io/gh/calderonsamuel/appsheet?branch=main)
[![R-CMD-check](https://github.com/calderonsamuel/appsheet/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/calderonsamuel/appsheet/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

The goal of appsheet is to provide an easy way to use the Appsheet API
to retrieve, add, update and delete rows from your app tables. The
package exports a single function called `appsheet()`, which you can use
to perform all the supported actions.

## Installation

You can install the development version of appsheet from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("calderonsamuel/appsheet")
```

## Authentication

The first step is to [Enable the API for cloud-based service
communication](https://support.google.com/appsheet/answer/10105769?hl=en&ref_topic=10105767&sjid=7476345061548698748-SA).
Once this is done you should have:

1.  The App ID. Use it in the `appId` argument of `appsheet()` or via
    the `APPSHEET_APP_ID` environmental variable.
2.  The Application Access Key. Use it in the `access_key` argument of
    `appsheet()` or via the `APPSHEET_APP_ACCESS_KEY` environmental
    variable.

The `appsheet()` function looks for both environmental variables by
default.

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(appsheet)

# Find all the content of the "Driver" table
appsheet("Driver")
#> # A tibble: 7 × 7
#>   `_RowNumber` Key      `Driver Name` Photo           Email `Phone Number` Jobs 
#>   <chr>        <chr>    <chr>         <chr>           <chr> <chr>          <chr>
#> 1 2            70608c66 Driver 1      Driver_Images/… driv… 1-206-555-1000 db9e…
#> 2 3            261fadec Driver 2      Driver_Images/… driv… 1-206-555-1001 36a4…
#> 3 4            525982c5 Driver 3      Driver_Images/… driv… 1-206-555-1002 1db9…
#> 4 5            90eb1244 Driver 4      Driver_Images/… driv… 1-206-555-1003 e367…
#> 5 6            ddb26f78 Driver 5      Driver_Images/… driv… 1-206-555-1004 5420…
#> 6 7            29671cfb Driver 6      Driver_Images/… driv… 1-206-555-1005 98ed…
#> 7 8            7a6fafca Driver 7      Driver_Images/… driv… 1-206-555-1006 0b64…
```
