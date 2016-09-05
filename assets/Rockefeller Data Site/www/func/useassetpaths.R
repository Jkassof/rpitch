### Base case use of asset.paths() ####

#construct faux returns matrix
portfolio_assets = 100
portfolio_wgts
years_4_cov = 5

rtns = matrix(
          rnorm(portfolio_assets*years_4_cov*12),
          nrow = portfolio_assets,
          ncol = years_4_cov*12
)



S = rnorm(portfolio_assets,100,25) # Starting stock prices
r = rnorm(portfolio_assets, .01, .05) # Expected return
sigma = abs(rnorm(portfolio_assets,.75,.25)) # Expected volatility
#rho = c(0.63, .55, .6, .6, .6) # covariance?
N = 10000 # Simulations

# # Single Asset for 10 years
# periods = 0:10
# prices = asset.paths(S[1], r, sigma[1], N, periods = periods)
# 
# # plot
# matplot(prices[,1:100], type='l', xlab='Years', ylab='Prices',
#         main='Selected Price Paths')
# 
# 
# Multiple Assets for 10 years
periods = 0:1
# cov.matrix = sigma%*%t(sigma) * matrix(c(1,rho,rho,1),length(S),length(S))
cov.matrix_j = cov(t(rtns))
prices = asset.paths(S, r, cov.matrix_j, N, periods = periods)

# plot
matplot(prices[1,,1:100], type='l', xlab='Years', ylab='Prices',
        main='Selected Price Paths for Asset 1')
matplot(prices[2,,1:100], type='l', xlab='Years', ylab='Prices',
        main='Selected Price Paths for Asset 2')
matplot(prices[3,,1:100], type='l', xlab='Years', ylab='Prices',
        main='Selected Price Paths for Asset 1')
matplot(prices[4,,1:100], type='l', xlab='Years', ylab='Prices',
        main='Selected Price Paths for Asset 2')
matplot(prices[5,,1:100], type='l', xlab='Years', ylab='Prices',
        main='Selected Price Paths for Asset 1')
matplot(prices[6,,1:100], type='l', xlab='Years', ylab='Prices',
        main='Selected Price Paths for Asset 2')

