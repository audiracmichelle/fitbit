# fitibble


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
```

* test fitibble class


```r
minute_data <- read_rds("../../data/prep/minute_data__export_1.rds") 

minute_data <- fitibble:::new_fitibble(
  minute_data, 
  intensity_colname = "intensity", 
  intensity_levels = c(sedentary = "0", 
                       light = "1", 
                       moderate = "2", 
                       active = "3")
)

attr(minute_data, "intensity_colname")
```

```
## [1] "intensity"
```

```r
attr(minute_data, "intensity_levels")
```

```
## sedentary     light  moderate    active 
##       "0"       "1"       "2"       "3"
```

```r
class(minute_data)
```

```
## [1] "fitibble"   "tbl_df"     "tbl"        "data.frame"
```


```r
minute_data$is_wear = T
minute_data$is_adherent = T
minute_data$is_valid_day = T
fitibble:::validate_fitibble(minute_data)
```

```
## # A tibble: 2,116,800 × 9
##    time                   id label                          HR steps intensity is_wear is_adherent is_valid_day
##    <dttm>              <int> <chr>                       <dbl> <dbl>     <dbl> <lgl>   <lgl>       <lgl>       
##  1 2019-04-26 00:00:00     1 0462-006 off study 5.6.2021    75     0         0 TRUE    TRUE        TRUE        
##  2 2019-04-26 00:01:00     1 0462-006 off study 5.6.2021    78     0         0 TRUE    TRUE        TRUE        
##  3 2019-04-26 00:02:00     1 0462-006 off study 5.6.2021    76     0         0 TRUE    TRUE        TRUE        
##  4 2019-04-26 00:03:00     1 0462-006 off study 5.6.2021    78     0         0 TRUE    TRUE        TRUE        
##  5 2019-04-26 00:04:00     1 0462-006 off study 5.6.2021    77     0         0 TRUE    TRUE        TRUE        
##  6 2019-04-26 00:05:00     1 0462-006 off study 5.6.2021    76     0         0 TRUE    TRUE        TRUE        
##  7 2019-04-26 00:06:00     1 0462-006 off study 5.6.2021    77     0         0 TRUE    TRUE        TRUE        
##  8 2019-04-26 00:07:00     1 0462-006 off study 5.6.2021    72     0         0 TRUE    TRUE        TRUE        
##  9 2019-04-26 00:08:00     1 0462-006 off study 5.6.2021    68     0         0 TRUE    TRUE        TRUE        
## 10 2019-04-26 00:09:00     1 0462-006 off study 5.6.2021    72     0         0 TRUE    TRUE        TRUE        
## # … with 2,116,790 more rows
## $intensity_colname
## [1] "intensity"
## 
## $intensity_levels
## sedentary     light  moderate    active 
##       "0"       "1"       "2"       "3"
```


```r
sum(minute_data$is_wear & minute_data$is_adherent & minute_data$is_valid_day)
```

```
## [1] 2116800
```

* test fitibble function


```r
#use fitibble function
minute_data <- read_rds("../../data/prep/minute_data__export_1.rds") %>% 
  fitibble()
fitibble:::validate_fitibble(minute_data)
```

```
## # A tibble: 2,116,800 × 9
##       id time                label                          HR steps intensity is_wear is_adherent is_valid_day
##    <int> <dttm>              <chr>                       <dbl> <dbl>     <dbl> <lgl>   <lgl>       <lgl>       
##  1     1 2019-04-26 00:00:00 0462-006 off study 5.6.2021    75     0         0 TRUE    FALSE       TRUE        
##  2     1 2019-04-26 00:01:00 0462-006 off study 5.6.2021    78     0         0 TRUE    FALSE       TRUE        
##  3     1 2019-04-26 00:02:00 0462-006 off study 5.6.2021    76     0         0 TRUE    FALSE       TRUE        
##  4     1 2019-04-26 00:03:00 0462-006 off study 5.6.2021    78     0         0 TRUE    FALSE       TRUE        
##  5     1 2019-04-26 00:04:00 0462-006 off study 5.6.2021    77     0         0 TRUE    FALSE       TRUE        
##  6     1 2019-04-26 00:05:00 0462-006 off study 5.6.2021    76     0         0 TRUE    FALSE       TRUE        
##  7     1 2019-04-26 00:06:00 0462-006 off study 5.6.2021    77     0         0 TRUE    FALSE       TRUE        
##  8     1 2019-04-26 00:07:00 0462-006 off study 5.6.2021    72     0         0 TRUE    FALSE       TRUE        
##  9     1 2019-04-26 00:08:00 0462-006 off study 5.6.2021    68     0         0 TRUE    FALSE       TRUE        
## 10     1 2019-04-26 00:09:00 0462-006 off study 5.6.2021    72     0         0 TRUE    FALSE       TRUE        
## # … with 2,116,790 more rows
## $intensity_colname
## [1] "intensity"
## 
## $intensity_levels
## sedentary     light  moderate    active 
##       "0"       "1"       "2"       "3"
```


```r
sum(minute_data$is_wear & minute_data$is_adherent & minute_data$is_valid_day)
```

```
## [1] 413991
```

```r
sum(minute_data$is_wear & minute_data$is_adherent & !minute_data$is_valid_day)
```

```
## [1] 20709
```

* test relevel_fittible function


```r
minute_data$nonsense <- 1
try(relevel_fitibble(
  minute_data, 
  intensity_colname = "nonsense", 
  intensity_levels = c(fool = "3")
  ))
```

```
## Error : Non-valid `intensity_levels`
```

```r
#an error should appear
```


```r
minute_data$nonsense <- 1
relevel_fitibble(
  minute_data, 
  intensity_colname = "nonsense", 
  intensity_levels = c(fool = "1")
  )
```

```
## # A tibble: 2,116,800 × 10
##       id time                label                          HR steps intensity is_wear is_adherent is_valid_day nonsense
##    <int> <dttm>              <chr>                       <dbl> <dbl>     <dbl> <lgl>   <lgl>       <lgl>           <dbl>
##  1     1 2019-04-26 00:00:00 0462-006 off study 5.6.2021    75     0         0 TRUE    FALSE       TRUE                1
##  2     1 2019-04-26 00:01:00 0462-006 off study 5.6.2021    78     0         0 TRUE    FALSE       TRUE                1
##  3     1 2019-04-26 00:02:00 0462-006 off study 5.6.2021    76     0         0 TRUE    FALSE       TRUE                1
##  4     1 2019-04-26 00:03:00 0462-006 off study 5.6.2021    78     0         0 TRUE    FALSE       TRUE                1
##  5     1 2019-04-26 00:04:00 0462-006 off study 5.6.2021    77     0         0 TRUE    FALSE       TRUE                1
##  6     1 2019-04-26 00:05:00 0462-006 off study 5.6.2021    76     0         0 TRUE    FALSE       TRUE                1
##  7     1 2019-04-26 00:06:00 0462-006 off study 5.6.2021    77     0         0 TRUE    FALSE       TRUE                1
##  8     1 2019-04-26 00:07:00 0462-006 off study 5.6.2021    72     0         0 TRUE    FALSE       TRUE                1
##  9     1 2019-04-26 00:08:00 0462-006 off study 5.6.2021    68     0         0 TRUE    FALSE       TRUE                1
## 10     1 2019-04-26 00:09:00 0462-006 off study 5.6.2021    72     0         0 TRUE    FALSE       TRUE                1
## # … with 2,116,790 more rows
## $intensity_colname
## [1] "nonsense"
## 
## $intensity_levels
## fool 
##  "1"
```

* test crop_valid function

```r
valid_data <- crop_valid(minute_data, mask = T)
sum(valid_data$is_valid)
```

```
## [1] 413991
```

```r
sum(!is.na(valid_data$HR))
```

```
## [1] 413991
```

```r
sum(!is.na(valid_data$steps))
```

```
## [1] 413991
```

```r
sum(!is.na(valid_data$intensity))
```

```
## [1] 413991
```


```r
valid_data <- crop_valid(minute_data)
nrow(valid_data)
```

```
## [1] 413991
```


* test crop_nonvalid function


```r
nonvalid_data <- crop_nonvalid(minute_data, mask = T)
sum(nonvalid_data$is_nonvalid)
```

```
## [1] 20709
```

```r
sum(!is.na(nonvalid_data$HR))
```

```
## [1] 20709
```

```r
sum(!is.na(nonvalid_data$steps))
```

```
## [1] 20709
```

```r
sum(!is.na(nonvalid_data$intensity))
```

```
## [1] 20709
```


```r
nonvalid_data <- crop_nonvalid(minute_data)
nrow(nonvalid_data)
```

```
## [1] 20709
```
