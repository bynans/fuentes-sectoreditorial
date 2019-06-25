library(shiny)
library(tidyverse)
library(DT)
library(extrafont)

fuentes <- read.csv("fuentes-info.csv", fileEncoding = 'UTF-8')

fuentes_table <- fuentes %>%
  mutate(title_link =  paste0("<a href='",link,"' target='_blank'>",titulo,"</a>")) %>%
  select(title_link, everything(), -titulo, -link)

ui <- fluidPage(
  # formatting with css
  includeCSS("styles.css"),
  
  # Application title
  
  h2(toupper("Fuentes de información del sector editorial argentino")),
  
  # Intro text
  p("Una compilación de fuentes primarias sobre la producción, circulación y venta de libros, revistas y diarios en el país"),
  
  p("Si tenés consultas sobre el listado o querés aportar fuentes para agregar, contactame a",
    a("@bynans1", href = "https://twitter.com/bynans1")),
  
  # DT table
  DTOutput("tbl"),
  
  br(),
  
  # credits
  div(p("Compilado por", a("@bynans1", href = "https://twitter.com/bynans1"), 'y la cátedra de Marketing Editorial (FFyL - UBA)'),
      p("Diseño original:", a("David Smale", href = "https://davidsmale.netlify.com/portfolio/")),
      p("Blog:", a("mcnanton.netlify.com", href = "https://mcnanton.netlify.com/")),
      p("GitHub:", a("freeR", href = "https://github.com/bynans/fuentes-sectoreditorial")),
      style="text-align: right;")
  
  
  
)



server <- function(input, output) {
  
  # render DT table
  output$tbl <- renderDT({
    
    datatable(fuentes_table,
              colnames = c('Título', 'Author/Mantenedor', 'Descripción', 'Período', 'Palabras clave'),
              rownames = FALSE,
              escape = FALSE,
              class = 'display',
              options = list(pageLength = 20,
                             lengthMenu = c(10, 20, 50))
              
    )
  })
  
}

# Run
shinyApp(ui = ui, server = server)

