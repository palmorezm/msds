
# Data was run in order: DataRequirements ->  CAINCMAP_Slider -> here

t <- df %>% 
  filter(Statistic == "Income Per Capita") %>% 
  filter(Years == "2019-01-01") %>%
  mutate(mpay = (Value*.28)/12, 
         lmpay = (Value*.16)/12,
         dif = mpay - lmpay) %>% 
  mutate(RegionName = case_when(
    Region == 1 ~ "New England", 
    Region == 2 ~ "Mid-Atlantic",
    Region == 3 ~ "Midwest",
    Region == 4 ~ "Great Plains",
    Region == 5 ~ "South",
    Region == 6 ~ "Southwest",
    Region == 7 ~ "Rocky Mountain",
    Region == 8 ~ "Pacific West",
    ))

dmap <- df %>% 
  filter(Statistic == "Income Per Capita") %>% 
  mutate(mpay = (Value*.28)/12, 
         lmpay = (Value*.16)/12,
         dif = mpay - lmpay) %>% 
  mutate(RegionName = case_when(
    Region == 1 ~ "New England", 
    Region == 2 ~ "Mid-Atlantic",
    Region == 3 ~ "Midwest",
    Region == 4 ~ "Great Plains",
    Region == 5 ~ "South",
    Region == 6 ~ "Southwest",
    Region == 7 ~ "Rocky Mountain",
    Region == 8 ~ "Pacific West",
  )) 


dmap$hover <- with(dmap, paste(GeoName, "<br>",
                         "Region:", RegionName, "<br>",
                         '<br>', "Income Per Capita:", paste0("$", format(Value, nsmall = 0)), "<br>",
                         "Max. Monthly Payment:", paste0("$", format(mpay, nsmall = 2, digits = 2)), "<br>", 
                         "Min. Monthly Payment:", paste0("$", format(lmpay, nsmall = 2, digits = 2)), "<br>",
                         "Affordability Range", paste0("$", format(dif, nsmall = 2, digits = 2)))) # Alter to fit map

  dmap %>% 
  filter(Years == "2019-12-31") %>%
  plot_ly(.) %>% 
  add_trace(
    type="choropleth",
    geojson=counties,
    locations=~GeoFips,
    z=~Value,
    colorscale="Cividis",
    zmin=0,
    zmax=100000,
    text =~hover,
    marker=list(line=list(
      width=0))) %>% 
  colorbar(title = "Value") %>% 
  layout(title = "Selected Statistical Changes in U.S. Counties") %>% 
  layout(geo = g) 



print(paste(t$GeoName, "Max:", round(t$mpay, 1), "Min:", round(t$lmpay)))

