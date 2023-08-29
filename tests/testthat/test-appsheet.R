test_that("defaults work ok", {
	# This code assumes you have a "Driver" table
	
	expect_s3_class(
		object = appsheet(tableName = "Driver"), 
		class = "data.frame"
	)
})

test_that("fails without credentials", {
	expect_error(appsheet("Driver", appId = ""))
	expect_error(appsheet("Driver", access_key = ""))
})
