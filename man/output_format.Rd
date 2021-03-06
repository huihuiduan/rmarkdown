\name{output_format}
\alias{output_format}
\title{Define an R Markdown output format}
\usage{
output_format(knitr, pandoc, clean_supporting = TRUE, pre_processor = NULL,
  post_processor = NULL)
}
\arguments{
  \item{knitr}{Knitr options for an output format (see
  \code{\link{knitr_options}})}

  \item{pandoc}{Pandoc options for an output format (see
  \code{\link{pandoc_options}})}

  \item{clean_supporting}{Cleanup any supporting files
  after conversion see
  \code{\link{render_supporting_files}}}

  \item{pre_processor}{An optional pre-processor function
  that receives the \code{metadata}, \code{input_lines},
  \code{runtime}, \code{knit_meta}, and \code{files_dir}
  and can return additional arguments to pass to pandoc.}

  \item{post_processor}{An optional post-processor function
  that receives the \code{metadata}, \code{input_file},
  \code{output_file}, \code{clean}, and \code{verbose}
  parmaeters, and can return an alternative
  \code{output_file}.}
}
\value{
An R Markdown output format definition that can be passed
to \code{\link{render}}.
}
\description{
Define an R Markdown output format based on a combination
of knitr and pandoc options.
}
\examples{
\dontrun{
output_format(knitr = knitr_options(opts_chunk = list(dev = 'png')),
              pandoc = pandoc_options(to = "html"))
}
}
\seealso{
\link{render}, \link{knitr_options}, \link{pandoc_options}
}

