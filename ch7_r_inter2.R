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

head(grp_data, 10)

#### output sample behind ####
# Year  Day     Mean Median   Max Counts
# <fct> <fct>  <dbl>  <dbl> <dbl>  <int>
#   1 2012  금    17179.  17280 21480     50
# 2 2012  목    17161.  17220 21300     51
# 3 2012  수    17125.  17215 21040     52
# 4 2012  월    17099.  17200 20320     45
# 5 2012  화    17099.  17225 20610     50
# 6 2013  금    32641.  33850 43950     51
# 7 2013  목    32906.  33700 44800     51
# 8 2013  수    32888   33850 42550     50
# 9 2013  월    32825.  33525 43400     42
# 10 2013  화    32631.  33650 42800     51


# ungroup : group 으로 묶인 데이터를 해제 시켜주는명령어
# 잘 이해가 안됨.
ungrp_data <- grp_data %>% 
  ungroup()

head(ungrp_data, 3)
str(ungrp_data)

str(grp_data)


count_data = stock %>% 
  group_by(Year, Day) %>% 
  count()

head(count_data) 

# output sample
# Year  Day       n
# <fct> <fct> <int>
#   1 2012  금       50
# 2 2012  목       51
# 3 2012  수       52
# 4 2012  월       45
# 5 2012  화       50
# 6 2013  금       51

### A2. 조건에 따라 데이터 추출하기
# filter(), subset() : 두 명령어 모두 같은 기능을 수행함.
subset_data = grp_data %>% 
  filter(Year == '2012')

head(subset_data, 10)


### A3. 데이터 중복 제거하기
# distinct() : 데이터 내에 존재하는 중복 데이터 제거


# 중복데이터 샘플 생성
sl = sample(1:nrow(grp_data), 500, replace=TRUE)
head(sl, 10)
duplicated_data = grp_data[sl,]
# duplicated_data$Year = as.Date(duplicated_data$Year, "%Y")
# duplicated_data_sort = duplicated_data[order(duplicated_data[, 'Year'], decreasing=TRUE), ]
count(duplicated_data)
### sample output
# 1 2012     86
# 2 2013    102
# 3 2014    112
# 4 2015    109
# 5 2016     91


# 중복제거 
duplicated_distinct = duplicated_data %>% 
  distinct(Year, Day, Mean, Median, Max, Counts)

count(duplicated_distinct)
### sample output
# 1 2012      5
# 2 2013      5
# 3 2014      5
# 4 2015      5
# 5 2016      5


### A4. 샘플 데이터 무작위 추출
# sample_frac() :
# sample_n() : 

# 그룹이 지정되어 있는 데이터 
sample_frac_grp = grp_data %>% 
  sample_frac(size = 0.4, replace = FALSE)

head(sample_frac_grp)
# 각 년도에서 5개 중 2개씩 균형있게 sampling 됨.

# 그룹이 해제되어 있는 데이터
sample_frac_ungrp = ungrp_data %>% 
  sample_frac(size = 0.4, replace=FALSE)
head(sample_frac_ungrp)
# 년도별로 균형있게 sampling 되지 않음

sample_n_grp = grp_data %>% 
  sample_n(size = 6, replace = TRUE)
head(sample_n_grp)


### A5. 정해진 index 에 따라 데이터 추출하기
# slice(), top_n() 명령어 사용
# slice() : index를 직접 설정해서 추출가능. Dataset은 ungroup() 되어 있는 데이터여야 함

slice_data = ungrp_data %>% 
  slice(1:5)

head(slice_data, 10)

head(grp_data, 10)

slice_data2 = grp_data %>% 
  slice(1:5)

head(slice_data2, 10)
# sliece 잘 안되는데?

# top_n() : 설정해준 변수를 기준으로 가장 값이 높은 n개의 데이터를 가져옴.
topn_data = ungrp_data %>% 
  top_n(5, Mean) # Mean 값 중 값이 가장 높은 5개 추출

head(topn_data, 10)

### A6. 데이터 정렬하기
# arrange() : ungroup 데이터만 정렬 가능. grouping 되어 있는 데이터는 Year 별로 정렬

# ascending
asc_data = ungrp_data %>% 
  arrange(Mean) # Mean 기준으로 정렬

head(asc_data, 10)

# descending
desc_data = ungrp_data %>% 
  arrange(-Mean) # Mean 에 - (마이너스) 또는 desc()  붙이면 descending

desc_data2 = ungrp_data %>% arrange(desc(Mean))

head(desc_data, 10)
head(desc_data2, 10)

# 여러 변수 정렬
desc_data3 = ungrp_data %>%  arrange(desc(Year), desc(Mean))

head(desc_data3, 10)



### A7. 원하는 변수만 뽑아내기
# select(), select_if()

# index 활용
select_data = grp_data %>% 
  select(1:2)

head(grp_data, 10)
head(select_data, 10)

# column 활용
sel_data = grp_data %>% 
  select(Year, Mean, Counts)

head(sel_data, 10)


# select_if : 조건을 통해 데이터 추출 가능.
# factor 변수만 뽑기
sel_if_data = grp_data %>% 
  select_if(is.factor)

head(sel_if_data, 5)

# integer 만 뽑기
sel_if_data2 = grp_data %>% 
  select_if(is.integer)
head(sel_if_data2)


### A8. 새로운 변수 만들기 혹은 한번에 처리하기
# mutate(), mutate_if(), mutate_at()
head(stock)

mut_data = stock %>% 
  mutate(Divided = round(High/Low, 2)) %>% 
  select(Date, High, Low, Divided)

head(mut_data)

# mutate_if 
# integer 를 모두 numeric으로 변경
mut_if_data <- stock %>% 
  mutate_if(is.integer, as.numeric)

summary(mut_if_data)
str(mut_if_data)
str(stock)

# mutate_at() : 지정한 변수들에 대해 계산식을 적용시키는 명령어
# Date, Year, Day를 제외한 모든 변수를 log 변환
mut_at_data <- stock %>% 
  mutate_at(vars(-Date, -Year, -Day), log) %>% 
  select_if(is.numeric)

head(mut_at_data)

###
