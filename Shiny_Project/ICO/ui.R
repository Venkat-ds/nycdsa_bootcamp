## ui.R ##
library(shinydashboard)



dashboardPage(
    dashboardHeader(title = 'ICO - Coffee Stats'),
    
    dashboardSidebar(
        sidebarUserPanel('Venkata Vemanedi'),
        sidebarMenu(
            menuItem("Coffee Crop", tabName = "home", icon = icon("info")),
            menuItem(" World's Top 5", tabName = "top_5", icon = icon("chart-bar")),
            menuItem(" % Change in Prod", tabName = "chg_prod", icon = icon("chart-line")),
            menuItem(" Trend Over Years", tabName = "trend", icon = icon("chart-bar")),
            menuItem(" Crop by Seasons", tabName = "corr", icon = icon("chart-line")),
            menuItem("Data", tabName = "data", icon = icon("database")))
    ),
    
    dashboardBody(
        tabItems(
            # First Tab
            tabItem(tabName = "home",
                    h1("International Coffee Organization (ICO) Coffee Production & Consumption")
                    ,img(src="1.JPG",  width="88%"),
                    fluidRow(box(tags$h5(tags$b('This is a historical dataset summarising annual reports 
                                  gathered by International Coffee Organisation for 56 member 
                                  state countries from 1990 to 2017. ICO is the main 
                                  intergovernmental organisation for coffee market, representing 
                                  almost entire coffee production market and two-thirds of 
                                  coffee consumption.')), width = 100))
                ),
            # Second Tab
            tabItem(tabName = "top_5",
                    fluidRow(
                        box(plotlyOutput("top5_1", height = 500)),
                        box(plotlyOutput("top5_2", height = 500))),
                        fluidRow(box(tags$h5(tags$b("The above graphs depict the Domestic Consumption and Total Production
                                       of the 'Top 5' countries in the recent years. Brazil is the leading 
                                       country in both production and consumption of the coffee crop. 
                                       Vietnam is the next big producer of the crop after Brazil.")),
                            width = 100)
                        )),
            # Third Tab
            tabItem(tabName = "chg_prod",
                    fluidRow(
                        box(plotlyOutput("chg_prod", height = 500, width = 1150))
                    ),
                    fluidRow(
                        box(tags$h5(tags$b("The above graph shows the percentage changes in the 'Total Production'
                                       of the crop in the member countries whose median total production 
                                       greater than 3 million bags per year in recent years which helps in 
                                       identifying the emerging markets.")),
                            tags$h5(tags$b('Based on the oberservation of the above graph:')),
                            tags$h5(tags$b('- Vietnam and India are identified as the 
                                           emerging crop markets with a percentage increase of 
                                           15% and 12% respectively.')),
                            width = 500)
                    )),
            # Fourth Tab
            tabItem(tabName = "trend",
                    fluidRow(
                        box(plotlyOutput('trend', height = 450, width = 1150))
                        ),
                    fluidRow(
                        box(sliderInput("years", " Year",
                                        min = 1990, max = 2017,
                                        value = 1990, step = 1,
                                        animate = TRUE)),
                        box(tags$h5(tags$b('The graph shows the trend of Production and Consumption 
                                       of the member countries over the years 1990 to 2017, 
                                       which had a median total production greater than 3 million
                                       bags per year since 1990.')))
                        )
                    ),
            # Fifth Tab
            tabItem(tabName = "corr",
                    fluidRow(
                        box(plotlyOutput("spring", height = 350)),
                        box(plotlyOutput("summer", height = 350)),
                        box(plotlyOutput("fall", height = 350)),
                        box(tags$h5(tags$b('Correlation for Spring (April) group of countries:  0.9852523')),
                            tags$h5(tags$b('Correlation for Summer (July) group of countries:  0.06980663')),
                            tags$h5(tags$b('Correlation for Fall (October) group of countries:  0.5823859')))
                    )
                    ),
            # Sixth Tab
            tabItem(tabName = "data",
                    fluidPage(
                        titlePanel("Basic DataTable"),

                        # Create a new Row in the UI for selectInputs
                        fluidRow(
                            column(4,
                                   selectInput("country",
                                               "Country:",
                                               c("All",
                                                 unique(as.character(ICO_1$COUNTRY))))
                            ),
                            column(4,
                                   selectInput("year",
                                               "Year:",
                                               c("All",
                                                 unique(as.character(ICO_1$YEAR))))
                            ),
                            column(4,
                                   selectInput("month",
                                               "Month:",
                                               c("All",
                                                 unique(as.character(ICO_1$MONTH))))
                            )
                        ),
                        # Create a new row for the table.
                        DTOutput("table"),
                        tags$h4(tags$b('Content')),
                        tags$h5(tags$b('This dataset summarises four annual reports submitted by 
                                   the Member states of ICO from 1990 to 2017. By the end of 
                                   each crop year, a member state reports on Total Production,
                                   Domestic Consumption, Exportable production and 
                                   Gross Opening Stocks. The values represent thousand 60 kg bags
                                   of green coffee.')),
                        tags$h5(tags$b('The columns in this dataset represent:')),
                        tags$h5(tags$b('1. COUNTRY - Member state of ICO; there are 56 countries in this dataset')),
                        tags$h5(tags$b('2. YEAR - Crop year for which the data was collected')),
                        tags$h5(tags$b('3. MONTH - Month of crop harvest')),
                        tags$h5(tags$b('4. TOTAL_PRODUCTION - total coffee production in a member state per year')),
                        tags$h5(tags$b('5. DOMESTIC_CONSUMPTION - coffee consumption in a member state per year')),
                        tags$h5(tags$b('6. PCT_CONSUMPTION - percent of coffee consumed in a member state per year'))
                    )
                    )
        )   
    )
)
