get_random_HEX <- function(){
    # this function produces a random colour in HEX
    set.seed(Sys.time())
    r = sample(0:255, 1)
    g = sample(0:255, 1)
    b = sample(0:255, 1)
    
    
    HEX <- paste0(format(as.hexmode(r), width = 2), format(as.hexmode(g), width = 2), format(as.hexmode(b), width = 2))
    
    return(HEX)
}

write_results_to_database <- function(choice){
    # convert choice into r, g, b and text_colour
    r <- as.integer(as.hexmode(substr(choice, 1, 2)))
    g <- as.integer(as.hexmode(substr(choice, 3, 4)))
    b <- as.integer(as.hexmode(substr(choice, 5, 6)))
    text_colour <-  as.integer(substr(choice, 7, 7))
    
    
    # write user choice to database
    make_con_to_database()
    postgresqlExecStatement(conn,
                            'insert into colour_choice
                            (r, g, b, text_colour) 
                            VALUES ($1, $2, $3, $4)',
                            list(r, g, b, text_colour)
    )
    dbClearResult(dbListResults(conn)[[1]])
    dbDisconnect(conn)
                            
                    
    
    
    
    # this is sql script used to create table to hold this data
#     create table colour_choice
#     (
#         id SERIAL PRIMARY KEY,
#         created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
#         r integer NOT NULL,
#         g integer NOT NULL,
#         b integer NOT NULL,
#         text_colour integer NOT NULL CHECK (text_colour IN (0, 1)) -- 0 means black, 1 means white
#     );
}

run <- function(white, black, choice, ...) {
    HEX <- get_random_HEX()
    
    if(!missing(choice)) {
        # write results to database
        write_results_to_database(choice)
    }
    
    
    # use out() and done() to produce a HTML page which uses example8 t
    # return two images
    out()
    out("<form>")
    out("<title> Click the one which is easier to read </title>")
    out("Click the one which is easier to read<p>")
    oinput("white", type = "image", 
           src = paste0("http://52.27.26.223/rserve-surf/example8_ggplot2.png?", 
                        "text_colour=FFFFFF", 
                        paste0("&HEX=", HEX)
           )
    )
    
    choice1 = gsub("#", "", paste0(HEX, "1"))
    oselection("choice", text = choice1, values = choice1, sel.value = 1, size = 0, style = "display:none")
    out("</form>")
    
    out("<form>")
    oinput("black", type = "image", 
           src = paste0("http://52.27.26.223/rserve-surf/example8_ggplot2.png?", 
                        "text_colour=000000", 
                         paste0("&HEX=", HEX)
                        )
    )
    
    choice2 = gsub("#", "", paste0(HEX, "0"))
    oselection("choice", text = choice2, values = choice2, sel.value = 1, size = 0, style = "display:none")
    out("</form>")
    
    # link to train model
    out("<a href = http://52.27.26.223/rserve-surf/example9_fit_model.r>Train model!</a><p>")
    out("<a href = http://harthur.github.io/brain/>With thanks to brain.js for the idea</a>")
    
    done()
}