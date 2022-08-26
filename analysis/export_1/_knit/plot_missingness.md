# plot_missingness


```r
library(tidyverse)
library(magrittr)
library(lubridate)
library(fitibble)
```


```r
minute_data <- read_rds("../../data/prep/minute_data__export_1.rds") %>% 
  fitibble()
```


```r
plot_missingness(minute_data)
```

![](./plot_missingness_files/figure-html/unnamed-chunk-20-1.png)<!-- -->


```r
plot_missingness(minute_data, calendar_time = F)
```

![](./plot_missingness_files/figure-html/unnamed-chunk-21-1.png)<!-- -->


```r
plot_missingness(minute_data, calendar_time = F, type = "raster")
```

![](./plot_missingness_files/figure-html/unnamed-chunk-22-1.png)<!-- -->
