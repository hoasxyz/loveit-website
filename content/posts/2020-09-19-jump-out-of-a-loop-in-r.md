---
title: R语言跳出循环
author: hoas
date: '2020-09-19'
slug: jump out of a loop in r
categories:
  - notes
tags:
  - R
subtitle: ''
lastmod: '2020-09-19T11:29:31+08:00'
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/83/Break.com_Logo_2017.svg/1200px-Break.com_Logo_2017.svg.png'
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: no
lightgallery: no
license: CC BY-NC 4.0
---

一直都容易忘记 R 中的循环跳出，在 R 中有两个函数：`break`和`next`。

## 示例

首先看几个个例子：

``` r
c <- 0
for (a in 1:15) {
  for (b in 1:15) {
    c <- c + 1
    if (c > 10) break
  }
}
c
#> [1] 25

c <- 0
for (a in 1:15) {
  for (b in 1:15) {
    c <- c + 1
  }
  if (c > 10) break
}
c
#> [1] 15

c <- 0
for (a in 1:15) {
  for (b in 1:15) {
    c <- c + 1
    if (c > 10) next
  }
}
c
#> [1] 225

c <- 0
for (a in 1:15) {
  for (b in 1:15) {
    if (c > 10) break
    c <- c + 1
  }
}
c
#> [1] 11

c <- 0
for (a in 1:15) {
  for (b in 1:15) {
    c <- c + 1
  }
  if (c > 10) next
}
c
#> [1] 225
```

<sup>Created on 2020-09-19 by the [reprex package](https://reprex.tidyverse.org) (v0.3.0)</sup>

<!--more-->

## 结论

从这里可以看出，`break`和`next`均能跳出循环。所不同的是：

- `break`是**跳出当前（指循环）的整个（指迭代）`for()`循环**。加入在`i = 4`处`break`，那么跳出整个`for()`循环，直接执行接下来的语句；
- `next`是跳出当前（指循环）的所在（指迭代）`for(i == current_constant)`循环，而进行当前循环的下一个迭代`for(i == current_constant + 1)`