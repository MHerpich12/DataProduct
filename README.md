# DataProduct
Final Project For Data Products Class

The application consists of a server.R file (server) and ui.R file (user interface).  Both R files were constructed using the shiny 
package.  To execute, download both files and load shiny into R console (require(shiny)).  Then, execute RunApp() command.

The project is a simple prediction algorithm on R's esoph dataset.  The data is a case-control study for esophageal cancer, and the frame
has three predictors: Age, alcohol consumption, and tobacco use.  Each of the predictors is a known cause of esophageal cancer globally.

The server.R file runs a simple glm on training data using 3-fold cross validation to predict the outcome for the various potential factor inputs for the model,
sourced from the user interface.  The user interface also displays the actual data so that the user can get a sense for the prediction "error."
