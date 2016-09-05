#-------------------------------------------------------------------------
#  This application is governed by the CeCILL-B license. 
#  You can  use, modify and/ or redistribute this code under the terms
#  of the CeCILL license:  http://www.cecill.info/index.en.html
#
#  Marc Lavielle, Inria Saclay
#  May 11th, 2015
#-------------------------------------------------------------------------


library(shinydashboard); library(dplyr); library(plotly); library(shinyjs)
source('www/func/active_wgt_plot.R'); 
reg_tab <- read.csv('www/data/reg_wgts.csv'); sec_tab <- read.csv('www/data/sec_wgts.csv')
port_char_tab <- read.csv('www/data/risk_char_tab.csv'); risk_char_tab <- read.csv('www/data/port_char_tab.csv')
shinyServer(function(input, output, session){
    
     ###### Reactive Functions that make active weight plots on pm dashboard 
     output$reg_wgts <- renderPlotly({
           make_active_weight_chart(reg_tab)
          # style the xaxis
     })
      output$sec_wgts <- renderPlotly({
           make_active_weight_chart(sec_tab)
      })

      output$port_char_tab <- renderTable({
           port_char_tab
      }, include.rownames = FALSE, align = 'cccc')
      
      output$risk_char_tab <- renderTable({
           risk_char_tab
      }, include.rownames = FALSE, align = 'cccc')
      
      output$plotly_gantt <- renderPlotly({
           source('www/func/gantt_maker.R')
      })
      
      
#   
#      record <-   xlsx::read.xlsx('/Users/Jordan/Downloads/rock data site/Event Record 2016 - jordan testing - dont use.xlsx', sheetIndex = 1)
#      output$count <- renderPrint(
#           nrow(record))
#      
#      
#      count_by_analyst <- tbl_df(record) %>%
#           group_by(Analyst, Broker) %>%
#           summarize(Counts = n())
#      
#      output$mytable1 <- renderDataTable({count_by_analyst})
#      
#      by_analy_broker <- record %>%
#                          group_by(Analyst,Broker) %>%
#                          summarise(Count = n())
#           
#      
#      output$plot1 <- renderPlotly({
#           ggplotly(
#                ggplot(by_analy_broker, 
#                       aes(x=Broker,y=Count,fill=Analyst)) + 
#                     geom_bar(stat = 'identity') + 
#                     xlab(' ') +
#                     theme(axis.text.x = element_text(angle = 50, size = 10)) +
#                     theme(legend.position='none'))
#      })
# 
#   
#  
# Function That Forms Users Inputs into New Record
  # fieldsAll <- c("event_date", "analyst_name", "broker_name", "event_type", "desc")
  # formData <- reactive({
  #   data <- sapply(fieldsAll, function(x) ifelse(grepl(x, pattern = '*date'),
  #                                                 as.character(input[[x]]),
  #                                                 input[[x]]))
  #   data <- t(data)
  #   data
  # })
  # 
  # fieldsAll2 <- c('directed_broker_date', 'directed_broker_analyst_name','directed_broker_security_name',
  #                 'directed_broker_broker_name','directed_broker_desc')
  # formData2 <- reactive({
  #   data <- sapply(fieldsAll2, function(x) ifelse(grepl(x, pattern = '*date'),
  #                                                 format(as.character(input[[x]], '%m/%d/%Y')),
  #                                                 input[[x]]))
  #   data <- t(data)
  #   data
  # })
#   # Function That Saves a New Broker Event Record
#   saveData <- function(data) {
#      
#      XLConnect::writeWorksheetToFile(file = 'P:/Jordan_Kassof/My Documents/Projects/test  site/Event Record 2016 - jordan testing - dont use.xlsx',
#                                  data = data,
#                                  sheet = 'Sheet1',
#                                  startRow = nrow(xlsx::read.xlsx('P:/Jordan_Kassof/My Documents/Projects/test  site/Event Record 2016 - jordan testing - dont use.xlsx', sheetIndex = 1)) + 2,
#                                  header = FALSE)
# 
# 
#   }
#   
#   saveData2 <- function(data) {
#     
#     XLConnect::writeWorksheetToFile(file = 'Q:/Investments/INVSHARE/Broker Directed Record/Directed_Broker_Record.xlsx',
#                                     data = data,
#                                     sheet = 'Sheet1',
#                                     startRow = nrow(xlsx::read.xlsx('Q:/Investments/INVSHARE/Broker Directed Record/Directed_Broker_Record.xlsx', sheetIndex = 1)) + 2,
#                                     header = FALSE)
#     
#     
#   }
#   
#  ############ Broker Event Buttons ######################################## 

 # Action from Clicking Submit Button
  observeEvent(input$submit_broker_event, {
     #  saveData(formData())
       shinyjs::reset('broker_submit_form')
       shinyjs::hide('broker_submit_form')
       shinyjs::show("thankyou_msg")

    #   record <-   xlsx::read.xlsx('P:/Jordan_Kassof/My Documents/Projects/test  site/Event Record 2016 - jordan testing - dont use.xlsx', sheetIndex = 1)
     #  output$count <- renderPrint(
      #      nrow(record))


  #      count_by_broker <- tbl_df(record) %>%
  #           group_by(Broker) %>%
  #           summarize(Counts = n())
  # 
  #      output$mytable1 <- renderDataTable({count_by_broker})
  # 
  #      by_analy_broker <- summarise(
  #           group_by(
  #                record, Broker, Analyst),
  #           Count = n())
  # 
  #      output$plot1 <- renderPlotly({
  #           ggplotly(
  #                ggplot(by_analy_broker,
  #                       aes(x=Broker,y=Count,fill=Analyst)) +
  #                     geom_bar(stat = 'identity'))
  #      })
  # 
  })
  # # Action from Clicking Submit Another Button
  observeEvent(input$submit_another, {
       shinyjs::reset("broker_submit_form")
       shinyjs::show("broker_submit_form")
       shinyjs::hide("thankyou_msg")
       })

  # observe({
  #      if(input$selectall == 0) return(NULL)
  #      else if (input$selectall%%2 == 0)
  #      {
  #           updateCheckboxGroupInput(session,"broker_filter","Broker Chart Filter",choices=broker_names, selected = NULL)
  #           updateCheckboxGroupInput(session,"broker_cats","Broker Chart Filter",choices=broker_categories, selected = NULL)
  #      }
  #      else
  #      {
  #           updateCheckboxGroupInput(session,"broker_filter","Broker Chart Filter",choices=broker_names,selected=names(broker_names))
  #           updateCheckboxGroupInput(session,"broker_cats","Broker Chart Filter",choices=broker_categories,selected=names(broker_categories))
  #      }
  # })

############## Directed Broker Buttons ##########################

  observeEvent(input$broker_directed_submit, {
   # saveData2(formData2())
    shinyjs::reset('directed_broker_form')
    shinyjs::hide('directed_broker_form')
    shinyjs::show('thankyou_msg2')
  })

  observeEvent(input$submit_another2, {
    shinyjs::show('directed_broker_form')
    shinyjs::hide('thankyou_msg2')
  })

 ############ PEG Tools Buttons #####################################################

 # Action from clicking various peg tool submission buttons
  observeEvent(input$peg_run_batch, {
       shinyjs::show("success_message")
  })
  observe({
    shinyjs::toggleState(id = 'peg_run_batch',    condition = input$peg_run_batch_confirm == TRUE)
    shinyjs::toggleState(id = 'peg_rfresh_batch', condition = input$peg_run_batch)
  })

 # 
 #  observeEvent(input$strat_check, {
 #       shinyjs::show("success_message2")
 #  })
 #  observe({
 #    shinyjs::toggleState(id = 'strat_check', condition = input$strat_check_confirm == TRUE)
 #  })
 # 
 # 
 #  observeEvent(input$account_recon, {
 #    source("BBG_Recon.R")
 #    bbgrecon()
 #    shinyjs::show("success_message3")
 #  })
 #  observe({
 #  shinyjs::toggleState(id = 'account_recon', condition = input$account_recon_confirm == TRUE)
 #  })
 #  # Action from reset of submission confirmation message on peg tools
 # 
   observeEvent(input$reset, {
       shinyjs::hide("success_message")
       shinyjs::toggleState(id = 'peg_run_batch')
       updateCheckboxInput(session, inputId = 'peg_run_batch_confirm', value = FALSE)
       shinyjs::toggleState(id = 'peg_rfresh_batch')
       
  })
   observeEvent(input$reset2, {
        shinyjs::hide("success_message2")
   })
   observeEvent(input$reset3, {
        shinyjs::hide("success_message3")
   })
 # 
 # 

  })