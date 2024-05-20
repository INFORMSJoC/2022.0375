library(readxl)
stock_index1 <- read_excel("E:/paper6/code/stockprice.xlsx")

stock_index1=stock_index1[seq(1167,1,-1),]
stock_index1["Date"]=NULL
na=dim(stock_index1)
scenario=(stock_index1[2:na[1],]-stock_index1[1:na[1]-1,])/stock_index1[1:na[1]-1,]

library(rmgarch)
residu=varxfit(scenario,1)
esidu$Bcoef[,na[2]+1]
theta=residu$Bcoef[,1:na[2]]
std_residu=residu$xresiduals



garch11.spec = ugarchspec(mean.model = list(armaOrder = c(1,1)),
          variance.model = list(garchOrder = c(1,1),model = "sGARCH"),distribution.model = "norm" )
dcc.garch11.spec = dccspec(uspec = multispec(replicate(na[2],garch11.spec)),dccOrder = c(1,1),
      distribution = "mvnorm")
dcc_fit=dccfit(dcc.garch11.spec, data = scenario)
file1="G:/paper6/JOC/revision/code/"
for (i in c(1:20)){
  samples=dccsim(dcc_fit,n.sim=10000)
  samples=samples@msim$simX[[1]]
  write.csv(samples,paste0(file1,"samples_",i,".csv"),row.names = FALSE)
}