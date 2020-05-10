---
title: Git设置汇总
author: hoas
date: '2020-05-07'
slug: settings-in-git
categories:
  - notes
tags:
  - Git
subtitle: ''
lastmod: '2020-05-07T17:37:54+08:00'
authorLink: ''
description: ''
hiddenFromHomePage: no
hiddenFromSearch: no
featuredImage: 'https://likeitea-1257692904.cos.ap-guangzhou.myqcloud.com/liketea_blog/1_9qX9F9MGsWKfcmgTOR9BPw.png'
featuredImagePreview: ''
toc:
  enable: yes
math:
  enable: no
lightgallery: no
license: CC BY-NC 4.0
---

## `.gitignore`

一些可以忽略，不用占用过多内存的文件如下：

<!--more-->

```git
.Rproj.user
.Rhistory
.RData
.Ruserdata
draft/
Excel/
public/
*.R
*.xlsx
themes/theme-LoveIt/
```

其语法规范如下：

- 空行或是以`#`开头的行即注释行将被忽略。
- 可以在前面添加正斜杠`/`来避免递归,下面的例子中可以很明白的看出来与下一条的区别。
- 可以在后面添加正斜杠`/`来忽略文件夹，例如`build/`即忽略build文件夹。
- 可以使用`!`来否定忽略，即比如在前面用了`*.apk`，然后使用`!a.apk`，则这个`a.apk`不会被忽略。
- `*`用来匹配零个或多个字符，如`*.[oa]`忽略所有以".o"或".a"结尾，`*~`忽略所有以`~`结尾的文件（这种文件通常被许多编辑器标记为临时文件）；`[]`用来匹配括号内的任一字符，如`[abc]`，也可以在括号内加连接符，如`[0-9]`匹配0至9的数；`?`用来匹配单个字符。

举例如下：

```
# 忽略 .a 文件
*.a
# 但否定忽略 lib.a, 尽管已经在前面忽略了 .a 文件
!lib.a
# 仅在当前目录下忽略 TODO 文件， 但不包括子目录下的 subdir/TODO
/TODO
# 忽略 build/ 文件夹下的所有文件
build/
# 忽略 doc/notes.txt, 不包括 doc/server/arch.txt
doc/*.txt
# 忽略所有的 .pdf 文件 在 doc/ directory 下的
doc/**/*.pdf
```



## 移除缓存时的注意事项

因为`.gitignore`能忽略那些原来没有被 track 的文件，如果某些文件已经被纳入了版本管理中，则修改`.gitignore`是无效的。解决方法是先把本地缓存删除，然后再提交。删除本地缓存的方法是`git rm -r --cached .`。

{{<admonition warning "注意" true>}}
- 该指令会删除很多别的你需要的文件！`commit`的时候这些文件都会消失，进而出现一系列别的问题！

- 删除的文件可以通过`git status`查看，如果有想要留下的缓存就用`git add <file>`添加！
{{< /admonition >}}

## warning: LF will be replaced by ...

```
warning: LF will be replaced by CRLF in .gitignore.
The file will have its original line endings in your working directory.
```

解决方法：

```bash
git config --global core.autocrlf false//禁用自动换行
```

## `git submodule`

先将缓存中的子模块文件删除：`git rm -r --cached themes/LoveIt/`，再将本地仓库中的`/themes/LoveIt/`删除，然后

```bash
$ git submodule add https://github.com/dillonzq/LoveIt.git themes/LoveIt
Cloning into 'F:/1R/loveit-website/themes/LoveIt'...
remote: Enumerating objects: 25, done.
remote: Counting objects: 100% (25/25), done.
remote: Compressing objects: 100% (21/21), done.
remote: Total 9046 (delta 9), reused 12 (delta 4), pack-reused 9021
Receiving objects: 100% (9046/9046), 35.85 MiB | 899.00 KiB/s, done.
Resolving deltas: 100% (4423/4423), done.
```

这个时候在本地仓库根目录可以看到`.gitmodules`文件，打开后是

```
[submodule "themes/LoveIt"]
	path = themes/LoveIt
	url = https://github.com/dillonzq/LoveIt.git
```

`git push`之后，可以在github上看到子模块文件夹，文件夹带上了其所在仓库的版本号：

![LoveIt @ 4479d55](https://i.loli.net/2020/05/09/QJCVWKkFwsn3I2e.png)

目前没有待更新，等theme再有更新再更。

### 参考

- https://d.cosx.org/d/421442-blogdowngithubtheme
- https://yihui.org/cn/2017/03/git-submodule/
- https://zhuanlan.zhihu.com/p/87053283

## 缓存中删除文件的恢复

```bash
git rm -r --cached .
git restore --staged .
git restore .
```

