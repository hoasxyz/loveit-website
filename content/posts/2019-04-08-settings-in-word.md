---
title: Word设置汇总
author: Hoas
date: '2019-04-08'
slug: settings-in-word
categories:
  - notes
tags:
  - Word
lastmod: '2019-04-08T20:32:07+08:00'
keywords: [Word]
description: 'Word设置汇总'
comment: yes
toc: yes
autoCollapseToc: no
postMetaInFooter: yes
hiddenFromHomePage: no
exclude_jquery: no
contentCopyright: no
reward: no
mathjax: yes
mathjaxEnableSingleDollar: yes
mathjaxEnableAutoNumber: yes
hideHeaderAndFooter: no
---

想着自己还得老老实实用Word用几年，一些每次遇到都头疼的问题都写这儿吧！

<!--more-->

## 插入页码

在封面上插入，设置首页不同，分节的话不要另外加页码，直接选中下一节的页码后右键设置格式。

若设置奇偶页不同，那么需要额外加页码了，在省略掉的奇/偶页上加上页码。

注意：

1. 别忘了每个分节后调整页脚底端距离！

## 插入奇偶互异的页眉

设置奇偶页不同，在正文第一页的页眉上左对齐点击`域`，选择`Styleref`然后点击查看域代码。若不改动那么就是标题文字了，如果这样设置`STYLEREF  "标题 1,章" \r`就可以提取标题前的编号。

如果想只是在页眉上加一个横线，只需选中页眉文字，在开始--段落--边框。

注意：

1. 正文前要加分节符！
2. 正文后两页要取消`链接到前一条页眉`！
3. 若在正文开始奇偶互异页眉，别忘了取消勾选`首页不同`！
4. 若单个章节只有一页，那么也要分节然后更改页眉，不仅仅是内容，还有摆放方式！

待测试:

- 正文奇偶分页的话，每一节的设置应该都是：
  1. 如果首页和上一节末页页眉一致，需要首页不同；
  2. 前两页应该**取消上一页的页眉链接**！

如果不是这样的话，那怕是封面第二页始终会调皮地给你显示一个刺眼的页码，一删后面页眉全乱，不删又太那啥了。第二页也是一个节，链接到它的页眉应该是**正文中没有取消的第一个**。

## 错误！文档中没有指定样式的文字！

我也是醉了，到头来发现竟然是这个梗，掀桌！

复制到新文档中的内容，**样式都变成正文了**，域是没有问题的，问题就在于要重新点样式……

## 目录设置

按照武汉大学论文要求，标题的目录一般是黑体小四，其余为宋体四号，子标题需要有缩进。

## 错误！未定义书签

这word要和我死干到底了？！这些乱七八糟的问题怎么这下全过来了？我告诉你这样只会加快我摒弃word的步伐。

## 代码段

代码段的行距固定为15磅才能显示下划线。

其实这和字体有关，不过小于12磅后行间距会让人太压抑，字体是`Consolas`。

# `PDFMOfficeAddin.dll`

这个是比较坑的一个地方。word自带的PDF导出（即另存为）和文件中的打印设置不能完全还原成你想要的文档样式，目前已经发现了两点：

1. 分页符后面空了一页，现在发现是为了保证**每节一定是偶数页**，我就奇了怪了之前怎么没发现；
2. mathtype插入的章节符被打印出来了。

于是乎，我自己的`.dll`文件又遇到了报错，反正就是使用不了，然后在官网一堆[解决方案](https://helpx.adobe.com/cn/acrobat/kb/pdfmaker-unavailable-office-2007-office.html)中找到了合适的答案：

打开**命令提示符**（可以左下角搜索），然后以管理员身份运行，

```cmd
Microsoft Windows [版本 10.0.17134.765]
(c) 2018 Microsoft Corporation。保留所有权利。

C:\WINDOWS\system32>regsvr32 "C:\Program Files\Adobe\Acrobat\PDFMaker\Office\x64\PDFMOfficeAddin.dll"

C:\WINDOWS\system32>regsvr32 "C:\Program Files\Adobe\Acrobat\PDFMaker\Office\PDFMOfficeAddin.dll"

C:\WINDOWS\system32>regsvr32 "D:\Adobe\Acrobat DC\PDFMaker\Office\x64\PDFMOfficeAddin.dll"

C:\WINDOWS\system32>regsvr32 "D:\Adobe\Acrobat DC\PDFMaker\Office\PDFMOfficeAddin.dll"
```

其中在`x64`中的文件是最终的解决方案。

## 三线表样式设置

主要是上下粗线和内框细线的区别，这个地方有点坑，必须要掌握好设置的顺序。word每次添加新线的磅数默认是0.5磅。因此先不要设置内框线，先设置好上下两个粗线，然后再添加内框线，这时已经默认为0.5磅了。设置上下框线可以**间**接在**格式-边框和底纹**中设置（说实话我不知道要这个有啥用……）。

如果先设置好了一个粗磅，比如1.5磅，然后加上的新线默认为0.5磅，若这个时候在界面中（不是边框和底纹）修改磅数为0.75磅，那么所有的设置的线的磅数都为0.75磅了。

经测试设置三种及三种以上不同粗细的线是不现实的……

## Mathtype

### 插入章节分隔符

一般都是章，这个分隔符不要放在章标题上！我不知道如何不让它在目录中显示。

## 参考文献

R的两本书：

- Hadley Wickam,Garrett Grolemund. R for Data Science[M]. First Edition. Sebastopol. O’Reilly Media, Inc. 2016(12).

- Robert I. Kabacoff. R in Action[M]. Second Edition. Westampton. Manning Publications. 2015.

## 文字样式

文字样式在电脑中的位置为：`C:\Users\Hoas\AppData\Roaming\Microsoft\QuickStyles`。

我发现表格样式是包含在文字样式之内的，因为别的不清楚，所以我只留了一个文字样式。

如果想应用一个文档A的文字样式到另一个文档B中，那么就先打开A文档，然后在`设计`中保存样式集，路径为上述路径。

## `normal.dotm`

`normal.dot`是Word的默认模板。因为模板就是预先设定好的文字、排版格式等，方便以后调用，可以减少重复工作。所以，Word软件在工作时都是基于某个模板进行的。另外，模板的后缀是`.dot`。一般运行Word，都是利用这个模板建立一个新的`.doc`文档。当然，用户也可以自己设置个性化模板。 

以下内容要放在该文件中设置：

- 默认表格样式：在`设计`->`样式`->`管理样式`->`导入/导出`中设置normal.dotm的表格样式。
- 默认页边距标准：上边距为25mm，下边距为20mm，左边距为30mm，右边距为30mm。然后再点击窗口左下方“设为默认值”。

当保存封面样式时会问到将样式保存到`normal`中还是`building blocks`里，我选择了`building blocks`，虽然放狗搜并没有得到一个好的结论。

## R语言高清图插入

在论坛：

1.  https://d.cosx.org/d/420771-rstudio ;
2.  https://d.cosx.org/d/421024-r-rstudio/4 

中均未得到一个让我比较满意的结果。但并不是没有结果，可以用来保存少量高质量的PDF或者是PNG图像，不过操作略微繁琐，不适合大批量图像的使用。

在RStudio中，将图像以metafile的形式导出至剪贴板，然后放置到word中进行裁剪。将word文件导出为PDF格式的文件不能通过Adobe acrobat和内置的导出为PDF，而是需要在打印中选择Microsoft Print to PDF打印机去打印。这个可以正常显示DIN字体。

## 文档样式的更改

在word的`设计`中，新样式集的保存路径为：`C:\Users\Administrator\AppData\Roaming\Microsoft\QuickStyles`，虽然本来用得好好的，但是**可能因为**我无意中在`管理样式`里点击了`基于该模板的新文档`，因此在该模板即`Normal.dotm`中的新文档里，只要点击两次不同的样式，那一次保存在`Normal.dotm`中的样式都全部出现了，而且还删不掉。为了解决这个问题，目前有两个思路：

### Microsoft Word 模板 (.dotx)

具体设置参考[这里](https://www.sohu.com/a/313786523_825825)，亲测有效。简单来讲就是打开一个空白文档，在所有的样式都设置完毕之后，另存为`Microsoft Word 模板 (.dotx)`格式，下次如果需要套用这个模板，就在`模板和加载项`中选用该模板即可。该模板的默认保存路径就是`C:\Users\Administrator\AppData\Roaming\Microsoft\QuickStyles`。

### Microsoft Word 启用宏的模板 (.dotm)

这个模板就是上面提到的坏得不明不白的模板，现在仍然没找到解决方法，所以我把常用的格式命名为`Normal.dotm`，把最初的格式命名为`Initial.dotm`，如果想用毕设模板，那么还是得换`Microsoft Word 模板 (.dotx)`格式。

