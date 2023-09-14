test_that("Action Find works", {
	skip_on_cran()
	appsheet(tableName = "Driver", Action = "Find") %>%
		expect_s3_class(class = "data.frame")
})

test_that("Action Find works in appsheet database", {
	skip_on_cran()
	appsheet_alt(tableName = "items", Action = "Find") %>%
		expect_s3_class(class = "data.frame")
})
