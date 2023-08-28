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
#' @examples
#' app_data <- appsheet("my_table", Action = "Find", Properties = list(Locale = "en-US"))
#'
appsheet <- function(
		tableName,
		Action = "Find", 
		Properties = list(Locale = "en-US"), 
		Rows = list(),
		appId = Sys.getenv("APPSHEET_APP_ID"),
		access_key = Sys.getenv("APPSHEET_APP_ACCESS_KEY")
) {
	
	req_body <- ash_req_body(Action = Action, Properties = Properties, Rows = Rows)
	
	ash_request <- httr2::request("https://api.appsheet.com") |>
		httr2::req_url_path_append("api") |>
		httr2::req_url_path_append("v2") |>
		httr2::req_url_path_append("apps") |>
		httr2::req_url_path_append(appId) |>
		httr2::req_url_path_append("tables") |>
		httr2::req_url_path_append(tableName) |>
		httr2::req_url_path_append("Action") |>
		httr2::req_headers(ApplicationAccessKey = access_key) |>
		httr2::req_body_json(req_body) 
	
	ash_response <- ash_request |> 
		httr2::req_perform() |> 
		httr2::resp_body_json() 
	
	ash_response |> 
		lapply(tibble::as_tibble) |> 
		purrr::list_rbind()
}

ash_req_body <- function(Action = "Find", Properties = list(Locale = "en-US"), Rows = list()) {
	good_actions <- c("Find", "Add", "Delete", "Edit")
	if(!Action %in% good_actions) {
		cli::cli_abort('{.code Action} must be one of {good_actions}')
	}
	
	if(rlang::is_empty(Properties))  {
		cli::cli_warn('Empty {.code Properties} might return an empty response')
	}
	
	list(
		Action = Action,
		Properties = Properties,
		Rows = Rows
	)
}


