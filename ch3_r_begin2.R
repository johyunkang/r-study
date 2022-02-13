# Ch3. 기본문법 2단계
# Kaggle data set url : https://www.kaggle.com/colara/human-resource


##### data 설명 #####
# satisfaction_level : 직무 만족도
# last_evaluation : 마지막 평가점수
# number_project : 진행 프로젝트 수
# average_monthly_hours : 월평균 근무시간
# time_spend_company : 근속년수
# work_accident : 사건사고 여부(0: 없음, 1: 있음, 명목형)
# left : 이직 여부(0: 잔류, 1: 이직, 명목형)
# promotion_last_5years: 최근 5년간 승진여부(0: 승진 x, 1: 승진, 명목형)
# sales : 부서
# salary : 임금 수준
###################################

### A2. 데이터 불러오기 및 strings 확인
# file read
hr = read.csv('C:/R/data/HR_comma_sep.csv')

# 데이터 윗부분 출력
head(hr, n=3)

# shape, strings 파악
str(hr)

# 데이터 요약
summary(hr)

# 데이터 타입(strings) 변경
summary(hr$left)
# left 가 이직여부 의미라서 integer 가 아닌 factor 로 인식해야 하지만 integer로 인식함

# strings 를 통해 factor 로 변경 
hr$Work_accident = as.factor(hr$Work_accident)
hr$left = as.factor(hr$left)
hr$promotion_last_5years = as.factor(hr$promotion_last_5years)

# factor 형식으로 인식 
summary(hr$left)

### A3. 조건에 맞는 데이터 가공하기

# satisfaction_level이 0.5보다 크면 'high', 낮으면 'low'
hr$satisfaction_level_group_1 = ifelse(hr$satisfaction_level > 0.5, 'high', 'low')
summary(hr$satisfaction_level_group_1)

hr$satisfaction_level_group_1 = as.factor(hr$satisfaction_level_group_1)
summary(hr$satisfaction_level_group_1)

hr$satisfaction_level_group_2 = ifelse(hr$satisfaction_level > 0.8, 'high',
                                       ifelse(hr$satisfaction_level> 0.5, 'mid', 'low')
                                       )

hr$satisfaction_level_group_2 = as.factor(hr$satisfaction_level_group_2)
summary(hr$satisfaction_level_group_2)


# subset() : 조건에 맞는 데이터를 추출하는 명령어
# subset(데이터, 추출조건)

# salary가 high 인 직원들만 추출
str(hr$salary)
hr_high = subset(hr, salary == 'high')
str(hr_high$salary)
hr_high$salary = as.factor(hr_high$salary)
summary(hr_high$salary)

# salary 가 high 이면서, sales 가 IT 직원들만 추출 (and 조건)
hr$salary = as.factor(hr$salary)
summary(hr$sales)
hr$sales = as.factor(hr$sales)
hr_high_it = subset(hr, salary=='high' & sales == 'IT')
summary(hr_high_it)

print(xtabs(~ hr_high_it$sales + hr_high_it$salary))

# or 조건 , salary가 high 이거나, sales 가 IT인 직원들
hr_high_it2 = subset(hr, salary == 'high' | sales == 'IT')
print(xtabs(~ hr_high_it2$sales + hr_high_it2$salary))


### A4. 조건에 맞는 집계 데이터 만들기
# plyr 패키지 : 엑셀의 피벗테이블과 비슷한 기능

install.packages("plyr")
library(plyr)

# ddply(데이터, 집계기준, summarise, 요약변수)
ss = ddply(hr, # 분석할 데이터 셋
           c("sales", "salary"),
           summarise, # 집계 기준 변수 설정
           m_sf = mean(satisfaction_level), # 컬럼명 및 계산 함수 설정
           count = length(sales),
           m_wh = round(mean(average_montly_hours), 2)
           )
head(ss, 10)

### A5. ggplot2 기본 시각화
install.packages("ggplot2")
library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
hr$salary = factor(hr$salary, levels = c("low", "mid", "high"))

ggplot(hr)

ggplot(hr, aes(x=salary))

ggplot(hr, aes(x=salary)) + geom_bar()

ggplot(hr, aes(x=salary)) + geom_bar(fill = 'royalblue')

# 변수는 무조건 aes() 안에 들어가야 함
ggplot(hr, aes(x=salary)) + geom_bar(aes(fill=salary))


# 막대도표
# 색설정 1
# 점, 선 처럼 면적이 없는 그래프는 col 옵션, 면적이 있는 그래프는 fill 옵션
ggplot(hr, aes(x=salary)) + geom_bar(aes(fill=left))


# 히스토그램
# 기본
ggplot(hr, aes(x=satisfaction_level)) + geom_histogram()

# 구간 수정 및 색 입히기
# col은 테두리 색, fill 은 채워지는 색
ggplot(hr, aes(x=satisfaction_level)) + geom_histogram(binwidth = 0.01, col='red', fill='royalblue')


# 밀도그래프(density plot) : 연속형 변수 하나를 집계 내는 그래프, 1차원
# 기본
ggplot(hr, aes(x=satisfaction_level)) + geom_density()

# 색 입히기
ggplot(hr, aes(x=satisfaction_level)) + geom_density(col='red', fill='royalblue')


# 박스플롯(boxplot)
# 기본
ggplot(hr, aes(x=left, y=satisfaction_level)) + 
  geom_boxplot(aes(fill=left)) +
  xlab("이직여부") + ylab("만족도") + ggtitle("박스플롯") +
  labs(fill = "이직여부")

# alpha는 색 명도 조절 기능, 0 ~ 1 사이 값
ggplot(hr, aes(x=left, y=satisfaction_level)) + 
  geom_boxplot(aes(fill=left), alpha=I(0.4)) +
  geom_jitter(aes(col=left), alpha=I(0.2)) +
  xlab("이직여부") + ylab("만족도") + ggtitle("박스플롯") +
  labs(fill = "이직여부", col="이직여부")

# 아웃라이어 
ggplot(hr, aes(x=left, y=satisfaction_level)) + 
  geom_boxplot(aes(fill=salary), alpha=I(0.4), outlier.colour = 'red') +
  xlab("이직여부") + ylab("만족도") + ggtitle("박스플롯") +
  labs(fill = "임금수준")


# 산점도(scatter plot)
# 기본
ggplot(hr, aes(x=average_montly_hours, y=satisfaction_level)) + geom_point()

# 색칠로 인한 인사이트 발굴
ggplot(hr, aes(x=average_montly_hours, y=satisfaction_level)) +
  geom_point(aes(col=left)) +
  labs(col="이직 여부") + xlab("평균 근무시간") +ylab("만족도")
