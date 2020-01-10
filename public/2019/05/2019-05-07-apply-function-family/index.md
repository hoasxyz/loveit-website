# apply函数族


很多开发者都结合C++和R进行R包的开发，这也是**Rcpp**能够下载量第一的原因了。哎，要么说R是面向用户的呢？开发者去调试C++代码在R中优雅地运行，可见开发真的不是一件易事呀！

之前一直认为for循环并不算慢，现在终于有了觉悟，虽然apply函数族不能完全代替for，可这也是用C++写出来的函数呀！

![apply function family](http://blog.fens.me/wp-content/uploads/2016/04/apply.png)

参考文章见：<http://blog.fens.me/r-apply/>

<!--more-->

# `apply()`

```r
apply(X, MARGIN, FUN, ...)
```

| Arguments | Meaning                                                      |
| --------- | ------------------------------------------------------------ |
| `X`       | an array, including a matrix.                                |
| `MARGIN`  | a vector giving the subscripts which the function will be applied over. E.g., for a matrix `1` indicates rows, `2`indicates columns, `c(1, 2)` indicates rows and columns. Where `X` has named dimnames, it can be a character vector selecting dimension names. |
| `FUN`     | the function to be applied: see ‘Details’. In the case of functions like `+`, `%*%`, etc., the function name must be backquoted or quoted. |
| `...`     | optional arguments to `FUN`.                                 |

``` r
x <- matrix(1:12, ncol = 3)
x
#>      [,1] [,2] [,3]
#> [1,]    1    5    9
#> [2,]    2    6   10
#> [3,]    3    7   11
#> [4,]    4    8   12
apply(x, 1, sum)
#> [1] 15 18 21 24

x <- cbind(x1 = 3, x2 = c(4:1, 2:5))
x
#>      x1 x2
#> [1,]  3  4
#> [2,]  3  3
#> [3,]  3  2
#> [4,]  3  1
#> [5,]  3  2
#> [6,]  3  3
#> [7,]  3  4
#> [8,]  3  5

myFUN <- function(x, c1, c2) {
  c(sum(x[c1], 1), mean(x[c2]))
}

apply(x, 1, myFUN, c1 = "x1", c2 = c("x1", "x2"))
#>      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8]
#> [1,]  4.0    4  4.0    4  4.0    4  4.0    4
#> [2,]  3.5    3  2.5    2  2.5    3  3.5    4

data.frame(x1 = x[, 1] + 1, x2 = rowMeans(x))
#>   x1  x2
#> 1  4 3.5
#> 2  4 3.0
#> 3  4 2.5
#> 4  4 2.0
#> 5  4 2.5
#> 6  4 3.0
#> 7  4 3.5
#> 8  4 4.0
```

<sup>Created on 2019-05-07 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

`apply()`的默认摆放方式和自己理解的稍有不同（按列从上往下摆放，如果原数据换列则结果也换列），不过使用R内置的向量计算操作几乎不耗时间。

# `lappy()`

```r
lapply(X, FUN, ...)
```

``` r
x <- list(a = 1:10, b = rnorm(6, 10, 5), c = c(TRUE, FALSE, FALSE, TRUE))
x
#> $a
#>  [1]  1  2  3  4  5  6  7  8  9 10
#> 
#> $b
#> [1] 10.428540 13.721877 13.196627  7.140429  9.671823  6.126874
#> 
#> $c
#> [1]  TRUE FALSE FALSE  TRUE
lapply(x, fivenum)
#> $a
#> [1]  1.0  3.0  5.5  8.0 10.0
#> 
#> $b
#> [1]  6.126874  7.140429 10.050182 13.196627 13.721877
#> 
#> $c
#> [1] 0.0 0.0 0.5 1.0 1.0

x <- cbind(x1 = 3, x2 = c(2:1, 4:5))
x
#>      x1 x2
#> [1,]  3  2
#> [2,]  3  1
#> [3,]  3  4
#> [4,]  3  5
lapply(x, sum)
#> [[1]]
#> [1] 3
#> 
#> [[2]]
#> [1] 3
#> 
#> [[3]]
#> [1] 3
#> 
#> [[4]]
#> [1] 3
#> 
#> [[5]]
#> [1] 2
#> 
#> [[6]]
#> [1] 1
#> 
#> [[7]]
#> [1] 4
#> 
#> [[8]]
#> [1] 5

lapply(data.frame(x), sum)
#> $x1
#> [1] 12
#> 
#> $x2
#> [1] 12
```

<sup>Created on 2019-05-07 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# `sapply()`

```r
sapply(X, FUN, ..., simplify=TRUE, USE.NAMES = TRUE)
```

`sapply()` 是一个简化版的 `lapply()`，`sapply()` 增加了 2 个参数 simplify 和 `USE.NAMES`，主要就是让输出看起来更友好，返回值为向量，而不是 list 对象。

如果 `simplify=FALSE` 和 `USE.NAMES=FALSE`，那么完全 `sapply()` 就等于 `lapply()` 了。

``` r
x <- cbind(x1 = 3, x2 = c(2:1, 4:5))
x
#>      x1 x2
#> [1,]  3  2
#> [2,]  3  1
#> [3,]  3  4
#> [4,]  3  5

sapply(x, sum)
#> [1] 3 3 3 3 2 1 4 5

sapply(data.frame(x), sum)
#> x1 x2 
#> 12 12

a <- 1:2

sapply(a, function(x) matrix(x, 2, 2), simplify = "array")
#> , , 1
#> 
#>      [,1] [,2]
#> [1,]    1    1
#> [2,]    1    1
#> 
#> , , 2
#> 
#>      [,1] [,2]
#> [1,]    2    2
#> [2,]    2    2

sapply(a, function(x) matrix(x, 2, 2))
#>      [,1] [,2]
#> [1,]    1    2
#> [2,]    1    2
#> [3,]    1    2
#> [4,]    1    2
```

<sup>Created on 2019-05-07 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# Parallel

`*apply`函数族用得多的还数前三个，可是哪个更快些呢？使用新安江模型测试。包含数据导入在内，整个新安江模型一遍需要0.3秒左右，如果去掉洪号的list，可以缩短至0.20秒左右，其中数据的导入只需0.03秒：

```r
> system.time(xaj.model(raw_param))
用户 系统 流逝 
0.29 0.02 0.30 
```

这里使用[PSO算法](https://hoas.xyz/post/particle-swarm-optimization/)优化参数，其中参数矩阵为：

``` r
> par_matrix %>% str
 num [1:100, 1:13] 107.9 30.9 149.4 100.4 58 ...
 - attr(*, "dimnames")=List of 2
  ..$ : NULL
  ..$ : chr [1:13] "WM" "WUM" "WLM" "K" ...
```

## `*pply()`

`sapply()`>`lapply()`>`apply()`：

```r
> system.time(apply(par_matrix, 1, xaj.model))
 用户  系统  流逝 
22.65  2.22 26.99 
> system.time(lapply(par_matrix %>% t %>% data.frame, xaj.model) %>% unlist)
 用户  系统  流逝 
20.33  1.50 24.09 
> system.time(sapply(par_matrix %>% t %>% data.frame, xaj.model, simplify = TRUE))
 用户  系统  流逝 
19.62  1.53 22.02 
```

## `snow::*` or `parallel::*`

`parapply()`>`parLapply()`>`parApply()`：

```r
> # Calculate the number of cores
> no_cores <- detectCores() - 1
> # Initiate cluster
> cl <- makeCluster(no_cores)
> system.time(parApply(cl, par_matrix, 1, xaj.model))
用户 系统 流逝 
0.45 0.30 9.91 
> system.time(parLapply(cl, par_matrix %>% t %>% data.frame, xaj.model))
用户 系统 流逝 
0.45 0.28 8.96 
> system.time(parSapply(cl, par_matrix %>% t %>% data.frame, xaj.model, simplify = TRUE))
用户 系统 流逝 
0.06 0.19 8.11 

> stopCluster(cl)
```

## `snowfall::`

```r
> sfInit(parallel = TRUE, cpus = detectCores() - 1)

> system.time(sfApply(par_matrix, 1, xaj.model))
用户 系统 流逝 
0.00 0.20 8.90 
> system.time(sfLapply(par_matrix %>% t %>% data.frame, xaj.model))
用户 系统 流逝 
0.04 0.13 7.90 
> system.time(sfSapply(par_matrix %>% t %>% data.frame, xaj.model, simplify = TRUE))
用户 系统 流逝 
0.05 0.15 7.74 
> system.time(sfApply(par_matrix, 1, xaj.model))

> sfStop()

Stopping cluster
```

## `future.apply::`

```r
> system.time(future_apply(par_matrix, 1, xaj.model))
 用户  系统  流逝 
18.56  1.38 20.44 
> system.time(future_lapply(par_matrix %>% t %>% data.frame, xaj.model) %>% unlist)
 用户  系统  流逝 
16.34  1.25 17.78 
> system.time(future_sapply(par_matrix %>% t %>% data.frame, xaj.model, simplify = TRUE))
 用户  系统  流逝 
16.93  1.26 18.97 
```

## `foreach()`

对`if()`函数的并行优化，这里只能是对速度的优化，如果迭代有先后顺序那么就很抱歉了……这个思想和该函数族一样，说白了高级语言还就只是高级语言，[具体用法](https://blog.csdn.net/sinat_26917383/article/details/52719232)这里的比较初级。