---
title: Excel设置汇总
author: hoas
date: '2020-06-18'
slug: settings-in-excel
categories:
  - notes
tags:
  - Excel
subtitle: ''
lastmod: '2020-06-18T15:04:27+08:00'
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: 'https://tealtek.co.za/wp-content/uploads/2018/04/how-to-create-pivottables-main_thumb800.png'
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: no
lightgallery: no
license: 'CC BY-NC 4.0'
---

## 其他格式数据转为Excel

在`数据`-`获取数据`中进行数据转换，而不是直接对某一格式的文件（如`.txt`）进行名称后缀的更改！

<!--more-->

## 分列

某日徐局长给我了一个`.xlsx`文件，用Excel打不开，不过转换为`.xls`之后可以强制打开，打开后的两列原本应该为数值格式的数据左上角均带上了绿色角标，而且框住这些数据无法进行数值运算。

右键转换为数值格式依然无效，强制转换为其它格式文件后提示原文件为WPS的私密文件。

这个问题目前找到了两个方法解决：

1. Excel中，选中有问题的单元格，左上角会有感叹号图标提示，点击并选择`转换为数字`；
2. **分列**，类似于R语言中的`tidyr::separate()`，对有问题的单元格进行分隔符和数值的拆开，保留数值。

