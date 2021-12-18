#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)


# Define server logic required to draw a histogram
# Define server functions
server <- function(input, output){
    
    # Choropleth Map
    # output$map <- renderPlotly({
    #  map_df <- df_types %>% 
    #   filter(year == input$year)
    #z_min <- map_df$Value
    #z_max <- map_df$Value
    output$map <- renderPlotly({
        dmap %>% 
            filter(Year == input$mapyear) %>%
            plot_ly(.) %>% 
            add_trace(
                type="choropleth",
                geojson=counties,
                locations=~GeoFips,
                z=~Value,
                colorscale=input$mapcolor,
                zmin=0,
                zmax=100000,
                text =~hover,
                marker=list(line=list(
                    width=0))) %>% 
            colorbar(title = "Salary") %>% 
            layout(title = "U.S. Median Income Per Capita") %>% 
            layout(geo = g) 
    })
    
    # Method Tab
    output$method1 <- renderPlot({
        
        method_function <- switch(input$method_geom_function,
                                  boxplot = geom_boxplot,
                                  density = geom_density,
                                  hist = geom_histogram, 
                                  bar = geom_bar)
        
        df_finkey %>% 
            filter(key == input$df_finkey_key) %>% 
            ggplot(aes(value, col = key)) + 
            method_function(alpha = .05) + 
            geom_vline(xintercept = 100) + 
            labs(subtitle = "Method Distributions", x = "Selected Statistic", y = "Count") + 
            theme(plot.subtitle = element_text(hjust = 0.5)) + 
            facet_wrap(~key, scales = "free_x", labeller = labeller(key = hainames)) +
            theme(legend.position = "none", 
                  panel.grid = element_blank()) 
    })
    
    output$method2 <- renderPlot({
        # HAI Scatterplot Comparisson Plots
        HAINAMES <- list("Normal" = "HAI", "Real Wage"="HAIRW", "Rent Adjustment"="HAIRNT", 
                         "Inflation Adjusted"="HAIIPD", "Raw Values"="HAIRAW", "Lenient Lending"="HAILEN")
        hainames <- c("HAI" = "Normal", 
                      "HAIRW"="Real Wage", 
                      "HAIRNT"="Rent Adjusted", 
                      "HAIIPD"="Inflation Adjusted", 
                      "HAIRAW"="Raw Values", 
                      "HAILEN"="Lenient Lending")
        HAItitle <- function(variable,value){
            return(HAINAMES[value])
        }
        # Main 6 HAIs labeled Scatterplot Trends
        main6 <- df.fin %>%
            gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
                   -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
            filter(key == input$df_finkey_key) %>% 
            filter(AINCALL <100000) %>% 
            ggplot(aes(value, (AINCALL/1000))) + 
            geom_point(aes(x = value, alpha = .01, col = key)) + 
            geom_vline(xintercept = 100, lty = "dotdash", col = "black") + 
            geom_smooth(aes(x = value), 
                        method="lm", col = "grey30", fill = "light grey",
                        se = T, na.rm = T) + 
            labs(x = "Home Affordability Value", y = "Income ($1000)", 
                 subtitle = "Method Comparison to National Benchmark") +
            facet_wrap(key ~ ., scales = "free_x", shrink = F, labeller = labeller(key = hainames)) + 
            theme(legend.position = "none", 
                  plot.subtitle = element_text(hjust = 0.5), 
                  panel.grid = element_blank())
        # Outstanding Debts HAI ScatterPlot Trends
        dbts1 <- df.fin %>%
            gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
                   -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
            filter(key == c("HAIDBT")) %>% 
            filter(AINCALL <100000) %>% 
            ggplot(aes(value, (AINCALL/1000))) + 
            geom_point(aes(x = value, alpha = .01, col = key)) + 
            geom_vline(xintercept = 100, lty = "dotdash", col = "black") + 
            geom_smooth(aes(x = value), 
                        method="loess", col = "grey30", fill = "light grey",
                        se = T, na.rm = T) + 
            labs(x = "Home Affordability Value", y = "Income ($1000)", 
                 subtitle = "Debt Adjusted") +
            theme(legend.position = "none", 
                  plot.title = element_text(hjust = .5)) 
        dbts2 <- df.fin %>%
            gather(key, value, -GeoFips, -GeoName, -year, -MEDINC, 
                   -MEDVAL, -MOE, -UMEDVAL, -LMEDVAL, -POP, -PERINC, -AINCALL) %>%
            filter(key == c("HAIDBT")) %>% 
            filter(AINCALL <100000) %>% 
            ggplot(aes(value, (AINCALL/1000))) + 
            geom_point(aes(x = value, alpha = .01, col = key)) +
            geom_smooth(aes(x = value), 
                        method="loess", col = "grey30", fill = "light grey",
                        se = T, na.rm = T) + 
            labs(x = "Home Affordability Value", y = element_blank(), 
                 subtitle = "Debt Adjusted Centered") +
            theme(legend.position = "none", 
                  plot.title = element_text(hjust = .5), 
                  panel.grid.minor.y = element_blank())
        # Arrange plots 
        ggarrange(main6,
                  ggarrange(dbts1, dbts2, 
                            ncol=2, labels = c(" ", " ")),
                  nrow = 2, labels = " ")
    })
    
    output$method3 <- renderPlot({
        MEGANAMES <- list("Affordable" = "GT100", "Unaffordable"="LT100")
        meganames <- c("GT100" = "Affordable", 
                       "LT100"="Unaffordable")
        megatitles <- function(variable,value){
            return(MEGANAMES[value])
        }
        # Megaplots 
        PMEDINC.median <- median(d$PMEDINC)
        megaplot1 <- d %>% 
            sample_n(715, replace = T) %>% 
            filter(key == input$df_finkey_key) %>%
            group_by(key, Set) %>%
            arrange(desc(Set)) %>% 
            ggplot(aes(x = MMEDHAI, col = key)) + geom_point(aes(y = PMEDINC, col = key, size = 4)) + 
            geom_hline(yintercept = PMEDINC.median, lty = "dotted") + 
            geom_point(aes(y = PMEDINC)) +
            facet_wrap(~Set, scales = "free_x", labeller = labeller(Set = meganames)) +
            geom_smooth(aes(y = PMEDINC), 
                        method="loess",
                        col = "grey30", 
                        fill = "light grey", 
                        se = T, na.rm = T, 
                        lty = "solid") + 
            geom_smooth(aes(y = PMEDINC), 
                        method="lm", alpha = 0.25,
                        col = "blue", 
                        fill = "light blue", 
                        se = F, na.rm = T, 
                        lty = "dashed") + 
            labs(x = "Median HAI Value", y = "Median Income") + 
            theme(legend.position = "none", plot.title = element_blank())
        megaplot2 <- d %>% 
            sample_n(715, replace = T) %>% 
            filter(key == input$df_finkey_key) %>%
            group_by(key, Set) %>% 
            ggplot(aes(x = MMEDHAI, col = key)) + geom_point(aes(y = PMEDINC, col = key, size = 4)) + 
            geom_hline(yintercept = PMEDINC.median, lty = "dotted")  +
            facet_wrap(~key, scales = "free", labeller = labeller(key = hainames)) +
            geom_smooth(aes(y = PMEDINC), 
                        method="loess",
                        col = "grey30", 
                        fill = "light grey", 
                        se = F, na.rm = T, 
                        lty = "solid") + 
            geom_smooth(aes(y = PMEDINC), 
                        method="lm", alpha = 0.25,
                        col = "blue", 
                        fill = "light blue", 
                        se = T, na.rm = T, 
                        lty = "dashed") + 
            labs(x = element_blank(), y = "Median Income", subtitle = "Patterns in MSA by HAI Method") + 
            theme(legend.position = "none", 
                  plot.subtitle = element_text(hjust=0.5))
        ggarrange(megaplot2, megaplot1, nrow=2)
    })
    
    output$method4 <- renderPlot({
        d %>% 
            sample_n(715, replace = T) %>%
            filter(key == input$df_finkey_key) %>% 
            group_by(key, Set) %>% 
            ggplot(aes(x = year, col = key)) + geom_point(aes(y = PMEDINC, col = key)) + 
            geom_hline(yintercept = PMEDINC.median, lty = "dotted") + 
            geom_line(aes(y = PMEDINC)) +
            facet_wrap(~Set, scales = "free", labeller = labeller(Set = meganames)) +
            geom_smooth(aes(y = PMEDINC), 
                        method="loess",
                        col = "grey30", 
                        fill = "light grey", 
                        se = T, na.rm = T, 
                        lty = "solid") + 
            labs(x = element_blank(), y = "Median Income", subtitle = "Method Comparison for all MSA per Year") +
            theme(legend.position = "none", 
                  plot.subtitle = element_text(hjust = 0.5),
                  panel.grid.minor.x = element_blank(), 
                  panel.grid.major.y = element_blank(), 
                  panel.grid.minor.y = element_blank())
    })
    
    output$method4_5 <- renderPlot({
        d %>% 
            sample_n(715, replace = T) %>%
            filter(key == input$df_finkey_key) %>%
            group_by(key, Set) %>% 
            ggplot(aes(x = year, col = key)) + geom_point(aes(y = MMEDHAI, col = key)) + 
            geom_hline(yintercept = 100,  lty = "dotted") + 
            geom_line(aes(y = MMEDHAI)) +
            facet_wrap(~Set, scales = "fixed", labeller = labeller(Set = meganames)) +
            geom_smooth(aes(y = MMEDHAI), 
                        method="lm",
                        col = "grey30", 
                        fill = "light grey", 
                        se = T, na.rm = T, 
                        lty = "solid") + 
            labs(x = element_blank(), y = "Median HAI", subtitle = "Method Comparison for all MSA per Year") +
            theme(legend.position = "none", 
                  plot.subtitle = element_text(hjust = 0.5),
                  panel.grid.minor.x = element_blank(), 
                  panel.grid.major.y = element_blank(), 
                  panel.grid.minor.y = element_blank()) 
    })
    
    output$method5 <- renderPlot({
        d %>% 
            sample_n(715, replace = T) %>%
            filter(key == input$df_finkey_key) %>%
            group_by(key, Set) %>% 
            ggplot(aes(x = year, col = key)) + geom_point(aes(y = MMEDHAI, col = key)) + 
            geom_hline(yintercept = 100, lty = "dotted")  +
            facet_wrap(~key, scales = "fixed", labeller = labeller(key = hainames)) +
            geom_smooth(aes(y = MMEDHAI), 
                        method="lm",
                        col = "grey30", 
                        fill = "light blue", 
                        se = T, na.rm = T, 
                        lty = "solid") + 
            theme(legend.position = "none", 
                  plot.subtitle = element_text(hjust = 0.5)) + 
            labs(x = element_blank(), y = "Median HAI", 
                 subtitle = "Method Comparisson for all MSA by Year (Above and Below National Benchmark = 100)")
    })
    
    output$method6 <- renderPlot({
        
        method_function <- switch(input$method_geom_function,
                                  boxplot = geom_boxplot,
                                  density = geom_density,
                                  hist = geom_histogram, 
                                  bar = geom_bar)
        
        df_types %>% 
            filter(Type == input$method6type) %>% 
            ggplot(aes(value, col = key, alpha = 0.05)) + 
            method_function() + 
            labs(subtitle = "Distribution", x = "Selected Statistic", y = "Count") + 
            theme(plot.subtitle = element_text(hjust = 0.5)) + 
            facet_wrap(~key, scales = "free") +
            theme(legend.position = "none", 
                  panel.grid = element_blank())
    })
    
    
    # Income Tab
    output$boxplotincome <- renderPlotly({
        df.tbl %>% 
            filter(Statistic == input$Statisticdftbl) %>% 
            plot_ly(., y = ~min, name = 'min', type = "box", boxpoints = "all", jitter = 0.75,
                    pointpos = 0, 
                    marker = list(opacity = 0.5, color = 'rgb(17, 157, 255)', line = list(width = 2))) %>% 
            add_trace(y = ~med, name = 'med', boxpoints = "all", jitter = 0.3,
                      pointpos = 0, 
                      marker = list(opacity = 0.5, color = 'rgb(17, 157, 255)', line = list(width = 2))) %>% 
            add_trace(y = ~max, name = 'max', boxpoints = "all", jitter = 0.3,
                      pointpos = 0, 
                      marker = list(opacity = 0.5, color = 'rgb(17, 157, 255)', line = list(width = 2))) %>% 
            layout(yaxis = list(title = "Selected Statistic"))
    })
    
    output$plotincome2 <- renderPlotly({
        df.tbl %>% 
            filter(Statistic == input$Statisticdftbl) %>% 
            plot_ly(., x = ~Years, y = ~min, name = "min", type = "scatter", mode = "lines+markers") %>% 
            add_trace(y = ~med, name = 'med', mode = 'lines+markers') %>% 
            add_trace(y = ~max, name = 'max', mode = 'lines+markers') %>% 
            layout(xaxis = list(title = "Year"),
                   yaxis = list(title = "Selected Statistic"))
    })
    
    
    # Population Tab
    output$barproportionmsabymethod <- renderPlot({
        d %>% 
            filter(key == input$barcharthaikey2) %>% 
            ggplot(aes(year, (TPOP/1000000), fill=Set)) + 
            geom_col(col = "grey38", alpha= 0.25) + 
            # scale_x_discrete(limit = c(2010, 2015, 2019)) + 
            labs(x = "Year (2010 - 2019)", y = "Population (Millions)", subtitle = "Proportion of MSA Population by Method") + 
            theme(axis.text.x = element_blank(), 
                  # axis.ticks = element_line(size = .5), 
                  plot.subtitle = element_text(hjust = 0.5)) +
            facet_wrap(~key, scales = "fixed", labeller = labeller(key = hainames)) + 
            scale_fill_discrete(limits = c("LT100", "GT100"), labels = c("Unaffordable", "Affordable") )
    })
    
    output$barcharthai <- renderPlotly({
        d %>% 
            filter(Set == input$barcharthaiset) %>%
            filter(key %in% input$barcharthaikey) %>% 
            plot_ly(., x = ~year, y = ~(TPOP/1000000), type = "bar", name = ~key, opacity = 0.75) %>% 
            layout(yaxis = list(title = "Population (Millions)"))
    })  
    
    # Tables Tab
    output$ltdftable <- renderDataTable({
        ltdf %>% 
            dplyr::select(GeoName, key, year, MEDINC, MEDVAL, MOE, POP, AINCALL, value) %>%
            filter(key == input$haitablestab) 
    }, filter = 'top',
    rownames = T)
    
    output$gtdftable <- renderDataTable({
        gtdf %>% 
            dplyr::select(GeoName, key, year, MEDINC, MEDVAL, MOE, POP, AINCALL, value) %>%
            filter(key == input$haitablestab) 
    }, filter = 'top',
    rownames = T)
    
    output$alltable <- renderDataTable({
        df.fin %>% 
            filter(GeoName == input$dffingeoname)
    }, filter = "top", 
    rownames = F)
    
} # Close server