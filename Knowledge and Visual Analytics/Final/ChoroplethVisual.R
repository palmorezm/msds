
t <- df %>% 
  filter(Statistic == "Income Per Capita") %>% 
  filter(Years == "2019-01-01") %>%
  mutate(mpay = (Value*.28)/12, 
         lmpay = (Value*.16)/12,
         dif = mpay - lmpay) 

t$hover <- with(t, paste(GeoName, '<br>', "Beef", beef, "Dairy", dairy, "<br>",
                           "Fruits", total.fruits, "Veggies", total.veggies,
                           "<br>", "Wheat", wheat, "Corn", corn)) # Alter to fit map

  t %>% 
  plot_ly(.) %>% 
  add_trace(
    type="choropleth",
    geojson=counties,
    locations=~GeoFips,
    z=~Value,
    colorscale="Viridis",
    zmin=0,
    zmax=100000,
    text =~mpay,
    featureidkey=~GeoName,
    hovertemplate = paste("Max Per Month:%{text:$.2f}</b>", 
                          "<br>Income: %{z:$.2f}", 
                          "<br>Max Per Month:{featureidkey:$.2f}"),
    marker=list(line=list(
      width=0))) %>% 
  colorbar(title = "Value") %>% 
  layout(title = "Selected Statistical Changes in U.S. Counties") %>% 
  layout(geo = g) 



print(paste(t$GeoName, "Max:", round(t$mpay, 1), "Min:", round(t$lmpay)))

