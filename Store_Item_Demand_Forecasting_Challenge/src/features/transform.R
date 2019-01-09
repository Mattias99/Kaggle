
##### DATA TRANSFORMATION ####


example <- train %>%
  group_by(store) %>%
  summarise(numItems = n_distinct(item))

# Preparation before correlogram is used

train_wide <- spread(train, store, sales)

train_group <- spread(train, store, sales) %>%
  select(-date) %>%
  rename_all(paste0, "_store") %>%
  group_by(item_store) %>%
  summarise_all(funs(sum))

cor_group <- cor(train_group[, -1])