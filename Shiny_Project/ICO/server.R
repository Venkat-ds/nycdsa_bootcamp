## app.R ##
library(shinydashboard)


server <- function(input, output) {
    output$top5_1 <- renderPlotly(ggplotly
                                (g_1_1
                                )
                                )
    output$top5_2 <- renderPlotly(ggplotly
                                (g_1_2
                                )
                                )
    output$chg_prod <- renderPlotly(p_chg_prod
    )
    output$trend <- renderPlotly(
     
        ggplotly(g_trend <- ICO_Top_PROD %>%
                     filter(YEAR == input$years) %>%
                     ggplot(aes(x = TOTAL_PRODUCTION, y = DOMESTIC_CONSUMPTION)) +
            geom_point(aes(col = COUNTRY, size = TOTAL_PRODUCTION)) +
            theme_light() +
            guides(size = FALSE) +
            labs(
                title = 'TREND OVER THE YEARS (1990-2017)',
                x = 'TOTAL PRODUCTION',
                y = 'DOMESTIC CONSUMPTION'
            ) +
            theme(plot.title = element_text(size=16,
                                            face="bold", hjust = 0.5),
                  axis.title.x = element_text(size=14,
                                              face="bold"),
                  axis.title.y = element_text(size=14,
                                              face="bold"),
                  legend.title = element_text(size=14,
                                              face="bold"),
                  legend.text = element_text(size=12,
                                             face="bold"),
                  legend.key.size = unit(0.7, 'cm')))
                        
                                    )
    output$spring <- renderPlotly(ggplotly
                                (g_spring
                                )
                                )
    output$summer <- renderPlotly(ggplotly
                                (g_summer
                                )
                                )
    output$fall <- renderPlotly(ggplotly
                              (g_fall
                              )
                                )
    output$table <- renderDataTable({
        data <- ICO_1
        if (input$country != "All") {
            data <- data[data$COUNTRY == input$country,]
        }
        if (input$year != "All") {
            data <- data[data$YEAR == input$year,]
        }
        if (input$month != "All") {
            data <- data[data$MONTH == input$month,]
        }
        data
    })
}

