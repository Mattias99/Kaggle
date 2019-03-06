# Analyzes

#### Dickey-Fuller test ####


# Stationarity test


stationarity <- train_feature %>%
  group_by(store, item) %>%
  summarise(suppressWarnings(adf.test(sales)$p.value))

colnames(stationarity)[3] <- "pValue"

nonStationary <- filter(stationarity, pValue > 0.05) %>% arrange(desc(pValue))
