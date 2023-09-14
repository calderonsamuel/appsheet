## Resubmission

This is a resubmission. In this version I have:

* Fixed the error in CRAN check for failing tests

## R CMD check results

0 errors | 0 warnings | 1 note

* This is a new release.
* There are no references describing the methods in this package.
* urlchecker::url_check() flags 3 links on Google's support pages. They don't work with curl -I -L <link>, but they work in browsers. What happens is that the support page redirects to the browser's language version of the page. I didn't remove those links because there is no other way to point to the official documentation of the service.
