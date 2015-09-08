run <- function(){
    # Get data from database
    make_con_to_database()   
    df <- dbGetQuery(conn, "select * from colour_choice")
    df$text_colour <- as.factor(df$text_colour)
    dbDisconnect(conn)
    
    # fit neural network
    nnmodel <- nnet(data = df, text_colour ~ r + g + b, size = 6, maxit = 1000)
    
    # save with appropriate filename
    file_list <- list.files('/var/FastRWeb/web')
    number_of_files = length(file_list)
    file_name = paste0("/var/FastRWeb/web/model_", (number_of_files + 1))
    save(nnmodel, file = file_name)
    print(paste0("Model saved to: ", file_name))
}



