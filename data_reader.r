library("tidyverse")

ecommerce_orders <- read_csv("data/ecommerce_orders.csv")

view(ecommerce_orders)

glimpse(ecommerce_orders)
summary(ecommerce_orders)

colSums(is.na(ecommerce_orders))

colSums(is.na(ecommerce_orders)) %>% 
  sort(decreasing = TRUE) %>% 
  .[. > 0]