### ch7. 중급문법 2단계

# Kaggle data set url : https://www.kaggle.com/daiearth22/uniqlo-fastretailing-stock-price-prediction

library(dplyr)
# library(plyr)

stock = read.csv('C:/R/data/Uniqlo_stocks_2012_2016.csv')

stock$Date = as.Date(stock$Date)
stock$Year = as.factor(format(stock$Date, '%Y'))
stock$Day = as.factor(format(stock$Date, '%a'))

str(stock)

### A1. 집계 데이터 만들기

grp_data <-  stock %>% 
  group_by(Year) %>% 
  count()
  # summarise(Mean = round(mean(Open), 2),
  #           Median = round(median(Open), 2),
  #           Max = round(max(Open), 2),
  #           Counts = length(Open))
grp_data
## grp data 가 생각한 대로 안 묶임



