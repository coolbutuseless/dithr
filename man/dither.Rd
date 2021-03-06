% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dither.R
\name{dither}
\alias{dither}
\title{Dither a numeric matrix}
\usage{
dither(m, edm, threshold = 0.5)
}
\arguments{
\item{m}{numeric matrix with all values in the range [0, 1]}

\item{edm}{the error diffusion matrix}

\item{threshold}{threshold value. default: 0.5}
}
\value{
numeric matrix with dithering. all values are 0 or 1.
}
\description{
Dither a numeric matrix
}
