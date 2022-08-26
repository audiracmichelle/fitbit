# prep_minute_data


```r
library(tidyverse)
library(magrittr)
library(lubridate)
library(fitibble)
```


```r
fitabase_files <- read_fitabase_files("../../data/input/export_1.zip")
fitabase_files$files
```

```
## # A tibble: 12 × 6
##    filename                                                                     filetype  lines label    id is_valid_file_l…
##    <chr>                                                                        <chr>     <int> <chr> <int> <lgl>           
##  1 0462-006 off study 5.6.2021_heartrate_1min_20181231_20211231.csv             HR       3.46e5 0462…     1 TRUE            
##  2 0462-007 completed 24 month follow-up 3.17.2021_heartrate_1min_20181231_202… HR       5.60e4 0462…     2 TRUE            
##  3 0462-010 Aug 17 2020 informed that device had been lost_heartrate_1min_2018… HR       1.55e5 0462…     3 TRUE            
##  4 0462-013 Pt expired June 19 2020_heartrate_1min_20181231_20211231.csv        HR       2.20e5 0462…     4 TRUE            
##  5 0462-006 off study 5.6.2021_minuteStepsNarrow_20181231_20211231.csv          steps    1.40e6 0462…     1 TRUE            
##  6 0462-007 completed 24 month follow-up 3.17.2021_minuteStepsNarrow_20181231_… steps    1.08e6 0462…     2 TRUE            
##  7 0462-010 Aug 17 2020 informed that device had been lost_minuteStepsNarrow_2… steps    6.00e5 0462…     3 TRUE            
##  8 0462-013 Pt expired June 19 2020_minuteStepsNarrow_20181231_20211231.csv     steps    2.65e5 0462…     4 TRUE            
##  9 0462-006 off study 5.6.2021_minuteIntensitiesNarrow_20181231_20211231.csv    intensi… 1.40e6 0462…     1 TRUE            
## 10 0462-007 completed 24 month follow-up 3.17.2021_minuteIntensitiesNarrow_201… intensi… 1.08e6 0462…     2 TRUE            
## 11 0462-010 Aug 17 2020 informed that device had been lost_minuteIntensitiesNa… intensi… 6.00e5 0462…     3 TRUE            
## 12 0462-013 Pt expired June 19 2020_minuteIntensitiesNarrow_20181231_20211231.… intensi… 2.65e5 0462…     4 TRUE
```


```r
fitabase_files$time_period
```

```
## # A tibble: 4 × 11
## # Rowwise: 
##      id label            min_HR_time         max_HR_time         min_steps_time      max_steps_time      min_intensity_time 
##   <int> <chr>            <dttm>              <dttm>              <dttm>              <dttm>              <dttm>             
## 1     1 0462-006 off st… 2019-04-25 13:08:00 2021-12-02 22:14:00 2019-04-13 00:00:00 2021-12-11 23:59:00 2019-04-13 00:00:00
## 2     2 0462-007 comple… 2019-04-29 10:50:00 2019-07-01 13:11:00 2019-04-15 00:00:00 2021-05-06 10:16:00 2019-04-15 00:00:00
## 3     3 0462-010 Aug 17… 2019-07-08 09:42:00 2020-04-22 19:40:00 2019-07-08 00:00:00 2020-08-27 23:59:00 2019-07-08 00:00:00
## 4     4 0462-013 Pt exp… 2019-12-19 16:07:00 2020-06-06 20:28:00 2019-12-19 00:00:00 2020-06-19 23:59:00 2019-12-19 00:00:00
## # … with 4 more variables: max_intensity_time <dttm>, min_time <date>, max_time <dttm>, is_valid_time_period <lgl>
```


```r
lapply(fitabase_files$raw_HR_list, function(x) summary(x$HR))
```

```
## [[1]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   47.00   72.00   82.00   84.34   95.00  203.00 
## 
## [[2]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   60.00   83.00   92.00   92.15  100.00  178.00 
## 
## [[3]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   43.00   72.00   87.00   87.47  101.00  177.00 
## 
## [[4]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    59.0    96.0   107.0   106.6   117.0   170.0
```

```r
lapply(fitabase_files$raw_steps_list, function(x) summary(x$steps))
```

```
## [[1]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.7415   0.0000 159.0000 
## 
## [[2]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.676   0.000 142.000 
## 
## [[3]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.9374   0.0000 129.0000 
## 
## [[4]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.1196   0.0000 118.0000
```

```r
lapply(fitabase_files$raw_intensity_list, function(x) summary(as.factor(x$intensity)))
```

```
## [[1]]
##       0       1       2       3 
## 1358896   36341    3955    3368 
## 
## [[2]]
##       0       1       2       3 
## 1003204   75098    2578    2618 
## 
## [[3]]
##      0      1      2      3 
## 562206  35847   1791    636 
## 
## [[4]]
##      0      1      2      3 
## 258479   6101    340     40
```


```r
minute_data <- prep_minute_data(fitabase_files)
minute_data[1:10, ] %>%
  mutate(hour = hour(time),
         weekday = wday(as.Date(time), label = TRUE))
```

```
## # A tibble: 10 × 8
##    time                   id label                          HR steps intensity  hour weekday
##    <dttm>              <int> <chr>                       <dbl> <dbl>     <dbl> <int> <ord>  
##  1 2019-04-26 00:00:00     1 0462-006 off study 5.6.2021    75     0         0     0 Fri    
##  2 2019-04-26 00:01:00     1 0462-006 off study 5.6.2021    78     0         0     0 Fri    
##  3 2019-04-26 00:02:00     1 0462-006 off study 5.6.2021    76     0         0     0 Fri    
##  4 2019-04-26 00:03:00     1 0462-006 off study 5.6.2021    78     0         0     0 Fri    
##  5 2019-04-26 00:04:00     1 0462-006 off study 5.6.2021    77     0         0     0 Fri    
##  6 2019-04-26 00:05:00     1 0462-006 off study 5.6.2021    76     0         0     0 Fri    
##  7 2019-04-26 00:06:00     1 0462-006 off study 5.6.2021    77     0         0     0 Fri    
##  8 2019-04-26 00:07:00     1 0462-006 off study 5.6.2021    72     0         0     0 Fri    
##  9 2019-04-26 00:08:00     1 0462-006 off study 5.6.2021    68     0         0     0 Fri    
## 10 2019-04-26 00:09:00     1 0462-006 off study 5.6.2021    72     0         0     0 Fri
```


```r
xx <- minute_data %>% 
  group_by(id, label) %>% 
  summarise(HR_is_missing = sum(is.na(HR)), 
            steps_is_missing = sum(is.na(steps)))
```

```
## `summarise()` has grouped output by 'id'. You can override using the `.groups` argument.
```

```r
xx
```

```
## # A tibble: 4 × 4
## # Groups:   id [4]
##      id label                                                   HR_is_missing steps_is_missing
##   <int> <chr>                                                           <int>            <int>
## 1     1 0462-006 off study 5.6.2021                                   1024505                0
## 2     2 0462-007 completed 24 month follow-up 3.17.2021                 34846                0
## 3     3 0462-010 Aug 17 2020 informed that device had been lost        261716                0
## 4     4 0462-013 Pt expired June 19 2020                                24958                0
```


```r
write_rds(fitabase_files, "../../data/prep/fitabase_files__export_1.rds")
write_rds(minute_data, "../../data/prep/minute_data__export_1.rds")
```
