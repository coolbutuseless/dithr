% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/error_diffusion_matrices.R
\docType{data}
\name{diffusion_matrix}
\alias{diffusion_matrix}
\title{Named list of standard error diffusion matrices}
\format{An object of class \code{list} of length 10.}
\usage{
diffusion_matrix
}
\description{
The way error is diffused is defined by a matrix of values called
the 'error diffusion matrix'.   It defines how the error is distributed to
the surrounding pixels.
}
\details{
The matrix must contain one \code{NA} value in the first row to indicate the
position of the current pixel.

Matrices should mostly sum to 1 (a key exception is the Atkinson diffusion
matrix which purposefully does not diffuse 25% of the error)
}
\keyword{datasets}
