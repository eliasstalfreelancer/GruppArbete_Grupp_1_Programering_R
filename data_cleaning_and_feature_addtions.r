library(tidyverse)


replace_na_values <- function(ecommerce_orders){
  ecommerce_orders %>% 
    mutate(
      campaign_source = replace_na(campaign_source, "Unknown"),
      payment_method = replace_na(payment_method, "Unknown"),
      city = replace_na(city, "Unknown"),
      discount_pct = replace_na(discount_pct, median(discount_pct, na.rm = TRUE)),
      shipping_days = replace_na(shipping_days, median(shipping_days, na.rm = TRUE))
    )
}
convert_dups <- function(ecommerce_orders){
  ecommerce_orders %>%
    mutate(across(where(is.character), ~ str_to_lower(.)))
}

get_top_selling_categories <- function(clean_ecommerce_orders){
  clean_ecommerce_orders %>% 
    mutate(revenue = unit_price * quantity) %>% 
    group_by(product_category) %>%
    summarise(total_revenue = sum(revenue)) %>%
    arrange(desc(total_revenue))

}
get_top_selling_subcategories <- function(clean_ecommerce_orders){
  clean_ecommerce_orders %>% 
    mutate(revenue = unit_price * quantity) %>% 
    group_by(product_subcategory) %>%
    summarise(total_revenue = sum(revenue)) %>%
    arrange(desc(total_revenue))
  
}


analyze_product_subcategory_vs_returns <- function(clean_ecommerce_orders){
  clean_ecommerce_orders %>% 
    mutate(returned = returned == "yes") %>% 
    group_by(product_subcategory,product_category) %>% 
    summarise(
      return_rate = mean(returned),
      count = n()
    ) %>% 
    mutate(
      count_rate = count / sum(count)
    ) %>% 
    arrange(desc(return_rate))
}
analyze_unit_price_by_payment_method <- function(clean_ecommerce_orders){
  clean_ecommerce_orders %>% 
    mutate(revenue = unit_price * quantity) %>% 
    group_by(payment_method) %>%
    summarise(
      revenue_mean = mean(revenue),
      count = n(),
      total = sum(revenue)
    )%>%
    arrange(desc(total))
}


