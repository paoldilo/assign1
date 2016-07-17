
library(shiny)


shinyUI(
     fluidPage(theme = "bootstrap.css",
          titlePanel("Clairvoyant Word Prediction"),
          navbarPage("Menu Bar",
          tabPanel("Predict",
               mainPanel(
                    strong("Instructions: "),
                    p("Insert a sentence or part of a sentence the the text field and press the Predict button."),
                    p("The word with the highest probability will be shown in the field below together with the part of the dictionary the decision was made from."),
                    p("Please wait a few seconds for the dictionary to load..."),
                    img(src = "./crystal.jpg", height = 82, width = 154,align ="right"),
                    textInput("frase", label = h3("Enter Sentence:",align = "center"), value = "",width='100%'),
                    actionButton("do", "Predict Next Word"),
                    hr(),
                    h4("Predicted Sentence", align = "center"),
                    verbatimTextOutput("predizione"),
                    h4("Prediction dictionary with associated probability Values", align = "center"),
                    dataTableOutput("tabella")
               )
          ),
          tabPanel("About",
                  h4("This Shiny App was developed by:"),
                  br(),
                  strong("P. Di Lorenzo, Rome, Italy", align="center"),
                  br(),
                  br(),
                  h4("As part of the final capstone of the Data Science Coursera Specializations." ),
                  h4("You can find the pitch for this application here on Rpubs:"),
                  hr(),
                  a(href="http://rpubs.com/paoldilo/clairvoyant", "Rpubs Pitch for this App"),
                  hr(),
                  h4("Thank you for your time!"),
                  img(src = "./smile.gif", height = 90, width = 130,align ="left")
          ))
          )
     )
#)

