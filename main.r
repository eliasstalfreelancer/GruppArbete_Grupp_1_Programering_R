source("data_reader.R")
source("data_cleaning_and_feature_addtions.R")
source("analys.r")
source("visualisering.r")

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

# Skapar statistiska sammanfattningar av den rensade datan.
stat_summary <- create_statistical_summaries(clean_data)

# Visar en övergripande statistisk sammanfattning av hela datasetet.
view(stat_summary$overall_summary)

# Visar statistisk sammanfattning uppdelad efter produktkategori.
view(stat_summary$category_summary)

# Visar statistisk sammanfattning uppdelad efter kundsegment.
view(stat_summary$segment_summary)

# Visar statistisk sammanfattning uppdelad efter region.
view(stat_summary$region_summary)

# Visar statistisk sammanfattning uppdelad efter betalningsmetod.
view(stat_summary$payment_summary)

# Visar boxplot (Intäkt per kategori)
#best_category_box_graph(clean_data)
return_by_subcat_colur_by_cat(clean_data)

# Visar (Return rate by subcategory)
return_by_subcat(clean_data)

# Visar (Intäkt per betalmetod samt antal)
type_of_payment_method_graph(clean_data)
