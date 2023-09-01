#' Build the properties of an Appsheet request
#' 
#' This function exist to provide auto completion. Still, it is 
#' likely that users will need to visit the [official documentation](https://support.google.com/appsheet/answer/10105398?hl=en&ref_topic=10105767&sjid=10290494026986339725-SA)
#' for further customization.
#' 
#' Any NULL will be internally dropped before performing the request.
#'
#' @param Locale Locale of the client making the request. 
#' For example, en-US indicates English, United States. 
#' If this value is not specified, Locale defaults to en-US. \cr
#' The Locale is used when validating Date, DateTime, Decimal, Percent, Price, and Time data values. 
#' For example, when Locale is en-US, date values must be entered in MM/DD/YYYY format; 
#' when Locale is en-GB, date values must be entered in DD/MM/YYYY format.
#' @param Location Latitude and longitude of the client making the request.
#' If not specified, Location defaults to 0.000000, 0.000000.
#' @param RunAsUserEmail User email address of the person taking the action. 
#' The action is performed under the user email address you specify. 
#' If this value is not specified, the action is performed under the user email address 
#' of the application owner.
#' @param Timezone Timezone of the client making the request.
#' @param UserSettings User setting to be used when performing the action. 
#' If not specified, no user settings are used.
#' @param Selector Expression to select and format the rows returned. 
#' Only valid when Action is "Find".
#' @param ... Placeholder for future properties to be introduced in the API.
#'
#' @return A list of properties
#' @export
#'
#' @examples 
#' ash_properties()
#' ash_properties(Locale = "en-GB")
ash_properties <- function(
		Locale = "en-US",
		Location = NULL,
		RunAsUserEmail = NULL,
		Timezone = NULL,
		UserSettings = NULL,
		Selector = NULL,
		...
) {
	list(
		Locale = Locale,
		Location = Location,
		RunAsUserEmail = RunAsUserEmail,
		Timezone = Timezone,
		UserSettings = UserSettings,
		Selector = Selector,
		...
	) %>%
		purrr::discard(is.null)
}
