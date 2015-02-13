
### Last Update


```r
Sys.time()
```

```
## [1] "2015-02-13 19:43:08 CET"
```


### Data Set




The data sets have been directly retrived with an own Twitter application.

Related Twitter Accounts:

* [Amnesty International][1]

        Number of analyzed tweets after cleaning: 587

* [American Red Cross][2] 

        Number of analyzed tweets after cleaning: 404

* [PETA][3] 
        
        Number of analyzed tweets after cleaning: 531

***

### Notices

This application is primarily a demo to show what is possible. 

In case of any questions related to this application, feel free to write [me a mail.][4]

***

### Used R Packages


```r
library(graph)
library(twitteR)
library(NLP)
library(tm)
library(shinyIncubator)
library(grid)
library(pvclust)
library(Rgraphviz)
library(qdapTools)
library(qdapRegex)
library(magrittr)
library(wordcloud)
library(RColorBrewer)
library(ggplot2)
library(RCurl)
library(bitops)
library(shinyapps)
library(BH)
library(qdap)
library(SnowballC)
library(slam)
library(RWeka)
library(rJava) 
library(RWekajars)
library(memoise)
library(devtools)
library(rjson)
library(bit64)
library(httr)
library(plyr)
library(shinythemes)
```

***

### Last Session Info


```r
devtools::session_info()
```

```
## Session info --------------------------------------------------------------
```

```
##  setting  value                       
##  version  R version 3.1.2 (2014-10-31)
##  system   x86_64, darwin13.4.0        
##  ui       X11                         
##  language (EN)                        
##  collate  de_DE.UTF-8                 
##  tz       Europe/Berlin
```

```
## Packages ------------------------------------------------------------------
```

```
##  package    * version date       source        
##  devtools   * 1.7.0   2015-01-17 CRAN (R 3.1.2)
##  digest     * 0.6.8   2014-12-31 CRAN (R 3.1.2)
##  evaluate   * 0.5.5   2014-04-29 CRAN (R 3.1.0)
##  formatR    * 1.0     2014-08-25 CRAN (R 3.1.1)
##  htmltools  * 0.2.6   2014-09-08 CRAN (R 3.1.1)
##  knitr      * 1.9     2015-01-20 CRAN (R 3.1.2)
##  memoise    * 0.2.1   2014-04-22 CRAN (R 3.1.0)
##  rmarkdown  * 0.5.1   2015-01-26 CRAN (R 3.1.2)
##  rstudioapi * 0.2     2014-12-31 CRAN (R 3.1.2)
##  stringr    * 0.6.2   2012-12-06 CRAN (R 3.1.2)
##  yaml       * 2.1.13  2014-06-12 CRAN (R 3.1.0)
```



[1]: https://twitter.com/amnesty "Amnesty Twitter Account"

[2]: https://twitter.com/RedCross "Red Cross Twitter Account"

[3]: https://twitter.com/peta "PETA Twitter Account"

[4]: http://nierhoff.info/#contact "Contact"

***
