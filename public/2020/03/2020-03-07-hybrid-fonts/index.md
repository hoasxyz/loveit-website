# 杂交字体


杂交字体在坊间由来已久，随着当今码农审美水平的提高，他们对编程的外部环境需求越来越大，其中字体就是重点之一。

中日韩字体（统汉码）都包含太多字符，但是又包括英文字符。欧美的拉丁字符又不包括统汉码，但是其对拉丁文字的设计更加独具匠心，因此统汉码的主要用户对设计优美的英文字体和自己的母语字体的合成字体的追求也日益强烈。

<!--more-->

## FontCreator

在软件`High-Logic FontCreator`中，可以进行字体的手动更改及杂交。

分别找到一个英文字体和一个中文字体，在`FontCreator`的`Glyphs`中，将英文字体的`exclam`至`asciitilde`部分全部copy至中文字体的对应部分中，然后在`Font`-`Properties`中更改该字体的名称和属性，如果不更改属性的话名称可能不会变（比如微软雅黑）。然后直接导出即可。

## Warcraft Font Merger

[`Warcraft Font Merger`](https://github.com/nowar-fonts/Warcraft-Font-Merger)是某大神制作的字体合并和补全工具，虽然根本没有介绍合并、补全、合并和补全分别是什么意思，但是我按照官方教程操作后发现三个的结果都一样……

该方法可以自动更改字体名称，精选合并或补全操作后直接在`Font`-`Properties`中更改该字体的名称即可，不用改属性了。

## YaHei Consolas Hybrid

一款现成、精美的杂交字体，见[YaHei-Consolas-Hybrid-1.12](https://github.com/yakumioto/YaHei-Consolas-Hybrid-1.12)。

---

MATLAB中的字体在：`C:\Program Files\Polyspace\R2019a\sys\java\jre\win64\jre\lib\fonts`。