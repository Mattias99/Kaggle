# Data preperation
# Check data quality before analyze

#### Missing values ####


# No missing data. Commented because of computation time

#md.pattern(train, plot = FALSE)


#### Features ####


train_feature <- train %>% 
  mutate(
    Month = month(date, label = TRUE),
    Weekday = wday(date, label = TRUE),
    Week = week(date),
    Quarter = quarter(date)
  )


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


# Data consisted of one store. Store as a time-series object

train_decompose <- train_feature %>% 
  filter(store == 1 | store == 1,
         item == 1)

#2013-01-01
head(train_decompose)

#2017-12-31
tail(train_decompose)

# Convert serie to time-series object

decompose_ts <- ts(train_decompose[,4],
                   frequency = 365,
                   start = c(2013, 1, 1),
                   end = c(2017, 12, 31))

# Decompose function

decompose_season <- decompose(decompose_ts)