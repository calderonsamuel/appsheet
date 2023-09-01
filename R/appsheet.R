#' Appsheet Function
#'
#' This function interacts with the AppSheet API to perform actions on a specified table. 
#' For more info, check the [official documentation](https://support.google.com/appsheet/answer/10105768?hl=en&ref_topic=10105767&sjid=5773035771729381163-SA).
#'
#' @inheritParams ash_request
#'
#' @return A data frame containing the response from the AppSheet API.
#' 
#' @export
#' 
#' @importFrom magrittr %>%
#' 
#' @examples
#' \dontrun{
#' appsheet("my_table")
#' appsheet("my_table", Properties = list(Locale = "en-US"))
#' }
#'
appsheet <- function(
		tableName,
		Action = "Find", 
		Properties = ash_properties(), 
		Rows = list(),
		appId = Sys.getenv("APPSHEET_APP_ID"),
		access_key = Sys.getenv("APPSHEET_APP_ACCESS_KEY")
) {
	request <- ash_request(
			tableName = tableName,
			Action = Action,
			Properties = Properties,
			Rows = Rows,
			appId = appId,
			access_key = access_key
		)
	
	response <- request %>% 
		httr2::req_perform() %>% 
		httr2::resp_body_json() 
	
	# When Action != "Find" the response content is wrapped 
	# inside the Rows property. really annoying
	if ("Rows" %in% names(response)) {
		response <- response$Rows
	}
	
	response %>%
		lapply(tibble::as_tibble) %>% 
		purrr::list_rbind()
}
