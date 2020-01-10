# 水文水利计算课设总结


两周多的水文水利计算课设我差不多已经做完了，我要对这10天来的迷茫、喜悦和成果做一个总结。Hadley说他每天写作时间为一个小时至一个半小时左右，我现在已经很赞同这个方式了——当然是基于我有了自己的网站哈哈。

这次课设我编了1500多行代码，还记得佘老师说本科教学阶段就是这个数，那我可以证明我已经达到了。其实也很正常，因为除非万不得已我都没有用Excel。

向Hadley致敬！

![hadley](https://rawcdn.githack.com/hoasxyz/mdphotos/c4d2e1f98761ad97aa876f1537f5c681086d4468/other/Hadley.png)

<!--more-->

# 课设1

## 水文年整理

```r
q <- q %>%
  mutate(y = ifelse(ymd(q$T) >= ymd(paste(year(q$T), "5-1", sep = "-")) &
    ymd(q$T) <= paste(year(q$T) + 1, "4-30", sep = "-"),
  year(q$T),
  ifelse(ymd(q$T) < ymd(paste(year(q$T), "5-1", sep = "-")),
    year(q$T) - 1,
    year(q$T) + 1
  )
  )) %>%
  dplyr::filter(y %in% 1954:2015)

```

这就已经直接整理出来了水文年划分后的年份。

## 最大7、15日洪量

平均和最大一日很简单，但是这个我却是[向别人求助](https://d.cosx.org/d/420569-3)了的，不过用序列的方法更加适用于R：

```r
# 求均值和最值
qetc <- q %>%
  group_by(y) %>%
  summarise(
    ave = mean(Q),
    max1 = max(Q)
  ) %>%
  ungroup()

# 最大7/15日洪量
max7 <- vector("numeric")
index <- vector("numeric")
max7_1 <- vector("numeric")
max15 <- vector("numeric")
for (i in seq_along(qetc$max1)) {
  max7[i] <- max(q$Q[which(q$Q == qetc$max1[i]) +
    (-7 + 1):0 +
    rep(seq_len(7) - 1, each = 7)] %>%
    matrix(ncol = 7) %>%
    apply(1, sum))
  index[i] <- which.max(q$Q[which(q$Q == qetc$max1[i]) +
    (-7 + 1):0 +
    rep(seq_len(7) - 1, each = 7)] %>%
    matrix(ncol = 7) %>%
    apply(1, sum))
  max7_1[i] <- (q$Q[which(q$Q == qetc$max1[i]) +
    (-7 + 1):0 +
    rep(seq_len(7) - 1, each = 7)] %>%
    matrix(ncol = 7))[index[i], 1]
  max15[i] <- max(q$Q[which(q$Q == max7_1[i]) +
    (-15 + 6 + 1):6 +
    rep(seq_len(15) - 1, each = 15)] %>%
    matrix(ncol = 15) %>%
    apply(1, sum))
}

qetc <- qetc %>%
  mutate(
    max7 = max7 * 86400 / 100000000,
    max15 = max15 * 86400 / 100000000
  )
```

## 滑动平均值法

见https://hoas.xyz/post/base-r-plot/#moving-average-method

# 课设2

## spline in ggplot2

[受教](https://d.cosx.org/d/420602-ggplot2-spline-excel/4)了！

```r
myspline = function(formula, data, ...)
{
  dat = model.frame(formula, data)
  res = splinefun(dat[[2]], dat[[1]])
  class(res) = "myspline"
  res
}

predict.myspline = function(object, newdata, ...)
{
  object(newdata[[1]])
}


library(ggplot2)
set.seed(123)
dat = data.frame(xx = runif(100, -5, 5))
dat$yy = sin(dat$xx)

ggplot(dat, aes(x = xx, y = yy)) +
  geom_point() +
  geom_smooth(method = myspline, se = FALSE)
```

## spline插值预测

这次课设主要用的是spline插值拟合法。

```r
# 预测
spline(x = z_q$q,y = z_q$z, xout = 500)$y
# spline(x = z_q$z,y = z_q$q, xout = 90.50468)

spline(x = z_vaq$v,y = z_vaq$z,xout = v0)$y

# 插值
ipl <- tibble(
  n = seq(1, 361, 1),
  dx = spline(dfplines$n, dfplines$dx, n = 361, xmin = min(dfplines$n), xmax = max(dfplines$n))[[2]],
  xy = spline(dfplines$n, dfplines$xy, n = 361, xmin = min(dfplines$n), xmax = max(dfplines$n))[[2]],
  sj = spline(dfplines$n, dfplines$sj, n = 361, xmin = min(dfplines$n), xmax = max(dfplines$n))[[2]],
  jh = spline(dfplines$n, dfplines$jh, n = 361, xmin = min(dfplines$n), xmax = max(dfplines$n))[[2]]
)
ipl_plot <- ipl %>% gather(type, q, 2:5)
```

不过也可以用别的，比如loess，这个东西好像只有R有……

```r
# 预测值
predict(loess(z ~ v, z_vaq), 8.07)
predict(loess(z ~ q, z_q), mean(qetc$ave))
predict(loess(v ~ z, z_vaq), 140.516)
predict(loess(z ~ v, z_vaq), 137.3906)
predict(loess(z ~ v, z_vaq), 128.7758)
```

## 改名方式

```r
names(dfplines) <- c("t", "xy", "sj", "jh", "dx")
```

另外`janitor::clean_names()`可以用来整理变量名，适合英文的。

## 表格运算

这个是让我感觉非常舒服的一点，表格形式的运算程序，~~本人命名~~简称**表格运算**。

```r
ipl_xy <- ipl %>%
  select(n, xy) %>%
  rename(q_in = xy) %>%
  mutate(
    q_in_ave = 0, q_out = 0, q_out_ave = 0,
    delta_v = 0, v = 128.638, z = 150.2847
  ) %>%
  within({
    for (i in seq_along(n)) {
      if (i < length(n)) q_in_ave[i + 1] <- mean(c(q_in[i], q_in[i + 1]))
      q_out[i] <- ifelse(q_in[i] >= 15000, 15000, q_in[i])
      if (i > 1) {
        q_out_ave[i] <- mean(c(q_out[i], q_out[i - 1]))
        delta_v[i] <- (q_in_ave[i] - q_out_ave[i]) * 3600 / 10^8
        v[i] <- v[i - 1] + delta_v[i]
        # z[i] <- predict(loess(z ~ v, z_vaq), v[i])
        z[i] <- spline(z_vaq[[2]], z_vaq[[1]], xout = v[i])$y
      }
    }
  }) %>%
  select(-i)
```

以上是一个典型的结构，从主数据里筛选、重命名、添加空变量，然后打开数据框进行编程计算，最后移走循环的小尾巴~

## clipboard

剪贴板操作也很有用：

```r
temp <- clipr::read_clip() %>% as.numeric() # R只能读取最直观的数据
clipr::clear_clip()
# (predict(loess(z ~ v, z_vaq), temp) - error) %>% clipr::write_clip()
spline(x = z_q$q,y = z_q$z, xout = temp)$y %>% clipr::write_clip()
spline(x = z_vaq$v,y = z_vaq$z,xout =  temp)$y %>% clipr::write_clip()
```

## basicTrendline

可以直接用这个函数进行特定形式公式的拟合，精度相当高！而且拟合好后直接放入方程计算也很方便！

```r
trendline(z_q$q, z_q$z,
  model = "power3P", linecolor = "blue2",
  show.equation = TRUE, show.Rpvalue = TRUE,
  xlab = expression(流量(m^3 / s)), ylab = "水位(m)", lwd = 3, lty = 3
)
z_q_fit <- trendline_summary(z_q$q, z_q$z, model = "power3P")
z_q_fit_y <- function(x) z_q_fit$parameter$a * x^z_q_fit$parameter$b + z_q_fit$parameter$c
```

## 等出力调节

原来觉得还挺简单的（不要问了当然是使用R的原因），但是我又犯傻了……逆向推水量平衡公式也要变呀！！

## `.xlsx`导出

**openxlsx**包的导出还可以，如果把数据框都放在一个`list`中那么它还会给你分sheet。但是`utils::write.csv()`就不一样了，是全部塞在一个sheet中，我现在才知道为什么，因为`.csv`哪儿来的sheet……

## ggplot2

### legend锚点

```r
  theme(
    plot.subtitle = element_text(vjust = 1),
    plot.caption = element_text(vjust = 1),
    plot.title = element_text(hjust = 0.5), legend.title = element_blank(),
    legend.justification = c(1, 1), legend.position = c(0.99, 0.99)
  )
```

最后一句的意思是将**图例**的右上角放在**图像**的右上角（0.9,0.9）处！

另外不想要图例标题以上代码已关。

### 点线

一般来说图上的线可以用1.2个大小，辅助线可以用1个大小。点可以用2~3个大小。

### qplot

现在才知道有些时候快速出图的确有用：

```r
qplot(z, q, data = z_vaq, geom = c("smooth", "point"))
```

### 零点对齐

顺便也把轴坐标的限制也加上了，另外还可以直接用`x/ylim()`来实现。

```r
  scale_x_continuous(expand = c(0, 0))+
  scale_y_continuous(expand = c(0, 0),limits = c(0,2600)) + 
```

### 终极绘图

高能预警，包含多种NB的函数：

```r
n_10k <- readxl::read_xlsx("ks2.xlsx", sheet = "data", range = "D18:N32") %>%
  gather(year, z, 2:11)

ggplot(n_10k, aes(x = m, y = z, color = year, linetype = year)) +
  theme_bw() +
  geom_point() +
  geom_line(size = 1.1) +
  scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10,11,12),
                     labels=c("5","6","7","8","9","10",
                              "11","12","1","2","3","4"),
                     expand = c(0,0)) + 
  ylim(140,160.5) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "年调节水电站基本调度线", y = "Z/m", x = "t/月", colour = "枯水年组", 
    linetype = "枯水年组", shape = "枯水年组") +
  geom_hline(yintercept = z_death, color = "#CCCC00", size = 1) +
  geom_segment(aes(x = 0.5, y = z_xx, xend = 3.5, yend = z_xx), color = "#666600", size = 1) +
  # geom_hline(yintercept = z_xx, color = "#666600", size = 1) +
  geom_hline(yintercept = z_normal, color = "#CCCCFF", size = 1) +
  geom_hline(yintercept = z_g, color = "#CC9933", size = 1) +
  geom_hline(yintercept = z_sj, color = "#009999", size = 1) +
  geom_hline(yintercept = z_jh, color = "#FFCC33", size = 1) +
  geom_segment(aes(x = 3.5, y = z_xx, xend = 5.5, yend = z_g),color = "#666600",size = 1) +
  annotate("text",
           x = c(8, 2.5, 2.5,4.5, 6, 4.5),
           y = c(141.4, 151, 152.6, 158.2, 158.7, 160.2),
           label = c(expression(paste(nabla,Z[死])),
                     expression(paste(nabla,Z[汛])),
                     expression(paste(nabla,Z[正])),
                     expression(paste(nabla,Z[高])),
                     expression(paste(nabla,Z[设])),
                     expression(paste(nabla,Z[校]))),
           color = c("#CCCC00", "#666600", "#CCCCFF", "#CC9933", "#009999", "#FFCC33")) +
  annotate("text",
           x = c(1.25, 2, 2, 2),
           y = c(149, 155, 158.7, 160.2),
           label = c("兴利区","正常防洪区","加大泄洪区","非常泄洪区"))

n_10k_mod <- readxl::read_xlsx("ks2.xlsx", sheet = "data", range = "D39:G66")

n_10k_mod %>% select(1:3) %>%
  gather(type, z, 2:3) %>%
ggplot(aes(x = m, y = z, color = type, shape = type, linetype = type)) + 
  theme_bw() +
  geom_point(size = 2)+
  geom_line(size = 1.1) +
  scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10,11,12),
                     labels=c("5","6","7","8","9","10",
                              "11","12","1","2","3","4"),
                     expand = c(0,0)) + 
  ylim(140,160.5) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "年调节水电站水库调度图", y = "Z/m", x = "t/月", colour = "调度线", 
       linetype = "调度线", shape = "调度线") +
  geom_hline(yintercept = z_death, color = "#CCCC00", size = 1) +
  geom_segment(aes(x = 0.5, y = z_xx, xend = 3.5, yend = z_xx), color = "#666600", size = 1) +
  # geom_hline(yintercept = z_xx, color = "#666600", size = 1) +
  geom_hline(yintercept = z_normal, color = "#CCCCFF", size = 1) +
  geom_hline(yintercept = z_g, color = "#CC9933", size = 1) +
  geom_hline(yintercept = z_sj, color = "#009999", size = 1) +
  geom_hline(yintercept = z_jh, color = "#FFCC33", size = 1) +
  geom_segment(aes(x = 3.5, y = z_xx, xend = 5.5, yend = z_g),color = "#666600",size = 1) +
  annotate("text",
           x = c(8, 2.5, 2.5,4.5, 6, 4.5),
           y = c(141.4, 151, 152.6, 158.2, 158.7, 160.2),
           label = c(expression(paste(nabla,Z[死])),
                     expression(paste(nabla,Z[汛])),
                     expression(paste(nabla,Z[正])),
                     expression(paste(nabla,Z[高])),
                     expression(paste(nabla,Z[设])),
                     expression(paste(nabla,Z[校]))),
           color = c("#CCCC00", "#666600", "#CCCCFF", "#CC9933", "#009999", "#FFCC33")) +
  annotate("text",
           x = c(6.5, 6.5, 11.5, 1.25, 2, 2, 2),
           y = c(142.5, 148.5, 150, 149, 155, 158.7, 160.2),
           label = c("降低出力区","保证出力区", "加大出力区",
                     "兴利区","正常防洪区","加大泄洪区","非常泄洪区"))

n_10k_mod %>%
  gather(type, z, 2:4) %>%
ggplot(aes(x = m, y = z, color = type, shape = type, linetype = type)) + 
  theme_bw() +
  geom_point(size = 2)+
  geom_line(size = 1.1) +
  scale_x_continuous(breaks=c(1,2,3,4,5,6,7,8,9,10,11,12),
                     labels=c("5","6","7","8","9","10",
                              "11","12","1","2","3","4"),
                     expand = c(0,0)) + 
  ylim(140,160.5) +
  theme(plot.title = element_text(hjust = 0.5)) +
  labs(title = "年调节水电站水库调度图", y = "Z/m", x = "t/月", colour = "调度线", 
       linetype = "调度线", shape = "调度线") +
  geom_hline(yintercept = z_death, color = "#CCCC00", size = 1) +
  geom_segment(aes(x = 0.5, y = z_xx, xend = 3.5, yend = z_xx), color = "#666600", size = 1) +
  # geom_hline(yintercept = z_xx, color = "#666600", size = 1) +
  geom_hline(yintercept = z_normal, color = "#CCCCFF", size = 1) +
  geom_hline(yintercept = z_g, color = "#CC9933", size = 1) +
  geom_hline(yintercept = z_sj, color = "#009999", size = 1) +
  geom_hline(yintercept = z_jh, color = "#FFCC33", size = 1) +
  geom_segment(aes(x = 3.5, y = z_xx, xend = 5.5, yend = z_g),color = "#666600",size = 1) +
  annotate("text",
           x = c(8, 2.5, 2.5,4.5, 6, 4.5),
           y = c(141.4, 151, 152.6, 158.2, 158.7, 160.2),
           label = c(expression(paste(nabla,Z[死])),
                     expression(paste(nabla,Z[汛])),
                     expression(paste(nabla,Z[正])),
                     expression(paste(nabla,Z[高])),
                     expression(paste(nabla,Z[设])),
                     expression(paste(nabla,Z[校]))),
           color = c("#CCCC00", "#666600", "#CCCCFF", "#CC9933", "#009999", "#FFCC33")) +
  annotate("text",
           x = c(6.5, 6.5, 11.5, 1.25, 2, 2, 2),
           y = c(142.5, 148.5, 150, 149, 155, 158.7, 160.2),
           label = c("降低出力区","保证出力区", "加大出力区",
                     "兴利区","正常防洪区","加大泄洪区","非常泄洪区"))
```

我现在真的可以说，Excel绘图确实比不过**ggplot2**了。

# 答辩

刚刚答辩回来，更新……

1. 又是在一些小细节上扣了分，水轮机适应最小水头为49m，就是在水头低于49m的时候等流量调节和等出力调节（~~这里还好我没有附表老师没扣分……~~）不能用，这一点和接下来的抽水蓄能水电站出力范围一样，别再搞错了！

2. 成果报告书的结论部分，你要把属于成果或者是指标类型的东西明明白白地展示出来！

  - 意义较大的指标，比如衡量一个库容大小的**总库容**指标；
  - 这些指标宜多不宜少，比如你确定了装机台数，那么总装机虽然也确定下来了，但是谁TM知道一台机多少出力？就算之前写过，写在这不也更好吗？另外在你知道最大工作容量、重复容量和备用容量都是用来决定总装机的情况下，为什么还要把这些**半成品**放到结论里来？

以上的结果就是扣了5分，我不知道是不是总分扣去5分，从某种程度上来讲还有5分裕度。张同学在排版上没我做得好，但是好像扣分比我少，这等等都是属于老师侧重的问题。下次记住这些东西了，虽然这次不怎么失风范，可是下次再犯这种细节错误，裕度可能就不止5分这么简单了。