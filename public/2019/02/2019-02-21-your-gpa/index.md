# 又卡绩了


不知道自己是带着什么样的心情写完了这一篇文章。用数据说话终于用在了我自己身上……

<center>

![sad](https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/72/samsung/78/pensive-face_1f614.png)

</center>

<!--more-->

```r
require(readxl)
g_sum <- read_xlsx("./Excel/hoasgrade.xlsx",1,"A8:J85") %>%
  dplyr::filter(成绩 >= 0)

g <- g_sum %>%
  dplyr::filter(学年==2017|学年==2016|学年==2018)

# g1 <- g_sum%>%
#   dplyr::filter(学年==2017&学期=="下")

'绩点' <- vector("double",0.0)
attach(g)
for (i in seq_along(成绩)) {
  if (成绩[i]>=90) {
    `绩点`[i]=4.0
  } else if (all(85<=成绩[i],成绩[i]<90)) {
    `绩点`[i]=3.7
  } else if (all(82<=成绩[i],成绩[i]<85)) {
    `绩点`[i]=3.3
  } else if (all(78<=成绩[i],成绩[i]<82)) {
    `绩点`[i]=3.0
  } else if (all(75<=成绩[i],成绩[i]<78)) {
    `绩点`[i]=2.7
  } else if (all(72<=成绩[i],成绩[i]<75)) {
    `绩点`[i]=2.3
  } else if (all(68<=成绩[i],成绩[i]<72)) {
    `绩点`[i]=2.0
  } else if (all(64<=成绩[i],成绩[i]<68)) {
    `绩点`[i]=1.5
  } else if (all(60<=成绩[i],成绩[i]<64)) {
    `绩点`[i]=1.0
  } else  `绩点`[i]=0
}
g <- mutate(g,`绩点`)
detach(g)

g %>%
  dplyr::filter(课程类型 %in% c("专业必修","公共必修","专业选修"))%>%
  with({
    b1 <<- sum(学分*成绩)/sum(学分)
    sp1 <<- sum(学分*绩点)/sum(学分) 
  })
  
# 根据不同课程类型分析  
gy <- g %>%
  group_by(课程类型) %>%
  summarise(
    数量 = n(),
    平均成绩 = mean(成绩,na.rm = TRUE)
  )
```

本来后面还有按照公选权绩高低来选择最好的几门公选课计入奖学金评定计算的。对没错，这些代码一开始是为了奖学金评定省事儿的，早知道我有这一天就不写这个代码了。后面的因为R编码问题乱码了，我也不再补充，但我要补充的是，一份对卡绩的研究……

```r
p <- c(89,84,81,77,74,71,67,63,59)

kaj <- g %>%
  dplyr::filter(成绩 %in% p)

# > count(kaj)
# # A tibble: 1 x 1
#       n
#   <int>
# 1    10
```

10次被卡绩了，好开心呢！

可惜生活不是代码，没有`if`让你用……

```r
unkaj <- g %>%
  dplyr::filter(成绩 %in% p) %>%
  dplyr::mutate(成绩=成绩+1) %>%
  select(-绩点)

'绩点' <- vector("double",0.0)
attach(unkaj)
for (i in seq_along(成绩)) {
  if (成绩[i]>=90) {
    `绩点`[i]=4.0
  } else if (all(85<=成绩[i],成绩[i]<90)) {
    `绩点`[i]=3.7
  } else if (all(82<=成绩[i],成绩[i]<85)) {
    `绩点`[i]=3.3
  } else if (all(78<=成绩[i],成绩[i]<82)) {
    `绩点`[i]=3.0
  } else if (all(75<=成绩[i],成绩[i]<78)) {
    `绩点`[i]=2.7
  } else if (all(72<=成绩[i],成绩[i]<75)) {
    `绩点`[i]=2.3
  } else if (all(68<=成绩[i],成绩[i]<72)) {
    `绩点`[i]=2.0
  } else if (all(64<=成绩[i],成绩[i]<68)) {
    `绩点`[i]=1.5
  } else if (all(60<=成绩[i],成绩[i]<64)) {
    `绩点`[i]=1.0
  } else  `绩点`[i]=0
}
unkaj <- mutate(unkaj,`绩点`)
detach(unkaj)

newg <- g %>%
  dplyr::filter(!(成绩 %in% p)) %>%
  rbind(unkaj) %>%
  dplyr::filter(课程类型 %in% c("专业必修","公共必修","专业选修"))%>%
  with({
    b2 <<- sum(学分*成绩)/sum(学分)
    sp2 <<- sum(学分*绩点)/sum(学分) 
  })

# > sp2-sp1
# [1] 0.07180617
```

如果我从来没有被卡绩过，那么我的绩点会提高0.07……

——来点理想中的希望吧！

```r
cre <- g %>%
  dplyr::filter(课程类型 %in% c("专业必修","公共必修","专业选修")) %>%
  group_by(学年) %>%
  summarise(
    课程总数 = n(),
    学分总数 = sum(学分)
  )
  
future <- read_xlsx("./Excel/hoasgrade.xlsx",1,"A8:J85") %>%
  dplyr::filter(is.na(成绩))

sum(future$学分)

# 现已修得的所有学分为125.5分，除去公选课是113.5分
# 大三下所修总学分为15.5，没有选公选

# > (sum(future$学分)*4.0+sum(cre$学分总数)*sp1)/(sum(future$学分)+sum(cre$学分总数)) - sp1
# [1] 0.03694635
```