
# draw n-sample of {-1,1}
plot_chart <- function(n)
{
  s <- 1-2*rbinom(n, 1, 0.5)
  t <- rep(0,n)
  for (i in 2:n)
  {
    t[i] <- s[i]+t[i-1]
  }
  plot(t,type="l")
}
