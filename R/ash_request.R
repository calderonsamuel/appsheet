#' Appsheet request builder
#'
#' @param tableName The name of the table to perform actions on.
#' @param Action The action to be performed on the table, one of ("Find", "Add", "Delete", "Edit"). 
#' Default is "Find", which reads a table.
#' @param Properties A list of properties for the action. `ash_properties()` provides sensible defaults, but can be customized.
#' @param Rows A list of rows for the action. Default is an empty list.
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
		appId = Sys.getenv("APPSHEET_APP_ID"),
		access_key = Sys.getenv("APPSHEET_APP_ACCESS_KEY")
) {
	
	if (appId == "" || is.null(appId)) cli::cli_abort("Must provide {.code appId}")
	if (access_key == "" || is.null(appId)) cli::cli_abort("Must provide {.code access_key}")
	
	
	req_body <- ash_req_body(Action = Action, Properties = Properties, Rows = Rows)
	
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

ash_req_body <- function(Action = "Find", Properties = ash_properties(), Rows = list()) {
	
	good_actions <- c("Find", "Add", "Delete", "Edit")
	
	if(!Action %in% good_actions) {
		cli::cli_abort('{.code Action} only supports {.strong {good_actions}} actions')
	}
	
	if(rlang::is_empty(Properties))  {
		cli::cli_abort('Empty {.code Properties} will return an empty response')
	}
	
	if (!is.null(Properties$Selector) && Action != "Find") {
		cli::cli_abort('Property {.arg Selector} only works with a {.strong Find} action')
	}
	
	if (Action != "Find" && rlang::is_empty(Rows)) {
		cli::cli_abort('{.code Rows} cant be empty when {.code Action} is {Action}')
	}
	
	if ("_RowNumber" %in% names(Rows)) {
		cli::cli_abort("Can't use column {.var _RowNumber} in requests")
	}
	
	if (Action == "Add" && ("Row ID" %in% names(Rows))) {
		cli::cli_abort("Can't use column {.var Row ID} in Add actions")
	}
	
	list(
		Action = Action,
		Properties = Properties,
		Rows = Rows
	) %>% 
		purrr::discard(is.null)
}
