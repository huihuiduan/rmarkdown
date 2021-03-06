
# resolve the html extras for a document (dependencies and arbitrary html to
# inject into the document)
html_extras_for_document <- function(knit_meta, runtime, format_deps = NULL) {

  extras <- list()

  # if this is a shiny document then start with shiny extras
  if (identical(runtime, "shiny"))
    extras <- shiny_html_extras(knit_meta)

  # merge the dependencies discovered with the dependencies of this format and
  # dependencies discovered in knit_meta
  extras$dependencies <-
    html_dependencies_for_document(knit_meta, c(format_deps,
                                                extras$dependencies))

  # return extras
  extras
}

# convert html extras to the pandoc args required to include them
pandoc_html_extras_args <- function(extras, self_contained, lib_dir) {

  args <- c()

  # dependencies
  dependencies <- extras$dependencies
  if (length(dependencies) > 0) {
    if (self_contained)
      file <- as_tmpfile(html_dependencies_as_string(dependencies, NULL))
    else
      file <- as_tmpfile(html_dependencies_as_string(dependencies, lib_dir))
    args <- c(args, pandoc_include_args(in_header = file))
  }

  # extras
  args <- c(args, pandoc_include_args(
                    in_header = as_tmpfile(extras$in_header),
                    before_body = as_tmpfile(extras$before_body),
                    after_body = as_tmpfile(extras$after_body)))

  args
}

# return the html extras required to serve a document as a shiny app
shiny_html_extras <- function(knit_meta) {
  heads <- as.logical(sapply(knit_meta, is, "shiny_head"))

  # get a list of the Shiny dependencies and mark them as external
  shiny_dependencies <- lapply(shiny::getProvidedHtmlDependencies(),
                               function(dep) { dep$external = TRUE; dep })
  list(dependencies = shiny_dependencies,
       in_header = unlist(knit_meta[heads]))
}

