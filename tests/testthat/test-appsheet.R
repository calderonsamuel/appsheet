test_that("defaults work ok", {
	# This code assumes you have a "Driver" table
	
	expect_s3_class(
		object = appsheet(tableName = "Driver"), 
		class = "data.frame"
	)
})
