##Load packages
library(shiny)
library(datasets)
library(caret)
library(swirl)

##Prune data
data(esoph)
esoph$agegp <- unclass(esoph$agegp)
esoph$alcgp <- unclass(esoph$alcgp)
esoph$tobgp <- unclass(esoph$tobgp)
esoph <- cbind(esoph,esoph$ncases/(esoph$ncases+esoph$ncontrols))
names(esoph)[6] <- "Pospercent"

##Train GLM
set.seed(1000)
inTrain <- createDataPartition(y=esoph$Pospercent,p=0.9,list=FALSE)
Training <- esoph[inTrain,]
Testing <- esoph[-inTrain,]
fitControl <- trainControl(method="repeatedcv",number=3,repeats=3)
Model <- train(Pospercent~ (agegp:alcgp) + (agegp:tobgp),data=Training,method="glm",trControl=fitControl)

##Preidct MSE
MSE <- data.frame(cbind(Testing$Pospercent,predict(Model,Testing[,-6])))
names(MSE) <- c("Actual","Predicted")
MSE[MSE<0] = 0
MSE <- cbind(MSE,(MSE$Actual-MSE$Predicted)^2)
names(MSE)[3] <- "MSE"
esophPredict <- function(Age,Alc,Tob)
{
  Input <- data.frame()
  Input[1,1] <- as.numeric(Age)
  Input[1,2] <- as.numeric(Alc)
  Input[1,3] <- as.numeric(Tob)
  names(Input) <- c("agegp","alcgp","tobgp")
  if (predict(Model,Input) < 0) {
    0
  } else { predict(Model,Input)}
}

plotter <- function(Age,Alc,Tob) 
{
  sub <- subset(esoph,agegp==Age & alcgp==Alc & tobgp==Tob)
  mat <- matrix(c(sub[1,4],sub[1,5]),nrow=1,ncol=2)
  dimnames(mat) <- list(c("x"),c("Cases","Controls"))
  mat
}

actual <- function(Age,Alc,Tob) 
{
  sub <- subset(esoph,agegp==Age & alcgp==Alc & tobgp==Tob)
  act <- sub[1,4]/(sub[1,4]+sub[1,5])
}

shinyServer(
  function(input, output) {
    output$oid1 <- renderPrint({paste(round(esophPredict(input$id1,input$id2,input$id3)*100,2),"%",sep="")})
    output$oid2 <- renderPrint({paste(round(actual(input$id1,input$id2,input$id3)*100,2),"%",sep="")})
    output$newBar <- renderPlot({barplot(plotter(input$id1,input$id2,input$id3),main="Source Data",ylab="People",col="blue",ylim=c(0,60))})
  }
)