#### GGPLOT ####


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