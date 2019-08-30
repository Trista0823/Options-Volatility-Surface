# Volatility-Surface

This project selects the 50 ETF put and call options for the period from June 12, 2017 to June 12, 2018, including all execution prices, and the expiration months are from June 2017 to December 2018, for a total of 543 options. The number of samples is 29,107. 


The option price is the daily settlement price, with the closing price of 50 ETF as the underlying asset price, and the daily 3-month SHIBOR as the risk-free rate for the period. The remaining maturity period is the trading days remaining from the closing day to the last trading day/365 days (per year). 


In order to eliminate the impact of the shift effect, this paper excludes the remaining expiration date less than or equal to one day.
