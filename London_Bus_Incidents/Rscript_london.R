library(tidyverse)
library(lubridate)
library(ggplot2)
library(readxl)

#prepare data / clean data
df <- read_xlsx('TFL Bus Safety.xlsx')
# this dataset has 12 coloums and 23,168 rows
str(df)

#adjust letter to easy coding
colnames(df) <- tolower(colnames(df))

# change column name to better understanding and remove column bus garage 
df <- df %>% select(!`bus garage`) %>%
             rename(incident_date = "date of incident",
                    company = "group name",
                    injury_result = "injury result description",
                    incident_type = "incident event type",
                    victim_category = "victim category",
                    victim_sex = "victims sex",
                    victim_age = "victims age")
# check missing values 
which(is.na(df)) 
# this data set don't has any missing value so we good to go !! 





# Data Exploring 
# first, we have 23158 incidents from january 2015 to September 2018
count(df)
min(df$incident_date) 
max(df$incident_date)
n_distinct(df$operator) # 25 bus operators

# I try to transform data into seperated table for easy to build a data vistualisation

# Bus Operator and number of incidents. (we make a table for data vistualise later)  
df_operator <- df %>% 
                select (operator) %>% 
                group_by(operator) %>% 
                count() %>% 
                arrange(desc(n))


# we try to look in to boroughs in london that accidents occurred.
df_area <- df %>% 
            select(company,operator, borough) %>% 
            group_by(company,operator) %>% 
            count(borough) %>% 
            arrange(desc(n))


df_age_incidents <- df %>% 
                    select(victim_age,incident_type) %>%
                    group_by(victim_age, incident_type) %>%
                    count(incident_type) %>%
                    arrange(victim_age,desc(n))



df_injury <- df %>% 
              select(victim_category,injury_result) %>% 
              group_by(victim_category, injury_result) %>%
              count() %>%
              arrange(victim_category,desc(n))

# by year and months
df_year_month <- df %>% 
  select (incident_date) %>% 
  mutate(month = month(incident_date,label = T , abbr = T), 
         year = year(incident_date)) %>%
  group_by(year,month) %>% 
  summarise(number_incidents = n() , .groups = 'drop') %>%
  arrange(year,month,desc(number_incidents))



##Data Vistualisation
# Chart: Incident types and Number of Incidents
df_age_incidents %>% 
  select(victim_age,incident_type,n) %>% 
  ggplot(.,aes(reorder(victim_age,-n),n , label = n)) + 
  geom_col() +geom_text(vjust = -0.3) + 
  facet_wrap(~incident_type, nrow = 2) +
  labs(
    title = "Comparison of Incident Types and Number of Incidents") + 
  xlab ("Number of Incidents") + 
  ylab("Incident type")    

#Chart:Total Incidents in month between 2015 -2018
df_year_month %>% ggplot(.,aes(month,number_incidents, group = year)) +
  geom_line(linejoin = "round") +
  geom_smooth(
    method = "lm", 
    color = "salmon", 
    se = FALSE) +
  labs(
    title = "Monthly Incidents Trend Between 2015 and 2018 with     Correlation Line",
       x = "Date",
       y = "Number of Incidents") +
  facet_wrap(~ year, scales = "free_x")


#Chart: Most incidents occurred in boroughs between 2015-2018
df_area %>% head(10) %>% ggplot(.,aes(borough,n)) + geom_col()





                                                                                                                          
