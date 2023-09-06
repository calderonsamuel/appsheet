test_that("Action Find works", {
	appsheet(tableName = "Driver", Action = "Find") %>%
		expect_s3_class(class = "data.frame")
})

test_that("Action Find works in appsheet database", {
	appsheet_alt(tableName = "items", Action = "Find") %>%
		expect_s3_class(class = "data.frame")
})
