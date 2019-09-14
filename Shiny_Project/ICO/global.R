library(shiny)
library(dplyr)
library(ggplot2)
library(data.table)
library(DT)
library(plotly)
library(gapminder)

ICO_1 <- fread(file = "./ICO_CROP_DATA.csv")

#### Top 6 of the World

ICO_K <- ICO_1 %>% 
  filter(YEAR >= '2013') %>% 
  group_by(YEAR, COUNTRY) %>% 
  summarise(Total_Consumption = sum(DOMESTIC_CONSUMPTION)) %>% 
  arrange(desc(Total_Consumption)) %>% 
  top_n(5)

g_1_1 <- ggplot(ICO_K, aes(x = YEAR, y = Total_Consumption)) +
  geom_bar(stat = 'identity', aes(fill = COUNTRY), position = 'dodge') +
  xlab('Year') +
  ylab('Domestic Comsumption (in thousand of 60 kg bags)') +
  ggtitle('Domestic Consumption by Top 5 Countries') +
  theme_light() +
  theme(plot.title = element_text(size=15,
                                  face="bold", hjust = 0.5),
        axis.title.x = element_text(size=12, 
                                    face="bold"),
        axis.title.y = element_text(size=12,
                                    face="bold"),
        legend.title = element_text(size=12, 
                                    face="bold"),
        legend.text = element_text(size=10, 
                                   face="bold")) 



ICO_L <- ICO_1 %>% 
  filter(YEAR >= '2013') %>% 
  group_by(YEAR, COUNTRY) %>% 
  summarise(Total_Prod = sum(TOTAL_PRODUCTION)) %>% 
  arrange(desc(Total_Prod)) %>% 
  top_n(5)

g_1_2 <- ggplot(ICO_L, aes(x = YEAR, y = Total_Prod)) +
  geom_bar(stat = 'identity', aes(fill = COUNTRY), position = 'dodge') +
  xlab('Year') +
  ylab('Total Production (in thousand of 60 kg bags)') +
  ggtitle('Total Production by Top 5 Countries') +
  theme_light() +
  theme(plot.title = element_text(size=15,
                                  face="bold", hjust = 0.5),
        axis.title.x = element_text(size=12, 
                                    face="bold"),
        axis.title.y = element_text(size=12,
                                    face="bold"),
        legend.title = element_text(size=12, 
                                    face="bold"),
        legend.text = element_text(size=10, 
                                   face="bold")) 


#### CHANGES IN TOTAL PRODUCTION AND DOMESTIC CONSUMPTION (1990-2017)

ICO_Top_PROD <- ICO_1 %>% 
  filter(COUNTRY == 'Brazil' | 
           COUNTRY == 'Colombia' | 
           COUNTRY == 'Ethiopia' |
           COUNTRY == 'Guatemala' |
           COUNTRY == 'Honduras' |
           COUNTRY == 'India' |
           COUNTRY == 'Indonesia' |
           COUNTRY == 'Mexico' |
           COUNTRY == 'Uganda' |
           COUNTRY == 'Vietnam')

##### 'Total Production' vs 'Domestic Consumption' by 'SEASON'

ICO_by_April <- ICO_1 %>% 
  group_by(YEAR) %>% 
  filter(MONTH == 'April')

cor(ICO_by_April$TOTAL_PRODUCTION, ICO_by_April$DOMESTIC_CONSUMPTION)

g_spring <-  ggplot(ICO_by_April, aes(x = TOTAL_PRODUCTION, y = DOMESTIC_CONSUMPTION)) +
  geom_point(col = 'lightgreen') + 
  xlab('Total Production') +
  ylab('Domestic Consumption') +
  ggtitle('Spring (April)') +
  theme_light() +
  theme(plot.title = element_text(size=14,
                                  face="bold", hjust = 0.5),
        axis.title.x = element_text(size=12, 
                                    face="bold"),
        axis.title.y = element_text(size=12,
                                    face="bold"))

ICO_by_July <- ICO_1 %>% 
  group_by(YEAR) %>% 
  filter(MONTH == 'July')

cor(ICO_by_July$TOTAL_PRODUCTION, ICO_by_July$DOMESTIC_CONSUMPTION)


g_summer <- ggplot(ICO_by_July, aes(x = TOTAL_PRODUCTION, y = DOMESTIC_CONSUMPTION)) +
  geom_point(col = 'orange') + 
  xlab('Total Production') +
  ylab('Domestic Consumption') +
  ggtitle('Summer (July)') +
  theme_light() +
  theme(plot.title = element_text(size=14,
                                  face="bold", hjust = 0.5),
        axis.title.x = element_text(size=12, 
                                    face="bold"),
        axis.title.y = element_text(size=12,
                                    face="bold"))


ICO_by_October <- ICO_1 %>% 
  group_by(YEAR) %>% 
  filter(MONTH == 'October')

cor(ICO_by_October$TOTAL_PRODUCTION, ICO_by_October$DOMESTIC_CONSUMPTION)


g_fall <- ggplot(ICO_by_October, aes(x = TOTAL_PRODUCTION, y = DOMESTIC_CONSUMPTION)) +
  geom_point(col = 'blue') + 
  xlab('Total Production') +
  ylab('Domestic Consumption') +
  ggtitle('Fall (October)') +
  theme_light() +
  theme(plot.title = element_text(size=14,
                                  face="bold", hjust = 0.5),
        axis.title.x = element_text(size=12, 
                                    face="bold"),
        axis.title.y = element_text(size=12,
                                    face="bold"))

########### Percentage change in Total Production (2010 - 2017)

ICO_PCT_CHG <- ICO_Top_PROD %>% 
  group_by(COUNTRY) %>% 
  arrange(YEAR, .by_group = TRUE) %>% 
  mutate(pct_change = (TOTAL_PRODUCTION/lag(TOTAL_PRODUCTION) - 1) * 100)

ICO_PCT_CHG <-ICO_PCT_CHG %>% 
  filter(YEAR > 2010)

g_pct_chg <- ggplot(ICO_PCT_CHG, aes(x = YEAR, y = pct_change)) +
  geom_line(aes(col = COUNTRY)) +
  theme_light() +
  guides(size = FALSE) +
  labs(
    title = '% CHANGES IN TOTAL PRODUCTION (2010-2017)',
    x = 'YEAR',
    y = ' % Change in TOTAL PRODUCTION'
  ) +
  theme(plot.title = element_text(size=14,
                                  face="bold", hjust = 0.5),
        axis.title.x = element_text(size=11, 
                                    face="bold"),
        axis.title.y = element_text(size=11,
                                    face="bold"),
        legend.title = element_text(size=10, 
                                    face="bold"),
        legend.text = element_text(size=10, 
                                   face="bold"),
        legend.key.size = unit(0.5, 'cm'))

p_chg_prod <- ggplotly(g_pct_chg)

# Sys.setenv("plotly_username"="Venkata22v")
# Sys.setenv("plotly_api_key"="sNZw7dyTP26eiMdnWrJK")
# 
# api_create(p_chg_prod, filename = "r-ico-pct-chg-prod")



