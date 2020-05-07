---
title: Hugo设置汇总
author: hoas
date: '2020-05-07'
slug: settings-in-hugo
categories:
  - notes
tags:
  - Hugo
subtitle: ''
lastmod: '2020-05-07T16:58:07+08:00'
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: 'https://hugoloveit.com/images/theme-documentation-extended-shortcodes/featured-image-preview.jpg'
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: no
lightgallery: no
license: CC BY-NC 4.0
---

## Hugo更新

每次Hugo更新都需要从[官网](https://github.com/gohugoio/hugo/releases)下载然后重新安装。**blogdown**的`blogdown::update_hugo()`是默认下载`extended`的版本。

下载好后还需要配置**环境变量**。如果手动下载后解压到F盘，即使添加了`Administrator的用户变量`和`系统变量`，也会出现报错：

<!--more-->

{{< admonition failure "错误" true >}}
'hugo' 不是内部或外部命令，也不是可运行的程序或批处理文件。
{{< /admonition >}}



解决方法就是在`系统变量-Path`中添加路径`C:\Users\Administrator\AppData\Roaming\Hugo\`这个路径不需要精确到`hugo.exe`。另外也不需要在`Administrator的用户变量`中添加该路径。

以后hugo的手动更新就保存在这里把！