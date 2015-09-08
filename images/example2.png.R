df <- data.frame(x = 0:10, y = 0:10)

ggplot(df) +
    geom_ribbon(aes(x = x, ymin = min(y), ymax = max(y)), fill = "#FF0000", alpha = .5)  +
    # scale_x_discrete(breaks=NULL) +
    scale_x_continuous(limits=c(0, 10), expand = c(0, 0), breaks = NULL) +
    scale_y_continuous(limits=c(0, 10), expand = c(0, 0), breaks = NULL)
    