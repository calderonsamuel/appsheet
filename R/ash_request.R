#' Appsheet request builder
#'
#' @param tableName The name of the table to perform actions on.
#' @param Action The action to be performed on the table. Default is "Find", which reads a table.
#' @param Properties A list of properties for the action. `ash_properties()` provides sensible defaults, but can be customized.
#' @param Rows A list of rows for the action. Default is an empty list.
#' @param Selector Expression to select and format the rows returned. Only valid when Action is "Find".
#' @param appId The AppSheet application ID. Default is retrieved from the APPSHEET_APP_ID environment variable.
#' @param access_key The AppSheet application access key. Default is retrieved from the APPSHEET_APP_ACCESS_KEY environment variable.
#'
#' @return An httr2 request
#'
ash_request <- function(
		tableName,
		Action = "Find", 
		Properties = ash_properties(), 
		Rows = list(),
		Selector = NULL,
		appId = Sys.getenv("APPSHEET_APP_ID"),
		access_key = Sys.getenv("APPSHEET_APP_ACCESS_KEY")
) {
	
	if (appId == "" || is.null(appId)) cli::cli_abort("Must provide {.code appId}")
	if (access_key == "" || is.null(appId)) cli::cli_abort("Must provide {.code access_key}")
	
	
	req_body <- ash_req_body(Action = Action, Properties = Properties, Rows = Rows, Selector = Selector)
	
	httr2::request("https://api.appsheet.com") %>%
		httr2::req_url_path_append("api") %>%
		httr2::req_url_path_append("v2") %>%
		httr2::req_url_path_append("apps") %>%
		httr2::req_url_path_append(appId) %>%
		httr2::req_url_path_append("tables") %>%
		httr2::req_url_path_append(tableName) %>%
		httr2::req_url_path_append("Action") %>%
		httr2::req_headers(ApplicationAccessKey = access_key) %>%
		httr2::req_body_json(req_body) 
}

ash_req_body <- function(Action = "Find", Properties = ash_properties(), Rows = list(), Selector = NULL) {
	
	good_actions <- c("Find", "Add", "Delete", "Edit")
	
	if(!Action %in% good_actions) {
		cli::cli_abort('{.code Action} only supports {good_actions} actions')
	}
	
	if(rlang::is_empty(Properties))  {
		cli::cli_abort('Empty {.code Properties} will return an empty response')
	}
	
	if (!is.null(Selector) && Action != "Find") {
		cli::cli_abort('{.code Selector} only works with a Find action')
	}
	
	list(
		Action = Action,
		Properties = Properties,
		Rows = Rows,
		Selector = Selector
	) %>% 
		purrr::discard(is.null)
}
