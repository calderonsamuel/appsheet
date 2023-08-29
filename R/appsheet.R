#' Appsheet Function
#'
#' This function interacts with the AppSheet API to perform actions on a specified table.
#'
#' @param tableName The name of the table to perform actions on.
#' @param Action The action to be performed on the table. Default is "Find".
#' @param Properties A list of properties for the action. Default is a list with Locale set to "en-US".
#' @param Rows A list of rows for the action. Default is an empty list.
#' @param appId The AppSheet application ID. Default is retrieved from the APPSHEET_APP_ID environment variable.
#' @param access_key The AppSheet application access key. Default is retrieved from the APPSHEET_APP_ACCESS_KEY environment variable.
#'
#' @return A data frame containing the response from the AppSheet API.
#' 
#' @export
#' 
#' @importFrom magrittr %>%
#' 
#' @examples
#' app_data <- appsheet("my_table", Action = "Find", Properties = list(Locale = "en-US"))
#'
appsheet <- function(
		tableName,
		Action = "Find", 
		Properties = list(Locale = "en-US"), 
		Rows = list(),
		Selector = NULL,
		appId = Sys.getenv("APPSHEET_APP_ID"),
		access_key = Sys.getenv("APPSHEET_APP_ACCESS_KEY")
) {
	request <- ash_request(
			tableName = tableName,
			Action = Action,
			Properties = Properties,
			Rows = Rows,
			Selector = Selector,
			appId = appId,
			access_key = access_key
		)
	
	response <- request %>% 
		httr2::req_perform() %>% 
		httr2::resp_body_json() 
	
	response %>% 
		lapply(tibble::as_tibble) %>% 
		purrr::list_rbind()
}