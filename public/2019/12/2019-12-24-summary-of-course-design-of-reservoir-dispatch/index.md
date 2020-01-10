# 水电站水库运行与调度课设总结


这应该是最后一次课设了，把一些用R编程需要的总结贴在这里，不要老是再犯错！

<!--more-->

## `read_excel`

在使用这个函数的时候要注意有可能读取的时候为日期格式！即使在Excel中以数字格式显示的，所以每次导入还是检查一下，如果出现日期格式的情况，在`read_excel`函数中加入`col_types = 'numeric'`。

## 表格运算

在[上次课设中介绍的表格运算](https://hoas.xyz/post/summary-of-course-design/)里，

1. 如果中途生成了非向量形式的结构，比如`matrix`或者`data.frame`，那么需要在每次循环最后进行移除；
2. 如果每次循环有生成下次循环的初始变量，那么可以在循环的最后加上`if(i < length(y)) z[i + 1] <- z_next[i]`，最开始最好全部赋值为`NA`，用`if(i == 1) z[i] <- z0`引入初值；
3. 某些公式中一定要注意**单位变换**！比如：

```r
      z_next[i] <- spline(
        x = para_zv$V,
        y = para_zv$Z,
        xout = ifelse(qq[i] > 0, v_max, v[i] + (q[i] - qx[i]) * 30.4 * 24 * 60 * 60 / 100000000)
      )$y # 流量和库容的换算

	 qx2[i] <- n[i] * 1000 / 8.6 / h[i] # 出力公式
```

以上代码中也要记住，使用`spline`插值时，不要忘了加`$y`！

4. 如果存在过程中数据突增或突减的情况，很可能是过程量超过了插值范围！

## 添加进度条

使用`progress`包来解决，很简单，只需要在循环前输入：

```r
pg <- progress_bar$new(format = "[:bar] :current/:total (:percent)", total = length(y))
```

循环内的最后使用：

```r
  pg$tick()
```

即可。详情见：https://github.com/r-lib/progress

## 自定义红字非警告提示信息

```r
message(paste0('i = ', i, ', temp_n = ', temp_n))
```

这种方法非常适合在循环无解但是很难查明原因的情况中使用：

```r
message(paste0('i = ', i, ', temp_n = ', temp_n, ', qx[i] = ', qx[i], ', qx2[i] = ', qx2[i]))
```

`message()`一般是换行的，但是**progress**包没有换行，所以会连在一起。

## 插值

在进行插值时，某些**特定且关键**的参数的插值与反差值不对应。解决的方法有：

1. 使用相同的插值方法；
2. 即使基于第1点，也需要进行插值与反差值查看结果是否完全对应。实在不行可以`near(z[i])`。

## shiny

使用**shiny**时，最好还是在官网上找个样式的模板直接套，如果demo比较简单的话。