### ch6. 중급문법 1단계

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


# file read
hr = read.csv('C:/R/data/HR_comma_sep.csv')

# apply () 함수 설명
# apply(데이터, 계산기준(1:행, 2:열), 함수)

# apply와 for 문의 계산 차이
# hr 데이터셋의 1,2 열의 평균 구하기
# for
for(i in 1:2) {
  print(paste(colnames(hr)[i], " : ", mean(hr[, i])))
}

# apply
apply(hr[, 1:2], 2, mean) # apply(data, 1(행) or 2(열), 함수)

# colMeans
colMeans(hr[, 1:2])

# apply 를 이용하여 표준편차 구하기
apply(hr[, 1:2], 2, sd)


# 각 변수의 표준편차 구하는 방법
D = c(1, 2, 3, 4, NA)
E = c(1,2,3,4,5)

df = data.frame(D = D, E = E)

# NA 가 포함된 데이터의 표준편차 구하기
apply(df, 2, sd) # apply(df, 2, sd, na.rm=TRUE) na.rm=TRUE 옵션을 주면 NA 제거 후 계산

colSd = function(x) {
  y = sd(x, na.rm=TRUE)
  return(y)
}

apply(df, 2, colSd)

# tapply
tapply(hr$satisfaction_level, hr$left, mean)

# lapply: 한 번에 여러 변수들에 동일한 조건을 주고 싶은 경우 
df$D2 = gsub(1, "a", df$D) # gsub(1, "a", 변수) 변수의 값이  1이면 a로 변경 
df$E2 = gsub(1, "a", df$E)
head(df)

# 위의 변경 작업을 한 번에 일괄 적용 lapply를 이용하여.
df2 = df[, 1:2]
df3 = lapply(df2, function(x) gsub(1, "a", x))
df3 = as.data.frame(df3)
head(df3)


## dplyr 패키지 소개
# install.packages("dplyr")
library(dplyr)
head(rowMeans(hr[, 1:2]))

# 위 head(rowMeans(hr[, 1:2])) 를 dplyr 을 이용하여 아래 표현
hr[, 1:2] %>% 
  rowMeans() %>% 
  head()
# 위 dplyr 연산을 이용하면 순서대로 직관적으로 표현됨

# 예시 한 번 더
apply(hr[, 1:5], 2, mean)

hr[, 1:5] %>% 
  colMeans()


# 데이터 집계 내기
# summarise
summarise(hr, MEAN = mean(satisfaction_level),
              N = length(satisfaction_level))

hr %>% 
  summarise(MEAN = mean(satisfaction_level),
            N = length(satisfaction_level))

# subset 후 ddply 적용했을 때 %>%  활용법
# install.packages("plyr")
library(plyr)

# hr 의 left 컬럼 값이 1인 행의 sales 별  평균과 개수 구하기
hr2_0 = ddply(subset(hr, left == 1), c("sales"), 
              summarise,
              MEAN = mean(satisfaction_level),
              N = length(satisfaction_level))

hr2_d = hr %>% 
  subset(left == 1) %>% 
  group_by(sales) %>% 
  dplyr::summarise(MEAN = mean(satisfaction_level),
                   N = length(satisfaction_level))

head(hr2_d, 3)

# 새로운 변수를 추가하고 싶은 경우
# mutate() : DF에 새로운 컬럼을 만드는 함수
hr3_d = hr2_d %>% 
  mutate(percent = MEAN / N)

head(hr3_d, 3)

# dplyr 와 ggplot2 조합
library(ggplot2)

hr2_d %>% 
  ggplot() +
  geom_bar(aes(x=sales, y=MEAN , fill=sales), stat="identity") +
  geom_text(aes(x=sales, y=MEAN + 0.05,
                label=round(MEAN, 2) * 100)) +
  theme_bw() +
  xlab("부서") + ylab("평균 만족도") + guides(fill = FALSE) +
  theme(axis.text.x = element_text(angle= 45, size=8.5, color="blue",
                                   face="plain", vjust = 1, hjust = 1))


### A4. 중복데이터 제거하기 및 데이터 프레임 정렬

# 1차원 벡터, 리스트에서의 중복 제거
a = rep(1:10, each = 2)
print(a)

# 중복제거
unique(a)

# DF에서 중복제거
OBS = rep(1:10)
NAME = c("A", "A", "B", "A", "C", "C", "D", "D", "E", "E")
ID = c("A10153", "A10153", "B15432", "A15853", "C54652", 
       "C54652", "D14568", "D17865", "E13254", "E13254")
DATE = c("20181130", "20181130", "20181130", "20181129", "20181128", 
         "20181127", "20181128", "20181127", "20181126", "20181125")
BTW = c(1,3,4,5,5,6,7,3,2,3)
FFM = c(7000, 6353, 9123, 5423, 8235,
        7345, 5234, 9453, 8453, 5535)

dup = data.frame(OBS, NAME, ID, DATE, BTW, FFM)

# obs : 번호
# btw : Body TOtal Water

# 전체 중복 제거
# 하나라도 중복되면 전부 지워버림. 추천되지 않음
dup1 = dup[-which(duplicated(dup)),]
head(dup1, 3)

# 변수 한 개를 기준으로 중복 제거
# NAME 이 같은 변수들 중복 제거
dup2 = dup[-which(duplicated(dup$NAME)), ]
head(dup2, 6)

# 멀티 변수를 기준으로 중복제거
# NAME, ID 두 개의 값이 같은 중복 제거
dup3 = dup[!duplicated(dup[, c("NAME", "ID")]), ]
head(dup3, 10)

# 변수 인덱스로 제거
dup4 = dup[!duplicated(dup[, c(2,3)]), ]
head(dup4, 10)

# 중복데이터 삭제는 제일 처음 데이터를 남김
# 최신데이터를 남기기 위해서는 역순으로 정렬 후 중복제거 작업 진행

# 데이터 정렬
# 날짜 변수 설정
dup$DATE = as.Date(dup$DATE, "%Y%m%d")
summary(dup$DATE)

dup_sort = dup[order(dup[, 'DATE'], decreasing = TRUE), ] # decreasing=TRUE (내림차순)


# RESHAPE 
# install.packages("reshape")
library(reshape)

OBS = rep(1:10)
NAME = c("A", "A", "B", "A", "C", "C", "D", "D", "E", "E")
ID = c("A10153", "A10153", "B15432", "A15853", "C54652", 
       "C54652", "D14568", "D17865", "E13254", "E13254")
DATE = c("20181130", "20181130", "20181130", "20181129", "20181128", 
         "20181127", "20181128", "20181127", "20181126", "20181125")
TEST = c("T1", "T1", "T1", "T2", "T2", "T2", "T3", "T3", "T4", "T4")
VALUE = c(5, 2, 2, 4, 4, 4, 2, 3, 3, 0)

RESHAPE = data.frame(OBS, NAME, ID, DATE, TEST, VALUE)

# cast() : PYTHON의 원핫인코딩이랑 비슷
cast_data = cast(RESHAPE, OBS + NAME + ID + DATE ~ TEST) # Wide Form

# melt() : cast() 한 것을 원래대로 되돌릴 때 사용
MELT_DATA = melt(cast_data, id=c("OBS", "NAME", "ID", "DATE")) 
MELT_DATA2 = na.omit(MELT_DATA)

# cast data : 그래프 시각화할 때의 데이터 구조로 적합
# melt data : 모델링 할 때의 데이터 구조로 적합


# data 병합 (merge)

dup3 = dup[!duplicated(dup[, c("NAME", "ID")]), ]

# 데이터 병합
# all.x = TRUE : 레프트 아우터 조인
# all.y = TRUE : 라이트 아우터 조인
# all = TRUE : 아우터 조인
# all = FALSE : 이너 조인
head(dup3, 10)
head(cast_data, 10)

merge_df = merge(dup3, cast_data[, c(-1, -2, -4)], by = "ID", all.x = TRUE)
head(merge_df, 10)
