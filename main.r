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


# Med vår analys kan vi se att top kategorin i försäljning var Electronics följt av Home, Sports, Fashion och slutligen Beauty.
# 
# Returgraden av olika kategorier visar att Fashion är kategorin som kunder returnerar i högst grad följt av Home, Beauty, Electronics och slutligen Sports. Däremot den enskilt högsta returgraden är Sub Kategorin Kitchen på nästan 20% returgrad.
# 
# Mellan diverse kundtyper kan vi inte se att någon typ har högre sannolikhet att returnera varor, alla ligger kring en 15% returgrad +/- 1% enhet, vilket med det lilla datasettet kan ses som en rimlig spridning.
# 
# När vi ser över returgraden per region kan vi se att väst har en högre returgrad en andra regioner på en grad på 18.77% och norr har lägst på 11.30% returgrad. 
# 
# Det är svårt att se ifall det finns någon korrelation mellan vilken betalningsmetod de använde och priset på varorna köpta. Däremot kan vi se att betalningsmetoden swish har en lägre mediansumma på köpta varor än de andra, men att medelvärdet är kring liknande värde som resterande metoder. Det skulle kunna antyda kunder använder sig av swish för att köpa varor till ett mindre värde.
# 
# De resultat som varit bäst att få fram svar på de frågor vi hade inför analysen är tabellerna "get_top_selling_categorier" i samband med visualiseringen "best_category_boxgraph(clean_data)" då dessa två ger oss en bra insikt dels i totala summan i försäljning per kategori. Men boxgraphen ger oss insikt i vart utstickare finns och vart ett medelvärde per order verkar finnas.
# 
# För att ge oss insikt i returgrader så får vi bra insikter med tabellerna "stat_summary$region_summary", "stat_summary$segment_summary" och "stat_summary$category_summary". Sista tabellen som gav oss viktig information till våra frågeställningar var "stat_summary$payment_summary", då den delade upp betalningsmetoderna och gav oss medel och medianvärde. 
# 
# Slutsatser
# 
# Beauty har lägst Revenue men inne i Beauty kan vi även se att Skincare produkter har nästan en returgrad på 20%, detta gör att denna kategori inte returnerar samma vinst som andra kategorier. I Electronics och Home har vi 1 produkt vardera som höjer returgraden inne i kategorin, Laptops och Kitchen. Vi borde se över mer djupgående vad som orsakar att de har högre returgrad en medelvärdet på returer på strax över 14%. Vi ser även en betydligt högre returgrad i regionen väst, detta behöver undersökas ifall det är problem med butikerna där eller vad som orsakar att fler kunder returnerar i den regionen. En jämförelse mellan väst och norr hade varit rekommenderat och se vad som gör att norr har lägre en medel i returgrad och implementera de dom gör bra.

