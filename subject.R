#과제

chk<-file.info("./data/recomen/tran.csv")
if(is.na(chk$size)){
  recoment<-"http://rcoholic.duckdns.org/oc/index.php/s/jISrPutj4ocLci2/download"
  dir.create("./data", showWarnings = F)
  dir.create("./data/recomen", showWarnings = F)
  download.file(recoment,destfile="./data/recomen/tran.csv",mode='wb')
}


# receiptNum가 "6998419"인 구매기록의 가격(amout)의 합은 얼마인가요?
#  가장 비싼 item은 무엇인가요?
#  사용자들이 가장 많이 사용한 체널은 mobile/app과 onlinemall 중에 무엇입니까?
#  월매출이 2015년 03월 가장 높은 매장의 storeCode는 무엇인가요?
#  경쟁사의 이용기록이 가장 많은 사용자의 성별은 무엇입니까? (competitor 데이터에서 1row가 1건이라고 가정)
#  한번에 3개 이상 구매한 경우에 가장 많이 구매에 포함된 제품 카테고리(cate_3)는 무엇입니까?