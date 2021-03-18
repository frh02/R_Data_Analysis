######################
# Loading the dataset
######################

#Method 1

library(datasets)
data(dhfr)


#Method 2 

#library(RCurl)
#iris <- read.csv(text = getURL("https://raw.githubusercontent.com/dataprofessor/data/master/iris.csv"))#

#view the data 
View(dhfr)

################################
# Display the summary statistics
################################

#head()/tail()

head(dhfr, 5)
tail(dhfr, 5)


#summary()
summary(dhfr)
summary(dhfr$Y)

#check to see if there are missing data ?
sum(is.na(dhfr))

#skmir() - expands on the summary() by providing larger set of statistics
#install.packages("skmir")

library(skimr)

skim(dhfr)    # Perform skimr to display summary 

#group data by Y (biological activity) then perform skim

dhfr %>%
  dplyr::group_by(Y) %>%
  skim()

################################
# QUICK DATA VISUALISATION
# R base Plot()
################################

# Panel plots
#plot(dhfr)
#plot(dhfr,col="blue")

#Scatter plot
plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol)

plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col ="blue") #makes blue circles

plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col = dhfr$Y)

plot(dhfr$moe2D_zagreb, dhfr$moe2D_weinerPol, col ="blue", 
     xlab = "moe2D_zagreb", ylab = "moe2D_weinerPol")

#Histograms 
hist(dhfr$moe2D_zagreb)
hist(dhfr$moe2D_zagreb, col = "blue") #makes blue bar 


#Feature Plot 

library(AppliedPredictiveModeling)
library(caret)

featurePlot(x = dhfr[,2:5],
            y = dhfr$Y,
            plot = "box",
            strip = strip.custom(par.strip.text=list(cex=.7)),
            scales = list(x = list(relation = "free"),
                          y = list(relation = "free")))

