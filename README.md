
<!-- README.md is generated from README.Rmd. Please edit that file -->

# appsheet

<!-- badges: start -->

[![Codecov test
coverage](https://codecov.io/gh/calderonsamuel/appsheet/branch/main/graph/badge.svg)](https://app.codecov.io/gh/calderonsamuel/appsheet?branch=main)
[![R-CMD-check](https://github.com/calderonsamuel/appsheet/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/calderonsamuel/appsheet/actions/workflows/R-CMD-check.yaml)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![CRAN
status](https://www.r-pkg.org/badges/version/appsheet)](https://CRAN.R-project.org/package=appsheet)
<!-- badges: end -->

The goal of appsheet is to provide an easy way to use the Appsheet API
to retrieve, add, update and delete rows from your app tables.

The package exports a main function called `appsheet()`, which you can
use to perform all the supported actions. A supporting
`ash_properties()` function allows you to customize the expected
input/output.

Have in mind that there is no evidence that the API will also work well
with *slices* and that `appsheet()` returns all the columns as
*character* vectors.

## Installation

You can install the stable version of appsheet from CRAN.

``` r
install.packages("appsheet")
```

Also, you can install the development version of appsheet from
[GitHub](https://github.com/) with:

``` r
# install.packages("remotes")
remotes::install_github("calderonsamuel/appsheet")
```

## Authentication

The first step is to [Enable the API for cloud-based service
communication](https://support.google.com/appsheet/answer/10105769).
Once this is done you should have:

1.  The App ID. Use it in the `appId` argument of `appsheet()` or via
    the `APPSHEET_APP_ID` environmental variable.
2.  The Application Access Key. Use it in the `access_key` argument of
    `appsheet()` or via the `APPSHEET_APP_ACCESS_KEY` environmental
    variable.

The `appsheet()` function looks for both environmental variables by
default.

## Example

Here are some examples on how to perform the four basic operations. It
all starts with loading the package.

``` r
library(appsheet)
```

### Read a table

The first argument of `appsheet()` is a table name. By default,
`appsheet()` will use the “Find” action, which reads all the rows. The
following code is the equivalent of using
`appsheet(tableName = "Driver", Action = "Find")`.

``` r
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

When the action is “Find”, you can take advantage of the `Selector`
argument of `ash_properties()`, which can use some AppSheet internal
functions to narrow the output.

``` r
appsheet(
    tableName = "Driver", 
    Properties = ash_properties(Selector = 'Filter(Driver, [Key] = "70608c66")')
)
#> # A tibble: 1 × 7
#>   `_RowNumber` Key      `Driver Name` Photo           Email `Phone Number` Jobs 
#>   <chr>        <chr>    <chr>         <chr>           <chr> <chr>          <chr>
#> 1 2            70608c66 Driver 1      Driver_Images/… driv… 1-206-555-1000 db9e…
```

### Add records to a table

The “Add” action allows to add one or multiple records to a table. You
must provide `Rows`, which can be a dataframe with the same column names
as the specified table. You don’t need to provide all the columns to be
successful, but can’t exclude the ones *required* by your app. Also,
don’t try to add the `_RowNumber`(or `Row ID` when using an AppsSheet
database), as it is generated internally.

An “Add” action returns a data.frame with the added rows when
successful.

``` r
row_key <- paste0(sample(letters, 8), collapse = "") # to be reused 

appsheet(
    tableName = "Driver",
    Action = "Add",
    Rows = tibble::tibble(
        Key = row_key, # required in app logic
        `Email` = "driverXX@company.com" # required in app logic
    ) 
)
#> # A tibble: 1 × 7
#>   `_RowNumber` Key      `Driver Name` Photo Email           `Phone Number` Jobs 
#>   <chr>        <chr>    <chr>         <chr> <chr>           <chr>          <chr>
#> 1 9            uksbawnc ""            ""    driverXX@compa… ""             ""
```

### Update records from a table

The “Edit” action allow to update values from one or multiple records
from a table, it also can target multiple columns. This one also
requires the `Rows` argument. Again, you can’t use the `_RowNumber`
column (but in this one you can use the `Row ID` generated by an
Appsheet database).

An “Edit” action returns a data.frame with the whole content of the
updated rows when successful.

``` r
appsheet(
    tableName = "Driver",
    Action = "Edit",
    Rows = tibble::tibble(
        Key = row_key,
        `Driver Name` = "Some name",
        Photo = "some/path.jpg"
    ) 
)
#> # A tibble: 1 × 7
#>   `_RowNumber` Key      `Driver Name` Photo         Email   `Phone Number` Jobs 
#>   <chr>        <chr>    <chr>         <chr>         <chr>   <chr>          <chr>
#> 1 9            uksbawnc Some name     some/path.jpg driver… ""             ""
```

### Delete records from a table

The “Delete” action allows to delete one or multiple records from a
table. This one also requires the `Rows` argument. Again, you can’t use
the `_RowNumber` column (but in this one you can use the `Row ID`
generated by an Appsheet database).

A “Delete” action returns a data.frame with the deleted rows when
successful.

``` r
appsheet(
    tableName = "Driver",
    Action = "Delete",
    Rows = tibble::tibble(
        Key = row_key
    ) 
)
#> # A tibble: 1 × 7
#>   `_RowNumber` Key      `Driver Name` Photo         Email   `Phone Number` Jobs 
#>   <chr>        <chr>    <chr>         <chr>         <chr>   <chr>          <chr>
#> 1 9            uksbawnc Some name     some/path.jpg driver… ""             ""
```
