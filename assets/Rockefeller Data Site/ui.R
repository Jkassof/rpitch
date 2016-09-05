

library(shinydashboard)
library(plotly)
library(shinyjs)

###############################################################
#                                                             #
#                  Dashboard Sidebar Area                     #
#                                                             #
#                                                             #
#                                                             #
###############################################################
load('www/data/analyst_names.rdata')
load('www/data/broker_list.rdata')


sidebar <- dashboardSidebar(
     includeCSS('www/bootstrap.css'),
     
     ######################### Sidebar User Panel ###########################
     sidebarUserPanel(
          name = "Jordan Kassof",
          subtitle = h6(
               "Data Solutions Manager",
               style = "color: #fff;
               font-family; 'Roboto', sans-serif;
               line-height: 25%"
          ),
          image = 'images/jordan.png'
          ),
     
     ####################### Sidebar Tabs ########################################
     
     
     sidebarMenu(
          id = "tabs",
          
          ###########################  Investments Tab Roll-up ####################################
          menuItem(
               "Investments",
               tabName = "pm_dash",
               icon = icon("book"),
               menuItem(
                    'Portfolio Management',
                    tabName = 'pm',
                    menuSubItem('PM Dashboard', tabName = 'pm_dash'),
                    menuSubItem('Order Entry', tabName = 'pm_order_ent'),
                    menuSubItem('Monte Carlo Simulator', tabName = 'pm_monte')
               ),
               menuItem(
                    "Portfolio Engineering",
                    tabName = "Submit",
                    menuSubItem("Daily Trading Batch", tabName = "peg_daily_batch"),
                    menuSubItem("Strategy Change Check", tabName = "peg_strat_change_check"),
                    menuSubItem("RIT-BBG Holdings Recon", tabName = "peg_rit_bbg_holding_recon"),
                    menuSubItem("RIT-BBG Attribute Recon", tabName = "peg_rit_bbg_attrib_recon")
               ),
               menuItem(
                    "Trading",
                    tabName = 'trading',
                    menuSubItem("Broker Event Submission", tabName = "trading_broker_submit"),
                    menuSubItem("Broker Event Analysis", tabName = "trading_broker_analy"),
                    menuSubItem("Broker Directed Trade Request", tabName = "trading_directed_broker")
               ),
               menuItem(
                    "Reporting",
                    tabName = 'reporting',
                    menuSubItem('Volume & Liquidity Check', tabName = 'vol_check'),
                    menuSubItem('Benchmark Busters', tabName = 'bench_bust'),
                    menuSubItem('Attribution Repotrs', tabName = 'attrib_rpts'),
                    menuSubItem('Weight Reports', tabName = 'wgt_rpts'),
                    menuSubItem('Report Packages', tabName = 'rpt_pckgs')
               )
          ),
          
          ###########################  Wealth Advisory Tab Roll-up ####################################
          
          menuItem(
               "Wealth Advisory",
               tabName = "readme",
               icon = icon("bar-chart-o"),
               menuItem('Asset Allocation', tabName = 'batch'),
               menuItem('Test1', tabName = 'strat_check'),
               menuItem('Test2', tabName = 'account_recon')
          ),
          
          ###########################  Corporate Finance Tab Roll-up ####################################
          
          menuItem(
               "Corporate Finance",
               icon = icon("calculator"),
               menuItem(
                    "Firm Dashboard",
                    tabName = "corp_fin_dash",
                    icon = icon("angle-right")
               ),
               menuItem(
                    "Spread Analysis",
                    tabName = "spread_analysis",
                    icon = icon("angle-right")
               )
          ),
          
          ###########################  Operations Tab Roll-up ####################################
          
          menuItem("Operations", tabName = "ops", icon = icon("cog")),
          
          ###########################  Marketing Tab Roll-up ####################################
          
          menuItem(
               "Marketing",
               tabName = "mkting",
               icon = icon("comments-o")
          ),
          
          ###########################  Sales Tab Roll-up ####################################
          
          menuItem(
               "Institutional Sales",
               tabName = "sales",
               icon = icon("building-o")
          ),
          
          ###########################  ISG Tab Roll-up ####################################
          
          menuItem(
               "Technology Solutions Group",
               tabName = "dsg",
               icon = icon("laptop")
          ),
          
          ###########################  DSG Tab Roll-up ####################################
          
          menuItem(
               "Data Solutions Group",
               tabName = "dsg",
               icon = icon("database")
          ),
          
          ###########################  Help Tab Roll-up ####################################
          
          menuItem(
               "Help",
               tabName = "help",
               icon = icon("question-circle")
          )
          # menuItem('', tabName = 'home', selected = T)
     )
     )
###############################################################
#                                                             #
#                  Dashboard Body Area                        #
#                                                             #
#                                                             #
#                                                             #
###############################################################

body <- dashboardBody(useShinyjs(),
                      tabItems(
                           tabItem(tabName = 'home',
                                   div(
                                        id = 'homepage',
                                        h2('Rockefeller Data Warehouse'),
                                        h4('Jordanalytics'),
                                        br(),
                                        br(),
                                        p(
                                             '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut
                                             labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris
                                             nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate
                                             velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident,
                                             sunt in culpa qui officia deserunt mollit anim id est laborum."'
                                        )
                                        
                                        )),
                           
                           #############  PM Dashboard Tab Item ##################################
                           tabItem(
                                tabName = "pm_dash",
                                fluidRow(
                                     column(
                                          width = 3,
                                          selectInput(
                                               'Strategy',
                                               inputId = 'strat_selctor',
                                               selected = 'Global',
                                               width = "100%",
                                               choices = c(
                                                    'Global',
                                                    'Global S&I',
                                                    'Libra S&I',
                                                    'Libra S&I Ex-Fossil Fuels',
                                                    'Global Div Growth',
                                                    'US',
                                                    'Non-US',
                                                    'Non-US Ex-Fossil Fuels',
                                                    'Emerking Markets',
                                                    'Nikko Gravity',
                                                    'Nikko Healthcare',
                                                    'Transamerica'
                                               )
                                          )
                                     ),
                                     column(
                                          width = 3,
                                          selectInput(
                                               'Viewpoint',
                                               inputId = 'viewpoint',
                                               selected = 'PBD',
                                               width = "100%",
                                               choices = c('PBD',
                                                           'Last Month End',
                                                           'Last Quarter End')
                                          )
                                     ),
                                     column(
                                          width = 3,
                                          radioButtons(
                                               'Return Period',
                                               inputId = 'rtn_per',
                                               selected = 'YTD',
                                               inline = T,
                                               choices = c('YTD',
                                                           'QTD',
                                                           'MTD')
                                          )
                                     ),
                                     column(
                                          width = 3,
                                          actionButton(
                                               label = 'Apply Portfolio',
                                               inputId = 'submit_port',
                                               style = "color: #fff; background-color: #3c8dbc; border-color: #2e6da4"
                                          )
                                     )
                                ),
                                br(),
                                fluidRow(
                                     # A static infoBox
                                     valueBox(
                                          subtitle = "# Stocks",
                                          h3(65, style = "color: #ffffff;"),
                                          icon = icon("book"),
                                          color = 'light-blue'
                                     ),
                                     valueBox(
                                          subtitle = "% Cash",
                                          h3(2.2, style = "color: #ffffff;"),
                                          icon = icon("dollar"),
                                          color = 'light-blue'
                                     ),
                                     valueBox(
                                          subtitle = "Active Return",
                                          h3(2.5, style = "color: #ffffff;"),
                                          icon = icon("line-chart"),
                                          color = 'light-blue'
                                     )
                                ),
                                # Dynamic infoBoxes
                                #infoBoxOutput("progressBox"),
                                #infoBoxOutput("approvalBox")
                                # A static infoBox
                                fluidRow(
                                     infoBox(
                                          "Portfolio Return",
                                          p(6.5, style = "color: #777777"),
                                          icon = icon("line-chart"),
                                          color = 'light-blue'
                                     ),
                                     infoBox(
                                          "Benchmark Return",
                                          p(4.0, style = "color: #777777"),
                                          icon = icon("line-chart"),
                                          color = 'light-blue'
                                     ),
                                     infoBox(
                                          "Tracking Error",
                                          p(3.2, style = "color: #777777"),
                                          icon = icon("bullseye"),
                                          color = 'light-blue'
                                     )
                                     
                                     # Dynamic infoBoxes
                                     #infoBoxOutput("progressBox"),
                                     #infoBoxOutput("approvalBox")
                                ),
                                fluidRow(column(
                                     width = 7,
                                     tabBox(
                                          width = '100%',
                                          title = "Weights",
                                          side = "right",
                                          # The id lets us use input$tabset1 on the server to find the current tab
                                          id = "wgts_tab_box",
                                          tabPanel(id = "sector_wgts", title = "Sector",
                                                   plotlyOutput('sec_wgts')),
                                          tabPanel(id = "geo_wgts", title = "Region",
                                                   plotlyOutput('reg_wgts'))
                                     )
                                ),
                                column(
                                     width = 5,
                                     tabBox(
                                          width = '100%',
                                          id = 'chars_tab_box',
                                          side = "right",
                                          title = "Characteristics",
                                          tabPanel(
                                               id = "port_chars",
                                               title = "Portfolio",
                                               tableOutput('port_char_tab')
                                          ),
                                          tabPanel(
                                               id = "risk_chars",
                                               title = "Risk",
                                               tableOutput('risk_char_tab')
                                          )
                                     )
                                ))
                           ),
                           
                           
                           ######################### Broker Event Submission Form Tab Item #############################
                           tabItem(
                                tabName = "trading_broker_submit",
                                
                                div(
                                     id = 'broker_submit_form',
                                     box(
                                          width = '75%',
                                          status = "primary",
                                          solidHeader = TRUE,
                                          title = "Submit Events",
                                          dateInput(
                                               'event_date',
                                               label = "Date of Event",
                                               width = '50%',
                                               startview = 'month',
                                               format = "mm/dd/yyyy"
                                          ),
                                          selectInput(
                                               'analyst_name',
                                               label = 'Analyst Name',
                                               width = '50%',
                                               choices = analy_names
                                          ),
                                          selectInput(
                                               'broker_name',
                                               label = 'Broker Name',
                                               width = '50%',
                                               choices = broker_names
                                          ),
                                          radioButtons(
                                               'event_type',
                                               label = 'Type of Event',
                                               choices = list(
                                                    'Conference Call with Analyst'     = 'Conference Call with Analyst',
                                                    'Conference Hosted by Broker'      = 'Conference Hosted by Broker',
                                                    'Meeting with Meal'                = 'Meeting with Meal',
                                                    '1:1 with management of a Company' = '1:1 with management of a Company',
                                                    'Visit to Rock & Co. Office'       = 'Visit to Rock & Co. Office',
                                                    'Visit to Company Facility'        = 'Visit to Company Facility',
                                                    'Trip Sponsored Meeting(s)'        = 'Trip Sponsored Meeting(s)',
                                                    'Entertainment'                    = 'Entertainment',
                                                    'Data Request'                    = 'Data Request'
                                               )
                                          ),
                                          br(),
                                          textInput(
                                               'desc',
                                               label = "Brief Description",
                                               value = 'Enter Description',
                                               width = '75%'
                                          ),
                                          actionButton('submit_broker_event', label = 'Submit')
                                     )
                                ),
                                
                                shinyjs::hidden(div(
                                     id = "thankyou_msg",
                                     h3("Thanks, your event was submitted successfully!"),
                                     actionLink("submit_another", "Submit another event")
                                ))
                           ),
                           
                           # ####### Broker Event Analysis ############
                           #
                           #     tabItem(tabName = "Analysis",
                           #         div(id = 'event_analysis',
                           #             # box(width = "100%", status = "info", solidHeader = TRUE, title="Broker Event Analysis",
                           #                 h1('Broker Event Analysis'),
                           #                 plotlyOutput('plot1', height = '500px'), br(), br(), br(),
                           #                 fluidRow(
                           #                 box(title = 'Table of Events by Attendee', width = 8,
                           #                     dataTableOutput('mytable1'), status = 'info', solidHeader = TRUE, collapsible = TRUE),
                           #
                           #                 box(solidHeader = TRUE, status = 'info', width = 4,
                           #                      title = 'Event Count YTD',
                           #                      h3(textOutput('count'),
                           #                     align ='center'),
                           #                     collapsible = TRUE)
                           #
                           #                  )
                           #             )),
                           tabItem(
                                tabName = "trading_directed_broker",
                                div(
                                     id = 'directed_broker_form',
                                     box(
                                          width = '100%',
                                          status = 'info',
                                          solidHeader = TRUE,
                                          title = "Directed Broker Request Form",
                                          
                                          dateInput(
                                               'directed_broker_date',
                                               label = "Date",
                                               width = '50%',
                                               startview = 'month',
                                               format = "mm/dd/yyyy"
                                          ),
                                          
                                          selectInput(
                                               'directed_broker_analyst_name',
                                               label = 'Analyst Name',
                                               width = '50%',
                                               choices = analy_names
                                          ),
                                          
                                          selectInput(
                                               'directed_broker_security_name',
                                               label = 'Security Name',
                                               width = '50%',
                                               choices = list(hey = 'hey', blah = 'blah')
                                          ),
                                          
                                          selectInput(
                                               'directed_broker_broker_name',
                                               label = 'Broker Name',
                                               width = '50%',
                                               choices = broker_names
                                          ),
                                          
                                          textInput(
                                               'directed_broker_desc',
                                               label = "Reason for Broker Direction",
                                               value = '*Type Here*',
                                               width = '75%'
                                          ),
                                          
                                          actionButton('broker_directed_submit', label = 'Submit')
                                     )
                                ),
                                shinyjs::hidden(div(
                                     id = "thankyou_msg2",
                                     h3("Thanks, your request was submitted successfully!"),
                                     actionLink("submit_another2", "Submit another request")
                                ))
                           ),
                           
                           ########################## PEG Tools ######################################
                           
                           tabItem(
                                tabName = "peg_daily_batch",
                                div(
                                     id = 'peg_daily_batch',
                                     box(
                                          width = NULL,
                                          status = "primary",
                                          solidHeader = TRUE,
                                          title = "Run Batch",
                                          p("To download today's pro-forma trading batch click below:"),
                                          downloadButton(outputId = "peg_batch_dload", label = "Daily Batch"),
                                          br(),
                                          h3('Instructions for Re-Run'),
                                          p(
                                               'Step 1: Refresh Bloomberg Formulas',
                                               a('here', href = '', style = "color: red; text-decoration: underline;")
                                          ),
                                          p(
                                               'Step 2: Update BDS Cash',
                                               a('here', href = '', style = "color: red; text-decoration: underline;")
                                          ),
                                          p('Step 3: Confirm Below & Cick Button'),
                                          checkboxInput(
                                               'peg_run_batch_confirm',
                                               "Are you sure you want to run this?",
                                               value = FALSE
                                          ),
                                          actionButton('peg_run_batch', 'Run Batch'),
                                          downloadButton('peg_rfresh_batch', 'Ad-Hoc Daily Batch')
                                     )
                                ),
                                shinyjs::hidden(div(
                                     id = "success_message",
                                     h3("Success!"),
                                     actionLink("reset", "Reset")
                                ))
                           ),
                           
                           
                           ################## Corporate Finance Dashboard Tab Item ############################
                           
                           tabItem(
                                tabName = "corp_fin_dash",
                                fluidRow(
                                     box(title = "Box title", "Box content"),
                                     box(status = "warning", "Box content")
                                ),
                                
                                fluidRow(
                                     box(title = "Box title", "Box content"),
                                     box(status = "warning", "Box content")
                                ),
                                
                                fluidRow(
                                     box(
                                          width = 4,
                                          background = "black",
                                          "A box with a solid black background"
                                     ),
                                     box(
                                          title = "Title 5",
                                          width = 4,
                                          background = "light-blue",
                                          "A box with a solid light-blue background"
                                     ),
                                     box(
                                          title = "Title 6",
                                          width = 4,
                                          background = "maroon",
                                          "A box with a solid maroon background"
                                     )
                                )
                           )
                           
                           ))


dbHeader <- dashboardHeader(
     title = a(
          href = 'http://www.rockco.com',
          'Rock DataMart',
          style = "font-family: 'Roboto';
          font-weight: 800;
          color: #ffffff;"
     )
)


dashboardPage(skin = 'blue',
              dbHeader,
              sidebar,
              body)
