source("data_cleaning_and_feature_addtions.r")

library(tidyverse)
library(scales)



best_category_col_graph <- function(df) {
  get_top_selling_categories(df) %>% 
    ggplot(aes(x = reorder(product_category, -total_revenue),
               y = total_revenue)) +
    geom_col() +
    labs(
      title = "Top categories",
      x = "Categories",
      y = "Revenue"
    )
}
# Visar att elektronik är den kategori som bidrar mest till intäkt



best_category_box_graph <- function(df) {
  df %>%
    mutate(revenue = unit_price * quantity) %>%
    ggplot(aes(x = product_category, y = revenue)) +
    geom_boxplot() +
    scale_y_continuous(breaks = c(100,500, 1000,1500, 2000,2500, 3000)) +
    labs(
      title = "Revenue by category",
      x = "Categories",
      y = "Revenue"
    )
}


# Samma som ovan fast som boxplot istället. För att se spridning
# Välj enbart en av dessa två



return_by_subcat <- function(df) {
  analyze_product_subcategory_vs_returns(df) %>% 
    ggplot(aes(x = reorder(product_subcategory, return_rate),
               y = return_rate)) +
    geom_col() +
    coord_flip() +
    scale_y_continuous(limits = c(0, 0.25), labels = percent) +
    labs(
      title = "Return rate by subcategories",
      x = "Subcategories",
      y = "Return rate"
    )
}

return_by_subcat_colur_by_cat <- function(df) {
  analyze_product_subcategory_vs_returns(df) %>% 
    ggplot(aes(
      x = reorder(product_subcategory, return_rate),
      y = return_rate,
      fill = product_category
    )) +
    geom_col() +
    coord_flip() +
    scale_y_continuous(limits = c(0, 0.25), labels = scales::percent) +
    labs(
      title = "Return rate by subcategories",
      x = "Subcategories",
      y = "Return rate",
      fill = "Category"
    )
}
    

# Visar vilken subcategory som har högst return rate



type_of_payment_method_graph <- function(df) {
  analyze_unit_price_by_payment_method(df) %>% 
    mutate(payment_method = reorder(payment_method, -total)) %>% 
    pivot_longer(
      cols = c(total, count),
      names_to = "header",
      values_to = "value"
    ) %>% 
    mutate(
      header = recode(header,
                      total = "Total revenue",
                      count = "Usage count"),
      header = factor(header,
                      levels = c("Total revenue", "Usage count"))
    ) %>% 
    ggplot(aes(x = payment_method, y = value)) +
    geom_col() +
    facet_wrap(~ header, scales = "free_y") +
    labs(
      title = "Payment method: total revenue and usage count",
      x = "Payment method",
      y = "Value"
    )
}
# Visar intäkt per betalningsmetod samt antal gånger en den användts

