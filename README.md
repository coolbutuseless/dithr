---
title: "dithr"
output: html_document
---





```r
# install.packages('magick')
# source("https://bioconductor.org/biocLite.R")
# biocLite("EBImage")
devtools::install_bitbucket('coolbutuseless/dithr')
```




```r
#-----------------------------------------------------------------------------
# Using imagemagick to load and convert the image to grayscale
#-----------------------------------------------------------------------------
im <- magick::image_read("./images/Portal_Companion_Cube.jpg") %>%
  magick::image_convert(type = 'grayscale') %>% 
  magick::image_scale(geometry="50%")
  

#-----------------------------------------------------------------------------
# Extract the matrix of values
#-----------------------------------------------------------------------------
m <- magick::as_EBImage(im)@.Data

#-----------------------------------------------------------------------------
# Show the original image
#-----------------------------------------------------------------------------
dithr::plot_matrix(m)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-2-1.png)



```r
dithered_matrix <- dithr::dither(m, dithr::diffusion_matrix$floyd_steinberg)
dithr::plot_matrix(dithered_matrix)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3-1.png)

