if(!requireNamespace("nycflights13")) install.packages("nycflights13")

library(nycflights13)
nycflights13::flights

str(flights)

#dplyr 패키지
library(dplyr)


#열 방향 : 선택 - select()
# 데이터에서 컬럼을 선택해 사용, 선언된 순서대로 컬럼을 결정
select(flights,year,month,day)
# 숫자에서만 제공하던 from:to 문법을 컬럼 순서를 기준으로 지원
select(flights, year:day)
# -(마이너스)는 지정한 컬럼을 제외하고 전부라는 의미
select(flights, -(year:day))
# everything() 같은 helper함수를 제공 -> 선언된 컬럼을 제외한 나머지 전부라는 의미
select(flights, time_hour, air_time, everything())
# ends_with()같이 글자의 일부에 해당하는 컬럼 전부를 가져오는 helper함수도 존재 정규표현식의 주요기능을 함수로 제공
# ?select로 확인
select(flights, year:day, ends_with("delay"), distance, air_time)


# 열 방향 : 계산 - mutate()
# 출력 편의를 위해 일부 데이터만 사용
flights_sml <- select(flights, year:day, ends_with("delay"), distance, air_time) 
flights_sml
# 각 컬럼간의 계산으로 새로운 열을 만들 수 있음
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60
       )
# 컬럼을 지우거나 기존의 컬럼을 변경하는 것도 가능
mutate(flights_sml,
       arr_delay = NULL,
       air_time = air_time / 60
       )
# transmute()는 계산한 컬럼만 있는 테이블을 생성
transmute(flights,
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours
          )
# group_by()와 함께 window function들이 유용하게 사용
flights_smlg <- group_by(flights_sml, month)
mutate(flights_smlg, rank = row_number(desc(arr_delay)))


# 행 방향 : 조건 - filter()
# filter()는 데이터 중 조건에 해당하는 일부 데이터만 필터해서 사용.
filter(flights, month == 1)
# & == and 조건을 추가할 때 사용
filter(flights, month == 1 & day == 1)
filter(flights, month == 1 and day == 1)  #이건 안되네요.
# | == or
filter(flights, month == 11 | month == 12 )
# %in%는 유용하게 사용하는 논리연산자로 왼쪽에 있는 벡터가 오른쪽 벡터의 데이터 중 어느 하나라도 맞으면 출력
filter(flights, month %in% c(11,12))
# !는 local 데이터에서 결과를 반대로 뒤집는 역할
# 수학에서의 괄호와 같이 연산의 범위를 작성해 두는 것이 문제 발생 소지 감소
filter(flights, !(arr_delay > 120 | dep_delay > 120))


# 행 방향 : 추가 - bind_rows()
feb <- filter(flights, month == 2)
dec <- filter(flights, month == 12)
dim(feb); dim(dec)
nrow(feb)+nrow(dec)
# bind_rows()는 컬럼 이름을 기준으로 같은 컬럼 킽에 데이터를 붙여서 묶어줌.
bind_rows(feb, dec)
# list()로 구분된 데이터도 묶어줌
bind_rows(list(feb, dec))
# split()은 첫번째 인자로 받은 데이터를 컬럼을 기준으로 list()로 분리해 줌.
flights_mon <- split(flights, flights$month)
summary(flights_mon)
# split()으로 분리된 12개의 list()자료도 잘 합쳐줌
nrow(flights)
bind_rows(flights_mon)
# 다른 종류의 데이터도 묶어줌, c()는 vector를 생성하고, data_frame은 data.frame을 생성
bind_rows(
  c(a = 1, b = 2),
  data_frame(a = 3:4,  b = 5:6),
  c(a = 7, b = 8)
)
# 데이터를 묶을 때 데이터를 구분하는 컬럼 추가 가능
bind_rows(list(feb, dec), .id = "id")
# 데이터를 구분하는 컬럼에 대해 이름이 동작하는 방식
bind_rows(list(a = feb, b = dec), .id = "data")
# 같은 이름의 컬럼이 없을 때는 NA로 채우면서 동작함
bind_rows(data.frame(x = 1:3), data.frame(y = 1:4))


# 행 방향 : 정렬 - arrange()
# arrange()는 지정되는 컬럼 순으로 오름차순 정렬해주는 함수
arrange(flights, dep_delay)
# desc()는 내림차순 정렬로 방향을 바꾸는 helper 함수
arrange(flights, desc(month), dep_delay)


# 그룹 계산 : group_by() + summarise()
# summarise()는 여러 데이터를 요약해 특성을 파악하는 방식으로 동작하는 함수들을 적용할 때 사용
summarise(flights, mean = mean(dep_delay, na.rm = T), n = n())
# group_by()는 데이터에 지정한 컬럼별이라는 추가 조건을 지정하는 기능을 수행
flights_g <- group_by(flights, month)
flights_g
# group_by()에 의해 지정한 컬럼별 summarise()연산을 수행
summarise(flights_g, mean = mean(dep_delay, na.rm = T), n = n())
