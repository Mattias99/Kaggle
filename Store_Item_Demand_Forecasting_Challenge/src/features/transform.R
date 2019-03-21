# Data preperation
# Check data quality before analyze

#### Missing values ####


# No missing data. Commented because of computation time

#md.pattern(train, plot = FALSE)


#### Features Engineering ####


train_feature <- train %>% 
  mutate(
    Month = month(date, label = TRUE),
    Weekday = wday(date, label = TRUE),
    Week = week(date),
    Quarter = quarter(date)
  ) 


# Dummy variables for specifc dates/periods
# Must be added for test set as well


train_new <- cbind(train_feature,
                   dummy(train_feature$Month, sep = "_"))


train_xreg <- train_feature %>%
  select(
    starts_with("train_feature_")
  )

# Weekdays

# Holidays

# Seasons, i.e. Spring/Atumn/Winter/Summer


#### Frequencies #### 


# Each store sell the fifty diffrent items

store_items <- train_feature %>%
  group_by(store) %>%
  summarise(numItems = n_distinct(item))


#### Preparation before correlogram (corrplot) is used ####


# Regroup, one variable per store.

train_group <- spread(train, store, sales) %>%
  select(-date) %>%
  rename_all(paste0, "_store") %>%
  group_by(item_store) %>%
  summarise_all(funs(sum))

cor_group <- cor(train_group[, -1])


#### Preparation before Dickey-Fuller test ####


# Data consisted of two stores and two items, for simpliciy

train_dickey <- train_feature %>% 
  filter(store == 1 | store == 2,
         item == 1)

#### Preparation before Decompose function ####


# Data consisted of one store. Store as a time-series object (decompose_ts)

train_decompose <- train_feature %>% 
  filter(store == 1, item == 1)

#### Data for ARIMA, store = 1, item = 1 ####

train_one <- train_feature %>% 
  filter(store == 1, item == 1, date < "2017-01-01")

test_one <- train_feature %>%
  filter(store == 1, item == 1, date > "2016-12-31",
         date < as.Date("2016-12-31") + 91)

#### Covariates / xreg-variables ####

# Transform to one variable/store
# Covariates must have values on the prediction interval

train_xvar <- spread(train, store, sales) %>%
  rename_all(paste0, "_store") %>%
  group_by(item_store)

xreg_var <- train_xvar %>% 
  select(-one_of("1_store")) %>%
  filter(item_store == 1, date_store < "2017-01-01")

# Must be converted to matrix (auto.arima xreg)  

xreg_mat <- as.matrix(xreg_var[, -c(1, 2)])


#### Outlier detection and replacement ####


# Returns zero outliers

train_one_out <- tsoutliers(x = train_one$sales)
