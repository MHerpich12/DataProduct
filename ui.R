library(shiny)

shinyUI(navbarPage("Herpich",
                   tabPanel("Application",
                            headerPanel(h2('Case-Control Study Of Esophageal Cancer (1,175 Subjects)')
                            ),
                            sidebarPanel(h2('Predictor Variables'),
                                         radioButtons("id1", "Age Profile",
                                                      c("25-34 years old" = "1",
                                                        "35-44 years old" = "2",
                                                        "45-54 years old" = "3",
                                                        "55-64 years old" = "4",
                                                        "65-74 years old" = "5",
                                                        "75+ years old" = "6"),selected=1),
                                         radioButtons("id2", "Alcohol Consumption",
                                                      c("0-39 gm/d" = "1",
                                                        "40-79 gm/d" = "2",
                                                        "80-119 gm/d" = "3",
                                                        "120+ gm/d" = "4"),selected=1),
                                         radioButtons("id3", "Tobacco Consumption",
                                                      c("0-9 gm/d" = "1",
                                                        "10-19 gm/d" = "2",
                                                        "20-29 gm/d" = "3",
                                                        "30+ gm/d" = "4"),selected=1)
                            ),
                            mainPanel(
                              h2('Model Output And Source Data'),
                              h4('Predicted chance of esophageal cancer:'),
                              verbatimTextOutput("oid1"),
                              h4('Actual percent of cases in esoph dataset:'),
                              verbatimTextOutput("oid2"),
                              plotOutput('newBar')
                            )
                   ),
                   tabPanel("Readme",
                            headerPanel(h2('About')),
                            mainPanel(h5('This application uses the R datasets package esoph to predict the prevalence of esophageal cancer based on (i) Age; (ii) Alcohol Consumption; and (iii) Tobacco use.  The esoph dataset is a case-control study of esophageal cancer in Ille-et-Vilaine, France.'),
                                      h5('The user is asked to input the classification of age, alcohol consumption, and tobacco use in radio boxes.  The inputs are then converted to appropriate factor variables and placed in the generalized linear model run on the esoph case-control dataset.  Based on user selections, the estimated prevalence of esophageal cancer in the chosen population is updated on the screen in percent form.  Additionally, the underlying case-control data is shown in barchart format so the user can compare predicted to actual results in the esoph dataset.'))
                   )
)
)