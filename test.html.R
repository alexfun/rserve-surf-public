
get_random_RGB <- function(){
    set.seed(Sys.time())
    R = sample(0:255, 1)
    G = sample(0:255, 1)
    B = sample(0:255, 1)
    
    
    RGB <- paste0(format(as.hexmode(R), width = 2), format(as.hexmode(G), width = 2), format(as.hexmode(B), width = 2))
    
    return(RGB)
}

write_results_to_database <- function(choice){
    # convert choice into R, G, B and text_colour
    R <- as.integer(as.hexmode(substr(choice, 1, 2)))
    G <- as.integer(as.hexmode(substr(choice, 3, 4)))
    B <- as.integer(as.hexmode(substr(choice, 5, 6)))
    text_colour <-  as.integer(substr(choice, 7, 7))
    
    make_con_to_database()
    postgresqlExecStatement(conn,
                            'insert into colour_choice
                            (R, G, B, text_colour) 
                            VALUES ($1, $2, $3, $4)',
                            list(R, G, B, text_colour)
    )
    dbClearResult(dbListResults(conn)[[1]])
    dbDisconnect(conn)
                            
                    
    
    
    
    # this is sql script used to create table to hold this data
#     create table colour_choice
#     (
#         id SERIAL PRIMARY KEY,
#         created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
#         R integer NOT NULL,
#         G integer NOT NULL,
#         B integer NOT NULL,
#         text_colour integer NOT NULL CHECK (text_colour IN (0, 1)) -- 0 means black, 1 means white
#     );
}

run <- function(white, black, choice, ...) {
    RGB <- get_random_RGB()
    
    if(!missing(choice)) {
        # write results to database
        write_results_to_database(choice)
    }
    
    out()
    out("<form>")
    out("<title> Click the one which is easier to read </title>")
    out("Click the one which is easier to read<p>")
    oinput("white", type = "image", 
           src = paste0("http://52.26.143.29/rserve-surf/example8_ggplot2.png?", 
                        "text_colour=FFFFFF", 
                        paste0("&RGB=", RGB)
           )
    )
    
    choice1 = gsub("#", "", paste0(RGB, "1"))
    oselection("choice", text = choice1, values = choice1, sel.value = 1, size = 0, style = "display:none")
    out("</form>")
    
    out("<form>")
    oinput("black", type = "image", 
           src = paste0("http://52.26.143.29/rserve-surf/example8_ggplot2.png?", 
                        "text_colour=000000", 
                         paste0("&RGB=", RGB)
                        )
    )
    
    choice2 = gsub("#", "", paste0(RGB, "0"))
    oselection("choice", text = choice2, values = choice2, sel.value = 1, size = 0, style = "display:none")
    out("</form>")
    
    # link to train model
    out("<a href = http://52.26.143.29/rserve-surf/example10_fit_model.R>
    
    done()
}