#' Convert to Jupyter Notebook
#'
#' \code{rmd_to_jupyter} is a custom knit function to convert the R Markdown file into
#' a Jupyter Notebook (formerly known as IPython Notebook, hence, the file extension
#' `.ipynb`). Jupyter Notebook files are simple JSON documents, that contain text, source code,
#' rich media output, and metadata where each segment of the document is stored in a cell. This
#' function converts the R Markdown code directly into a prettified JSON string using
#' \code{\link[jsonlite]{toJSON}} and \code{\link[jsonlite]{prettify}} and saves it in an
#' `.ipynb` file.
#'
#' @param input_file Name of .Rmd input file.
#' @param encoding 	The encoding of the input file. The argument is required for the document knitting.
#' @details
#' This code was adapted from the package \href{https://github.com/mkearney/rmd2jupyter}{rmd2jupyter}
#' by Michael Kearney. The advantage of this approach is that none of the Python distributions,
#' Jupyter Notebook, nor any other package has actually to be installed on the computer to run this
#' function.
#'
#' The only thing you need in the YAML header is
#'
#' \preformatted{
#' ---
#' knit: akrreport::rmd_to_jupyter
#' ---
#' }
#' Since everything from the YAML header will be cut out when converting the code, any title,
#' author name or other field will be neglected.
#'
#' @return Jupyter notebook output format
#' @export
rmd_to_jupyter <- function(input_file, encoding = "UTF-8") {

  x <- input_file
  save_as <- gsub("\\.Rmd", ".ipynb", x)

  con <- file(x)
  x <- readLines(con, warn = FALSE)
  close(con)

  ## strip yaml
  if (grepl("^---", x[1])) {
    yaml_end <- grep("^---", x)[2]
    x <- x[(yaml_end + 1L):length(x)]
  }

  chunks <- grep("^```", x)

  if (length(chunks) == 0L) {
    lns <- c(1L, length(x))
    chunks <- matrix(lns, ncol = 2, byrow = TRUE)
    chunks <- data.frame(chunks)
    names(chunks) <- c("start", "end")
    chunks$cell_type <- "markdown"
  } else {
    lns <- sort(c(
      1L, length(x), chunks,
      chunks[seq(1, length(chunks), 2)] - 1L,
      chunks[seq(2, length(chunks), 2)] + 1L
    ))
    lns <- lns[lns > 0 & lns <= length(x)]
    if (chunks[length(chunks)] == length(x)) {
      lns <- lns[-length(lns)]
    }
    if (chunks[1L] == 1L) {
      lns <- lns[-1]
    }
    chunks <- matrix(lns, ncol = 2, byrow = TRUE)
    chunks <- data.frame(chunks)
    names(chunks) <- c("start", "end")
    codes <- grep("^```", x)
    codes <- codes[seq(1, length(codes), 2)]
    chunks$cell_type <- ifelse(chunks$start %in% codes, "code", "markdown")
    x <- gsub("^```.*", "", x)
  }

  for (i in seq_len(nrow(chunks))) {
    s <- paste0(x[(chunks$start[i]):(chunks$end[i])], "\n")
    ## trim top and bottom blank lines
    while (s[1] == "\n" & length(s) > 2L) {
      s <- s[-1]
    }
    while (s[length(s)] == "\n" & length(s) > 1L) {
      s <- s[-length(s)]
    }
    ## remove last newline command in code to avoid empty lines in .ipynb
    if (chunks$cell_type[i] == "code") {
      s[length(s)] <- gsub("\n", "", x = s[length(s)])
    }
    chunks$source[i] <- I(list(s))
  }

  cells <- Map(format_cell, chunks$cell_type, chunks$source)

  # Prettify the JSON string
  x <- jsonlite::prettify(format_cells(cells))
  x <- gsub("count\": \"\"", "count\": null", x)
  x <- gsub("metadata\": \"\"", "metadata\": {}", x)
  x <- gsub("outputs\": \"\"", "outputs\": []", x)

  cat(x, file = save_as)
  message(paste("file saved as", save_as))

  # end of function
}



format_cell <- function(cell_type,
                        source) {
  if (cell_type == "code") {
    x <- list(cell_type = cell_type,
              execution_count = "",
              metadata = "",
              outputs = "",
              source = source)
  } else {
    x <- list(cell_type = cell_type,
              metadata = "",
              source = source)
  }
  x
}


format_cells <- function(cells) {
  x <- list(cells = unname(cells),
            metadata = list(
              "anaconda-cloud" = "",
              "kernelspec" = list(
                "display_name" = "R",
                "langauge" = "R",
                "name" = "ir"),
              "language_info" = list(
                "codemirror_mode" = "r",
                "file_extension" = ".r",
                "mimetype" = "text/x-r-source",
                "name" = "R",
                "pygments_lexer" = "r",
                "version" = "3.4.1")
            ),
            "nbformat" = 4,
            "nbformat_minor" = 1)
  jsonlite::toJSON(x, auto_unbox = TRUE)
}