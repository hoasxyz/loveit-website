# Base R Plot


Brief notes about the usage of base R plot.
<!--more-->
# moving-average method


```r
p_load(forecast)
plot(Nile,
  main = "年平均流量系列滑动平均法分析", xlab = "年份", ylab = "滑动平均值(立方米/秒)",
  col = "white"
)
sm_ave_4 <- ma(Nile, order = 4)
sm_ave_7 <- ma(Nile, order = 7)
sm_ave_10 <- ma(Nile, order = 10)
lines(sm_ave_4, col = "darkorange4", lty = 3, lwd = 2)
lines(sm_ave_7, col = "blue", lty = 2, lwd = 3)
lines(sm_ave_10, col = "red", lty = 1, lwd = 4)
legend("topright",
  lty = c(3, 2, 1), c("m=4", "m=7", "m=10"),
  col = c("darkorange4", "blue", "red"),
  lwd = c(2, 3, 4)
)
```

<img src="/posts/2019-04-09-base-r-plot_files/figure-html/unnamed-chunk-1-1.png" width="672" />

# histogram


```r
par(mar = c(2.1, 2.1, 1.5, 0.5))
plot(c(50, 350), c(0, 10),
  type = "n", font.main = 1,
  xlab = "", ylab = "", frame.plot = FALSE, axes = FALSE,
  # xlab = "hp", ylab = "Frequency",
  main = paste("Histogram with Base R", paste(rep(" ", 56), collapse = ""))
)
axis(
  side = 1, at = seq(50, 350, 50), labels = seq(50, 350, 50),
  col = "white", tick = FALSE, las = 1, padj = -1.5
)
axis(
  side = 2, at = seq(0, 10, 2), labels = seq(0, 10, 2),
  # col = "white", 坐标轴的颜色
  # col.ticks 刻度线的颜色
  tick = FALSE, # 取消刻度线
  las = 1, # 水平方向
  hadj = 1, # 右侧对齐
  mgp = c(3, 0.1, 0) # 纵轴边距线设置为 0.1
)
abline(h = seq(0, 10, 2), v = seq(50, 350, 50), col = "gray90", lty = "solid")
abline(h = seq(1, 9, 2), v = seq(75, 325, 50), col = "gray95", lty = "solid")
hist(mtcars$hp,
  col = "#56B4E9", border = "white",
  freq = TRUE, add = TRUE
  # labels = TRUE, axes = TRUE, ylim = c(0, 10.5),
  # xlab = "hp",main = "Histogram with Base R"
)
mtext("hp", 1, line = 1.0)
mtext("Frequency", 2, line = 1.2)
```

<img src="/posts/2019-04-09-base-r-plot_files/figure-html/unnamed-chunk-2-1.png" width="672" />

