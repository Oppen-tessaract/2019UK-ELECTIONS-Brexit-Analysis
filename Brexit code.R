#analysis

library(openxlsx)
library(ggplot2)
library(tidyverse)
library(foreign)
library(dplyr)


### Set working directory


setwd("C:/Users/faade/OneDrive/Desktop/DATA ANALYSIS 2/YEAR 2")


### Load data 
gg <- read.dta(".dta")
gg <- readRDS('.rds')
gg <- read.xlsx(".xlsx")


summary(election_clear$leaveHanretty)

election <- read.csv("BES2019.csv")
view(election)

nrow(election) #632 rows
ncol(election)#385 colums

#misisng NA, only 1 from Con19
election_clear <- election %>% 
  filter(!is.na(Con19))



election %>%
  select(Con19, leaveHanretty, c11Unemployed) %>%
  summary() #only 1 NA, from con19

#removed NA
election_clear %>%
  select(Con19, leaveHanretty, c11Unemployed) %>%
  summary() 

view(election_clear)


nrow(election_clear) #631 rows
ncol(election_clear)#385


# Premilinary graphics
model1 <- lm(formula = Con19 ~ leaveHanretty, data=election_clear)
summary(model1)

ggplot(election_clear, aes(x = leaveHanretty, y = Con19)) +
  geom_smooth(method = "lm", color = "red") +  
  geom_point(alpha = 0.6) + 
  labs(
    title = "Relationship Between Brexit Support and Conservative Vote Share",
    x = "Estimated 'Leave' Vote Share in 2016 EU Referendum (%)",
    y = "Conservative Vote Share in 2019 (%)"
  ) +
  theme_minimal()

stargazer(model1, type="text",
          title = "Advocacy for Brexit and Conservative Vote share",
          dep.var.labels = "Conservative Vote Share of 2019",
          covariate.labels = c("2016 brext support Vote share(%)"))


#explaining vaiance, checking how they all fit. great 70+
model5<- lm(formula = Con19 ~ leaveHanretty + c11QualLevel4 + c11Unemployed, data=election_clear)
summary(model5)



#scatterplot


#alternative
plot(election_clear$Con19, election_clear$leaveHanretty)
abline(model1, col = "red")

plot(election_clear$Con19, election_clear$c11Unemployed)
abline(model4, col = "pink" )

ggplot(election_clear, aes(x = c11Unemployed, y = Con19)) +
  geom_smooth(method = "lm", color = "red") +  
  geom_point(alpha = 0.6) + 
  labs(
    title = "Relationship Between unemployed rate and Conservative Vote Share",
    x = "2011 Census Unemployed rate per bitish cnstitiency (%)",
    y = "Conservative Vote Share in 2019 per constituency(%)"
  ) +
  theme_minimal()

class(election_clear$c11Unemplo)

c11ex <- election_clear %>% 
  select(ConstituencyName, ConstituencyType, Con19, c11Unemployed)

view(c11ex)

summary(c11ex$)



coef(model1)

confint(model1)
                   

#PArt 4

summary(election_clear$leaveHanretty)
table(election_clear$con19)

view(election_clear)


newdf <- data.frame(leaveHanretty = 20:76)
y.hat <- predict(model1, newdata=newdf, interval = 'confidence')
prediction <- cbind(newdf, y.hat)
print(prediction) #what does this tell us?

ggplot(prediction, aes(x=leaveHanretty)) +
  geom_ribbon(aes(ymin = lwr, ymax=upr), alpha=0.2) +
  geom_line(aes(y=fit), color = "red") +
  labs(title = "Model Predictions: Conservative Vote Share model pedictions against Brexit Support",
       x="Brexit Support Vote share (%)",
       y="Predicted Conservative Vote Share(%)")







model2 <-  lm(formula = Con19 ~ leaveHanretty + c11Unemployed, data=election_clear)
summary(model2)


model4 <- lm(formula = Con19 ~ c11Unemployed, data = election_clear)
summary(model4)


stargazer(model2, type="text",
          title = " Brexit support and unemploymnet rate on Conservative vote share in 2019",
          dep.var.labels = "Conservative Vote Share of 2019",
          covariate.labels = c("2016 brexit support Vote share(%)", "Uemploymnet Rate"))


# Create high/low unemployment categories
#election_clear <- election_clear %>%
 # mutate(unemp_group = ifelse(c11Unemployed > median(c11Unemployed), 
  #                            "High Unemployment", 
   #                           "Low Unemployment"))

#ggplot(election_clear, aes(x = leaveHanretty, y = Con19)) +
 # geom_point(alpha = 0.5) +
  #geom_smooth(method = "lm", color = "red", se = FALSE) +
#  facet_wrap(~ unemp_group) +
 # labs(title = "Brexit-Conservative Relationship by Unemployment Level",
  #     x = "Leave Vote Share (%)", 
   #    y = "Conservative Vote Share (%)")




class(election_clear$c11Unemployed)
class(election_clear$leaveHanretty)
class(election_clear$Con19)

anova(model1, model2)


library(ggplot2)
library(marginaleffects)

stargazer(model1, model2, type="text",
          title = "Comparison table for model 1 and model 2 estimates",
         y dep.var.labels = "Conservative Vote Share of 2019",
        x  covariate.labels = c("2016 brexit 'leave' Vote share(%)", "Uemploymnet Rate"),
          column.labels = c("Model 1: Brexit Only", 
                            "Model 2: Brexit + Unemployment Rate"))

stargazer(model2, type="text",
          title = " Brexit support and unemploymnet rate on Conservative vote share in 2019",
          dep.var.labels = "Conservative Vote Share of 2019",
          covariate.labels = c("2016 brexit support Vote share(%)", "Uemploymnet Rate"))



library(stargazer)

stargazer(model1, model2,
          type = "text",  # Use "html" for Word/LaTeX
          title = "Table 1: Comparing Brexit and Economic Effects on Conservative Vote Share",
          dep.var.labels = "Conservative Vote Share 2019",
          covariate.labels = c("Leave Vote Share (2016)", 
                               "Unemployment Rate",
                               "Constant"),
          column.labels = c("Model 1: Brexit Only", 
                            "Model 2: Brexit + Economics"),
          model.numbers = FALSE,
          notes = "Notes: Standard errors in parentheses. *p<0.1; **p<0.05; ***p<0.01",
          notes.append = FALSE,
          digits = 3,
          single.row = FALSE,
          header = FALSE,
          omit.stat = c("ser", "f"),  # We'll add these separately
          add.lines = list(
            c("R-squared", 
              sprintf("%.3f", summary(model1)$r.squared),
              sprintf("%.3f", summary(model2)$r.squared)),
            c("Adj. R-squared",
              sprintf("%.3f", summary(model1)$adj.r.squared),
              sprintf("%.3f", summary(model2)$adj.r.squared)),
            c("Observations",
              nobs(model1),
              nobs(model2))
          ))
# Calculate predictions across education levels
plot_predictions(
  model2, 
  condition = c("c11Unemployed", "c11QualLevel4"),
  draw = TRUE
)

#table(election$c11QualLevel4)

#install.packages("marginaleffects")

education_brexit<- lm(c11QualLevel4 ~ leaveHanretty, data = election_clear)
summary(education_brexit)


class(election_clear$Con19)

plot(model1, which = 1)


model2 <-  lm(formula = Con19 ~ leaveHanretty + c11Unemployed, data=election_clear)
summary(model2)


model6 <- lm(Con19 ~ leaveHanretty * c11Unemployed, data = election_clear)
   summary(model6)
   
  
   