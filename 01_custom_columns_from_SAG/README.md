
### seabass in 4bc… has a summary table and custom table with the recreational catches in there. How do I extract those however from SAG directly from R?

``` r
library(icesSAG)

keys <- icesSAG::findAssessmentKey("bss.27.4bc", year = 2021)
```

    ## GETing ... http://sg.ices.dk/StandardGraphsWebServices.asmx/getListStocks?year=2021

``` r
custom <- icesSAG::getCustomColumns(keys)
```

    ## GETing ... http://sg.ices.dk/StandardGraphsWebServices.asmx/getStockDownloadData?assessmentKey=15636

``` r
library(dplyr)
library(tidyr)

custom %>%
  select(Purpose, Year, customName, customValue) %>%
  filter(!is.na(customName)) %>%
  pivot_wider(names_from = "customName", values_from = "customValue")
```

    ## # A tibble: 37 x 5
    ##    Purpose  Year `Commercial landings` `Commercial discards` `Recreational removals`
    ##    <chr>   <int>                 <dbl>                 <dbl>                   <dbl>
    ##  1 Advice   1985                   994                    NA                    1771
    ##  2 Advice   1986                  1318                    NA                    1597
    ##  3 Advice   1987                  1979                    NA                    1457
    ##  4 Advice   1988                  1239                    NA                    1353
    ##  5 Advice   1989                  1161                    NA                    1253
    ##  6 Advice   1990                  1064                    NA                    1129
    ##  7 Advice   1991                  1226                    NA                    1037
    ##  8 Advice   1992                  1186                    NA                    1061
    ##  9 Advice   1993                  1256                    NA                    1235
    ## 10 Advice   1994                  1370                    NA                    1481
    ## # ... with 27 more rows
