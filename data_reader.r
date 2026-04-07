library(tidyverse)

load_ecommerce_data <- function(filepath = "data/ecommerce_orders.csv") {
  data <- read_csv(filepath)
  return(data)
}

# Funktion för EDA
run_eda <- function(df) {

  glimpse(df)
  
  print(summary(df))
  
  na_summary <- colSums(is.na(df)) %>% 
    sort(decreasing = TRUE) %>% 
    .[. > 0]
  
  cat("\n--- Saknade värden per kolumn ---\n")
  if(length(na_summary) > 0) {
    print(na_summary)
  } else {
    print("Inga saknade värden funna!")
  }
}

