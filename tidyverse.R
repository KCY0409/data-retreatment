# tidyverse 패키지
if(!requireNamespace("tidyverse")){
  install.packages("tidyverse")
}

library(tidyverse)

# 함수를 연결하는 파이프 연산자 (%>%)
# 함수를 중첩해서 사용할 일이 점점 빈번해 짐
plot(diff(log(sample(rnorm(10000,mean=10,sd=1),size=100,replace=FALSE))),col="red",type="l")
# %>% 를 사용하면
# 1. 생각의 순서대로 함수를 작성 가능
# 2. 중간 변수 저장을 할 필요가 없음
# 3. 순서가 읽기 용이해 기억하기 좋음
rnorm(10000,mean=10,sd=1) %>%
  sample(size=100,replace=FALSE) %>%
  log %>%
  diff %>%
  plot(col = "red", type="l")
# flights 데이터에 파이프 연산자 사용 예시1
flights %>%
  group_by(year, month , day) %>%
  summarise(delay=mean(dep_delay, na.rm = TRUE))
# group_by()는 filter()와도 함께 사용할 수 있음
popular_dests <- flights %>%
  group_by(dest) %>%
  filter(n() > 365)
popular_dests
# 사용할 데이터부터 순서대로 함수를 작성할 수 있는 장점
popular_dests %>%
  filter(arr_delay > 0 ) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)
