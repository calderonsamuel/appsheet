test_that("Action Edit works", {
	skip_on_cran()
	row_to_modify <-
		structure(
			list(Key = "70608c66", Email = "driver01@company.com"),
			row.names = c(NA, -1L),
			class = c("tbl_df", "tbl", "data.frame")
		)
	
	appsheet(tableName = "Driver", Action = "Edit", Rows = row_to_modify) %>%
		expect_s3_class(class = "data.frame")
})

test_that("Action edit works in appsheet database", {
	skip_on_cran()
	row_to_modify <- tibble::tibble(`Row ID` = "BXHrK70k6c4gA7oHmimo10")
	
	appsheet_alt(tableName = "items", Action = "Edit", Rows = row_to_modify) %>%
		expect_s3_class(class = "data.frame")
})
