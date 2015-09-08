run <- function(name) {
    payload <- jsonlite::toJSON(list(name = name), auto_unbox = TRUE)
    # use cmd = raw to send your own headers, 
    # e.g. we want the browser to interpret the response as json
    WebResult(payload = payload, cmd = "raw", 
              content.type = "application/json") 
}