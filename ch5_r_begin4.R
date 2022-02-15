# Ch5. 기본문법 4단계
# Kaggle data set url : https://www.kaggle.com/PromptCloudHQ/imdb-data

##### data 설명 #####
# Rank
# Title : 영화 제목
# Genre : 영화 장르
# Description : 영화 설명
# Director : 감독명
# Actors : 배우
# Year : 영화 상영 년도
# Runtime..Minutes : 상영시간
# Rating : Rating 점수
# Votes : 관객 수
# Revenue..Millions : 수익
# Metascore : 메타 스코어
###################################

### DATA read
imdb = read.csv('C:/R/data/IMDB-Movie-Data.csv')
summary(imdb)

### 결측치 (Missing Value)
# 결측치확인
# metascore 변수 내의 논리문 판단(TRUE, FALSE)
is.na(imdb$Metascore)[1:20]

# 결측치 갯수
sum(is.na(imdb$Metascore))

# imdb 내의 모든 변수별 결측치 갯수
colSums(is.na(imdb))

# 결측치 제거 (결측치가 포함된 행(obs) 삭제)
imdb2 = na.omit(imdb)
colSums(is.na(imdb2))
str(imdb2)


# complete.cases() : 행에 na 데이터가 있는지 확인해 주는 함수
# 행에 na 데이터가 없으면 TRUE 반환, na가 존재하면 FALSE 반환
# 12번째 열에 결측치가 존재하는 경우에만 해당 행을 삭제
imdb3 = imdb[complete.cases(imdb[, 12]), ]
colSums(is.na(imdb3))


# 결측치를 특정 값(58.99)으로 대체
imdb$Metascore2 = imdb$Metascore
imdb$Metascore2[is.na(imdb$Metascore2)] = 58.99

# 결측치를 생략하고 계산
count(imdb)
mean(imdb$Revenue..Millions.) # na가 포함되어 있어서 평균을 na 반환
mean(imdb$Revenue..Millions., na.rm = TRUE) # na 생략하고 계산하여 평균 반환환


### A4. 결측치 처리 시 주의할 점

### A5. 결측치 처리를 위한 데이터의 분포 탐색
ggplot(imdb, aes(x=Revenue..Millions.)) +
  geom_histogram(fill='royalblue', alpha=0.4) +
  ylab('') +
  xlab("Revenue_Millions") +
  theme_classic()

ggplot(imdb, aes(x= "", y=Revenue..Millions.)) +
  geom_boxplot(fill='red', alpha=0.4, outlier.colour = 'red') +
  xlab('') +
  ylab("Revenue_Millions") +
  theme_classic()

summary(imdb$Revenue..Millions.)


### A6. 이상치(Outlier) 뽑아내기

# 이상치 
ggplot(imdb, aes(x=as.factor(Year), y=Revenue..Millions.)) +
  geom_boxplot(aes(fill=as.factor(Year)), outlier.colour = "red", alpha=I(0.4)) +
  xlab("년도") + ylab("수익") + guides(fill=FALSE) +
  theme_bw() +
  theme(axis.text.x = element_text(angle=90))


# outlier 데이터 제거
# 1분위수 계산
q1 = quantile(imdb$Revenue..Millions., probs=c(0.25), na.rm=TRUE)
# 3분위수 계산
q3 = quantile(imdb$Revenue..Millions., probs=c(0.75), na.rm=TRUE)

lc = q1 - 1.5 * (q3 - q1) # 아래 울타리
uc = q3 + 1.5 * (q3 - q1) # 위 울타리

imdb2  =subset(imdb, Revenue..Millions. > lc & Revenue..Millions. < uc)
summary(imdb$Revenue..Millions.)
summary(imdb2$Revenue..Millions.)


### A7. 문자열 데이터 다루기 1편
# 문자열을 다룰 때 기본적으로 숙지하고 있어야 하는 명령어는 다음과 같습니다.
# 문자열 대체 : gsub()
# 문자열 분리 : strsplit()
# 문자열 합치기 : paste()
# 문자열 추출 : substr()
# 텍스트마이닝 함수: Corpus() & tm_map(), & tdm()
################################################

# 문자열 추출
print(imdb$Actors[1])
substr(imdb$Actors[1], 1, 5) # substr(x, start, stop)

# 문자열 붙이기 paste
# paste는 기본적으로 문자열 사이에 한 칸 빈칸이 기본 설정임.
# 이를 수정하기 위해서는 sep="" 옵션을 주어야 함

paste(imdb$Actors[1], "_", "A")
# [1] "Chris Pratt, Vin Diesel, Bradley Cooper, Zoe Saldana _ A"

paste(imdb$Actors[1], sep =",", "HI")
# [1] "Chris Pratt, Vin Diesel, Bradley Cooper, Zoe Saldana,HI"

paste(imdb$Actors[1], "_", "A", sep="") # 띄어쓰기 없이 붙이기
# [1] "Chris Pratt, Vin Diesel, Bradley Cooper, Zoe Saldana_A"

paste(imdb$Actors[1], "_", "EXAMPLE", sep="|") # |로 구분해서 붙이기
# [1] "Chris Pratt, Vin Diesel, Bradley Cooper, Zoe Saldana|_|EXAMPLE"


# 문자열 분리 strsplit
strsplit(as.character(imdb$Actors[1]), split=",")

# 문자열 대체 gsub
print(imdb$Genre)
imdb$Genre2 = gsub(",", " ", imdb$Genre) # , 를 띄어스기로 대체
print(imdb$Genre2)


### A8. 문자열 데이터 다루기 2편 (R텍스트 마이닝)
# 텍스트 마이닝의 절차
# 1. 코퍼스(말뭉치) 생성
# 2. TDM(문서 행렬) 생성
# 3. 문자 처리(특수문자 제거, 조사 제거, 숫자 제거 등)
# 4. 문자열 변수 생성

