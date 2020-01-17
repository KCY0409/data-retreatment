#tidyr이 데이터를 tidy하게 만드는 4개 함수
# 1. gather() : wide form 데이터를 long form으로 변환
# 2. spread() : long form 데이터를 wide form 으로 변환
# 3. separate() : 하나의 컬럼을 두 개로 나눔
# 4. unite() : 두개의 컬럼을 하나로 합침

# tidyr,dplyr은 tidyverse에 포함된 패키지
# tidyverse가 있다면 생략 가능
if(!requireNamespace("tidyr")) install.packages("tidyr")
library(tidyr)

library(tidyverse)

table1

# long form 예시
table2
# 한 컬럼에 두개의 의미를 지닌 데이터가 들어 있는 경우
table3

# wide form 의 예시 1
table4a
# wide form 의 예시 2
table4b

# wide to long - gather()
# gather(data, key = "컬럼 이름이 데이터로 들어갈 그 컬럼의 이름",
# value = "매트릭스로 펼쳐져 있는 데이터가 모이는 컬럼의 이름",
# "데이터로 들어갈 컬럼들을 지정") 의 형태로 작성
# "데이터로 들어갈 컬럼들을 지정"은 위치에 자유로움
table4a %>%
  gather('1999', '2000'
         , key = "year"
         , value = "cases")

# 값에 해당하는 데이터는 matrix -> column, 지정한 컬럼들은 key의 데이터로 변경


# long to wide - spread()
# spread(data, key = "컬럼에 위치할 데이터가 있는 컬럼"
# , value = "매트릭스 모양이로 펼쳐질 데이터가 있는 컬럼")으로 작성
table2 %>%
  spread(key = type,
         value = count)


# 하나의 컬럼을  나누기 - separate()
# 아래와 같이 여러 부호로 그 의미가 나뉘어져 있지만, 한 컬럼에 데이터가 있는 경우,
# 컬럼을 의미 단위로 분리하는 역할을 수행.
# into = c("나눠 질때 첫번째 컬럼 이름","나눠질 때 두번째 컬럼 이름")으로 새로 생성되는 컬럼의 이름을 지정 가능
table3 %>%
  separate(rate
           , into = c("cases", "population"))
# 간단한 형변환은 옵션으로 제공
table3 %>%
  separate(rate
           , into = c("cases",
                      "population")
           )
table3 %>%
  separate(rate,
           into = c("cases"
                    ,"population"
                    , convert = TRUE))


# 두 컬럼을합치기 - unite()
# paste0()와 비슷하게 합쳐주는 역할을 수행
table5 %>%
  unite(new, century, year)
# sep 인자를 이용해 구분자로 사용할 문자열을 지정 가능
table5 %>%
  unite(new, century, year, sep = "")



