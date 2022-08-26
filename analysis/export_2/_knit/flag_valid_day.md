# flag_valid_day


```r
library(tidyverse)
```

```
## ── Attaching packages ─────────────────────────────────────────────────────────────────────────────────── tidyverse 1.3.1 ──
```

```
## ✓ ggplot2 3.3.5     ✓ purrr   0.3.4
## ✓ tibble  3.1.6     ✓ dplyr   1.0.8
## ✓ tidyr   1.2.0     ✓ stringr 1.4.1
## ✓ readr   2.1.2     ✓ forcats 0.5.1
```

```
## ── Conflicts ────────────────────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
## x dplyr::filter() masks stats::filter()
## x dplyr::lag()    masks stats::lag()
```

```r
library(magrittr)
```

```
## 
## Attaching package: 'magrittr'
```

```
## The following object is masked from 'package:purrr':
## 
##     set_names
```

```
## The following object is masked from 'package:tidyr':
## 
##     extract
```

```r
library(lubridate)
```

```
## 
## Attaching package: 'lubridate'
```

```
## The following objects are masked from 'package:base':
## 
##     date, intersect, setdiff, union
```

```r
library(fitibble)

minute_data <- readRDS("../../data/prep/minute_data__export_2.rds")
```

## flag_adherent


```r
flag_adherent(sample(minute_data$time, 50))
```

```
##  [1]  TRUE FALSE  TRUE FALSE  TRUE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE
## [21] FALSE  TRUE FALSE FALSE  TRUE  TRUE  TRUE  TRUE FALSE  TRUE FALSE FALSE  TRUE  TRUE FALSE  TRUE FALSE FALSE  TRUE FALSE
## [41]  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE  TRUE FALSE
```

## nonwear_method missing_HR


```r
#apply nonwear method
minute_data <- readRDS("../../data/prep/minute_data__export_2.rds") %>% 
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
##  6087
```

```r
table(filter(xx, adherent_minutes >= 600) %>% pull(valid_adherent_hours))
```

```
## 
## TRUE 
## 4679
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
##  6771
```

```r
table(filter(xx, step_count >= 1000) %>% pull(valid_step_count))
```

```
## 
## TRUE 
## 3995
```

## nonwear_method choi_HR


```r
#apply nonwear method
minute_data <- readRDS("../../data/prep/minute_data__export_2.rds") %>% 
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
##  5929
```

```r
table(filter(xx, adherent_minutes >= 600) %>% pull(valid_adherent_hours))
```

```
## 
## TRUE 
## 4837
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
##  6770
```

```r
table(filter(xx, step_count >= 1000) %>% pull(valid_step_count))
```

```
## 
## TRUE 
## 3996
```

## Per subject comparison


```r
#apply nonwear method
minute_data <- readRDS("../../data/prep/minute_data__export_2.rds") %>% 
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
            valid_step_count = sum(valid_step_count)) %>% 
  mutate(ratio = valid_adherent_hours / valid_step_count) %>% 
  arrange(ratio)
```

```
## # A tibble: 46 × 4
##       id valid_adherent_hours valid_step_count ratio
##    <int>                <int>            <int> <dbl>
##  1    15                    0                1 0    
##  2    42                    2                4 0.5  
##  3    34                   29               47 0.617
##  4    32                   26               39 0.667
##  5    11                  195              287 0.679
##  6    23                   40               55 0.727
##  7    35                   69               91 0.758
##  8     3                    6                7 0.857
##  9    38                   60               70 0.857
## 10     8                   73               84 0.869
## # … with 36 more rows
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
## # A tibble: 46 × 3
##       id valid_adherent_hours valid_step_count
##    <int>                <int>            <int>
##  1     1                  341              244
##  2     2                   79               51
##  3     3                    7                8
##  4     4                  382              302
##  5     5                  246              235
##  6     6                   61               62
##  7     8                   86               88
##  8     9                  110              113
##  9    10                  213              215
## 10    11                  296              297
## # … with 36 more rows
```
