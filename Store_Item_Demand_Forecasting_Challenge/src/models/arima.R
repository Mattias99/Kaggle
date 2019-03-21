# ARIMA
# Evaluation of data on store = 1, item = 1



# Determine ACF and PACF

# Non stationary
train_one$sales %T>%
  acf(main = "Orginal Time-Serie") %>%
  pacf(main = "Orginal Time-Serie")

# Transformation with non-season length
train_one$sales %>% diff(lag = 1) %T>%
  acf(main = "One-Diff Time-Serie") %>%
  pacf(main = "One-Diff Time-Serie")

# Transformation with non-season and season length
train_one$sales %>% diff(lag = 1) %>% diff(lag = 365) %T>%
  acf(main = "One-Diff and Seasonal-Diff") %>%
  pacf(main = "One-Diff and Seasonal-Diff")

# Line Plot for stationary sales
train_one$sales %>%
  diff(lag = 1) %>%
  plot(main = "Orginal Time-Serie", type = "l")
  

# Line Plot for season
train_one$sales %>%
  diff(lag = 1) %>%
  diff(lag = 365) %>%
  plot(main = "One-Diff and Sesonal-Diff", type = "l")

# PACF suggests a AR(5) with seasonal spikes at lag 6, 13, 20, 27

# ACF suggests MA(1) with seasonal spikes at lag 7, 14, 21, 28

# Comment: Seasonal pattern looks like a weekly pattern.
# i.e. Higher sales at weekends

# ARIMA (p, d , q) (P, D, Q)s
# ARIMA (5, 1, 1) (3, 0, 0)S

one_arima <- arima(x = train_one$sales,
                   order = c(5, 1, 0),
                   seasonal = list(order = c(3, 0, 0),
                                   period = 7), xreg = train_xreg)

# Diagnostics, Residual Plot
plot(residuals(one_arima), type = "l",
     main = "Residual Plot. Store = 1, Item = 1")

# Prediction
one_pred <- predict(one_arima, n.ahead = 90,newxreg = test_xreg)

# Evaluation
mape(actual = test_one$sales,
     predicted = one_pred$pred)

plot(x = 1:90, y = test_one$sales, col = "green", 
     type = "l",
     main = "ARIMA\nStore = 1, Item = 1\nBlack = Prediction")
lines(x = 1:90,  y = one_pred$pred)
