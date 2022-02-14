## ch4. 기본문법 3단계
# Kaggle data set url : https://www.kaggle.com/colara/human-resource

hr = read.csv('C:/R/data/HR_comma_sep.csv')
summary(hr$salary)

hr$salary = as.factor(hr$salary)
summary(hr$salary)

summary(hr$satisfaction_level)
str(hr$satisfaction_level)


### quantile (분위수) : 오름차순으로 정렬하였을 때, 특정 % 위치에 해당되는 값을 의미

# 10%, 30%, 60%, 90% 값 뽑기
quantile(hr$satisfaction_level, probs=c(0.1, 0.3, 0.6, 0.9))

### 단일 변수의 합, 평균, 표준편차
sum(hr$satisfaction_level)

mean(hr$last_evaluation)

sd(hr$satisfaction_level)


### 다중 변수의 합, 평균 구하기
### obs(행) 별로 합, 평균 구할 시에는 rowSums, rowMeans 활용
colMeans(hr[1:5])

colSums(hr[1:5])


### 빈도 테이블 작성
# 1차원 빈도 테이블
tab = as.data.frame(table(hr$sales))
print(tab)

# 2차원 빈도 테이블
tab2 = as.data.frame(xtabs(~ hr$salary + hr$sales))
print(tab2)
