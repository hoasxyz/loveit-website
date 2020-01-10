# 四年一本线差分析

某日，我正在办公室玩电脑，突然听见高三年级主任李老师的声音——以及朝我而来的脚步声。我知道李老师又要来开我找不到女朋友的玩笑了，但是久经沙场的我依旧镇静自若地玩电脑，直到李老师走到我面前后如获至宝般地对我说道：“你终于回来了啊！”我……

“……这个东西学校计算机老师不会搞，你能不能搞啊？……哎！不是计算机专业的没关系……”

<img src="https://pic.36krcnd.com/201802/27112556/l57o5cb4lzuzn7e1.jpg!1200">
<!--more-->

# 问题分析

**问题**：有往两年的本校学生理科高考成绩，以及两年对应的理科一本线（我们学校只考虑一本线！——李老师），求在百分之八十的概率下，得到一个弱科的分数尺度，弱多少**还能**上线。

**解读**：例如，对理综，如果语数外都达到一本线，而总成绩也达到了一本线，根据学生高考数据来估计语文科目相差语文一本线的这个分数的尺度指标。

个人认为这个指标的**缺陷**：没有考虑总成绩距总和一本线的分差。

# 解决方式

解决R语言中文代码错误提示问题：https://d.cosx.org/d/419665-rmarkdown/5。（然鹅我并没有解决……）

```r
line15 <- c(113,91,117,195)
line16 <- c(107,108,118,187)
line17 <- c(106,104,113,166)
line18 <- c(107,110,116,186)

# 数据导入以及筛选
grade15 <- read_xls("E:/1R/website/grade15.xls",sheet = 1,range = "A2:I1124",col_names = TRUE) %>%
  select(-(年级:班级),-班名) %>%
  dplyr::filter(总分 >= sum(line15)&
                    !((语文>=line15[1])&(数学>=line15[2])&(英语>=line15[3])&(理综>=line15[4])))
  
grade16 <- read_xls("E:/1R/website/grade16.xls",sheet = 1,range = "C3:H1126",col_names = TRUE) %>%
  dplyr::filter(总分 >= sum(line16)&
                    !((语文>=line16[1])&(数学>=line16[2])&(英语>=line16[3])&(理综>=line16[4])))

grade17 <- read_xls("E:/1R/website/grade17.xls",sheet = 1,range = "B1:G1065",col_names = TRUE) %>%
  dplyr::filter(理综 <= 300) %>%
  dplyr::filter(总分 >= sum(line17)&
                    !((语文>=line17[1])&(数学>=line17[2])&(英语>=line17[3])&(理综>=line17[4])))

grade18 <- read_xls("E:/1R/website/grade18.xls",sheet = 1,range = "C1:J989",col_names = TRUE) %>%
  select(-备注) %>%
  dplyr::filter(总分 >= sum(line18)&
                    !((语文>=line18[1])&(数学>=line18[2])&(英语>=line18[3])&(理综>=line18[4])))

# 各科数据筛选
chinese15 <- grade15 %>%
  dplyr::filter(语文<line15[1]) %>%
  select(语文)
chinese15$语文 <- as.numeric(chinese15$语文)
chinese16 <- grade16 %>%
  dplyr::filter(语文<line16[1]) %>%
  select(语文)
chinese17 <- grade17 %>%
  dplyr::filter(语文<line17[1]) %>%
  select(语文)
chinese18 <- grade18 %>%
  dplyr::filter(语文<line18[1]) %>%
  select(语文)
c <- rbind(chinese15,chinese16,chinese17,chinese18)
sdc <- rbind(-chinese15+line15[1],-chinese16+line16[1],-chinese17+line17[1],-chinese18+line18[1])

math15 <- grade15 %>%
  dplyr::filter(数学<line15[2]) %>%
  select(数学)
math16 <- grade16 %>%
  dplyr::filter(数学<line16[2]) %>%
  select(数学)
math17 <- grade17 %>%
  dplyr::filter(数学<line17[2]) %>%
  select(数学)
math18 <- grade18 %>%
  dplyr::filter(数学<line18[2]) %>%
  select(数学)
m <- rbind(math15,math16,math17,math18)
sdm <- rbind(-math15+line15[2],-math16+line16[2],-math17+line17[2],-math18+line18[2])

english15 <- grade15 %>%
  dplyr::filter(英语<line15[3]) %>%
  select(英语)
english16 <- grade16 %>%
  dplyr::filter(英语<line16[3]) %>%
  select(英语)
english17 <- grade17 %>%
  dplyr::filter(英语<line17[3]) %>%
  select(英语)
english18 <- grade18 %>%
  dplyr::filter(英语<line18[3]) %>%
  select(英语)
e <- rbind(english15,english16,english17,english18)
sde <- rbind(-english15+line15[3],-english16+line16[3],-english17+line17[3],-english18+line18[3])

science15 <- grade15 %>%
  dplyr::filter(理综<line15[4]) %>%
  select(理综)
science16 <- grade16 %>%
  dplyr::filter(理综<line16[4]) %>%
  select(理综)
science17 <- grade17 %>%
  dplyr::filter(理综<line17[4]) %>%
  select(理综)
science18 <- grade18 %>%
  dplyr::filter(理综<line18[4]) %>%
  select(理综)
s <- rbind(science15,science16,science17,science18)
sds <- rbind(-science15+line15[4],-science16+line16[4],-science17+line17[4],-science18+line18[4])

# 分差统计整理、更名
# This rename function is in plyr package!
cc <- sdc  %>%
  count("语文") %>%
  rename(c("语文" = "分差", "freq" = "语文"))
ee <- sde %>%
  count("英语") %>%
  rename(c("英语" = "分差", "freq" = "英语"))
mm <- sdm %>%
  count("数学") %>%
  rename(c("数学" = "分差", "freq" = "数学"))
ss <- sds %>%
  count("理综") %>%
  rename(c("理综" = "分差", "freq" = "理综"))

# 分差数据合并
intg <- cc %>%
full_join(ee,by = "分差") %>%
  full_join(mm,by = "分差") %>%
  full_join(ss,by = "分差") %>%
  arrange(分差)
intg[is.na(intg)] <- 0
intg <- intg %>%
  melt(id = "分差") %>%
  plyr::rename(c("variable" = "科目", "value" = "人数"))

# 数据可视化以及保存
hc <- hchart(intg,"column",hcaes(x = "分差", y = "人数", group = "科目")) %>%
  hc_plotOptions(column= list(dataLabels = list(enabled =TRUE))) %>% 
  hc_title(text = "各科一本线分差分析图") %>%
  hc_yAxis(title = list(text = "人数",align = "middle"),
           tickInterval = 4,tickAmount = 4)
hc
htmlwidgets::saveWidget(hc,file = "oneline4.html", selfcontained = TRUE)
```
然后再运行下面一行就出来啦！！！

```html
<iframe src="https://rawcdn.githack.com/hoasxyz/MarkdownPhotos/980f8ca0b5aae6907a163da4aa558e7024a7db54/HtmlWidget/oneline4.html" width="100%" height="600px"></iframe>
```

<iframe src="https://rawcdn.githack.com/hoasxyz/MarkdownPhotos/980f8ca0b5aae6907a163da4aa558e7024a7db54/HtmlWidget/oneline4.html" width="100%" height="600px"></iframe>

现在应该可以看到了，如果这里实在看不到图我也没办法了，因为我自己不懂JavaScript，只能移步我的[RPubs](http://rpubs.com/Hoas_xyz/)：http://rpubs.com/Hoas_xyz/oneline。

# 数据分析

```r
percent <- 0.8*c(length(c$语文),length(m$数学),length(e$英语),length(s$理综))
> percent
[1] 435.2 280.0 302.4 152.0
```

由图可知，语文指标大概是7分左右，英语大概是19分左右，数学9分左右，理综在11分左右。
(以上是两年的数据分析。)
