---
title: 3D 曲面图
author: hoas
date: '2020-08-06'
slug: 3d surface plots
categories:
  - notes
tags:
  - R
subtitle: ''
lastmod: '2020-08-06T10:56:48+08:00'
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: 'https://i.loli.net/2020/08/06/RvpdeuO1QsZf7WY.png'
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: no
lightgallery: no
license: CC BY-NC 4.0
---

某日，钱老板给我安排任务，要我完成一个 3D 曲面图的绘制。面对钱老板无可抗拒的命令，我只能被迫学习……

<!--more-->

## 问题条件

```r
library(data.table)
# data <- fread("qk.csv")
# data
# library(read.so)
# write.so(data)
# dput(data)

data <- data.table(
  Tmin = c(-20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L, -20L, -15L, -10L, -5L, 0L, 5L, 10L, 15L, 20L),
  Tmax = c(-20L, -20L, -20L, -20L, -20L, -20L, -20L, -20L, -20L, -15L, -15L, -15L, -15L, -15L, -15L, -15L, -15L, -15L, -10L, -10L, -10L, -10L, -10L, -10L, -10L, -10L, -10L, -5L, -5L, -5L, -5L, -5L, -5L, -5L, -5L, -5L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 0L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 5L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 10L, 15L, 15L, 15L, 15L, 15L, 15L, 15L, 15L, 15L, 20L, 20L, 20L, 20L, 20L, 20L, 20L, 20L, 20L),
  ET0 = c(-0.573, -0.576, -0.579, -0.583, -0.586, -0.589, -0.592, -0.595, -0.598, -0.47, -0.473, -0.476, -0.479, -0.482, -0.485, -0.488, -0.491, -0.494, -0.366, -0.368, -0.371, -0.374, -0.377, -0.38, -0.383, -0.386, -0.389, -0.261, -0.264, -0.267, -0.27, -0.273, -0.275, -0.278, -0.281, -0.284, -0.156, -0.159, -0.162, -0.165, 0, -0.17, -0.173, -0.176, -0.179, -0.051, -0.054, -0.056, -0.059, -0.062, -0.064, -0.067, -0.07, -0.073, 0.055, 0.052, 0.05, 0.047, 0.044, 0.042, 0.039, 0.037, 0.034, 0.161, 0.159, 0.156, 0.154, 0.151, 0.149, 0.146, 0.144, 0.141, 0.268, 0.266, 0.264, 0.261, 0.259, 0.256, 0.254, 0.251, 0.249)
)
```

## Base 函数

首先来看看 base 函数，推`persp()`：

```r
# base --------------------------------------------------------------------

# 配置 x、y、z 轴数据，注意 z 轴是一个矩阵！而且矩阵的方向不要弄混！
Tmax <- unique(data[, Tmax])
Tmin <- unique(data[, Tmin])
ET0 <- matrix(data[order(-Tmin, Tmax), ET0], 9, 9)

# 配置颜色，由于默认的颜色渐变并不是按照 z 轴的大小来排布的，这里通过以下方法调整为 z 轴
nrz <- nrow(ET0)
ncz <- ncol(ET0)
jet.colors <- colorRampPalette(c("green", "blue"))
# Generate the desired number of colors from this palette
nbcol <- 100
color <- jet.colors(nbcol)
# or: color <- jet.col(100)
# Compute the z-value at the facet centres
zfacet <- ET0[-1, -1] + ET0[-1, -ncz] + ET0[-nrz, -1] + ET0[-nrz, -ncz]
# Recode facet z-values into color indices
facetcol <- cut(zfacet, nbcol)

persp(Tmax, Tmin, ET0)
persp(Tmax, Tmin, ET0,
      main = "富锦汇总_春",
      xlab = 'Error in Tmax(°C)',
      ylab = 'Error in Tmin(°C)',
      zlab = 'Error in ET0(mm/day)',
      theta = -45, phi = 45, border = 'black',
      col = color[facetcol], shade = 0.5, nticks = 5,
      ticktype = "detailed")
```

![persp 1](https://i.loli.net/2020/08/06/xbdXTq8rU6wQ1BF.png)

![persp 2](https://i.loli.net/2020/08/06/itKy7XJBR2HY5cu.png)

详见`example(persp)`。

## plot3D

`plot3D::persp3D()`：

```r
# plot3D ------------------------------------------------------------------

library(plot3D)
persp3D(Tmax, Tmin, ET0,
        main = "富锦汇总_春",
        xlab = 'Error in Tmax(°C)',
        ylab = 'Error in Tmin(°C)',
        zlab = 'Error in ET0(mm/day)',
        zlim = c(-1, 1),
        theta = -45, phi = 0, border = 'black', box = TRUE,
        col = jet.col(100), shade = 0.5, nticks = 2,
        ticktype = "detailed")
```

![persp3D](https://i.loli.net/2020/08/06/1TRq8ECxGNJFlge.png)

## rgl

`rgl::persp3d()`：

```r
# rgl ---------------------------------------------------------------------

library(rgl)
persp3d(Tmax, Tmin, ET0,
          main = NULL,
          xlab = expression('Error in Tmax(°C)'),
          ylab = expression('Error in Tmin(°C)'),
          zlab = expression('Error in ET0(mm/day)'),
          theta = -45, phi = 0, border = 'black', box = TRUE,
          col = jet.col(100), shade = 0.5, nticks = 5,
          ticktype = "detailed")
```

![persp3d](https://i.loli.net/2020/08/06/ziwhU4OPNjK5pdx.png)

## plot3Drgl

`plot3Drgl::persp3Drgl()`：

```r
# plot3Drgl ---------------------------------------------------------------

library(plot3Drgl)
persp3Drgl(Tmax, Tmin, ET0,
        main = NULL,
        xlab = 'Error in Tmax(Centigrade)',
        ylab = 'Error in Tmin(Centigrade)',
        zlab = 'Error in ET0(mm/day)',
        zlim = c(-1, 1),
        theta = -45, phi = 0, border = 'black', box = TRUE,
        col = jet.col(100), shade = 0.5, nticks = 2,
        ticktype = "detailed")
# movie3d(spin3d(axis = c(0, 0, 1), rpm = 10), duration = 6, type = "png", dir = tempdir())
```

![persp3Drgl](https://i.loli.net/2020/08/06/ofYzr7Ze8O9UbmQ.png)

![富锦汇总_春_movie.png](https://i.loli.net/2020/08/06/VDmaMYvoEqceXO8.gif)

## plotly

`plotly::plot_ly()`：

```r
# plotly ------------------------------------------------------------------

library(plotly)

p <- plot_ly(z = volcano, type = "surface")
p

plot_ly(x = Tmax, y = Tmin, z = ET0, type = 'surface', border = 'black') %>%
  # add_surface() %>% # 如果没有 type = 'surface'
  layout(
    scene = list(
      title = "",
      xaxis = list(title = "Error in Tmax(°C)"),
      yaxis = list(title = "Error in Tmin(°C)"),
      zaxis = list(title = "Error in ET0(mm/day)")
    )
  )
```

## 参考文献

- https://plotly-r.com/d-charts.html
  - https://plotly.com/r/reference/layout/#layout-margin
- https://stackoverflow.com/questions/6720526/plot-3d-data-in-r
- http://www.sthda.com/english/wiki/impressive-package-for-3d-and-4d-graph-r-software-and-data-visualization
- https://www.r-graph-gallery.com/3d.html
- http://www.countbio.com/web_pages/left_object/R_for_biology/R_fundamentals/3D_surface_plot_R.html
- https://www.datamentor.io/r-programming/3d-plot/
- https://stackoverflow.com/questions/51414756/creating-surface-3d-plot-of-3-numeric-variables-in-r
- https://hoas-old.netlify.app/post/oneline4/