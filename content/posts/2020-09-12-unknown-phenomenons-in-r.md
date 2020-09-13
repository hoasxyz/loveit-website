---
title: R语言未解之谜
author: hoas
date: '2020-09-12'
slug: unknown phenomenons in r
categories:
  - notes
tags:
  - R
subtitle: ''
lastmod: '2020-09-12T09:05:29+08:00'
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: 'https://www.kdopass.bzh/files/1572_817582891.png'
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: no
lightgallery: no
license: CC BY-NC 4.0
---

R 语言未解之谜……

<!--more-->

## 文件编码

关于文件编码目前有一些发现：

1. 文件的编码方式，即该文件保存时所对应的编码方式。可在`File - Reopen with Encoding`中设置。
2. 在一个编码方式下输入中文字符，然后再转为其它编码方式时中文字符可能会出现乱码。
3. 举例：当前编码为`UTF-8`且含有中文字符时，输入`source('file_name.R')`能够成功运行文件而输入`source('file_name.R', encoding = 'UTF-8')`时报错（invalid input）。
4. 电脑新安装 R 和 Rstudio 的时候会提示按照哪种方式编码，这个时候哪个方式`source()`都能成功。

太神奇了，今天（9.12）我把系统默认的地区换为中国，`source()`问题就解决了，虽然打开 RStudio 之后的截面显示有中文……