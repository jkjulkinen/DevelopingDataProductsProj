library(shiny)

# Define UI for random distribution application
shinyUI(fluidPage(

    # Application title
    titlePanel("MPG in relation to weight"),
    tabsetPanel(type = "tabs",

                tabPanel("Application",

                         sidebarLayout(
                             sidebarPanel(
                                 radioButtons("dist", "Transmission type:",
                                              c("All" = "choice_all",
                                                "Manual" = "choice_man",
                                                "Automatic" = "choice_aut")),
                                 br(),

                                 sliderInput("minwt",
                                             "Min weight:",
                                             value = 1,
                                             min = 1,
                                             max = 6),
                                 br(),
                                 sliderInput("maxwt",
                                             "Max weight:",
                                             value = 6,
                                             min = 1,
                                             max = 6)
                             ),

                             mainPanel(
                                 plotOutput("plot")
                                 ,tableOutput("results")
                             )

                         )
                ),
                tabPanel("Documentation", #tableOutput("table")

                         br(),
                         HTML("Welcome!<BR><BR>
The purpose of this application is to help you get information of
how much MPG variates from expected value calculated from other cars
in the same weight interval. That expectation will be shown as a line,
basically showing how MPG goes down when cars become heavier.
<BR><BR>
How the cars actual MPG variates from that expected value is shown on a list,
with the model name, MPG, value for that variation from expected value, and the cars weight.
<BR><BR>
You will see a plot, with the different models and the variation too.
<BR><BR>
Manual cars are plotted with red colour, and automatic cars are plotted with blue colour.
<BR><BR>
With the radio buttons you can choose which types of transmissions you are interested in.
<BR><BR>
With the sliders you can choose the minimum and maximum weight of your prefferred cars.
<BR><BR>
The expected MPG will be recalculated for that weight interval.
<BR><BR>
<a href=\"https://github.com/jkjulkinen/DevelopingDataProductsProj\">See the repo at Github</a>
                                  "
                         )


                )
    )
)
)



# Define UI for random distribution application
# shinyUI(fluidPage(
#
#
#     titlePanel("MPG in relation to weight"),
#
#     sidebarLayout(
#         sidebarPanel(
#             radioButtons("dist", "Transmission type:",
#                          c("All" = "choice_all",
#                            "Manual" = "choice_man",
#                            "Automatic" = "choice_aut")),
#             br(),
#
#             sliderInput("minwt",
#                         "Min weight:",
#                         value = 1,
#                         min = 1,
#                         max = 6),
#             br(),
#             sliderInput("maxwt",
#                         "Max weight:",
#                         value = 6,
#                         min = 1,
#                         max = 6)
#         ),
#
#         mainPanel(
#             plotOutput("plot")
#             ,tableOutput("results")
#         )
#     )
# )
# )
