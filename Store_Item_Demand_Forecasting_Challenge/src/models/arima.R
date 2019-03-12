# ARIMA
# Evaluation of data on store = 1, item = 1



# Determine ACF and PACF

# Non stationary
train_one$sales %T>% acf() %>% pacf()

# Transform with non-season length
train_one$sales %>% diff(lag = 1) %T>%
  acf() %>% pacf()

# Transform with non-season and season length
train_one$sales %>% diff(lag = 1) %>% diff(lag = 365) %T>%
  acf() %>% pacf()

# Line Plot for stationary sales
train_one$sales %>%
  diff(lag = 1) %>%
  plot(type = "l")
  

# Line Plot for season
train_one$sales %>%
  diff(lag = 1) %>%
  diff(lag = 365) %>%
  plot(type = "l")

# PACF suggests a AR(5) with seasonal spikes at lag 6, 13, 20, 27

# ACF suggests MA(1) with seasonal spikes at lag 7, 14, 21, 28

# Comment: Seasonal pattern looks like a weekly pattern.
# i.e. Higher sales at weekends

# ARIMA (p, d , q) (P, D, Q)s
# ARIMA (5, 1, 1) (3, 0, 0)S

one_arima <- arima(x = train_one$sales,
                   order = c(5, 1, 0),
                   seasonal = list(order = c(3, 0, 0)))

plot(residuals(one_arima), type = "l")
