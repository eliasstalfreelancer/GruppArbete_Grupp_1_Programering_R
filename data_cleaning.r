



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

analyze_shipping_time_vs_returns <- function(clean_ecommerce_orders){
  clean_ecommerce_orders %>% 
    mutate(returned = returned == "Yes") %>% #konverterar fall om det står yes till true
    group_by(shipping_days) %>% 
    summarise(
      return_rate = mean(returned),
      count = n()
    ) %>%
    arrange(shipping_days)
}

analyze_unit_price_by_payment_method <- function(clean_ecommerce_orders){
  clean_ecommerce_orders %>% 
    mutate(revenue = unit_price * quantity) %>% 
    group_by(payment_method) %>%
    summarise(
      revenue_mean = mean(revenue),
      count = n()
    )%>%
    arrange(revenue_mean)
}


