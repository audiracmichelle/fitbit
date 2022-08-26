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
├── analysis                # Documentation files (notebooks)
│   ├── export_1            # Folder containing notebooks that explore `export_1` datasets.
│   │    └── ...            
│   └── export_2            # Folder containing notebooks that explore `export_2` datasets.
│        └── ...            
└── ...
```

  * [./analysis/export_1/](./analysis/export_1/)
     * [./analysis/export_1/prep_minute_data.Rmd](./analysis/export_1/_knit/prep_minute_data.md) Reads input datasets and performs joins using the `fitibble::read_fitabase_files` function.

