test_that("Action Find works", {
	appsheet(tableName = "Driver", Action = "Find") %>%
		expect_s3_class(class = "data.frame")
})
