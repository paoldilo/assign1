#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(
     fluidPage(
          titlePanel("Cristal Ball"),
          sidebarLayout(
               sidebarPanel(
                    textInput("text", label = h3("Text input"), value = "Enter text..."),
                    hr(),
                    verbatimTextOutput("value"),
                    actionButton("do", "Predict")
               ),
     mainPanel(
          h3(textOutput("caption", container = span)),
          verbatimTextOutput("summary"), 
          tableOutput("view")
     )
))
)

