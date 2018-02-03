

#-----------------------------------------------------------------------------
#' Plot a matrix as an image
#'
#' @param m numeric matrix with all values in the range [0, 1]
#'
#' @importFrom EBImage as.Image
#' @importFrom graphics plot
#'
#' @export
#-----------------------------------------------------------------------------
plot_matrix <- function(m) {
  plot(EBImage::as.Image(m), interpolate = FALSE)
}


#-----------------------------------------------------------------------------
#' Add a border of zeros around a matrix
#'
#' @param m matrix
#' @param border border width
#'
#' @return a copy of the matrix embedded within a border of zeros
#-----------------------------------------------------------------------------
expand_matrix <- function(m, border) {
  em <- matrix(0, nrow = nrow(m) + 2*border, ncol=ncol(m) + 2*border)
  em[border + seq(nrow(m)), border + seq(ncol(m))] <- m
  em
}


#-----------------------------------------------------------------------------
#' Dither a numeric matrix
#'
#' @param m numeric matrix with all values in the range [0, 1]
#' @param edm the error diffusion matrix
#' @param threshold threshold value. default: 0.5
#'
#' @return numeric matrix with dithering. all values are 0 or 1.
#'
#' @export
#-----------------------------------------------------------------------------
dither <- function(m, edm, threshold = 0.5) {

  #---------------------------------------------------------------------------
  # Expand the matrix so we don't have to worry about edge conditions
  #---------------------------------------------------------------------------
  border <- max(dim(edm))
  em     <- expand_matrix(m, border = border)

  #---------------------------------------------------------------------------
  # Set up the error diffusion matrix and associated variables
  #---------------------------------------------------------------------------
  stopifnot(sum(is.na(edm)) == 1) # should be 1 NA to nominate current pixel position
  edm_w           <- ncol(edm)
  edm_h           <- nrow(edm)
  edm_xoff        <- which(is.na(edm[1, ])) - 1
  edm[is.na(edm)] <- 0

  #---------------------------------------------------------------------------
  # Loop over all pixels in the matrix
  #---------------------------------------------------------------------------
  for (row in seq(border, nrow(em) - border)) {

    #-------------------------------------------------------------------------
    # To which part of the matrix is the error diffusion matrix to be applied?
    #-------------------------------------------------------------------------
    ed_rows  <- row:(row+edm_h - 1)
    ed_cols  <- (border - edm_xoff):(border - edm_xoff + edm_w - 1)

    for (col in seq(border, ncol(em) - border)) {


      #-----------------------------------------------------------------------
      # For the current position, push it to zero or 1 and
      # calculate the error
      #-----------------------------------------------------------------------
      val <- em[row, col]
      if (val < threshold) {
        error <- val
        em[row, col] <- 0
      } else {
        error <- val - 1
        em[row, col] <- 1
      }

      #-----------------------------------------------------------------------
      # Distribute the error to the surrounding pixels
      #-----------------------------------------------------------------------
      em[ed_rows, ed_cols] <-  em[ed_rows, ed_cols] + edm * error

      #-----------------------------------------------------------------------
      # slide the diffusion matrix position one pixel to the right
      #-----------------------------------------------------------------------
      ed_cols <- ed_cols + 1
    }
  }

  #---------------------------------------------------------------------------
  # Return the subset of the expanded matrix which corresponds to the
  # original matrix
  #---------------------------------------------------------------------------
  em[border + seq(nrow(m)), border + seq(ncol(m))]
}