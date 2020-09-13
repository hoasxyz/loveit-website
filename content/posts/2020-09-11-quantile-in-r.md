---
title: 分位数
author: hoas
date: '2020-09-11'
slug: Quantile
categories:
  - notes
tags:
  - R
subtitle: ''
lastmod: '2020-09-11T15:00:43+08:00'
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: 'https://upload.wikimedia.org/wikipedia/commons/5/5e/Iqr_with_quantile.png'
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: yes
lightgallery: no
license: CC BY-NC 4.0
---

已经遇到或者是自己想遇到很多次关于分位数的东西了，在这里进行一下总结。

<!--more-->

## 分位数

[知乎上](https://www.zhihu.com/question/46609142)有一个简要的介绍：

<img src="https://i.loli.net/2020/09/11/X96IxkcYgdbuvpJ.png" alt="知乎某用户解答" width="100%" height="100%">

在这里，F 指的是数据的分布函数。这可能是比较概率论化的定义，回归计算的话，我们可以如此定义：

分位数（quantile）：把一组按照升序排列的数据分割成 n 个等份区间并产生 n-1 个等分点后**每个等分点所对应的数据**。按照升序排列称作第一至第 n-1 的 n 分位数。（注：如果等分点在其左右两个数据的中间，那么该等分点所对应的数就是**其左右两数的平均数**）

确定等分位点位置的其中一种常用公式：
$$
(n + 1) * p / q
$$
其中 n 表示一共有多少数据，p 表示第几分位，q 表示是几分位数。

```r
## Default S3 method:
quantile(x, probs = seq(0, 1, 0.25), na.rm = FALSE,
         names = TRUE, type = 7, ...)
```

## type = 6

在 Minitab 和 SPSS 中使用的方式，也是 Excel 中函数`percentile.exc()`的计算方式。

例如求四分位数（quartile；4-quantile），有数据：1，1，3，6，7，12，14，17，25，28，29。上述数据集中共有 11 个数据。将这组已排列好的数据等分成 4 等份后产生 3 个等分点。

其中第一四分位数：
$$
Q_1=（11+1）*（1/4）=3
$$
对应的数据为 3。

第二四分位数（即中位数）：
$$
Q_2=（11+1）*（2/4）=6
$$
对应的数据为 12。

第三四分位数：
$$
Q_3=（11+1）*（3/4）=9
$$
对应的数据为 25。

以此类推百分位数（percentile）就是把数据等分成 100 等份后所获得的数。根据分数性质，$Q_1$ 就是 25% 百分位数（左右数据数量 1:3），$Q_2$ 中位数就是 50%（1:1），$Q_3$ 就是 75%（3:1）。

```r
> quantile(c(1, 1, 3, 6, 7, 12, 14, 17, 25, 28, 29), .75, type = 6)
75% 
 25 
```

## type = 7

这种在 S 中常用，也是 Excel 中函数`percentile.inc()`的计算方式。

但是并不清楚如何计算。

```r
> quantile(c(1, 1, 3, 6, 7, 12, 14, 17, 25, 28, 29), .75, type = 7)
75% 
 21 
```

