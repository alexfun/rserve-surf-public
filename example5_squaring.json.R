run <- function(x) {
    payload <- x^2
    WebResult(payload = payload, cmd = "raw", 
              content.type = "application/json") 
}