library (ggplot2)
library (plot3D)

# calc exponential weighted average
ewa <- function(l, t)
{
  n <- length(t)
  f <- vector("numeric",n)
  f[1] <- t[1]
  
  m <- 1 - l
  
  for (i in 2:n)
    f[i] <- l*t[i] + m*f[i-1] 
  
  f
}

# random walk
random_walk <- function( n )
{
  s <- 1-2*rbinom(n, 1, 0.5)
  t <- vector( "numeric", n)
  t[0] = 0
  
  for (i in 2:n)
    t[i] <- s[i]+t[i-1]
  
  t
}

# mean reverting random walk
mrrw <- function( n, stddev )
{
  t <- vector( "numeric", n)
  t[0] = 0
  var <- stddev*stddev
  for (i in 2:n)
  {
    d <- t[i-1]
    e <- exp( -d*d/var )/2
    if (d >= 0)
      p <- e
    else
      p <- 1 - e
    
    t[i] <- d + 2*rbinom(1, 1, p) - 1
  }
  
  t
}

mrrw2 <- function( n, l )
{
  t <- random_walk( n )
  t - ewa( l, t )    
}

# smooth a graph
smooth <- function( t, l )
{
  f <- ewa(l, t)
  b <- rev( ewa(l, rev(t)))
  (f+b)/2
}

# draw n-sample of {-1,1}
plot_chart <- function(n, l = 0.05, l2 = 0.1)
{
  t <- random_walk( n )
  s <- smooth( t, l )
  
  d1 <- t + mrrw2( n, l2 )
  d1 <- d1 - ewa( l, d1 )
  s1 <- smooth( d1, l2 )
  
  d2 <- t + mrrw2( n, l2 )
  d2 <- d2 - ewa( l, d2 )
  s2 <- smooth( d2, l )

  d3 <- t + mrrw2( n, l2 )
  d3 <- d3 - ewa( l, d3 )
  s3 <- smooth( d3, l )
  
  df <- data.frame( x=1:n, s, d1, s1, d2, s2, d3, s3 )
  
  #g <- ggplot( df, aes(x))
  #g <- g  + geom_line( aes(y=s), colour = "Black", alpha=0.3)
  #g <- g  + geom_line( aes(y=s1), colour = "Red")
  #g <- g  + geom_line( aes(y=d1), alpha = 0.3, colour = "Red")
  #g <- g  + geom_line( aes(y=s2), colour = "Blue")
  #g <- g  + geom_line( aes(y=d2), alpha = 0.3, colour = "Blue")
  #g <- g  + geom_line( aes(y=s3), colour = "Green")
  #g <- g  + geom_line( aes(y=d3), alpha = 0.3, colour = "Green")
  #g <- g + geom_line(aes(y = c(s1,s2,s3)))
  #g

  #points3D( df$s1, df$s2, df$s3, colkey=FALSE )
  
  rgl.open()
  lines3d(df$s1, df$s2, df$s3)
}
