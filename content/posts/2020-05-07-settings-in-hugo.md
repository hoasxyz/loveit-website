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
featuredImage: 'https://hugoloveit.com/theme-documentation-built-in-shortcodes/featured-image.png'
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

## 盘古之白

在`F:\1R\loveit-website\themes\LoveIt\layouts\partials\footer.html`中插入：

```js
<script>
(function(u, c) {
  var d = document, t = 'script', o = d.createElement(t),
      s = d.getElementsByTagName(t)[0];
  o.src = u;
  if (c) { o.addEventListener('load', function(e) { c(e); }); }
  s.parentNode.insertBefore(o, s);
})('//cdn.bootcss.com/pangu/3.3.0/pangu.min.js', function() {
  pangu.spacingPage();
});
</script>
```

但是每次用`git submodule`更新时都要重更，目前还没有找到解决方法。

## 路径顺序

如果想在博文的`.md`文件中插入本地图片（`/static/images/`），可以采用：

```cmd
![balabala](/images/lalala.jpg)
```

因为Hugo博文默认的图片引用根目录就已经是`static`！

附上路径引用的区别：

```cmd
./  ::当前目录
../ ::父级目录
/   %根目录%
```

