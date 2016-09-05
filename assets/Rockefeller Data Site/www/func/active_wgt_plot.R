make_active_weight_chart <- function(data) {
     plot_groups <- data[,1]
     plot_weights <- data[,2]
     
     f <- list(
          family = "Roboto, sans-serif",
          size = 14,
          bgcolor = c(60,141,188)
     )
     x <- list(
          title = 'Active Weight',
          titlefont = f
     )
     y <- list(
          title = "",
          titlefont = f
     )
     m = list(
          l = 150,
          r = 0,
          b = 40,
          t = 0,
          pad = 4
     )
     
     g <- plotly::plot_ly(
                    x = data[order(data[,1]),2], 
                    y = data[order(data[,1]),1],
                    type = 'bar',
                    orientation = 'h',
                    marker = list(
                       bgcolor = c(60,141,188)
                  )
          ) %>%
          plotly::layout(xaxis = x, yaxis = y, margin = m)
     g
     
}