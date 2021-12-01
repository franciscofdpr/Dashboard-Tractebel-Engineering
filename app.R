
library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(ggthemes)
library(highcharter)
library(leaflet)
library(DT)


#### Banco de Dados ####
bd_ano = read.csv("Resultados_Ano.csv", sep = ";")
bd_campanha = read.csv("Resultados_Campanha.csv", sep = ";")
bd_Hipoteses = read.csv("Hipoteses.csv", sep = ";")
bd_Familias = read.csv("Familias.csv", sep = ";")
places_df = read.csv("places_df.csv", sep = ";")

#### CSS ####
tags$link(rel='stylesheet',type='text/css',href='custom.css')

ui= dashboardPage( 
    
    #### Menu ####
    dashboardHeader(title = "Painel Resultados"),
    dashboardSidebar(sidebarMenu(menuItem("14.2.3 - RC", tabName = "aba1", icon = icon("bar-chart-o")),
                                 menuItem("14.2.3 - Hipoteses", tabName = "aba2", icon = icon("bar-chart-o")),
                                 menuItem("14.2.3 - Mapa", tabName = "aba3", icon = icon("tag"))
                                 )
                     ),
    
    #### 14.2.3 - RC ####
    dashboardBody(tabItems(tabItem(tabName = "aba1", fluidRow(
      
      #### Box Variavel - Ano ####
      box(title = "Variavel - Ano", width = 6, status = "primary", solidHeader = TRUE,  collapsible = TRUE,
          selectInput(inputId = "Variavel_Ano",
                      label = "Selecione a variavel:",
                      choices = c("Padrao Construtivo",
                                  "Tipo de Pisos",
                                  "Tipo de Cobertura",
                                  "Localizacao Instalacao Sanitaria",
                                  "Disposicao dos Efluentes Domesticos",
                                  "Tipo de Energia",
                                  "Tipo de Acesso",
                                  "Producao Agropecuaria"))
      ),
      
      #### Box Extrato - Ano ####
      box(title = "Extrato - Ano", width = 6, status = "primary", solidHeader = TRUE,  collapsible = TRUE,
          selectInput(inputId = "Extrato_Ano",
                      label = "Selecione o extrato:",
                      choices = c("Area Rural-1",
                                  "Area Rural-2",
                                  "Area Urbana-1",
                                  "Area Urbana-2"))
      ),
      
      #### Box Grafico - Ano ####
      box(title = "Gráfico - Ano", width = 12, status = "primary",solidHeader = TRUE, collapsible = TRUE,
          tags$link(rel='stylesheet',type='text/css',href='custom.css'),
          highchartOutput("Grafico_Ano")
      ),
      
      #### Box Tabela - Ano ####
      box(title = "Tabela - Ano", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE,
          tags$link(rel='stylesheet',type='text/css',href='custom.css'),
          DT::dataTableOutput("Tabela_Ano")
      ),
      
      
      #### Box Variavel - Campanha ####
      box(title = "Variavel - Campanha", width = 6, status = "primary", solidHeader = TRUE,  collapsible = TRUE,
          selectInput(inputId = "Variavel_Campanha",
                      label = "Selecione a variavel:",
                      choices = c("Formas do Abastecimento de Agua",
                                  "Avaliacao do Abastecimento de Agua",
                                  "Destino do Lixo",
                                  "Atividade Economica Principal",
                                  "Atividade Economica Complementar",
                                  "Producao Agropecuaria",
                                  "Area Hectares por Plantio"))
      ),
      
    
      #### Box Extrato - Campanha ####
      box(title = "Extrato - Campanha", width = 6, status = "primary", solidHeader = TRUE,  collapsible = TRUE,
          selectInput(inputId = "Extrato_Campanha",
                      label = "Selecione o extrato:",
                      choices = c("Area Rural-1",
                                  "Area Rural-2",
                                  "Area Urbana-1",
                                  "Area Urbana-2"))
          ), 
      
      #### Box Grafico - Campanha ####
      box(title = "Gráfico - Campanha", width = 12, status = "primary",solidHeader = TRUE, collapsible = TRUE,
          tags$link(rel='stylesheet',type='text/css',href='custom.css'),
          highchartOutput("Grafico_Campanha")
          ),
      
      
      #### Box Tabela - Campanha ####
      box(title = "Tabela - Campanha", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE,
          tags$link(rel='stylesheet',type='text/css',href='custom.css'),
          DT::dataTableOutput("Tabela_Campanha")
          
          ),
      
      #### Box Grafico - Familias ####
      box(title = "Gráfico - Familias", width = 12, status = "primary",solidHeader = TRUE, collapsible = TRUE,
          tags$link(rel='stylesheet',type='text/css',href='custom.css'),
          highchartOutput("Grafico_Familias")
          ),
      
      #### Box Grafico - Populacao ####
      box(title = "Gráfico - Populacao", width = 12, status = "primary",solidHeader = TRUE, collapsible = TRUE,
          tags$link(rel='stylesheet',type='text/css',href='custom.css'),
          highchartOutput("Grafico_Populacao")
      )
      
      
      )),
      
      #### 14.2.3 - Hipoteses ####
      tabItem(tabName = "aba2", fluidRow(
        
        #### Box Perguntas - Hipoteses ####
        box(title = "Perguntas", width = 6,status = "primary", solidHeader = TRUE,  collapsible = TRUE,
            selectInput(inputId = "Variavel_Hipoteses",
                        label = "Selecione a Pergunta:",
                        choices = c("Aumento do n de residencias com banheiro",
                                    "Aumento do n de propriedades abastecidas por rede geral",
                                    "Destino dos efluentes domesticos rede geral ou fossa septica",
                                    "Pratica pesca",
                                    "Quantidade media diaria pescada KG",
                                    "Melhor epoca do ano para pesca",
                                    "Tipo de pesca praticada"))
        ),
        
        #### Box Extrato - Hipoteses ####
        box(title = "Extrato", width = 6,status = "primary", solidHeader = TRUE,  collapsible = TRUE,
            selectInput(inputId = "Extrato_Hipoteses",
                        label = "Selecione o extrato:",
                        choices = c("Area Rural-1",
                                    "Area Rural-2",
                                    "Area Urbana-1",
                                    "Area Urbana-2"))
        ),
        
        #### Box Gráfico - Hipoteses Linhas ####
        box(title = "Gráfico - Linhas", width = 12, status = "primary", solidHeader = TRUE,  collapsible = TRUE,
            tags$link(rel='stylesheet',type='text/css',href='custom.css'),
            highchartOutput("Grafico_Hipoteses_Linhas")
        ),
        
        
        #### Box Gráfico - Hipoteses Barras ####
        box(title = "Gráfico - Barras", width = 12, status = "primary", solidHeader = TRUE,  collapsible = TRUE,
            tags$link(rel='stylesheet',type='text/css',href='custom.css'),
            highchartOutput("Grafico_Hipoteses_Barras")
        ),
        
        
        #### Box Tabela - Hipoteses ####
        box(title = "Tabela", width = 12,status = "primary", solidHeader = TRUE,  collapsible = TRUE,
            tags$link(rel='stylesheet',type='text/css',href='custom.css'),
            DT::dataTableOutput("Tabela_Hipoteses")
        ),
        
        )),
      
      #### 14.2.3 - Mapa ####
      tabItem(tabName = "aba3",
        
        tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
        leafletOutput("MapPlot1", width = 2000, height = 2000),
        absolutePanel(top = 80, right = 50,
                      selectInput(inputId = "INDIGENA", 
                                  label ="Grupo familiar indigena", 
                                  choices=c("SIM", "NAO", "ALL"))
 
      )
      
      )
      
      )
      
    )
    
)


server= function(input, output) {
    
    #### Seleções - Ano ####
    selections_Ano = reactive({
        req(input$Variavel_Ano)
        req(input$Extrato_Ano)
        filter(bd_ano, Variavel_Ano == input$Variavel_Ano)%>%
          filter(Extrato_Ano %in% input$Extrato_Ano)
    })
  
    
    
    #### Grafico - Ano ####
    output$Grafico_Ano = renderHighchart({
      
      plotline <- list(color = "#888888", value = 2015.5, width = 2, zIndex = 5)
        
        hc <- (data = selections_Ano()) %>% 
          hchart('line',hcaes(x = Ano, y = Percentual_Ano, group = Niveis_Ano))%>%
          hc_xAxis(plotLines = list(plotline))%>%
          hc_yAxis(max = 100, title = list(text = 'Percentual'))%>%
          hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)%>%
          hc_add_annotation(
          labelOptions = list(
            backgroundColor = 'rgba(255,255,255,0.5)',
            verticalAlign = 'top',
            y = 15
          ),
          labels = list(
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 2013,
                y = 50
              ),
              text = "Pré - Enchimento"
            ),      
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 2019,
                y = 50
              ),
              text = "Pós - Enchimento"
            ))
          )
        
        })
  
    
    
    #### Tabela - Ano ####
    output$Tabela_Ano = DT::renderDataTable({
            DT::datatable(selections_Ano()[,c("Extrato_Ano","Niveis_Ano","Ano","Percentual_Ano")],
                          colnames = c("Extrato","Niveis","Ano", "Percentual"),
                          #options = list(order = list(2, 'des')),
                          rownames = FALSE,
                          )
      })
    
    

    #### Seleções - Campanha ####
    selections_Campanha = reactive({
      req(input$Variavel_Campanha)
      req(input$Extrato_Campanha)
      filter(bd_campanha, Variavel_Campanha == input$Variavel_Campanha)%>%
        filter(Extrato_Campanha %in% input$Extrato_Campanha)
    })
    
    
    
    #### Grafico - Campanha ####
    output$Grafico_Campanha = renderHighchart({
  
      plotline <- list(color = "#888888", value = 6.5, width = 2, zIndex = 5)
      
      hc <- (data = selections_Campanha()) %>% 
        hchart('line',hcaes(x = Campanha, y = Percentual_Campanha, group = Niveis_Campanha))%>%
        hc_xAxis(plotLines = list(plotline))%>%
        hc_yAxis(max = 100,  title = list(text = 'Percentual'))%>%
        hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)%>%
        hc_add_annotation(
          labelOptions = list(
            backgroundColor = 'rgba(255,255,255,0.5)',
            verticalAlign = 'top',
            y = 15
          ),
          labels = list(
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 2,
                y = 50
              ),
              text = "Pré - Enchimento"
            ),      
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 14,
                y = 50
              ),
              text = "Pós - Enchimento"
            ))
        )
      
    })
    
    
    
    #### Tabela - Campanha ####
    output$Tabela_Campanha = DT::renderDataTable({
      DT::datatable(selections_Campanha()[,c("Extrato_Campanha","Niveis_Campanha","Campanha","Percentual_Campanha")],
                    colnames = c("Extrato","Niveis","Campanha", "Percentual"),
                    #options = list(order = list(2, 'des')),
                    rownames = FALSE,
                    )
      })  
    
    
    #### Grafico - Familias####
    output$Grafico_Familias = renderHighchart({
      
      hc <- bd_Familias %>%
        hchart(
          "treemap", 
          hcaes(x = Localidades, value = Familias , color = Familias)
        )

    })
    
    
    #### Grafico - Populacao####
    output$Grafico_Populacao = renderHighchart({
      
      hc <- bd_Familias %>%
        hchart(
          "treemap", 
          hcaes(x = Localidades, value = Populacao , color = Populacao)
        )
      
    })
    
    
    #### Seleções - Hipoteses ####
    selections_Hipoteses = reactive({
      req(input$Variavel_Hipoteses)
      req(input$Extrato_Hipoteses)
      filter(bd_Hipoteses, Variavel_Hipoteses == input$Variavel_Hipoteses)%>%
        filter(Extrato_Hipoteses %in% input$Extrato_Hipoteses)
    })
    
    
    #### Grafico - Hipoteses Linhas ####
    output$Grafico_Hipoteses_Linhas = renderHighchart({
      
      plotline <- list(color = "#888888", value = 2015.5, width = 2, zIndex = 5)
      
      hc <- (data = selections_Hipoteses()) %>% 
        hchart('line',hcaes(x = Periodicidade, y = Percentual_Hipoteses, group = Niveis_Hipoteses))%>%
        hc_xAxis(plotLines = list(plotline))%>%
        hc_yAxis(max = 100, title = list(text = 'Percentual'))%>%
        hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)%>%
        hc_add_annotation(
          labelOptions = list(
            backgroundColor = 'rgba(255,255,255,0.5)',
            verticalAlign = 'top',
            y = 15
          ),
          labels = list(
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 2013,
                y = 50
              ),
              text = "Pré - Enchimento"
            ),      
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 2019,
                y = 50
              ),
              text = "Pós - Enchimento"
            ))
        )
      
    })
    
    
    
    #### Grafico - Hipoteses Barras ####
    output$Grafico_Hipoteses_Barras = renderHighchart({
      
      plotline <- list(color = "#888888", value = 2015.5, width = 2, zIndex = 5)
      
      hc <- (data = selections_Hipoteses()) %>% 
        hchart('column',hcaes(x = Periodicidade, y = Percentual_Hipoteses, group = Niveis_Hipoteses))%>%
        hc_xAxis(plotLines = list(plotline))%>%
        hc_yAxis(max = 100, title = list(text = 'Percentual'))%>%
        hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)%>%
        hc_add_annotation(
          labelOptions = list(
            backgroundColor = 'rgba(255,255,255,0.5)',
            verticalAlign = 'top',
            y = 15
          ),
          labels = list(
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 2013,
                y = 50
              ),
              text = "Pré - Enchimento"
            ),      
            list(
              point = list(
                xAxis = 0,
                yAxis = 0,
                x = 2019,
                y = 50
              ),
              text = "Pós - Enchimento"
            ))
        )
      
    })
    

    
    #### Tabela - Hipoteses ####
    output$Tabela_Hipoteses = DT::renderDataTable({
      DT::datatable(selections_Hipoteses()[,c("Extrato_Hipoteses","Niveis_Hipoteses","Periodicidade","Percentual_Hipoteses")],
                    colnames = c("Extrato","Niveis","Periodicidade", "Percentual"),
                    #options = list(order = list(2, 'des')),
                    rownames = FALSE,
                    )
      
    })
    
    #### Mapa ####
    
    filtered <- reactive({
      filter(places_df,INDIGENA == input$INDIGENA)

    })

    output$MapPlot1 <- renderLeaflet({
      
        leaflet(data =  filtered())%>% 
        setView(-51.127166, -4.299999, 10)%>%  
        addTiles()%>%
        addMarkers(popup = paste0(places_df$ID.GRUPO.FAMILIAR, "</br>", places_df$LOCALIDADES))
    
    })
    
    
    observe(
      leafletProxy("MapPlot1", data = filtered ())%>%  
        clearMarkers()%>%  
        addMarkers(popup = paste0(places_df$ID.GRUPO.FAMILIAR, "</br>", places_df$LOCALIDADES))
      )
    
    
}


shinyApp(ui = ui, server = server)

