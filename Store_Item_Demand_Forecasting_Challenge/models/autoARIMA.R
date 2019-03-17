# Automatic ARIMA with "forecast"-package
# Evaluation of data on store = 1, item = 1

#### auto.arima ####

# Fit model to original data

aa_fit <- auto.arima(y = train_one$sales,
                  d = 1,
                  seasonal = TRUE,
                  stepwise = TRUE)

summary(aa_fit)

accuracy(aa_fit)

aa_forecast <- forecast(aa_fit, h = 90)

autoplot(aa_forecast)

#### auto.arima with outlier transformation ####

# Identifying and replacement of outliers take place in transform.R

