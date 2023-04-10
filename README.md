# USFWS Disclaimer

This United States Fish & Wildlife Service (USFWS) code is provided on
an “as is” basis and the user assumes responsibility for its use. USFWS
has relinquished control of the information and no longer has
responsibility to protect the integrity , confidentiality, or
availability of the information. Any reference to specific commercial
products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recomendation or favoring by USFWS. The USFWS seal and logo
shall not be used in any manner to imply endorsement of any commercial
product or activity by USFWS or the United States Government.

# r4pr (Region 4 Project Reports)

This package provides a R Markdown template for R4 I\&M Project Reports.

## Installing r4pr

To use `r4pr` and generate the pdf Project Reports from the template,
you’ll need:

1.  **[R](https://www.r-project.org/)**

2.  **[Rtools](https://cran.r-project.org/bin/windows/Rtools/)**

3.  **LaTeX distribution**: If you don’t know what this means, we
    recommend you use `tinytex`. Install `tinytex` in R using the
    following commands and following the onscreen prompts:
    
    ``` r
    install.packages("tinytex")
    tinytex::install_tinytex()
    ```
    
    Other LaTeX distribution options include
    [MiKTeX](http://miktex.org/download) for Windows,
    [MacTeX](https://tug.org/mactex/mactex-download.html) for Mac OS X,
    and
    [TeXLive](https://www.tug.org/texlive/doc/texlive-en/texlive-en.html#x1-140003)
    for Linux. This template should be OS-agnostic, but has not been
    tested outside of 64-bit Windows 7.

4.  **pandoc**: If you’re using a relatively recent version of
    [RStudio](https://www.rstudio.com/products/rstudio/download/preview/),
    pandoc is included. Using `r4pr` outside of RStudio will require a
    recent version of [pandoc](http://pandoc.org/installing.html).

R & RStudio can be installed without administrative privileges via FWS
Apps-to-go (search for “R Statistical Package”). Rtools will require
administrative priveleges but the installation of packages after this
initial install will not.

With the installation formalities out of the way, install the template…

## Installing the Template

Install the template directly:

``` r
if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("adamdsmith/r4pr")
```

This will install the package `r4pr`. Once installed, the template will
be available within the R Markdown templates as shown below:

![R4 Project Report](https://i.imgur.com/oDqfOdh.png)
