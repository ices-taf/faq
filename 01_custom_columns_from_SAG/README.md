
### seabass in 4bc… has a summary table and custom table with the recreational catches in there. How do I extract those however from SAG directly from R?

First load the icesSAG library and find the approriate `assessmentKey`.

``` r
library(icesSAG)

keys <- icesSAG::findAssessmentKey("bss.27.4bc", year = 2021)
```

    ## GETing ... http://sg.ices.dk/StandardGraphsWebServices.asmx/getListStocks?year=2021

Then extract the custom columns using the `getCustomColumns` function.

``` r
custom <- icesSAG::getCustomColumns(keys)
```

    ## GETing ... http://sg.ices.dk/StandardGraphsWebServices.asmx/getStockDownloadData?assessmentKey=15636

``` r
head(custom)
```

    ##   AssessmentKey AssessmentYear   StockKeyLabel Purpose Year
    ## 1         15636           2021 bss.27.4bc7ad-h  Advice 1985
    ## 2         15636           2021 bss.27.4bc7ad-h  Advice 1986
    ## 3         15636           2021 bss.27.4bc7ad-h  Advice 1987
    ## 4         15636           2021 bss.27.4bc7ad-h  Advice 1988
    ## 5         15636           2021 bss.27.4bc7ad-h  Advice 1989
    ## 6         15636           2021 bss.27.4bc7ad-h  Advice 1990
    ##   customValue          customName customUnit customColumnId
    ## 1         994 Commercial landings          t              1
    ## 2        1318 Commercial landings          t              1
    ## 3        1979 Commercial landings          t              1
    ## 4        1239 Commercial landings          t              1
    ## 5        1161 Commercial landings          t              1
    ## 6        1064 Commercial landings          t              1

Finally, you can restructure the output using something like tidyr and
dplyr, for example:

``` r
library(dplyr)
library(tidyr)

custom %>%
  select(Purpose, Year, customName, customValue) %>%
  filter(!is.na(customName)) %>%
  pivot_wider(names_from = "customName", values_from = "customValue")
```

    ## # A tibble: 37 x 5
    ##    Purpose  Year `Commercial landings` `Commercial discards`
    ##    <chr>   <int>                 <dbl>                 <dbl>
    ##  1 Advice   1985                   994                    NA
    ##  2 Advice   1986                  1318                    NA
    ##  3 Advice   1987                  1979                    NA
    ##  4 Advice   1988                  1239                    NA
    ##  5 Advice   1989                  1161                    NA
    ##  6 Advice   1990                  1064                    NA
    ##  7 Advice   1991                  1226                    NA
    ##  8 Advice   1992                  1186                    NA
    ##  9 Advice   1993                  1256                    NA
    ## 10 Advice   1994                  1370                    NA
    ## # ... with 27 more rows, and 1 more variable:
    ## #   `Recreational removals` <dbl>
