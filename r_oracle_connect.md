## R과 Oracle 연동 방법

R과 Oracle 연동을 위해서는 우선 아래의 선행 작업이 필요합니다.

### 1. Java 설치

본인 PC에 java가 설치되어 있는지 잘 모르겠다면 ```win + R ``` 단축키 후 ```cmd``` 명령어를 통해 커맨드 창을 연 후 명령어 ```java -version```를 입력한다. 명령어 입력 시 아래 그림과 같은 화면이 나오면 Java 설치 및 환경변수 설정이 정상적으로 되어 있는것으로 간주 해도됨.

![cmd_java](https://user-images.githubusercontent.com/291782/153372118-dc72404f-1590-4461-a1b8-f55e2af2f61f.png)



아니라면 첨부된  JDK 파일 압축을 푼 후 Java를 우선 설치 후 다음 블로그 주소를 참조하여 java 환경변수 설정까지 완료 하여야 함

참조 블로그 :  https://marobiana.tistory.com/163

 

### 2. ojdbc8.jar

R과 Oracle 연동을 위해서는 ojdbc8.jar 파일이 필요함. 첨부된 ojdbc8.jar 파일을 적당한 장소에 다운 로드 후 아래 R 소스를 참조하여 본인이 복사한 ojdbc8.jar 파일의 경로를 설정하면 됨



```R
install.packages("DBI")
install.packages("RJDBC")
install.packages("rJava")


library(DBI)
library(RJDBC)
library(rJava)

# 본인이 복사한 ojdbc8.jar 경로 설정
drv <- JDBC(driverClass="oracle.jdbc.driver.OracleDriver", classPath="C:/UTIL/ojdbc/ojdbc8.jar")

# 아래의 DB URL, PORT_NUM, SID, DB_ID, DB_PASSWORD는 임의의 정보
con <-dbConnect(drv, "jdbc:oracle:thin:@192.168.150.123:1521:orcl", "DB_ID", "DB_PASS")            

query <- "SELECT *
            FROM SOME_TABLE
           WHERE BAS_YMD = '20200107'
         "
df_pos <-dbGetQuery(con, query)

head(df_pos)

```

```R
## head() 로 출력 결과
BAS_YMD     COM_LID   COM_NM 
1 20200107   LID1     우리회사
2 20200107   LID2     너희회사
3 20200107   LID3     모두회사
# ... 이하 생략
```



### 3. R DataFrame을 DB Table에 넣기

생성된 DF를 오라클 테이블에 넣는 방법은 아래와 같다.

```R
# DB에 넣기 위한 샘플 DF 파일 생성
bas_ymd <- c("20220211", "20220211", "20220211")
com_lid <- c("LID1", "LID2", "LID3")
com_nm <- c("COM1", "COM2", "COM3")

df <- data.frame(bas_ymd, stl_div_cd, pos_lid, pos_nm)
df
```

```R
# 위 df 출력 결과
   bas_ymd com_lid com_nm
1 20220211 LID1    COM1
2 20220211 LID2    COM2
3 20220211 LID3    COM3
```

```R
# 아래 3줄은 위의 DF 를 쿼리 문으로 만드는 과정이라 생략해도 됨 
apply(df, 1, paste0, collapse = "', '")
apply(df, 1, function(x) paste0(x, collapse = "', '"))
apply(df, 1, function(x) paste0("'", paste0(x, collapse="', '"), "'"))
#### 여기까진 생략 가능
```

```R
sql_insert <- sprintf("INSERT INTO SOME_TABLE (BAS_YMD, COM_LID, COM_NM) VALUES(%s)",
                      apply(df, 1, function(i) paste0("'", paste0(i, collapse="', '"), "'")))

sql_insert
```

```R
# 위 sql_insert 출력 결과
[1] "INSERT INTO SOME_TABLE (BAS_YMD, COM_LID, COM_NM) VALUES('20220211', 'LID1', 'COM1')"
[2] "INSERT INTO SOME_TABLE (BAS_YMD, COM_LID, COM_NM) VALUES('20220211', 'LID2', 'COM2')"
[3] "INSERT INTO SOME_TABLE (BAS_YMD, COM_LID, COM_NM) VALUES('20220211', 'LID3', 'COM3')"
```

```R
# 위 2번의 ojdbc8.jar 의 예제 목록에서 생성한 con 변수와 위에서 생성한 sql_insert 변수를 이용하여 DF 를 table에 입력
dbSendQuery(con, sql_insert)
```

```R
# 위 dbSendQuery(con, sql_insert) 실행 결과
> dbSendQuery(con, sql_insert)
<JDBCResult>
```

위 설명에서 실질적으로 사용되는 명령어를 아래에 다시 한 번 정리 한다.

```R
# DB에 넣기 위한 샘플 DF 파일 생성
bas_ymd <- c("20220211", "20220211", "20220211")
com_lid <- c("LID1", "LID2", "LID3")
com_nm <- c("COM1", "COM2", "COM3")

df <- data.frame(bas_ymd, stl_div_cd, pos_lid, pos_nm)

# DataFrame을 이용한 쿼리 생성
sql_insert <- sprintf("INSERT INTO SOME_TABLE (BAS_YMD, COM_LID, COM_NM) VALUES(%s)",
                      apply(df, 1, function(i) paste0("'", paste0(i, collapse="', '"), "'")))

# 생성된 쿼리를 이용하여 DB 입력
dbSendQuery(con, sql_insert)
```

