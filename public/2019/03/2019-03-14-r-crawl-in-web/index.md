# R语言网络爬虫

下个[SelectorGadget](https://chrome.google.com/webstore/search/selectorgadget?hl=zh-CN)然后开启你的爬虫之旅~

<!--more-->

# 常用函数

- `read_html()`, 读取html文档或链接，可以是url链接，也可以是本地的html文件，
  甚至是包含html的字符串。
- `html_nodes()`, 选择提取文档中指定元素的部分。
  支持`css`路径选择, 或`xpath`路径选择。
  如果tags层数较多，必须使用selectorGadget复制准确的路径。
  使用方式：开启SelectorGadget,然后鼠标选中位置，右击选择检查元素，光标移动到tags上。
  然后选择copy,选择selector或xpath选项。
- `html_text()`,提取tags内文本，
- `html_table()`, 提前tags内表格。
- `html_form()`, `set_values()`, 和`submit_form()`分别表示提取、修改和提交表单。

# 表格提取

```r
library(rvest)
library(magrittr)

city_name <- c(
  "beijing", "shanghai", "guangzhou", "shenzhen", "hangzhou",
  "tianjin", "chengdu", "nanjing", "xian", "wuhan"
)
url_cites <- paste0("http://www.pm25.in/", city_name)

for (n in 1:length(city_name)) {

  # 提取表格
  pm_city <- read_html(x = url_cites[n]) %>%
    html_nodes(css = ".aqis_live_data .container .table") %>%
    .[[2]] %>% # 注意这里的点
    html_table()

  # 批量生成变量
  assign(x = paste0("pm_", city_name[n]), value = pm_city)
}
rm(url_cites, pm_city)

DT::datatable(pm_chengdu)
DT::datatable(pm_beijing)
```

虽然我一直没有搞懂这个点的意思，换句话说我根本没搞懂这行代码的意思，但是代码确实运行成功了。不过下面的代码可以，可能是因为`li`的原因吧……这个指令好像把网站上的所有表格都抓取了，可是为什么只到2008年？我大中国的辉煌您就不认为能延续吗？另外还有些表格的内容没有读取成功，也不清楚是什么原因……

``` r
library(rvest)
#> 载入需要的程辑包：xml2
skiing <- read_html("http://info.2012.163.com/medals/")
skiing %>%
  html_table(fill = TRUE)
#> [[1]]
#>    排名     国家 金 银 铜
#> 1     1     中国 51 21 28
#> 2     2     美国 36 38 36
#> 3     3   俄罗斯 23 21 29
#> 4     4     英国 19 13 15
#> 5     5     德国 16 10 15
#> 6     6 澳大利亚 14 15 17
#> 7     7     韩国 13 10  8
#> 8     8     日本  9  6 11
#> 9     9   意大利  8  9 10
#> 10   10     法国  7 16 17
#> 
#> [[2]]
#>    排名     国家 金 银 铜
#> 1     1     美国 35 39 29
#> 2     2     中国 32 17 14
#> 3     3   俄罗斯 27 27 38
#> 4     4 澳大利亚 17 16 16
#> 5     5     日本 16  9 12
#> 6     6     德国 14 16 18
#> 7     7     法国 11  9 13
#> 8     8   意大利 10 11 11
#> 9     9     韩国  9 12  9
#> 10   10     英国  9  9 12
#> 
#> [[3]]
#>    排名     国家 金 银 铜
#> 1     1     美国 37 24 31
#> 2     2   俄罗斯 32 28 28
#> 3     3     中国 28 16 15
#> 4     4 澳大利亚 16 25 17
#> 5     5     德国 13 17 26
#> 6     6     法国 13 14 11
#> 7     7   意大利 13  8 13
#> 8     8     荷兰 12  9  4
#> 9     9     古巴 11 11  7
#> 10   10     英国 11 10  7
#> 
#> [[4]]
#>    排名     国家 金 银 铜
#> 1     1     美国 44 32 25
#> 2     2   俄罗斯 26 21 16
#> 3     3     德国 20 18 27
#> 4     4     中国 16 22 12
#> 5     5     法国 15  7 15
#> 6     6   意大利 13 10 12
#> 7     7 澳大利亚  9  9 23
#> 8     8     古巴  9  8  8
#> 9     9   乌克兰  9  2 12
#> 10   10     韩国  7 15  5
#> 
#> [[5]]
#>    排名             国家 金 银 铜
#> 1     1 联合队（独联体） 45 38 29
#> 2     2             美国 37 34 37
#> 3     3             德国 33 21 28
#> 4     4             中国 16 22 16
#> 5     5             古巴 14  6 11
#> 6     6           西班牙 13  7  2
#> 7     7             韩国 12  5 12
#> 8     8           匈牙利 11 12  7
#> 9     9             法国  8  5 16
#> 10   10         澳大利亚  7  9 11
#> 
#> [[6]]
#>    排名     国家 金 银 铜
#> 1     1     苏联 55 31 46
#> 2     2 民主德国 37 35 30
#> 3     3     美国 36 31 27
#> 4     4   南朝鲜 12 10 11
#> 5     5 联邦德国 11 14 15
#> 6     6   匈牙利 11  6  6
#> 7     7 保加利亚 10 12 13
#> 8     8 罗马尼亚  7 11  6
#> 9     9     法国  6  4  6
#> 10   10   意大利  6  4  4
#> 
#> [[7]]
#>    排名     国家 金 银 铜
#> 1     1     美国 83 61 30
#> 2     2 罗马尼亚 20 16 17
#> 3     3 联邦德国 17 19 23
#> 4     4     中国 15  8  9
#> 5     5   意大利 14  6 12
#> 6     6   加拿大 10 18 16
#> 7     7     日本 10  8 14
#> 8     8   新西兰  8  1  2
#> 9     9 南斯拉夫  7  4  7
#> 10   10     韩国  6  6  7
#> 
#> [[8]]
#>    排名     国家 金 银 铜
#> 1     1     苏联 80 69 46
#> 2     2 民主德国 47 37 42
#> 3     3 保加利亚  8 16 17
#> 4     4     古巴  8  7  5
#> 5     5   意大利  8  3  4
#> 6     6   匈牙利  7 10 15
#> 7     7 罗马尼亚  6  6 13
#> 8     8     法国  6  5  3
#> 9     9     英国  5  7  9
#> 10   10     波兰  3 14 15
#> 
#> [[9]]
#>    排名     国家 金 银 铜
#> 1     1     苏联 49 41 35
#> 2     2 民主德国 40 25 25
#> 3     3     美国 34 35 25
#> 4     4 联邦德国 10 12 17
#> 5     5     日本  9  6 10
#> 6     6     波兰  7  6 13
#> 7     7 保加利亚  6  9  7
#> 8     8     古巴  6  4  3
#> 9     9 罗马尼亚  4  9 14
#> 10   10   匈牙利  4  5 13
#> 
#> [[10]]
#>    排名     国家 金 银 铜
#> 1     1     苏联 50 27 22
#> 2     2     美国 33 31 30
#> 3     3 民主德国 20 23 23
#> 4     4 联邦德国 13 11 16
#> 5     5     日本 13  8  8
#> 6     6 澳大利亚  8  7  2
#> 7     7     波兰  7  5  9
#> 8     8   匈牙利  6 13 16
#> 9     9 保加利亚  6 10  5
#> 10   10   意大利  5  3 10
#> 
#> [[11]]
#>    排名         国家 金 银 铜
#> 1     1         美国 45 28 34
#> 2     2         苏联 29 32 30
#> 3     3         日本 11  7  7
#> 4     4       匈牙利 10 10 12
#> 5     5     民主德国  9  9  7
#> 6     6         法国  7  3  5
#> 7     7 捷克斯洛伐克  7  2  4
#> 8     8     联邦德国  5 11 10
#> 9     9     澳大利亚  5  7  5
#> 10   10         英国  5  5  3
#> 
#> [[12]]
#>    排名         国家 金 银 铜
#> 1     1         美国 36 26 28
#> 2     2         苏联 30 31 35
#> 3     3         日本 16  5  8
#> 4     4         德国 10 22 18
#> 5     5       意大利 10 10  7
#> 6     6       匈牙利 10  7  5
#> 7     7         波兰  7  6 10
#> 8     8     澳大利亚  6  2 10
#> 9     9 捷克斯洛伐克  5  6  3
#> 10   10         英国  4 12  2
#> 
#> [[13]]
#>    排名         国家 金 银 铜
#> 1     1         苏联 43 29 31
#> 2     2         美国 34 21 16
#> 3     3       意大利 13 10 13
#> 4     4         德国 12 19 11
#> 5     5     澳大利亚  8  8  6
#> 6     6       土耳其  7  2  0
#> 7     7       匈牙利  6  8  7
#> 8     8         日本  4  7  7
#> 9     9         波兰  4  6 11
#> 10   10 捷克斯洛伐克  3  2  3
#> 
#> [[14]]
#>    排名     国家 金 银 铜
#> 1     1     苏联 37 29 32
#> 2     2     美国 32 25 17
#> 3     3 澳大利亚 13  8 14
#> 4     4   匈牙利  9 10  7
#> 5     5   意大利  8  8  9
#> 6     6     瑞典  8  5  6
#> 7     7     德国  6  7 11
#> 8     8     英国  6  7 11
#> 9     9 罗马尼亚  5  3  5
#> 10   10     日本  4 10  5
#> 
#> [[15]]
#>    排名         国家 金 银 铜
#> 1     1         美国 40 19 17
#> 2     2         苏联 22 30 19
#> 3     3         瑞典 12 12 10
#> 4     4       匈牙利 10 10 16
#> 5     5       意大利  8  9  4
#> 6     6 捷克斯洛伐克  7  3  3
#> 7     7         法国  6  6  6
#> 8     8         芬兰  6  3 13
#> 9     9     澳大利亚  6  2  3
#> 10   10         挪威  3  0  2
#> 
#> [[16]]
#>    排名         国家 金 银 铜
#> 1     1         美国 38 27 19
#> 2     2         瑞典 16 11 17
#> 3     3         法国 10  6 13
#> 4     4       匈牙利 10  5 12
#> 5     5       意大利  8 11  8
#> 6     6         芬兰  8  7  5
#> 7     7       土耳其  6  4  2
#> 8     8 捷克斯洛伐克  6  2  3
#> 9     9         瑞士  5 10  5
#> 10   10         丹麦  5  7  8
#> 
#> [[17]]
#>    排名 国家 金 银 铜
#> 1    NA   NA NA NA NA
#> 2    NA   NA NA NA NA
#> 3    NA   NA NA NA NA
#> 4    NA   NA NA NA NA
#> 5    NA   NA NA NA NA
#> 6    NA   NA NA NA NA
#> 7    NA   NA NA NA NA
#> 8    NA   NA NA NA NA
#> 9    NA   NA NA NA NA
#> 10   NA   NA NA NA NA
#> 
#> [[18]]
#>    排名 国家 金 银 铜
#> 1    NA   NA NA NA NA
#> 2    NA   NA NA NA NA
#> 3    NA   NA NA NA NA
#> 4    NA   NA NA NA NA
#> 5    NA   NA NA NA NA
#> 6    NA   NA NA NA NA
#> 7    NA   NA NA NA NA
#> 8    NA   NA NA NA NA
#> 9    NA   NA NA NA NA
#> 10   NA   NA NA NA NA
#> 
#> [[19]]
#>    排名   国家 金 银 铜
#> 1     1   德国 33 26 30
#> 2     2   美国 24 20 12
#> 3     3 匈牙利 10  1  5
#> 4     4 意大利  8  9  5
#> 5     5   芬兰  7  6  6
#> 6     6   法国  7  6  6
#> 7     7   瑞典  6  5  9
#> 8     8   日本  6  4  8
#> 9     9   荷兰  6  4  7
#> 10   10   英国  4  7  3
#> 
#> [[20]]
#>    排名     国家 金 银 铜
#> 1     1     美国 41 32 30
#> 2     2   意大利 12 12 12
#> 3     3     法国 10  5  4
#> 4     4     瑞典  9  5  9
#> 5     5     日本  7  7  4
#> 6     6   匈牙利  6  4  5
#> 7     7     芬兰  5  8 10
#> 8     8     德国  4 12  5
#> 9     9     英国  4  7  5
#> 10   10 澳大利亚  3  1  1
#> 
#> [[21]]
#>    排名   国家 金 银 铜
#> 1     1   美国 22 18 16
#> 2     2   德国 10  7 14
#> 3     3   芬兰  8  8  9
#> 4     4   瑞典  7  6 12
#> 5     5 意大利  7  5  7
#> 6     6   瑞士  7  4  4
#> 7     7   法国  6 10  5
#> 8     8   荷兰  6  9  4
#> 9     9 匈牙利  4  5  0
#> 10   10 加拿大  4  4  7
#> 
#> [[22]]
#>    排名   国家 金 银 铜
#> 1     1   美国 45 27 27
#> 2     2   芬兰 14 13 10
#> 3     3   法国 13 15 10
#> 4     4   英国  9 13 12
#> 5     5 意大利  8  3  5
#> 6     6   瑞士  7  8 10
#> 7     7   挪威  5  2  3
#> 8     8   瑞典  4 13 12
#> 9     9   荷兰  4  1  5
#> 10   10 比利时  3  7  3
#> 
#> [[23]]
#>    排名   国家 金 银 铜
#> 1     1   美国 41 27 28
#> 2     2   瑞典 19 20 25
#> 3     3   英国 15 15 13
#> 4     4   芬兰 15 10  9
#> 5     5 比利时 13 11 11
#> 6     6   挪威 13  9  9
#> 7     7 意大利 13  5  5
#> 8     8   法国  9 19 13
#> 9     9   荷兰  4  2  5
#> 10   10   丹麦  3  9  1
#> 
#> [[24]]
#>    排名 国家 金 银 铜
#> 1    NA   NA NA NA NA
#> 2    NA   NA NA NA NA
#> 3    NA   NA NA NA NA
#> 4    NA   NA NA NA NA
#> 5    NA   NA NA NA NA
#> 6    NA   NA NA NA NA
#> 7    NA   NA NA NA NA
#> 8    NA   NA NA NA NA
#> 9    NA   NA NA NA NA
#> 10   NA   NA NA NA NA
#> 
#> [[25]]
#>    排名   国家 金 银 铜
#> 1     1   瑞典 24 24 16
#> 2     2   美国 23 19 19
#> 3     3   英国 10 15 16
#> 4     4   芬兰  9  8  9
#> 5     5   法国  7  4  3
#> 6     6   德国  5 13  7
#> 7     7   南非  4  2  0
#> 8     8   挪威  4  1  3
#> 9     9 匈牙利  3  2  3
#> 10   10 加拿大  3  2  2
#> 
#> [[26]]
#>    排名   国家 金 银 铜
#> 1     1   英国 56 50 39
#> 2     2   美国 23 12 12
#> 3     3   瑞典  8  6 11
#> 4     4   法国  5  5  9
#> 5     5   德国  3  5  4
#> 6     6 匈牙利  3  4  2
#> 7     7 加拿大  3  3  7
#> 8     8   挪威  2  3  3
#> 9     9 意大利  2  2  0
#> 10   10 比利时  1  5  2
#> 
#> [[27]]
#>    排名   国家 金 银 铜
#> 1     1   美国 78 82 79
#> 2     2   德国  4  4  5
#> 3     3   古巴  4  2  3
#> 4     4 加拿大  4  1  1
#> 5     5 匈牙利  2  1  1
#> 6     6 混合队  1  1  0
#> 7     7   英国  1  1  0
#> 8     8   希腊  1  0  1
#> 9     9   瑞士  1  0  1
#> 10   10 奥地利  0  0  1
#> 
#> [[28]]
#>    排名     国家 金 银 铜
#> 1     1     法国 26 36 33
#> 2     2     美国 20 15 16
#> 3     3     英国 17  8 12
#> 4     4   比利时  5  6  3
#> 5     5     瑞士  5  3  1
#> 6     6     德国  4  2  2
#> 7     7     丹麦  2  3  2
#> 8     8   意大利  2  2  0
#> 9     9 澳大利亚  2  0  4
#> 10   10   匈牙利  1  2  2
#> 
#> [[29]]
#>    排名     国家 金 银 铜
#> 1     1     美国 11  7  1
#> 2     2     希腊 10 19 17
#> 3     3     德国  7  5  2
#> 4     4     法国  5  4  2
#> 5     5     英国  2  3  2
#> 6     6   匈牙利  2  1  2
#> 7     7   奥地利  2  0  3
#> 8     8 澳大利亚  2  0  0
#> 9     9     丹麦  1  2  4
#> 10   10     瑞士  1  2  0
```

<sup>Created on 2019-04-22 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# 图片的提取和模拟对话

不想写了，代码运行不出来，如果自己以后会用到就直接看[链接](https://mp.weixin.qq.com/s/CI3TpgRNZNtBb_BqYxlAmA)学吧！

# 实例

## 链家网深圳二手房

爬取网站：https://sz.lianjia.com/ershoufang/pg/

```c
require(pacman)
p_load(xml2,rvest,downloader)
#t1 <- proc.time()
hs <- tibble()

for (i in 1:100) {
  url <- paste("https://sz.lianjia.com/ershoufang/pg/d", i, sep = "")
  
  hs_info <- url %>%
    read_html() %>%
    html_nodes("div.houseInfo") %>%
    html_text() %>%
    str_split("\\|", simplify = TRUE)
  
  hs_info[, 3] <- hs_info[, 3] %>%
    str_remove("(平米)")
  
  hs_posi <- url %>%
    read_html() %>%
    html_nodes("div.positionInfo") %>%
    html_text() %>%
    str_split(" - ", simplify = TRUE)
  
  hs_pric <- url %>%
    read_html() %>%
    html_nodes("div.priceInfo") %>%
    html_text() %>%
    str_extract_all("(\\d{3,6})", simplify = TRUE)
  
  house <- cbind(hs_info, hs_posi, hs_pric) %>%
    as_tibble() %>%
    rename(
      小区名 = V1, 厅室 = V2, 面积 = V3, 朝向 = V4, 装饰 = V5,
      电梯 = V6, 楼层 = V7, 周边 = V8, 总价 = V9, 单价 = V10
    )
  
  hs <- rbind(hs, house)
}

hs$面积 <- as.numeric(hs$面积)
hs$总价 <- as.numeric(hs$总价)
hs$单价 <- as.numeric(hs$单价)

write.csv(hs, "深圳二手房.csv")
#proc.time() - t1
hs <- read.csv("E:/1R/website/Excel/ershou.csv", fileEncoding = "UTF-8") %>%
  select(-1)
```

这里一共100页，一页30个二手房源，一共有3000个房源数据，和网友分析的一样，关于正则表达式的那一块，这里也贴上他们的小改进：

```c
# 1
str_split_fixed(house_tag," *\\|",7) #正则改成这样就能将所有的变量都分隔开了

# 2
library(tidyverse)
#df是数据集，col是按那一列进行划分，into是划分为新数据集的列名称，sep是划分的符号
df=separate(data = df, col = colname, into = c("code", "name"), sep = "\\|")
```

安居客深圳租房

我发现我自己有点不知天高地厚啊？竟然有胆量去查 **二手房** ！！知错就改还是好孩子嘛，这不马上写个~~单室~~租房的……不过换了网站，因为：

- 不想套用代码；
- 房源数量一样；
- 想尝试使用progress；
- 价钱只有一个。

链接：https://sz.zu.anjuke.com/fangyuan/fx1/

```c
library(rvest)
library(progress)
pg <- progress_bar$new(total = 50)

hs <- tibble()

for (i in 1:50) {
  url <- paste("https://sz.zu.anjuke.com/fangyuan/fx1-p", i, sep = "")

  hs_info <- url %>%
    read_html() %>%
    html_nodes("p.details-item.tag") %>%
    html_text() %>%
    str_split("\\|", simplify = TRUE)

  hs_info[, 1] <- str_remove_all(hs_info[, 1], "\\s")
  hs_info[, 2] <- str_remove(hs_info[, 2], "平米") %>%
    as.numeric()
  hs_info_else <- str_split(hs_info[, 3], "\\s", simplify = TRUE)[, 1] %>%
    str_split("层\\ue147", simplify = TRUE)
  hs_info <- hs_info[, 1:2] %>%
    cbind(hs_info_else)

  hs_posi <- url %>%
    read_html() %>%
    html_nodes("address.details-item") %>%
    html_text() %>%
    str_split("\\n", simplify = TRUE)
  hs_posi[, 2] <- str_remove_all(hs_posi[, 2], "\\s")
  hs_posi_else <- str_split(hs_posi[, 3], "\\s", simplify = TRUE)
  hs_posi <- cbind(hs_posi[, 2], hs_posi_else[, 57], hs_posi_else[, 58])

  hs_pric <- url %>%
    read_html() %>%
    html_nodes("div.zu-side") %>%
    html_text() %>%
    str_extract("(\\d{3,})") %>%
    as.numeric()

  house <- cbind(hs_posi, hs_info, hs_pric) %>%
    as_tibble() %>%
    rename(小区名 = V1, 地区 = V2, 道路 = V3, 厅室 = V4, 面积 = V5, 层数 = V6, 联系人 = V7, 月租 = hs_pric)

  hs <- rbind(hs, house)
  pg$tick()
  Sys.sleep(1 / 100)
}

write.csv(hs, "深圳市租房.csv")

```

这网站还设人机识别……加了进度条感觉目标似乎更加明确了呢！这里发现如果要导出`.csv`文件用到的是`write.csv()`，如果是`write.csv2()`那么所有的信息都在一列了，而且都是乱码……

如果在`write.csv()`中使用`fileEncoding = "UTF-8"`那么生成的也是乱码。因为Excel的默认编码方式不是`UTF-8`。但是不管是哪种在R中都没问题！

## 爬取豆瓣图书top250

说实话豆瓣还没人家二手房网站用心，你看看你们自己的数据，再看看人家的？我真是写得恼火气！

```c
library(rvest)
book <- tibble()
for (i in seq(0, 225, 25)) {
  url <- paste("https://book.douban.com/top250?start=", i, sep = "")

  bname <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("div.pl2") %>%
    html_text() %>%
    str_split("\\n", simplify = TRUE)
  bname <- bname[, 5] %>%
    str_remove_all("(\\s)")

  bdetail <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("p.pl") %>%
    html_text() %>%
    str_split("/", simplify = TRUE)
  for (j in 1:25) {
    if(length(bdetail[j,]) ==5){
      if (bdetail[j, 5] != "") {
        bdetail[j, 1] <- str_c(bdetail[j, 1], "(译)", bdetail[j, 2])
        bdetail[j, 2] <- bdetail[j, 3]
        bdetail[j, 3] <- bdetail[j, 4]
        bdetail[j, 4] <- bdetail[j, 5]
      }
    }#else if(length(bdetail[j,]) ==6){# 加一个判断，50时的"你今天真好看"...
    #   bdetail[j,] <- bdetail[j,-3]
    #   if (bdetail[j, 5] != "") {
    #     bdetail[j, 1] <- str_c(bdetail[j, 1], "(译)", bdetail[j, 2])
    #     bdetail[j, 2] <- bdetail[j, 3]
    #     bdetail[j, 3] <- bdetail[j, 4]
    #     bdetail[j, 4] <- bdetail[j, 5]
    # }
    # }
  }
  bdetail <- bdetail[, 1:4]
  for (j in 1:25) {
    if (bdetail[j, 4] != "") {
      bdetail[j, 4] <- bdetail[j, 4] %>%
        str_extract_all("(\\d{1,3}).(\\d{1,2})", simplify = TRUE)
    }
  }

  bgrade <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("span.rating_nums") %>%
    html_text()
  bnumber <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("span.pl") %>%
    html_text() %>%
    str_extract_all("(\\d{4,})", simplify = TRUE)
  if (length(bnumber) >= 25) bnumber <- bnumber[1:25, 1]
  bquote <- read_html(url, encoding = "UTF-8") %>%
    html_nodes("span.inq") %>%
    html_text()
  b <- cbind(bname, bdetail, bgrade, bnumber, bquote) %>%
    as_tibble() %>%
    rename(
      书名 = bname, 作者 = V2, 出版社 = V3, 出版时间 = V4,
      售价 = V5, 豆瓣评分 = bgrade, 评分人数 = bnumber, 引言 = bquote
    )
  book <- rbind(book, b)
}
```

只能运行到前100个，其中还有个张爱玲的书豆瓣连作者都没加上去；还有一书多价的（别找借口）；还有多个出版社的……

掀桌了！

## 网上下载`.txt`文件

```c
require(pacman)
p_load(downloader)

wd <- tibble()

# for(i in 1901:2100){
#   url <- paste("https://data.weather.gov.hk/gts/time/calendar/text/T", i,"e.txt", sep = "")
#   name <- paste("T", i, "e.txt", sep = "")
#   download(url = url, destfile = name)
# }
    
for (i in 2019:2025) {
  url <- paste("https://hoas.xyz/txt/calendar/T", i, "e.txt", sep = "")
  
  wd_en <- fread(url, fill = TRUE, header = FALSE, skip = 2, select = 1:5) %>%
    as_tibble()
  
  wd <- rbind(wd, wd_en)
}

wd <- wd %>%
  rename(solar = V1, lunar = V2, week = V3) %>%
  as_tibble() %>%
  mutate(month = NA)

for (i in seq_along(wd[[1]])) {
  if (str_detect(wd[[2]][i], "[td]")) {
    wd[[3]][i] <- wd[[5]][i]
    wd[[2]][i] <- str_replace(wd[[2]][i], "(.d)|(th)|(st)", "/1")
    wd$month[i] <- as.numeric(str_split(wd[[2]][i], "/", simplify = TRUE)[1])
    wd$lunar[i] <- str_split(wd[[2]][i], "/", simplify = TRUE)[2]
  }
}

wd <- wd %>%
  select(1:3, month) %>%
  mutate(year = 0)

j <- 0
k <- 0
l <- length(wd[[1]])
for (i in seq_along(wd[[1]])) {
  if (!is.na(wd[[4]][i])) {
    j <- i - 1
    if (wd[[4]][i] - 1 < 1) {
      wd[[4]][k:j] <- 12
    } else {
      wd[[4]][k:j] <- wd[[4]][i] - 1
    }
    k <- i + 1
  } else if ((i == l) & (is.na(wd[[4]][i]))) {
    wd[[4]][k:l] <- wd[[4]][k - 1]
  }
}

# 英文最终整理
j <- 0
for (i in seq_along(wd[[1]])) {
  if (wd$month[i] == 1) {
    j <- i
    wd$year[j:length(wd[[1]])] <- as.numeric(str_split(wd$solar, "/", simplify = TRUE)[1])
    break
  }
}
wd$year[1:(j - 1)] <- as.numeric(str_split(wd$solar, "/", simplify = TRUE)[1]) - 1

wd$month <- as.character(wd$month)

# 2-29显示不出来！！！
wd$lunar <- str_c(
  as.character(wd$year),
  "-",
  as.character(wd$month),
  "-",
  wd$lunar
)

wd$solar <- lubridate::ymd(wd$solar)

wd %>%
  dplyr::filter(is.na(wd$solar))
```

