library(shiny)

ui <- fluidPage(
  titlePanel("📰 Fake News Detection"),
  
  sidebarPanel(
    textAreaInput(
      "news",
      "Enter News:",
      "Scientists discovered a new technology"
    ),
    actionButton("check", "Check News")
  ),
  
  mainPanel(
    h3("Detection Result"),
    textOutput("result")
  )
)

server <- function(input, output) {
  
  output$result <- renderText({
    input$check
    
    text <- tolower(input$news)
    
    suspicious_words <- c(
      "aliens", "miracle", "secret",
      "shocking", "100% guaranteed",
      "free money"
    )
    
    found <- any(sapply(
      suspicious_words,
      function(x) grepl(x, text)
    ))
    
    if (found) {
      "⚠️ Result: POSSIBLY FAKE NEWS"
    } else {
      "✅ Result: NEWS APPEARS NORMAL"
    }
  })
}

shinyApp(ui, server)