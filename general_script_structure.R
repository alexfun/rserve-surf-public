func1 <- function(...){
    # do calculations here for main run() block   
}

func2 <- function(...){
    # some different batch of calculations    
}

# main run block

run <- function(arg1, arg2, ...){
    # load stuff locally
    library(RPostgreSQL) 
    
    # process inputs
    arg1 <- as.numeric(arg1)
    arg2 <- as.Date(arg2)
    # etc
    # end process inputs
    
    # do clever stuff to produce output
    payload <- func1(arg1) + func2(arg2)
    
    # now return payload using appropriate WebResult
    WebResult(payload = payload, cmd = ..., 
              content.type = ...)
    
}