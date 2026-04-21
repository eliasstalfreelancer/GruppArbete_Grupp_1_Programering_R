library(dplyr)

create_statistical_summaries <- function(df_clean) {
  
  df_summary <- df_clean %>%
    mutate(
      ordervarde = unit_price * quantity,
      returnerad_order = returned == "yes"
    )
  
  overall_summary <- df_summary %>%
    summarise(
      antal_ordrar = n(),
      antal_unika_kunder = n_distinct(customer_id),
      genomsnittligt_ordervarde = round(mean(ordervarde, na.rm = TRUE), 2),
      median_ordervarde = round(median(ordervarde, na.rm = TRUE), 2),
      genomsnittlig_rabatt_procent = round(mean(discount_pct, na.rm = TRUE), 2),
      median_rabatt_procent = round(median(discount_pct, na.rm = TRUE), 2),
      genomsnittlig_leveranstid_dagar = round(mean(shipping_days, na.rm = TRUE), 2),
      median_leveranstid_dagar = round(median(shipping_days, na.rm = TRUE), 2),
      returgrad_procent = round(mean(returnerad_order, na.rm = TRUE) * 100, 2)
    )
  
  category_summary <- df_summary %>%
    group_by(product_category) %>%
    summarise(
      antal_ordrar = n(),
      total_forsaljning = round(sum(ordervarde, na.rm = TRUE), 2),
      genomsnittligt_ordervarde = round(mean(ordervarde, na.rm = TRUE), 2),
      median_ordervarde = round(median(ordervarde, na.rm = TRUE), 2),
      returgrad_procent = round(mean(returnerad_order, na.rm = TRUE) * 100, 2)
    ) %>%
    arrange(desc(total_forsaljning))
  
  segment_summary <- df_summary %>%
    group_by(customer_segment) %>%
    summarise(
      antal_ordrar = n(),
      genomsnittligt_ordervarde = round(mean(ordervarde, na.rm = TRUE), 2),
      median_ordervarde = round(median(ordervarde, na.rm = TRUE), 2),
      returgrad_procent = round(mean(returnerad_order, na.rm = TRUE) * 100, 2)
    ) %>%
    arrange(desc(genomsnittligt_ordervarde))
  
  region_summary <- df_summary %>%
    group_by(region) %>%
    summarise(
      antal_ordrar = n(),
      total_forsaljning = round(sum(ordervarde, na.rm = TRUE), 2),
      genomsnittligt_ordervarde = round(mean(ordervarde, na.rm = TRUE), 2),
      returgrad_procent = round(mean(returnerad_order, na.rm = TRUE) * 100, 2)
    ) %>%
    arrange(desc(total_forsaljning))
  
  payment_summary <- df_summary %>%
    group_by(payment_method) %>%
    summarise(
      antal_ordrar = n(),
      andel_av_alla_ordrar_procent = round((n() / nrow(df_summary)) * 100, 2),
      genomsnittligt_ordervarde = round(mean(ordervarde, na.rm = TRUE), 2),
      median_ordervarde = round(median(ordervarde, na.rm = TRUE), 2)
    ) %>%
    arrange(desc(antal_ordrar))
  
  return(list(
    overall_summary = overall_summary,
    category_summary = category_summary,
    segment_summary = segment_summary,
    region_summary = region_summary,
    payment_summary = payment_summary
  ))
}