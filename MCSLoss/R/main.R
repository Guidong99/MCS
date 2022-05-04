get_loss=function(Data,models=c("sGARCH", "eGARCH", "gjrGARCH", "apARCH", "csGARCH",'iGARCH')
                  ,submodels=c("TGARCH","AVGARCH","NGARCH","NAGARCH")
                  ,distributions=c("norm", "std", "ged", "snorm", "sstd", "sged", "jsu", "ghyp")
                  ,mean=TRUE
                  ,Forecast.length=2000,Refit.every=200)
{
  spec.comp=list()

  if(mean==TRUE)
  {
    for( m in models ) {
      for( d in distributions ) {
        spec.comp[[paste( m, d,sep = "-" )]]=ugarchspec(mean.model = list(armaOrder = c(0, 0),include.mean = TRUE), variance.model = list(model = m, garchOrder = c(1, 1)), distribution.model=d)
      } }
    for ( s in submodels ){
      for( d in distributions ) {
        spec.comp[[paste( s, d, sep = "-" )]]=ugarchspec(mean.model = list(armaOrder = c(0, 0),include.mean = TRUE), variance.model = list(model = 'fGARCH', garchOrder = c(1, 1),submodel=s), distribution.model=d)
      }}
  }
  else
  {
    for( m in models ) {
      for( d in distributions ) {
        spec.comp[[paste( m, d,'mean',sep = "-" )]]=ugarchspec(mean.model = list(armaOrder = c(0, 0),include.mean = TRUE), variance.model = list(model = m, garchOrder = c(1, 1)), distribution.model=d)
        spec.comp[[paste( m, d,'no_mean',sep = "-" )]]=ugarchspec(mean.model = list(armaOrder = c(0, 0),include.mean = FALSE), variance.model = list(model = m, garchOrder = c(1, 1)), distribution.model=d)
      }
    }
    for ( s in submodels ){
      for( d in distributions ) {
        spec.comp[[paste( s, d,'mean', sep = "-" )]]=ugarchspec(mean.model = list(armaOrder = c(0, 0),include.mean = TRUE), variance.model = list(model = 'fGARCH', garchOrder = c(1, 1),submodel=s), distribution.model=d)
        spec.comp[[paste( s, d,'no_mean', sep = "-" )]]=ugarchspec(mean.model = list(armaOrder = c(0, 0),include.mean = FALSE), variance.model = list(model = 'fGARCH', garchOrder = c(1, 1),submodel=s), distribution.model=d)
      } }
  }
  specifications=names(spec.comp)
  print(specifications)
  i=0
  roll.comp=list()
  for( s in specifications ){
    i=i+1
    roll.comp[[s]]=ugarchroll(spec = spec.comp[[s]], data = Data, forecast.length = Forecast.length, refit.every = Refit.every)
    print(i)}
  specifications=names(roll.comp)
  VaR.comp=list()
  for( s in specifications ) {
    l=roll.comp[[s]]@forecast$VaR
    if(is.null(dim(l))==FALSE){
      VaR.comp[[s]]=as.data.frame(roll.comp[[s]], which = "VaR")[, 1]
    }
  }
  Loss=do.call(cbind,lapply(specifications,function(s) LossVaR(tau=0.01, realized=tail(Data, Forecast.length)/100,evaluated=VaR.comp[[s]]/100)))
  colnames(Loss)=specifications
  return(Loss)}
