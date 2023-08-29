ash_request <- function(
		tableName,
		Action = "Find", 
		Properties = list(Locale = "en-US"), 
		Rows = list(),
		appId = Sys.getenv("APPSHEET_APP_ID"),
		access_key = Sys.getenv("APPSHEET_APP_ACCESS_KEY")
) {
	
	req_body <- ash_req_body(Action = Action, Properties = Properties, Rows = Rows)
	
	httr2::request("https://api.appsheet.com") |>
		httr2::req_url_path_append("api") |>
		httr2::req_url_path_append("v2") |>
		httr2::req_url_path_append("apps") |>
		httr2::req_url_path_append(appId) |>
		httr2::req_url_path_append("tables") |>
		httr2::req_url_path_append(tableName) |>
		httr2::req_url_path_append("Action") |>
		httr2::req_headers(ApplicationAccessKey = access_key) |>
		httr2::req_body_json(req_body) 
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


