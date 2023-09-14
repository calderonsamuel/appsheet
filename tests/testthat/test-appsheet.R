test_that("defaults work ok", {
	skip_on_cran()
	# This code assumes you have a "Driver" table
	appsheet(tableName = "Driver") %>%
		expect_s3_class(class = "data.frame")
})

test_that("fails without tableName" , {
	skip_on_cran()
	appsheet() %>% 
		expect_error()
})

test_that("fails without credentials", {
	skip_on_cran()
	expect_error(appsheet("Driver", appId = ""))
	expect_error(appsheet("Driver", appId = NULL))
	expect_error(appsheet("Driver", appId = NA))
	expect_error(appsheet("Driver", access_key = ""))
	expect_error(appsheet("Driver", access_key = NULL))
	expect_error(appsheet("Driver", access_key = NA))
})

test_that("fails if bad Action is provided", {
	skip_on_cran()
	appsheet(tableName = "Driver", Action = "CustomMadeAction") %>%
		expect_error()
})

test_that("warns when Properties is empty", {
	skip_on_cran()
	appsheet(tableName = "Driver", Properties = NULL) %>%
		expect_error()
})

test_that("fails when Selector is provided without Find action", {
	skip_on_cran()
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
	skip_on_cran()
	appsheet(tableName = "Driver", Action = "Edit") %>%
		expect_error()
})

test_that("fails when _RowNumber column is provided", {
	skip_on_cran()
	appsheet("Driver", Rows = tibble::tibble("_RowNumber" = "a")) %>%
		expect_error(regexp = "_RowNumber")
})

test_that("fails when 'Row ID' column is provided for Add action", {
	skip_on_cran()
	appsheet("Driver", Rows = tibble::tibble("Row ID" = "a"), Action = "Add") %>%
		expect_error(regexp = "Row ID")
})
