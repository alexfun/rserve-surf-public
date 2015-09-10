run <- function(hex, r, g, b, model_number = 0){
    
    
    
    # process inputs
    if(!missing(hex)) {
        # convert hex into r, g, b
        r <- as.integer(as.hexmode(substr(hex, 1, 2)))
        g <- as.integer(as.hexmode(substr(hex, 3, 4)))
        b <- as.integer(as.hexmode(substr(hex, 5, 6)))
    } else {
        r = as.integer(r)
        g = as.integer(g)
        b = as.integer(b)
    }
    model_number = as.integer(model_number)
    HEX <- paste0(format(as.hexmode(r), width = 2), format(as.hexmode(g), width = 2), format(as.hexmode(b), width = 2))
    # end process inputs
    
    
    
    # try and find model
    if(model_number != 0){
        file_list <- list.files('/var/FastRWeb/web')
        number_of_files <- length(file_list)
        file_name = paste0('/var/FastRWeb/web/model_', number_of_files)
        
        if(length(grep(paste0('model_', number_of_files), file_list)) != 1) {
            stop('Model not found or not well specified, using default')
        } else {
            load(file_name)
            
        }
    }
    
    # load in new data for prediction    
    newdf <- data.frame(r, g, b)
    text_colour <- predict(nnmodel, newdata = newdf, type = "class")
    
    if(text_colour == "1") {
        text_colour_printed = "white"
        text_colour = "FFFFFF"
    } else {
        text_colour_printed = "black"
        text_colour = "000000"
        
    }
   # now use existing ggplot to construct output 
    out(paste0("Based on your choice of R: ", r, ", G: ", g, ", B: ", b, 
               ", the optimal text colour is ", text_colour_printed, "<p>"))
    out(paste0("<img src=", paste0("http://52.27.26.223/rserve-surf/example8_ggplot2.png?", 
                        "text_colour=", text_colour,  
                        paste0("&HEX=", HEX)), ">")
    )
    
    
    
    
    
    
    
    
}