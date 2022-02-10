x1 = c(1:10)
print(x1)

x2 = seq(1,10,2)
print(x2)


matrix_r = matrix(data=x1, nrow=5)
print(matrix_r)

matrix_c = matrix(data=x1, ncol=5)
print(matrix_c)

x1 = seq(1,5)
x1_2 = seq(1,5)
x2 = rep(1,5)
y = rep(2,5)

df = data.frame(X1=x1, X1_2 = x1_2, X2=x2, y=y)
print(df)

print(head(df, 3))

length(x1)

dim(df)

# ()
a = seq(1,5)
print(a)

# {}
for (i in a) {
  print(i)
}

b = c() # 빈 공간의 벡터 생성
for (k in seq(1,5)){
  b = c(b, k)
}
print(b)

b[2] # 2번째 값

b[2:6] # 2번째 부터 6번째 까지 값

b[-2] # 2번째 값 빼고

b[c(1,2,5)] # 1,2,5번째 값

df[1,] # 1행 전부

df[,1] # 1열 전부

df[c(1,2,3), -2] # 1,2,3행 중 2열은 빼고 전부 출력

df[seq(1,3), c(-2)]

num_vector = c(1:20)
str(num_vector)

chr_vector = c("a", "b", "c")
str(chr_vector)

chr_date = '2020-01-20'
date_date = as.Date(chr_date, format="%Y-%m-%d")
str(chr_date)
str(date_date)


chr_date1 = '2020-02-04 23:12:50'
str(chr_date1)

date_p = as.POSIXct(chr_date1, format="%Y-%m-%d %H:%M:%S")
str(date_p)

format(date_p, "%A")
format(date_p, "%S")
format(date_p, "%Y")


x = c(1:10)

x_int = as.integer(x)
x_num = as.numeric(x)
x_factor = as.factor(x)
x_chr = as.character(x)
str(x_int)
summary(x_int)

str(x_num)
summary(x_num)

str(x_factor)
summary(x_factor)

str(x_chr)
summary(x_chr)


x = c(1:10)
y = c("str", 'str2', "str3", 'str4')

is.integer(x)

is.numeric(x)

is.factor(x)

is.factor(y)

is.character(y)


# sample()
sample_data = sample(1:45, 6, replace=FALSE) # replace=FALSE 비복원추출, TRUE: 복원추출
print(sample_data)

# set.seed(number) 를 통해 random 값 고정 가능
set.seed(123)
s2 = sample(1:45, 6, replace = FALSE)
print(s2)

a = c(1:5)

# %in% a에 속해 있는지 확인하는 논리문
if( 7 %in% a){
  print("true")
} else{
  print("false")  
}

fn_plus = function(x, y){
  return(x+y)
}

fn_plus(2,3)

install.packages("ggplot2")
library(ggplot2)
