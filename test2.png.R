

run <- function(RGB, text_colour){

    # process inputs
    RGB <- paste0("#", RGB)   
    
    
    #print(col2rgb(RGB))
    text_colour = paste0("#", text_colour)
    # print(col2rgb(text_colour))
    
    
    # end process of inputs
    
    df <- data.frame(X = 0:10, Y = 0:10 * 0.8)
    
    df$labelnames <- c(rep("", 5), "This is clearer", rep("", 5))
    
    p <- ggplot(df, aes(x = X, y = Y, label = labelnames)) +
        geom_rect(xmin = -Inf, xmax = Inf,   ymin = -Inf, ymax = Inf,   fill = RGB) +
        geom_text(size = 4, colour = text_colour) +
        theme(axis.line=element_blank(),axis.text.x=element_blank(),
              axis.text.y=element_blank(),axis.ticks=element_blank(),
              axis.title.x=element_blank(),
              axis.title.y=element_blank(),
              legend.position="none",
              #panel.background=element_blank(),
              panel.border=element_blank(),
              panel.grid.major=element_blank(),
              panel.grid.minor=element_blank()#,
              #plot.background=element_blank()
        )
    
    file_name <- gsub("#", "", paste0(RGB,"_",text_colour, "_", gsub("( |:)", "-", Sys.time()), ".png"))
    
    ggsave(filename = paste0("/var/FastRWeb/tmp/", file_name), plot = p, height = 2.4, width = 3, dpi = 125)
    
    
    WebResult(cmd = "tmpfile", payload = file_name, content.type = "image/png")
    
}