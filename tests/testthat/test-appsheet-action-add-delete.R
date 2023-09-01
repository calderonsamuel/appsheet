test_that("Action Add and Delete work", {
	# We test these together to take advantage of parallel testing 
	# without adding infinte rows per check()
	
	# This complicated row_key is meant to prevent key collisions 
	# when performing multiple github actions
	row_key <- sample(letters, size = 8, replace = TRUE) |> paste0(collapse = "")
	
	row_to_add <- structure(
		.Data = list(
			Key = row_key,
			Email = "driver999@company.com"
		),
		row.names = c(NA,-1L),
		class = c("tbl_df", "tbl", "data.frame")
	)
	
	appsheet(tableName = "Driver", Action = "Add", Rows = row_to_add) %>%
		expect_s3_class(class = "data.frame")
	
	row_to_delete <- structure(
		.Data = list(Key = row_key),
		row.names = c(NA,-1L),
		class = c("tbl_df", "tbl", "data.frame")
	)
	
	appsheet(tableName = "Driver", Action = "Delete", Rows = row_to_delete) %>%
		expect_s3_class(class = "data.frame")
})
