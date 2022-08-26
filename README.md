# fitbit

We explore Fitbit data processing methods and visualizations for epi/health studies in a sequence of notebooks.
 
  * Two input datasets are explored:
    - export 1: consists of four patients
    - export 2: consists of 49 patients 
  * The `fitibble` R package is used. 

## Installing `fitibble`

To install the fitibble package use:

```
devtools::install_git("https://github.com/audiracmichelle/fitibble")
```

## Content

```
.
├── analysis                # Documentation files (notebooks)
├── data                    # Input, prepared and output data. The upstream folder is a placeholder (look at the indications in ./data/README.md)
└── README.md
```

## Notebooks

```
.
├── ...
├── analysis                # Documentation files
│   ├── export_1            # Folder containing notebooks that explore `export_1` datasets.
│   │    └── ...            
│   └── export_2            # Folder containing notebooks that explore `export_2` datasets.
│        └── ...            
└── ...
```

  * [./analysis/export_1/](./analysis/export_1/) the `export_1` dataset is a small set of csv files comprised by fitbit data of four participants. 
     - [./analysis/export_1/prep_minute_data.Rmd](./analysis/export_1/_knit/prep_minute_data.md) Reads input datasets and performs joins using the `fitibble::read_fitabase_files` function.
     - [./analysis/export_1/flag_nonwear.Rmd](./analysis/export_1/_knit/flag_nonwear.md) Identifies minutes of wear with multiple methods implemented in the function `fitibble::flag_nonwear`.
     - [./analysis/export_1/flag_valid_day.Rmd](./analysis/export_1/_knit/flag_valid_day.md) Compares the output of adherence and valid day method using the functions `fitibble::flag_adherent` and `fitibble::flag_valid_day`.
     - [./analysis/export_1/plot_missingness.Rmd](./analysis/export_1/_knit/plot_missingness.md) Visualization of missing HR and steps minute entries using the `fitibble::plot_missingness`.
     - [./analysis/export_1/fitibble.Rmd](./analysis/export_1/_knit/fitibble.md) Generates a `fitibble` object from the fitbit minute data using `fitibble::fitbit`.
     - [./analysis/export_1/plot_wear_heatmap.Rmd](./analysis/export_1/_knit/plot_wear_heatmap.md) Visualization of wear patterns, each cell representing proportion of wear per weak and time of day. The plot is generated iwht the `fitibble::plot_wear_heatmap` function.
     - [./analysis/export_1/summaries.Rmd](./analysis/export_1/_knit/summaries.md) Produced summaries of PA despcriptors for the subjects in the example datasets. Summaries are produced with the `fitibble::summaries` function.
     - [./analysis/export_1/plot_time_use.Rmd](./analysis/export_1/_knit/plot_time_use.md) Visualization of the time-use descriptors, that is the proportion of time per day in each PA activity level. The plots are generated   with the `fitibble::plot_time_use` function.

  * [./analysis/export_2/](./analysis/export_2/) the `export_2` dataset is a set of csv files comprised by fitbit data of 49 participants. The same analysis that are performed on the `export_1` dataset are done on the `export_1` dataset.
    - [./analysis/export_2/prep_minute_data.Rmd](./analysis/export_2/_knit/prep_minute_data.md)
    - [./analysis/export_2/flag_nonwear.Rmd](./analysis/export_2/_knit/flag_nonwear.md)
    - [./analysis/export_2/flag_valid_day.Rmd](./analysis/export_2/_knit/flag_valid_day.md)
    - [./analysis/export_2/fitibble.Rmd](./analysis/export_2/_knit/fitibble.md)
    - [./analysis/export_2/plot_wear_heatmap.Rmd](./analysis/export_2/_knit/plot_wear_heatmap.md)
    - [./analysis/export_2/summaries.Rmd](./analysis/export_2/_knit/summaries.md)
