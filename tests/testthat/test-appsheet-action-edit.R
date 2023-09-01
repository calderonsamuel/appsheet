test_that("Action Edit works", {
	row_to_modify <-
		structure(
			list(Key = "70608c66", Email = "driver01@company.com"),
			row.names = c(NA, -1L),
			class = c("tbl_df", "tbl", "data.frame")
		)
	
	appsheet(tableName = "Driver", Action = "Edit", Rows = row_to_modify) %>%
		expect_s3_class(class = "data.frame")
})
