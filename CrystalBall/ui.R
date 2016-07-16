
library(shiny)


shinyUI(
     fluidPage(theme = "bootstrap.css",
          titlePanel("CrYstal Ball"),img(src = "./crystal.jpg", height = 82, width = 154),
          #sidebarLayout(
          #     sidebarPanel(
          #          textInput("frase", label = h3("Insert Sentence:"), value = ""),
          #          hr(),
          #          actionButton("do", "predict")
          #     ),
               mainPanel(
                    strong("Instructions: "),
                    p("Insert a sentence or part of a sentence the the text field and press the Predict button."),
                    p("The word with the highest probability will be shown in the field below together with the part of the dictionary the decision was made from."),
                    p("Please wait a few seconds for the dictionary to load..."),
                    textInput("frase", label = h3("Enter Sentence:",align = "center"), value = "",width='100%'),
                    actionButton("do", "Predict Next Word"),
                    hr(),
                    h4("Predicted Sentence", align = "center"),
                    verbatimTextOutput("predizione"),
                    h4("Prediction dictionary with associated probability Values", align = "center"),
                    dataTableOutput("tabella")
               )
          )
     )
#)

