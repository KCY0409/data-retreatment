# 데이터 소스로서 DBI
if(!requireNamespace("dbplyr")) install.packages("dbplyr")
library(dbplyr)


# data.table
# 데이터 소스로서 data.table을 사용가능 -> dtplyr패키지 설치
if(!requireNamespace("dtplyr")) install.packages("dtplyr")
library(dtplyr)


# R데이터를 DB테이블로 만들기 - copy-to()
# DBI의 dbWriteTable()과 같은 기능을 수행
library(dplyr)
library(RSQLite)
library(nycflights13)

conn <- dbConnect(SQLite())

copy_to(conn
        , flights
        , temporary = FALSE
        , name = "flights")
dbListTables(conn)


# 테이블의 연결정보를 R 객체에 저장 - tbl()
# dbplyr 과 DBI,dplyr로 DB의 테이블을 dplyr 문법으로 다루기 위해
# DBI 패키지에서 conn 객체와 같이 테이블의 연결정보를 담고 있는 R 객체가  필요
# tbl()는 DB내 테이블 연결정보를 R객체로 만드는 함수
tb_flights <- tbl(conn, "flights")


# 속도를 빠르게 하는 indexes 옵션
# copy_to()를 진행할 때 key 역할을 수행할 컬럼을 미리 지정해주면
# 관련 컬럼을 사용하는 연산(group_by의 key컬럼 사용 등)에 속도 상승
copy_to(conn,
        flights,
        name = 'flights_idx',
        temporary = FALSE,
        indexes = list("carrier"))

tb_flights <- tbl(conn, "flights")
tb_flights_idx <- tbl(conn, "flights_idx")


# 함수 속도를 비교 - microbenchmark()
if(!requireNamespace("microbencgmark")) install.packages("microbenchmark")
library(microbenchmark)

# indexes 속도 비교
microbenchmark(tbl(conn, 'flights') %>%
                 group_by(carrier) %>%
                 summarise(count = n()) %>%
                 collect(),
               tbl(conn, 'flights_idx') %>%
                 group_by(carrier) %>%
                 summarise(count = n()) %>%
                 collect(),
               times = 10)


# collect()
# DB에 전달하는 명령의 최종 결과를 R객체로 가져오는 역할을 수행
tbl(conn, 'flights') %>%
  group_by(carrier) %>%
  summarise(count = n()) %>%
  collect()

# 결과를 테이블로 저장 - compute()
dbListTables(conn)

tbl(conn, 'flights') %>%
  group_by(tailnum) %>%
  summarise(count=n(),
            mean_distance = mean(distance),
            total_distance = sum(distance)) %>%
  filter(!is.na(tailnum)) %>%
  compute(name = 'planes_distance')
# 테이블 저장 결과 확인
dbListTables(conn)
dbReadTable(conn, "planes_distance")


# show_query()
# dplyr로 구성된 함수의 연결리 query문으로 어떻게 변환되는지 보여줌 
copy_to(conn, planes, name = 'planes', temporary = FALSE)
tbl(conn, 'planes_distance') %>%
  inner_join(tbl(conn, 'planes'), by='tailnum') %>%
  arrange(desc(total_distance)) %>%
  select(total_distance, manufacturer, model) %>%
  show_query()





