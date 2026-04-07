source("data_reader.R")
source("data_cleaning_and_feature_addtions.R")
#Load data
ecommerce_orders_read <- load_ecommerce_data("data/ecommerce_orders.csv")

#EDA 
run_eda(ecommerce_orders_read)

#Data cleaning
clean_data <- convert_dups(replace_na_values(ecommerce_orders_read))

#Vilka produktkategorier verkar driva högst försäljning?
view(get_top_selling_categories(clean_data))
#view(get_top_selling_subcategories(clean_data)) #finns också

#Hur skiljer sig returgrad mellan olika subkategorier?
view(analyze_product_subcategory_vs_returns(clean_data))  

#payment_method vs unit_price för att se fall om det finns en korrelation?
view(analyze_unit_price_by_payment_method(clean_data))


