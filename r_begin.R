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
