solve_quadratic_equation <- function(a, b, c) {
    # solve for roots of equation ax^2 + bx + c = 0 if real roots exist
    qdet = b^2 - 4*a*c
    if(qdet < 0){
        payload <- list(root = NA);
    } else if(qdet ==0) {
        payload <- list(root = (b + sqrt(qdet)) / (2*a))
    } else {
        payload <- list(root = (b + sqrt(qdet)) / (2*a), root2 = (b - sqrt(qdet)) / (2*a))
    }
    return(jsonlite::toJSON(payload, auto_unbox = TRUE, na = "string" ))
}

run <- function(a, b, c) {
    # process inputs
    a <- as.numeric(a)
    b <- as.numeric(b)
    c <- as.numeric(c)
    # end process inputs
    payload <- solve_quadratic_equation(a, b, c)
    WebResult(payload = payload, cmd = "raw", content.type = "application/json") 
}