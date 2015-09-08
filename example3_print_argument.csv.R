run <- function(name) {
    df = data.frame(name = name);
    file_name = paste0("example3_output_", Sys.Date(), ".csv")
    write.csv(df, paste0("/var/FastRWeb/tmp/", file_name), row.names = FALSE)
    
    # Use cmd = "tmpfile" to find file_name in the tmp directory.
    # setting content.type forces browser to download as csv.
    WebResult(payload = file_name, cmd = "tmpfile", 
              content.type = "text/csv; charset=utf-8") 
    
}