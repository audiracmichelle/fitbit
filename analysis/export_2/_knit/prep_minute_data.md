# prep_minute_data


```r
library(tidyverse)
library(magrittr)
library(fitibble)
```


```r
fitabase_files <- read_fitabase_files("../../data/input/export_2.zip")
fitabase_files$files
```

```
## # A tibble: 147 × 6
##    filename                                                                     filetype  lines label    id is_valid_file_l…
##    <chr>                                                                        <chr>     <int> <chr> <int> <lgl>           
##  1 0462-001 1.24.2021  2 years on study_heartrate_1min_20190101_20220228.csv    HR       462421 0462…     1 TRUE            
##  2 0462-002 expired on 7.1.2020_heartrate_1min_20190101_20220228.csv            HR        87533 0462…     2 TRUE            
##  3 0462-003 expired on 3.7.2019_heartrate_1min_20190101_20220228.csv            HR         9752 0462…     3 TRUE            
##  4 0462-004  pt. returned to Kuwait 4.8.2020_heartrate_1min_20190101_20220228.… HR       476901 0462…     4 TRUE            
##  5 0462-006 off study 5.6.2021_heartrate_1min_20190101_20220228.csv             HR       345677 0462…     5 TRUE            
##  6 0462-007 completed 24 month follow-up 3.17.2021_heartrate_1min_20190101_202… HR        55999 0462…     6 TRUE            
##  7 0462-008 Unable to sync device_heartrate_1min_20190101_20220228.csv          HR            1 0462…     7 FALSE           
##  8 0462-009 Is completing trtmt at home station and not responding to messages… HR       110975 0462…     8 TRUE            
##  9 0462-010 Aug 17 2020 informed that device had been lost_heartrate_1min_2019… HR       155038 0462…     9 TRUE            
## 10 0462-011 pt confirmed it has been misplaced_heartrate_1min_20190101_2022022… HR       280427 0462…    10 TRUE            
## # … with 137 more rows
```


```r
fitabase_files$time_period
```

```
## # A tibble: 47 × 11
## # Rowwise: 
##       id label           min_HR_time         max_HR_time         min_steps_time      max_steps_time      min_intensity_time 
##    <int> <chr>           <dttm>              <dttm>              <dttm>              <dttm>              <dttm>             
##  1     1 0462-001 1.24.… 2019-01-25 13:07:00 2020-09-24 10:06:00 2019-01-25 00:00:00 2020-09-24 23:59:00 2019-01-25 00:00:00
##  2     2 0462-002 expir… 2019-02-01 07:16:00 2020-06-14 17:17:00 2019-02-01 00:00:00 2020-07-01 23:59:00 2019-02-01 00:00:00
##  3     3 0462-003 expir… 2019-03-04 08:14:00 2019-03-13 19:12:00 2019-03-04 00:00:00 2019-03-13 19:16:00 2019-03-04 00:00:00
##  4     4 0462-004  pt. … 2019-03-11 10:48:00 2020-11-07 23:28:00 2019-03-11 00:00:00 2020-11-08 08:07:00 2019-03-11 00:00:00
##  5     5 0462-006 off s… 2019-04-25 13:08:00 2021-12-02 22:14:00 2019-04-13 00:00:00 2021-12-11 23:59:00 2019-04-13 00:00:00
##  6     6 0462-007 compl… 2019-04-29 10:50:00 2019-07-01 13:11:00 2019-04-15 00:00:00 2021-05-06 10:16:00 2019-04-15 00:00:00
##  7     8 0462-009 Is co… 2019-05-30 14:12:00 2019-09-20 12:34:00 2019-05-30 00:00:00 2019-09-20 23:59:00 2019-05-30 00:00:00
##  8     9 0462-010 Aug 1… 2019-07-08 09:42:00 2020-04-22 19:40:00 2019-07-08 00:00:00 2020-08-27 23:59:00 2019-07-08 00:00:00
##  9    10 0462-011 pt co… 2019-11-12 12:56:00 2020-10-15 14:59:00 2019-11-12 00:00:00 2021-01-29 23:59:00 2019-11-12 00:00:00
## 10    11 0462-012_ 5.11… 2020-01-02 20:04:00 2021-03-08 14:46:00 2019-10-22 00:00:00 2021-03-08 23:59:00 2019-10-22 00:00:00
## # … with 37 more rows, and 4 more variables: max_intensity_time <dttm>, min_time <date>, max_time <dttm>,
## #   is_valid_time_period <lgl>
```


```r
lapply(fitabase_files$raw_HR_list, function(x) summary(x$HR))
```

```
## [[1]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   44.00   70.00   79.00   81.42   92.00  196.00 
## 
## [[2]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   54.00   85.00   96.00   97.19  107.00  203.00 
## 
## [[3]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   46.00   71.00   82.00   84.88   95.00  202.00 
## 
## [[4]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   37.00   62.00   69.00   71.27   78.00  213.00 
## 
## [[5]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   47.00   72.00   82.00   84.34   95.00  203.00 
## 
## [[6]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   60.00   83.00   92.00   92.15  100.00  178.00 
## 
## [[7]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    54.0    78.0    87.0    89.1    98.0   196.0 
## 
## [[8]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   43.00   72.00   87.00   87.47  101.00  177.00 
## 
## [[9]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   42.00   64.00   74.00   76.36   87.00  198.00 
## 
## [[10]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   49.00   74.00   81.00   83.11   91.00  194.00 
## 
## [[11]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    59.0    96.0   107.0   106.6   117.0   170.0 
## 
## [[12]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    45.0    99.0   108.0   108.9   120.0   198.0 
## 
## [[13]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   48.00   76.00   88.00   88.33   99.00  205.00 
## 
## [[14]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    61.0   109.0   115.0   112.2   122.0   160.0 
## 
## [[15]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   46.00   78.00   87.00   87.42   96.00  188.00 
## 
## [[16]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   48.00   68.00   80.00   80.71   91.00  196.00 
## 
## [[17]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   53.00   74.00   84.00   87.77   98.00  199.00 
## 
## [[18]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   49.00   66.00   75.00   77.07   85.00  203.00 
## 
## [[19]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   46.00   76.00   88.00   88.85  100.00  208.00 
## 
## [[20]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   50.00   74.00   82.00   83.92   92.00  170.00 
## 
## [[21]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    50.0    78.0    91.0    91.4   102.0   185.0 
## 
## [[22]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   45.00   66.00   75.00   77.25   86.00  182.00 
## 
## [[23]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   52.00   73.00   84.00   84.56   94.00  196.00 
## 
## [[24]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   43.00   80.00   88.00   89.54   97.00  180.00 
## 
## [[25]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    58.0    98.0   107.0   106.9   116.0   165.0 
## 
## [[26]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   47.00   67.00   78.00   79.58   91.00  146.00 
## 
## [[27]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   44.00   62.00   69.00   71.54   78.00  169.00 
## 
## [[28]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   52.00   74.00   83.00   83.93   92.00  177.00 
## 
## [[29]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   49.00   82.00   92.00   92.26  102.00  205.00 
## 
## [[30]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   45.00   68.00   78.00   78.64   87.00  196.00 
## 
## [[31]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   58.00   85.00   94.00   94.23  103.00  203.00 
## 
## [[32]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   64.00   83.00   95.00   94.37  105.00  172.00 
## 
## [[33]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   54.00   80.00   92.00   91.81  102.00  212.00 
## 
## [[34]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   50.00   78.00   89.00   89.54   99.00  200.00 
## 
## [[35]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   39.00   68.00   81.00   81.74   95.00  187.00 
## 
## [[36]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   47.00   72.00   79.00   80.44   86.00  181.00 
## 
## [[37]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   49.00   76.00   84.00   86.35   95.00  201.00 
## 
## [[38]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   43.00   75.00   87.00   87.99  100.00  168.00 
## 
## [[39]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   38.00   86.00   95.00   97.35  107.00  178.00 
## 
## [[40]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   58.00   78.00   85.00   86.45   94.00  159.00 
## 
## [[41]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   65.00   76.00   87.00   86.85   95.00  164.00 
## 
## [[42]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    47.0    69.0    79.0    81.1    92.0   159.0 
## 
## [[43]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   47.00   72.00   80.00   82.08   91.00  143.00 
## 
## [[44]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   70.00   72.00  102.00   96.51  108.00  156.00 
## 
## [[45]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   52.00   73.00   85.00   84.21   93.00  145.00 
## 
## [[46]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##    81.0    81.0    82.0    83.5    84.5    89.0 
## 
## [[47]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   66.00   91.00   98.00   99.18  107.00  155.00
```


```r
lapply(fitabase_files$raw_steps_list, function(x) summary(x$steps))
```

```
## [[1]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.788   0.000 173.000 
## 
## [[2]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.1675   0.0000 118.0000 
## 
## [[3]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   3.705   0.000 133.000 
## 
## [[4]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.795   0.000 155.000 
## 
## [[5]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.7415   0.0000 159.0000 
## 
## [[6]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.676   0.000 142.000 
## 
## [[7]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   4.092   0.000 168.000 
## 
## [[8]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.9374   0.0000 129.0000 
## 
## [[9]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   2.431   0.000 175.000 
## 
## [[10]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.773   0.000 170.000 
## 
## [[11]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.1196   0.0000 118.0000 
## 
## [[12]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## 0.00e+00 0.00e+00 0.00e+00 4.57e-03 0.00e+00 1.10e+02 
## 
## [[13]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.7326   0.0000 123.0000 
## 
## [[14]]
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
##   0.00000   0.00000   0.00000   0.02646   0.00000 100.00000 
## 
## [[15]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.5199   0.0000 135.0000 
## 
## [[16]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   6.879   0.000 170.000 
## 
## [[17]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   2.195   0.000 136.000 
## 
## [[18]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.1536   0.0000 151.0000 
## 
## [[19]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.7736   0.0000 130.0000 
## 
## [[20]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.612   0.000 106.000 
## 
## [[21]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   0.485   0.000 137.000 
## 
## [[22]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.6267   0.0000 136.0000 
## 
## [[23]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.5454   0.0000 121.0000 
## 
## [[24]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.016   0.000 136.000 
## 
## [[25]]
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
##   0.00000   0.00000   0.00000   0.07953   0.00000 162.00000 
## 
## [[26]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.2912   0.0000 125.0000 
## 
## [[27]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.9303   0.0000 140.0000 
## 
## [[28]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.9594   0.0000 148.0000 
## 
## [[29]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.309   0.000 167.000 
## 
## [[30]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   4.403   0.000 224.000 
## 
## [[31]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.3039   0.0000 138.0000 
## 
## [[32]]
##      Min.   1st Qu.    Median      Mean   3rd Qu.      Max. 
##   0.00000   0.00000   0.00000   0.03275   0.00000 120.00000 
## 
## [[33]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.7019   0.0000 124.0000 
## 
## [[34]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.457   0.000 160.000 
## 
## [[35]]
##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
##   0.0000   0.0000   0.0000   0.6147   0.0000 159.0000 
## 
## [[36]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.371   0.000 201.000 
## 
## [[37]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.268   0.000 177.000 
## 
## [[38]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.582   0.000 121.000 
## 
## [[39]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.133   0.000 119.000 
## 
## [[40]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   2.325   0.000 154.000 
## 
## [[41]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   1.089   0.000 686.000 
## 
## [[42]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   4.466   0.000 151.000 
## 
## [[43]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##   0.000   0.000   0.000   2.779   0.000 116.000 
## 
## [[44]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.0000  0.0000  0.2957  0.0000 97.0000 
## 
## [[45]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.0000  0.0000  0.7618  0.0000 99.0000 
## 
## [[46]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       0       0       0       0       0       0 
## 
## [[47]]
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##  0.0000  0.0000  0.0000  0.5219  0.0000 99.0000
```


```r
lapply(fitabase_files$raw_intensity_list, function(x) summary(as.factor(x$intensity)))
```

```
## [[1]]
##      0      1      2      3 
## 815285  58230   2521    924 
## 
## [[2]]
##      0      1      2      3 
## 736092   6887    890    611 
## 
## [[3]]
##     0     1     2     3 
## 12131  1678   142   166 
## 
## [[4]]
##      0      1      2      3 
## 824658  44573   1746   5031 
## 
## [[5]]
##       0       1       2       3 
## 1358896   36341    3955    3368 
## 
## [[6]]
##       0       1       2       3 
## 1003204   75098    2578    2618 
## 
## [[7]]
##      0      1      2      3 
## 144614  15793   1780   1973 
## 
## [[8]]
##      0      1      2      3 
## 562206  35847   1791    636 
## 
## [[9]]
##      0      1      2      3 
## 573778  53114   8176   5732 
## 
## [[10]]
##      0      1      2      3 
## 664455  58907   1363   1035 
## 
## [[11]]
##      0      1      2      3 
## 258479   6101    340     40 
## 
## [[12]]
##      0      1      2      3 
## 529186    563     12    159 
## 
## [[13]]
##       0       1       2       3 
## 1015653   37002    7376    3365 
## 
## [[14]]
##      0      1      2      3 
## 254549    241     38     52 
## 
## [[15]]
##      0      1      2      3 
## 183403   8268    882    407 
## 
## [[16]]
##      0      1      2      3 
## 653662 140752  20268  14200 
## 
## [[17]]
##      0      1      2      3 
## 257836  22832   7198  10214 
## 
## [[18]]
##       0       1       2       3 
## 1042695    7424     425     343 
## 
## [[19]]
##      0      1      2      3 
## 791004  20178   3182   2714 
## 
## [[20]]
##     0     1     2     3 
## 64353  6055   136    16 
## 
## [[21]]
##      0      1      2      3 
## 643780  13942    602    464 
## 
## [[22]]
##      0      1      2      3 
## 557941  11855   1007   2106 
## 
## [[23]]
##      0      1      2      3 
## 659391  14487    782   1042 
## 
## [[24]]
##      0      1      2      3 
## 619737  30309   2257   1572 
## 
## [[25]]
##      0      1      2      3 
## 437198   5073    330     94 
## 
## [[26]]
##      0      1      2      3 
## 461454   5848    889    469 
## 
## [[27]]
##      0      1      2      3 
## 289915   8914    862   1018 
## 
## [[28]]
##      0      1      2      3 
## 394838  11372    751    707 
## 
## [[29]]
##      0      1      2      3 
## 412764  29361   1537    518 
## 
## [[30]]
##      0      1      2      3 
## 360535  46350   3787   4363 
## 
## [[31]]
##      0      1      2      3 
## 373956   7191     74     82 
## 
## [[32]]
##      0      1 
## 343908   1022 
## 
## [[33]]
##      0      1      2      3 
## 247155   6898    883    551 
## 
## [[34]]
##      0      1      2      3 
## 290751  10625   1098   2128 
## 
## [[35]]
##      0      1      2      3 
## 273240  25912   1392    800 
## 
## [[36]]
##      0      1      2      3 
## 333078  17448   1334    940 
## 
## [[37]]
##      0      1      2      3 
## 318908  13980   1700   1372 
## 
## [[38]]
##      0      1      2      3 
## 126436  16817   2894   1257 
## 
## [[39]]
##      0      1      2      3 
## 212444  14677   1406   1435 
## 
## [[40]]
##     0     1     2     3 
## 33323  4556    90    35 
## 
## [[41]]
##      0      1      2      3 
## 118074   2136     62     96 
## 
## [[42]]
##     0     1     2     3 
## 52865 12492   663   220 
## 
## [[43]]
##     0     1     2     3 
## 17571  2378    55     2 
## 
## [[44]]
##     0     1     2 
## 31820   561    10 
## 
## [[45]]
##     0     1     2     3 
## 15030   800     9     1 
## 
## [[46]]
##   0 
## 886 
## 
## [[47]]
##    0    1    2 
## 7527  327   12
```


```r
minute_data <- prep_minute_data(fitabase_files)

minute_data %>% 
  group_by(id, label) %>% 
  summarise(HR_is_missing = sum(is.na(HR)), 
            steps_is_missing = sum(is.na(steps)))
```

```
## `summarise()` has grouped output by 'id'. You can override using the `.groups` argument.
```

```
## # A tibble: 46 × 4
## # Groups:   id [46]
##       id label                                                                       HR_is_missing steps_is_missing
##    <int> <chr>                                                                               <int>            <int>
##  1     1 0462-001 1.24.2021  2 years on study                                               412458                0
##  2     2 0462-002 expired on 7.1.2020                                                       631599                0
##  3     3 0462-003 expired on 3.7.2019                                                         3339                0
##  4     4 0462-004  pt. returned to Kuwait 4.8.2020                                          397791                0
##  5     5 0462-006 off study 5.6.2021                                                       1024505                0
##  6     6 0462-007 completed 24 month follow-up 3.17.2021                                     34846                0
##  7     8 0462-009 Is completing trtmt at home station and not responding to messages         50772                0
##  8     9 0462-010 Aug 17 2020 informed that device had been lost                            261716                0
##  9    10 0462-011 pt confirmed it has been misplaced                                        205674                0
## 10    11 0462-012_ 5.11.20 to11.11.20 gap                                                   396505                0
## # … with 36 more rows
```


```r
write_rds(fitabase_files, "../../data/prep/fitabase_files__export_2.rds")
write_rds(minute_data, "../../data/prep/minute_data__export_2.rds")
```
