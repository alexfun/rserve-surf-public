run <- function(x) {
    # convert inputs
    x <- as.integer(x)
    # end convert inputs
    
    payload <- jsonlite::toJSON(list(result = x^2),
                                auto_unbox = TRUE)
    WebResult(payload = payload, cmd = "raw",
              content.type = "application/json") 
}