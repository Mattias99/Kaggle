# Analyzes

#### Dickey Fuller test ####


# Stationarity test


stationarity <- train_feature %>%
  group_by(store, item) %>%
  summarise(suppressWarnings(adf.test(sales)$p.value))

colnames(stationarity)[3] <- "p_value"

non_stationary <- filter(stationarity, p_value > 0.05) %>%
  arrange(desc(p_value))

stationary_series <- filter(stationarity, p_value < 0.05) %>%
  arrange(desc(p_value))


addmargins(A = table(non_stationary[, c(1, 2)]))

addmargins(A = table(stationary_series[, c(1, 2)]))

####  Classic decomposistion ####


# Convert serie to time-series object

decompose_ts <- ts(train_decompose[, 4],
                   frequency = 365,
                   start = c(2013, 1, 1),
                   end = c(2017, 12, 31))

# Decompose function

decompose_season <- decompose(decompose_ts,
                              type = "additive")
