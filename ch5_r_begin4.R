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


## 결측치 부분 추가부분 더 공부해라.
