test_that("defaults work ok", {
	# This code assumes you have a "Driver" table
	appsheet(tableName = "Driver") %>%
		expect_s3_class(class = "data.frame")
})

test_that("fails without tableName" , {
	appsheet() %>% 
		expect_error()
})

test_that("fails without credentials", {
	expect_error(appsheet("Driver", appId = ""))
	expect_error(appsheet("Driver", appId = NULL))
	expect_error(appsheet("Driver", appId = NA))
	expect_error(appsheet("Driver", access_key = ""))
	expect_error(appsheet("Driver", access_key = NULL))
	expect_error(appsheet("Driver", access_key = NA))
})

test_that("fails if bad Action is provided", {
	appsheet(tableName = "Driver", Action = "CustomMadeAction") %>%
		expect_error()
})

test_that("warns when Properties is empty", {
	appsheet(tableName = "Driver", Properties = NULL) %>%
		expect_error()
})

test_that("fails when Selector is provided without Find action", {
	appsheet(
		tableName = "Driver", 
		Action = "Delete",
		Properties = ash_properties(
			Selector = "Filter(Driver, true)"
		)
	) %>%
		expect_error()
})

test_that("fails when Rows is empty when action is not Find", {
	appsheet(tableName = "Driver", Action = "Edit") %>%
		expect_error()
})
