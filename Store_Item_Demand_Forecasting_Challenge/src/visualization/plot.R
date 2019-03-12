#### Correlations Plots ####


# Corrplot, correlation on sales grouped by store.
# Highliy correlated between all stores,

corrplot <- ggcorrplot(
  cor_group,
  type = "lower",
  hc.order = FALSE,
  lab = TRUE,
  lab_size = 3,
  method = "circle",
  colors = c("tomato2", "white", "springgreen3"),
  ggtheme = theme_bw,
  title = "Correlogram of Sales"
)

#### Seasonality check ####


# Additive seasonality

plot(decompose_season)
