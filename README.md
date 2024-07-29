# README - Painel de Resultados - Aplicação Shiny

Este é um aplicativo Shiny que visualiza dados de diferentes categorias, apresentando gráficos, tabelas e mapas interativos. Abaixo está uma explicação detalhada sobre os componentes do aplicativo e como ele funciona.

### Dependências

O aplicativo depende das seguintes bibliotecas R:

- `shiny`
- `shinydashboard`
- `dplyr`
- `readr`
- `ggthemes`
- `highcharter`
- `leaflet`
- `DT`

### Estrutura do Código

#### Banco de Dados

Os dados são carregados a partir de arquivos CSV:

```R
bd_ano = read.csv("Resultados_Ano.csv", sep = ";")
bd_campanha = read.csv("Resultados_Campanha.csv", sep = ";")
bd_Hipoteses = read.csv("Hipoteses.csv", sep = ";")
bd_Familias = read.csv("Familias.csv", sep = ";")
places_df = read.csv("places_df.csv", sep = ";")
```

#### CSS Customizado

Adiciona um arquivo CSS customizado:

```R
tags$link(rel='stylesheet',type='text/css',href='custom.css')
```

#### Interface do Usuário (UI)

A interface do usuário é definida usando `shinydashboard`:

```R
ui= dashboardPage( 
    dashboardHeader(title = "Painel Resultados"),
    dashboardSidebar(sidebarMenu(
        menuItem("14.2.3 - RC", tabName = "aba1", icon = icon("bar-chart-o")),
        menuItem("14.2.3 - Hipoteses", tabName = "aba2", icon = icon("bar-chart-o")),
        menuItem("14.2.3 - Mapa", tabName = "aba3", icon = icon("tag"))
    )),
    dashboardBody(
        tabItems(
            # Aba 14.2.3 - RC
            tabItem(tabName = "aba1", fluidRow(
                box(title = "Variavel - Ano", width = 6, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                    selectInput(inputId = "Variavel_Ano", label = "Selecione a variavel:", choices = c("Padrao Construtivo", "Tipo de Pisos", "Tipo de Cobertura", "Localizacao Instalacao Sanitaria", "Disposicao dos Efluentes Domesticos", "Tipo de Energia", "Tipo de Acesso", "Producao Agropecuaria"))
                ),
                box(title = "Extrato - Ano", width = 6, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                    selectInput(inputId = "Extrato_Ano", label = "Selecione o extrato:", choices = c("Area Rural-1", "Area Rural-2", "Area Urbana-1", "Area Urbana-2"))
                ),
                box(title = "Gráfico - Ano", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, highchartOutput("Grafico_Ano")),
                box(title = "Tabela - Ano", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, DT::dataTableOutput("Tabela_Ano")),
                box(title = "Variavel - Campanha", width = 6, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                    selectInput(inputId = "Variavel_Campanha", label = "Selecione a variavel:", choices = c("Formas do Abastecimento de Agua", "Avaliacao do Abastecimento de Agua", "Destino do Lixo", "Atividade Economica Principal", "Atividade Economica Complementar", "Producao Agropecuaria", "Area Hectares por Plantio"))
                ),
                box(title = "Extrato - Campanha", width = 6, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                    selectInput(inputId = "Extrato_Campanha", label = "Selecione o extrato:", choices = c("Area Rural-1", "Area Rural-2", "Area Urbana-1", "Area Urbana-2"))
                ), 
                box(title = "Gráfico - Campanha", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, highchartOutput("Grafico_Campanha")),
                box(title = "Tabela - Campanha", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, DT::dataTableOutput("Tabela_Campanha")),
                box(title = "Gráfico - Familias", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, highchartOutput("Grafico_Familias")),
                box(title = "Gráfico - Populacao", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, highchartOutput("Grafico_Populacao"))
            )),
            # Aba 14.2.3 - Hipoteses
            tabItem(tabName = "aba2", fluidRow(
                box(title = "Perguntas", width = 6, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                    selectInput(inputId = "Variavel_Hipoteses", label = "Selecione a Pergunta:", choices = c("Aumento do n de residencias com banheiro", "Aumento do n de propriedades abastecidas por rede geral", "Destino dos efluentes domesticos rede geral ou fossa septica", "Pratica pesca", "Quantidade media diaria pescada KG", "Melhor epoca do ano para pesca", "Tipo de pesca praticada"))
                ),
                box(title = "Extrato", width = 6, status = "primary", solidHeader = TRUE, collapsible = TRUE,
                    selectInput(inputId = "Extrato_Hipoteses", label = "Selecione o extrato:", choices = c("Area Rural-1", "Area Rural-2", "Area Urbana-1", "Area Urbana-2"))
                ),
                box(title = "Gráfico - Linhas", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, highchartOutput("Grafico_Hipoteses_Linhas")),
                box(title = "Gráfico - Barras", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, highchartOutput("Grafico_Hipoteses_Barras")),
                box(title = "Tabela", width = 12, status = "primary", solidHeader = TRUE, collapsible = TRUE, DT::dataTableOutput("Tabela_Hipoteses"))
            )),
            # Aba 14.2.3 - Mapa
            tabItem(tabName = "aba3",
                tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
                leafletOutput("MapPlot1", width = 2000, height = 2000),
                absolutePanel(top = 80, right = 50,
                    selectInput(inputId = "INDIGENA", label = "Grupo familiar indigena", choices = c("SIM", "NAO", "ALL"))
                )
            )
        )
    )
)
```

#### Servidor (Server)

O servidor define a lógica de processamento e renderização dos dados:

```R
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
                )
              )
          )
    })
    
    #### Tabela - Ano ####
    output$Tabela_Ano = DT::renderDataTable({
        DT::datatable(selections_Ano()[,c("Extrato_Ano","Niveis_Ano","Ano","Percentual_Ano")],
                      colnames = c("Extrato","Niveis","Ano", "Percentual"),
                      rownames = FALSE
                      )
    })
    
    #### Sele

ções - Campanha ####
    selections_Campanha = reactive({
        req(input$Variavel_Campanha)
        req(input$Extrato_Campanha)
        filter(bd_campanha, Variavel_Campanha == input$Variavel_Campanha)%>%
          filter(Extrato_Campanha %in% input$Extrato_Campanha)
    })
    
    #### Grafico - Campanha ####
    output$Grafico_Campanha = renderHighchart({
        plotline <- list(color = "#888888", value = 2015.5, width = 2, zIndex = 5)
        hc <- (data = selections_Campanha()) %>% 
          hchart('line',hcaes(x = Ano, y = Percentual_Campanha, group = Niveis_Campanha))%>%
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
                )
              )
          )
    })
    
    #### Tabela - Campanha ####
    output$Tabela_Campanha = DT::renderDataTable({
        DT::datatable(selections_Campanha()[,c("Extrato_Campanha","Niveis_Campanha","Ano","Percentual_Campanha")],
                      colnames = c("Extrato","Niveis","Ano", "Percentual"),
                      rownames = FALSE
                      )
    })
    
    #### Grafico - Familias ####
    output$Grafico_Familias = renderHighchart({
        hc <- bd_Familias %>% 
          hchart('column',hcaes(x = Ano, y = Total, group = Estado))%>%
          hc_xAxis()%>%
          hc_yAxis(max = 1000, title = list(text = 'Total'))%>%
          hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)
    })
    
    #### Grafico - Populacao ####
    output$Grafico_Populacao = renderHighchart({
        hc <- bd_Familias %>% 
          hchart('column',hcaes(x = Ano, y = Populacao, group = Estado))%>%
          hc_xAxis()%>%
          hc_yAxis(max = 10000, title = list(text = 'Populacao'))%>%
          hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)
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
        hc <- (data = selections_Hipoteses()) %>% 
          hchart('line',hcaes(x = Ano, y = Percentual_Hipoteses, group = Niveis_Hipoteses))%>%
          hc_xAxis()%>%
          hc_yAxis(max = 100, title = list(text = 'Percentual'))%>%
          hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)
    })
    
    #### Grafico - Hipoteses Barras ####
    output$Grafico_Hipoteses_Barras = renderHighchart({
        hc <- (data = selections_Hipoteses()) %>% 
          hchart('column',hcaes(x = Ano, y = Percentual_Hipoteses, group = Niveis_Hipoteses))%>%
          hc_xAxis()%>%
          hc_yAxis(max = 100, title = list(text = 'Percentual'))%>%
          hc_exporting(enabled = TRUE, sourceWidth = 900, sourceHeight = 580)
    })
    
    #### Tabela - Hipoteses ####
    output$Tabela_Hipoteses = DT::renderDataTable({
        DT::datatable(selections_Hipoteses()[,c("Extrato_Hipoteses","Niveis_Hipoteses","Ano","Percentual_Hipoteses")],
                      colnames = c("Extrato","Niveis","Ano", "Percentual"),
                      rownames = FALSE
                      )
    })
    
    #### Mapa ####
    output$MapPlot1 = renderLeaflet({
        leaflet(places_df) %>%
        addTiles() %>%
        addMarkers(~lon, ~lat, popup = ~as.character(geo), label = ~as.character(geo))
    })
}
shinyApp(ui = ui, server = server)
```

### Instruções de Execução

1. **Instale as dependências**: Certifique-se de que todas as bibliotecas listadas na seção de dependências estão instaladas.
2. **Prepare os dados**: Coloque os arquivos CSV na mesma pasta do script do Shiny.
3. **Execute o aplicativo**: Use o comando `shiny::runApp()` no RStudio ou `Rscript` para executar o script diretamente.

### Personalizações

1. **CSS Customizado**: Adapte o arquivo `custom.css` para estilizar a interface do usuário conforme suas preferências.
2. **Componentes Adicionais**: Adicione novas abas, gráficos, tabelas ou qualquer outro componente desejado na interface do usuário.

### Dicas

- **Validação de Dados**: Verifique a integridade dos dados antes de carregá-los no aplicativo.
- **Escalabilidade**: Considere otimizar o desempenho ao lidar com grandes volumes de dados.

Aproveite seu painel de resultados interativo!
