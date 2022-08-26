# flag_valid_day


```r
library(tidyverse)
library(magrittr)
library(lubridate)
library(fitibble)

minute_data <- readRDS("../../data/prep/minute_data__export_1.rds")
```

## flag_adherent


```r
flag_adherent(sample(minute_data$time, 50))
```

```
##  [1] FALSE FALSE  TRUE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE  TRUE
## [21]  TRUE  TRUE  TRUE  TRUE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
## [41] FALSE FALSE FALSE FALSE  TRUE FALSE  TRUE  TRUE FALSE  TRUE
```


## nonwear_method missing_HR


```r
#apply nonwear method
minute_data <- readRDS("../../data/prep/minute_data__export_1.rds") %>% 
  group_by(id) %>%
  mutate(
    is_wear = !flag_nonwear(HR, 
                            steps, 
                            nonwear_method = "missing_HR"),  
    is_adherent = flag_adherent(time)
  )
```

* valid_adherent_hours


```r
#apply valid_adherent_hours method
xx <- minute_data %>% 
  mutate(date = as.Date(time)) %>% 
  group_by(id, date) %>% 
  nest() %>% 
  mutate(
    adherent_minutes = map(data, function(x) 
      sum(x$is_wear * x$is_adherent)),
    valid_adherent_hours = map(data, function(x) 
      flag_valid_adherent_hours(x$is_wear, x$is_adherent))
  ) %>% 
  select(id, date, adherent_minutes, valid_adherent_hours) %>% 
  unnest(cols = c(adherent_minutes, valid_adherent_hours))

table(filter(xx, adherent_minutes < 600) %>% pull(valid_adherent_hours))
```

```
## 
## FALSE 
##   929
```

```r
table(filter(xx, adherent_minutes >= 600) %>% pull(valid_adherent_hours))
```

```
## 
## TRUE 
##  541
```

* flag_valid_step_count


```r
#apply valid_step_count method
xx <- minute_data %>% 
  mutate(date = as.Date(time)) %>% 
  group_by(id, date) %>% 
  nest() %>% 
  mutate(
    step_count = map(data, function(x) 
      sum(x$is_wear * x$is_adherent * x$steps, na.rm = T)),
    valid_step_count = map(data, function(x) 
      flag_valid_step_count(x$is_wear, x$is_adherent, x$steps))
  ) %>% 
  select(id, date, step_count, valid_step_count) %>% 
  unnest(cols = c(step_count, valid_step_count))

table(filter(xx, step_count < 1000) %>% pull(valid_step_count))
```

```
## 
## FALSE 
##  1088
```

```r
table(filter(xx, step_count >= 1000) %>% pull(valid_step_count))
```

```
## 
## TRUE 
##  382
```

## nonwear_method choi_HR


```r
#apply nonwear method
minute_data <- readRDS("../../data/prep/minute_data__export_1.rds") %>% 
  group_by(id) %>%
  mutate(
    is_wear = !flag_nonwear(HR, 
                            steps, 
                            nonwear_method = "choi_HR"),  
    is_adherent = flag_adherent(time)
  )
```

* valid_adherent_hours


```r
#apply valid_adherent_hours method
xx <- minute_data %>% 
  mutate(date = as.Date(time)) %>% 
  group_by(id, date) %>% 
  nest() %>% 
  mutate(
    adherent_minutes = map(data, function(x) 
      sum(x$is_wear * x$is_adherent)),
    valid_adherent_hours = map(data, function(x) 
      flag_valid_adherent_hours(x$is_wear, x$is_adherent))
  ) %>% 
  select(id, date, adherent_minutes, valid_adherent_hours) %>% 
  unnest(cols = c(adherent_minutes, valid_adherent_hours))

table(filter(xx, adherent_minutes < 600) %>% pull(valid_adherent_hours))
```

```
## 
## FALSE 
##   924
```

```r
table(filter(xx, adherent_minutes >= 600) %>% pull(valid_adherent_hours))
```

```
## 
## TRUE 
##  546
```

* flag_valid_step_count


```r
#apply valid_step_count method
xx <- minute_data %>% 
  mutate(date = as.Date(time)) %>% 
  group_by(id, date) %>% 
  nest() %>% 
  mutate(
    step_count = map(data, function(x) 
      sum(x$is_wear * x$is_adherent * x$steps, na.rm = T)),
    valid_step_count = map(data, function(x) 
      flag_valid_step_count(x$is_wear, x$is_adherent, x$steps))
  ) %>% 
  select(id, date, step_count, valid_step_count) %>% 
  unnest(cols = c(step_count, valid_step_count))

table(filter(xx, step_count < 1000) %>% pull(valid_step_count))
```

```
## 
## FALSE 
##  1088
```

```r
table(filter(xx, step_count >= 1000) %>% pull(valid_step_count))
```

```
## 
## TRUE 
##  382
```

## Per subject comparison


```r
#apply nonwear method
minute_data <- readRDS("../../data/prep/minute_data__export_1.rds") %>% 
  group_by(id) %>%
  mutate(
    is_wear = !flag_nonwear(HR, 
                            steps, 
                            nonwear_method = "missing_HR"),  
    is_adherent = flag_adherent(time)
  )

#apply valid_day method
minute_data %>% 
  mutate(date = as.Date(time)) %>% 
  group_by(id, date) %>% 
  nest() %>% 
  mutate(
    valid_adherent_hours = map(data, function(x) 
      flag_valid_day(x$is_wear, x$is_adherent, 
                     valid_day_method = "valid_adherent_hours")), 
    valid_step_count = map(data, function(x) 
      flag_valid_day(x$is_wear, x$is_adherent, 
                     valid_day_method = "valid_step_count", 
                     steps = x$steps))
  ) %>% 
  select(id, date, valid_adherent_hours, valid_step_count) %>% 
  unnest(c(valid_adherent_hours, valid_step_count)) %>% 
  group_by(id) %>% 
  summarise(valid_adherent_hours = sum(valid_adherent_hours), 
            valid_step_count = sum(valid_step_count))
```

```
## # A tibble: 4 × 3
##      id valid_adherent_hours valid_step_count
##   <int>                <int>            <int>
## 1     1                  240              209
## 2     2                   56               62
## 3     3                  101              104
## 4     4                  144                7
```


```r
# modify valid_day method parameters
minute_data %>% 
  mutate(date = as.Date(time)) %>% 
  group_by(id, date) %>% 
  nest() %>% 
  mutate(
    valid_adherent_hours = map(data, function(x) 
      flag_valid_day(x$is_wear, x$is_adherent, 
                     valid_day_method = "valid_adherent_hours", 
                     minimum_adherent_hours = 5)), 
    valid_step_count = map(data, function(x) 
      flag_valid_day(x$is_wear, x$is_adherent, 
                     valid_day_method = "valid_step_count", 
                     steps = x$steps, 
                     minimum_step_count = 500))
  ) %>% 
  select(id, date, valid_adherent_hours, valid_step_count) %>% 
  unnest(c(valid_adherent_hours, valid_step_count)) %>% 
  group_by(id) %>% 
  summarise(valid_adherent_hours = sum(valid_adherent_hours), 
            valid_step_count = sum(valid_step_count))
```

```
## # A tibble: 4 × 3
##      id valid_adherent_hours valid_step_count
##   <int>                <int>            <int>
## 1     1                  246              235
## 2     2                   61               62
## 3     3                  110              113
## 4     4                  160               13
```
