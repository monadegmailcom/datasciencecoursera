# n number of tosses of a coin (>0)
# p probability of head
tossCoin <- function(n, p)
{
  # toss coin n times
  ts<-runif(n)
  # number of heads
  hs<-ts[ts<=p]
  # return frequency
  length(hs)/n
}

plotFreq <- function(n,p)
{
  f <- function(n) {tossCoin(n,p)}
  plot(sapply(1:n, f))
}