run <- function(name) {
    payload <- paste0("Hello ", name)
    payload <- paste0("<h1>", payload, "</h1>")
    WebResult(payload = payload, cmd = "html") # html is the default return format.
}