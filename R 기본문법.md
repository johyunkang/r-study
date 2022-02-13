## R 기본 문법

### c()의 활용

c()는 Combind의 약자를 나타내는 명령어로, 벡터를 만드는데 사용. 데이터에서 하나의 열(column)을 의미. 즉 데이터가 세로로 저장된다고 생각하면 됨

```R
B = c(2,3,4,5)
  B
1 2
2 3
3 4
4 5

print(B)
[1] 2 3 4 5
```



### rep(), seq()를 통한 벡터 생성

seq: 순차적인 수열 생성 sequence의 줄임말로 순차적인 데이터 생성할 때 사용

>   seq() : seq(from=시작숫자, to=마지막숫자, by=증가범위)

```R
# 1 ~ 10까지 1씩 증가하는 수열 생성
x1 = c(1:10)
# 1 ~ 10까지 2씩 증가하는 수열 생성
x2 = seq(from=1, to=10, by=2) # seq(1,10,2) 와 같음
```

rep : 반복적인 수열 생성 repeat의 줄임말로 반복된 데이터를 생성할 때 사용

>   rep(): rep(반복할 값, 반복할 횟수)

```R
# 1을 10번 반복
y = rep(1,10)
print(y)
[1] 1 1 1 1 1 1 1 1 1 1 1

y2 = rep(c(1,10), 2)
print(y2)
[1] 1 10 1 10

y3 = rep(c(1, 10), c(2, 2))
print(y3)
[1] 1 1 10 10
```


### matrix(), data.frame() 데이터 셋 만들기

-   matrix 데이터 생성

>   matrix(data=데이터, nrow=행의수, ncol=열의수, byrow=행/열 기준)

```R
matrix_r = matrix(data=x1, nrow=5)
print(matrix_r)

     [,1] [,2]
[1,]    1    6
[2,]    2    7
[3,]    3    8
[4,]    4    9
[5,]    5   10

matrix_c = matrix(data=x1, ncol=5)
print(matrix_c)

     [,1] [,2] [,3] [,4] [,5]
[1,]    1    3    5    7    9
[2,]    2    4    6    8   10

```

-   dataframe의 생성

```R
x1 = seq(1,5)
x1_2 = seq(1,5)
x2 = rep(1,5)
y = rep(2,5)

df = data.frame(X1=x1, X1_2 = x1_2, X2=x2, y=y)
print(df)

  X1 X1_2 X2 y
1  1    1  1 2
2  2    2  1 2
3  3    3  1 2
4  4    4  1 2
5  5    5  1 2


# head는 데이터의 상단 부분을 지정한 행 만큼 출력. 아래는 3을 입력해서 3줄 보여줌
print(head(df, 3))

  X1 X1_2 X2 y
1  1    1  1 2
2  2    2  1 2
3  3    3  1 2
```



### length(), dim()을 활용한 데이터 형태 파악

-   length() : 1차원 벡터인 경우 사용

```R
length(x1)
[1] 5
```

-   dim(): 2차원 행렬, 데이터프레임인 경우에는 dim()을 활용

```R
# 행, 열
dim(df)
[1] 5 4
```

### 괄호의 활용

-   () 괄호 : 실행함수(function)과 함께 사용. 예를 들어, c()에서 c()는 들어오는 값들을 묶어 하나의 벡터로 만드는 기능을 실행
-   {} 괄호 : for, if 문 등의 조건식을 입력할 때 사용.
-   [] 괄호 : index를 입력해야 할 때 쓰임. 

```R
# ()
a = seq(1,5)
print(a)

[1] 1 2 3 4 5

# {}
for (i in a) {
  print(i)
}

[1] 1
[1] 2
[1] 3
[1] 4
[1] 5

b = c() # 빈 공간의 벡터 생성
for (k in seq(1,5)){
  b = c(b, k)
}
print(b)
[1] 1 2 3 4 5

# [] 1차원 데이터
> b[2] # 2번째 값
[1] 2
> b[2:6] # 2번째 부터 6번째 까지 값
[1]  2  3  4  5 NA
> b[-2] # 2번째 값 빼고
[1] 1 3 4 5
> b[c(1,2,5)] # 1,2,5번째 값
[1] 1 2 5

# [] 2차원 데이터
> df[1,] # 1행 전부
  X1 X1_2 X2 y
1  1    1  1 2
> df[,1] # 1열 전부
[1] 1 2 3 4 5

> df[c(1,2,3), -2] # 1,2,3행 중 2열은 빼고 전부 출력
  X1 X2 y
1  1  1 2
2  2  1 2
3  3  1 2
```



### 변수 형태 이해하기

R에서는 데이터의 타입을 다음으로 정리하며, 보통 Strings 라고 부름.

| Strings Type    | 설명                         |
| --------------- | ---------------------------- |
| chr (Character) | 문자열 형태                  |
| int (Integer)   | 숫자                         |
| num (Numeric)   | 숫자                         |
| Factor          | 명목형 변수                  |
| POSIXct         | 시간 변수(년/월/일 시:분:초) |
| Tseries         | 시계열 변수                  |

Strings에 따라 완전히 다른 분석결과가 나올 수 있기 때문에 문자열 종류 파악이 중요함. 그리고 Strings 에 따라 분석방법론이 정해지게 됨.

- 범주형 : 몇 개의 범주로 나누어진 자료를 의미
  - 명목형 : 성별, 성공여부, 혈액형 등 단순히 분류된 자료. 학점 이수 여부 (Pass/Fail)
  - 순서형(Ordinal) : 개개의 값들이 이산적이며 그들 사이에 순서 관계가 존재하는 자료. 학년 (1학년, 2학년)
- 수치형 : 이산형과 연속형으로 이루어진 자료를 의미
  - 이산형 (Discrete) : 이산적인 값을 갖는 데이터로 출산 횟수, 안타 횟수 등을 의미
  - 연속형(Continuous) : 연속적인 값을 갖는 데이터로 신장, 체중 등을 의미. 카운팅이 불가능. 정확히 키가 175, 176 으로 떨어지지 않고 175.333333333 이기도 함.

변수의 척도에 따른 정보량

| 변수 척도         | 예시                     | 정보량 |
| ----------------- | ------------------------ | ------ |
| 명목 (Norminal)   | 학점 이수 여부 (P / F)   | O      |
| 순서 (Ordinal)    | 공식 성적 (A+, A, B+, B) | OO     |
| 연속 (Continuous) | 백분위 점수 (0 ~ 100)    | OOO    |

- 데이터의 변환

  정보량이 풍부한 연속형의 데이터가 순서, 명목형으로 변환은 가능. 반대 순서는 정보량이 부족해서 변환이 불가능

- 데이터 타입 확인

  str() 명령어를 통해 확인 가능

  > str(벡터, 행렬, 데이터 등 모든 저장값)

```R
> num_vector = c(1:20)
> str(num_vector)
 int [1:20] 1 2 3 4 5 6 7 8 9 10 ...

> chr_vector = c("a", "b", "c")
> str(chr_vector)
 chr [1:3] "a" "b" "c"
```

### 시간(날짜) 형태의 변수 다루기

R에서 시간(날짜) 데이터 다루는 방법 3가지

- as.Date() : '년-월-일' 형태로 다루기
- as.POSIXct() : '년-월-일 시:분:초' 형태로 다루기
- lubridate 패키지를 활용하여 날짜 데이터 다루기

#### as.Date() 활용

> as.Date(변수, format="날짜형식")

| FORMAT | EXAMPLE   | FORMAT | EXAMPLE         |
| ------ | --------- | ------ | --------------- |
| %a     | 화        | %M     | 23 (분)         |
| %A     | 화요일    | %p     | AM / PM         |
| %b     | 1         | %S     | 23 (초)         |
| %B     | 1월       | %u     | 1-7 (1: 월요일) |
| %C     | 20세기    | %W     | 0-6 (0:일요일)  |
| %d     | 09 (날짜) | %y     | 12 (년)         |
| %H     | 23 (시간) | %Y     | 2012 (년)       |
| %I     | 11 (시간) | %m     | 01 (월)         |



```R
> chr_date = '2020-01-20'> date_date = as.Date(chr_date, format="%Y-%m-%d")> str(chr_date) chr "2020-01-20"> str(date_date) Date[1:1], format: "2020-01-20"
```



#### as.POSIXct() 활용

> as.POSIXct(날짜, format="날짜형식")

```R
> chr_date1 = '2020-02-04 23:12:50'
> str(chr_date1)
 chr "2020-02-04 23:12:50"
> date_p = as.POSIXct(chr_date1, format="%Y-%m-%d %H:%M:%S")
> str(date_p)
 POSIXct[1:1], format: "2020-02-04 23:12:50"
```

#### format() 활용

> format(날짜 변수, "형식")

```R
> format(date_p, "%A")
[1] "화요일"

> format(date_p, "%S")
[1] "50"

> format(date_p, "%Y")
[1] "2020"
```



### as, is 를 통해 strings 확인 및 변경하기

#### as()

as는 "변수 X를 ~로 취급하겠다." 라는 의미를 가짐.

```R
> x = c(1:10)

> x_int = as.integer(x)
> x_num = as.numeric(x)
> x_factor = as.factor(x)
> x_chr = as.character(x)

> str(x_int)
 int [1:10] 1 2 3 4 5 6 7 8 9 10

> summary(x_int)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1.00    3.25    5.50    5.50    7.75   10.00 

> str(x_num)
 num [1:10] 1 2 3 4 5 6 7 8 9 10

> summary(x_num)
   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
   1.00    3.25    5.50    5.50    7.75   10.00 

> str(x_factor)
 Factor w/ 10 levels "1","2","3","4",..: 1 2 3 4 5 6 7 8 9 10

> summary(x_factor)
 1  2  3  4  5  6  7  8  9 10 
 1  1  1  1  1  1  1  1  1  1 

> str(x_chr)
 chr [1:10] "1" "2" "3" "4" "5" "6" "7" "8" "9" "10"

> summary(x_chr)
   Length     Class      Mode 
       10 character character 

```



#### is()

is는 논리문으로써 변수 X가 ~ 인지 판단해라. 라는 의미. str()은 단순히 strings 인지 확인만 하지 결과를 반환하지는 않음.

```R
 x = c(1:10)
 y = c("str", 'str2', "str3", 'str4')

 is.integer(x)
[1] TRUE

 is.numeric(x)
[1] TRUE

 is.factor(x)
[1] FALSE

 is.factor(y)
[1] FALSE

 is.character(y)
[1] TRUE 
```



### sample()을 통한 데이터 무작위 추출

데이터가 방대한 경우 무작위 추출을 통해 데이터의 특성은 살리면서 테스트는 빠르게 실행이 가능함. 파라미터 중 **replace=FALSE**의 의미는 **비복원 추출**을 하겠다는 의미. (TRUE: 복원 추출, FALSE: 비복원 추출)

> sample(데이터 추출 범위, 추출 갯수, replace=TRUE / FALSE) 

```R
 sample_data = sample(1:45, 6, replace=FALSE) # replace=FALSE (비복원추출, TRUE: 복원추출)
 print(sample_data)
[1] 17 30 45 38  1 26
```

무작위 결과 값을 고정 시켜야 할때는 **set.seed()**를 이용하여 고정 가능

```R
 # set.seed(number) 를 통해 random 값 고정 가능
 set.seed(123)
 s2 = sample(1:45, 6, replace = FALSE)
 print(s2)
[1] 31 15 14  3 37 43
```



### if 문 활용하기

```R
 a = c(1:5)
 # %in% a에 속해 있는지 확인하는 논리문
 if( 3 %in% a){
   print("true")
 } else{
   print("false")  
 }
[1] "true"
```



###  function()을 통해 사용자 함수 만들기

입력된 두 수를 합하는 함수

```R
fn_plus = function(x, y){
  return(x+y)
}

fn_plus(2,3)
```

```R
[1] 5
```



### 패키지 설치방법

추가로 필요한 함수는 패키지를 설치하여 사용해야 함. 패키지 설치 후 사용을 위해서는 라이브러리 선언을 해야 함

```R
install.packages("ggplot2")
library(ggplot2)
```

