asset.paths <- function(s0, mu, sigma, 
                        nsims = 10000, 
                        periods = c(0, 1)   # time periods at which to simulate prices
) 
{
     s0 = as.vector(s0)
     nsteps = length(periods)*12
     dt = c(periods[1], diff(periods))
     
     if( length(s0) == 1 ) {
          drift = mu - 0.5 * sigma^2
          if( nsteps == 1 ) {
               s0 * exp(drift * dt + sigma * sqrt(dt) * rnorm(nsims))
          } else {
               temp = matrix(exp(drift * dt + sigma * sqrt(dt) * rnorm(nsteps * nsims)), nc=nsims)
               for(i in 2:nsteps) temp[i,] = temp[i,] * temp[(i-1),]
               s0 * temp
          }
     } else {
          require(MASS)
          drift = mu - 0.5 * diag(sigma)
          n = length(mu)
          
          if( nsteps == 1 ) {
               s0 * exp(drift * dt + sqrt(dt) * t(mvrnorm(nsims, rep(0, n), sigma)))
          } else {
               temp = array(exp(as.vector(drift %*% t(dt)) + t(sqrt(dt) * mvrnorm(nsteps * nsims, rep(0, n), sigma))), c(n, nsteps, nsims))
               for(i in 2:nsteps) temp[,i,] = temp[,i,] * temp[,(i-1),]
               s0 * temp
          }
     }
}
