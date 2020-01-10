# dplyr for single table


数据处理就它了！

> **dplyr** is a grammar of data manipulation, providing a consistent set of verbs that help you solve the most common data manipulation challenges:
>
> - `mutate()` adds new variables that are functions of existing variables
> - `select()` picks variables based on their names.
> - `filter()` picks cases based on their values.
> - `summarise()` reduces multiple values down to a single summary.
> - `arrange()` changes the ordering of the rows.

以上为五个核心函数，不过若只停留在核心怎么能体会到边界的美妙？

<center>

![dplyr](https://github.com/tidyverse/dplyr/raw/master/man/figures/logo.png)

</center>

<!--more-->

# `filter()`

里面可以塞很多比较运算符：

- `==`, `>`, `>=` etc
- `&`, `|`, `!`, `xor()`
- `is.na()`
- `beteen()`, `near()`

## Variation

```r
filter_all(.tbl, .vars_predicate, .preserve = FALSE)

filter_if(.tbl, .predicate, .vars_predicate, .preserve = FALSE)

filter_at(.tbl, .vars, .vars_predicate, .preserve = FALSE)
```

`filter()`是**行筛选**，所以这里的`all` / `if` / `at`对应的是 所有的/需要判断的/定义位置的 行。

```r
library(pacman)
p_load(dplyr)

filter_all(mtcars, all_vars(. > 150))
#>  [1] mpg  cyl  disp hp   drat wt   qsec vs   am   gear carb
#> <0 行> (或0-长度的row.names)

filter_all(mtcars, any_vars(. > 150))
#>     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1  21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> 2  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> 3  21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> 4  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> 5  18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> 6  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> 7  19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
#> 8  17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
#> 9  16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> 10 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 11 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> 12 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> 13 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> 14 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 15 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> 16 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 17 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> 18 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> 19 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> 20 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> 21 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

沿用上述思想，是否整行的变量都大于150？是否存在大于150的变量？若是，返回该变量所在的行。

```r
filter_at(mtcars, vars(starts_with("d")), any_vars((. %% 2) == 0))
#>     mpg cyl disp  hp drat    wt  qsec vs am gear carb
#> 1  21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
#> 2  21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
#> 3  22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
#> 4  21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
#> 5  18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
#> 6  14.3   8  360 245 3.21 3.570 15.84  0  0    3    4
#> 7  10.4   8  472 205 2.93 5.250 17.98  0  0    3    4
#> 8  10.4   8  460 215 3.00 5.424 17.82  0  0    3    4
#> 9  14.7   8  440 230 3.23 5.345 17.42  0  0    3    4
#> 10 15.5   8  318 150 2.76 3.520 16.87  0  0    3    2
#> 11 15.2   8  304 150 3.15 3.435 17.30  0  0    3    2
#> 12 13.3   8  350 245 3.73 3.840 15.41  0  0    3    4
#> 13 19.2   8  400 175 3.08 3.845 17.05  0  0    3    2
filter_at(mtcars, vars(starts_with("d")), all_vars((. %% 2) == 0))
#>  [1] mpg  cyl  disp hp   drat wt   qsec vs   am   gear carb
#> <0 行> (或0-长度的row.names)
filter_at(mtcars, vars(starts_with("dr")), any_vars((. %% 2) == 0))
#>  [1] mpg  cyl  disp hp   drat wt   qsec vs   am   gear carb
#> <0 行> (或0-长度的row.names)

filter_at(mtcars, vars(hp, vs), ~ . %% 2 == 0)
#>    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> 2 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> 3 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> 4 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 5 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> 6 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 7 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> 8 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 9 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
filter_at(mtcars, vars(hp, vs), all_vars(. %% 2 == 0))
#>    mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> 2 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> 3 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> 4 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 5 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> 6 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 7 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> 8 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 9 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
filter_at(mtcars, vars(hp, vs), any_vars(. %% 2 == 0))
#>     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1  21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> 2  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> 3  21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> 4  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> 5  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> 6  24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> 7  16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> 8  17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 9  15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> 10 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> 11 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> 12 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 13 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> 14 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> 15 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> 16 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 17 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> 18 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> 19 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> 20 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> 21 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> 22 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> 23 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

注意`start_with()`返回所有满足条件的**列**。对，这里转列的条件了，而且是多列筛选，因为这里不止一列满足限定条件，`_at`指的是列。使用`any_`对`*_vars()`里面的代词（列变量）进行筛选并返回整行，因此也解释了`all_vars()`返回空行的原因。

对多行都需要满足同一条件的筛选来讲，有一个简便写法，就是使用`~`（这里应该不被视为formula）。

# `arrange()`

该函数用来改变行的顺序。可以有多个想要排序的参数，按照优先级从左往右写，用逗号分开。另外也可以降序。另外`NA`会被排在最后。

```r
arrange(mtcars, cyl, disp)
#>     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1  33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
#> 2  30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> 3  32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> 4  27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> 5  30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
#> 6  22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> 7  21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> 8  26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> 9  21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
#> 10 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> 11 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> 12 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> 13 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> 14 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> 15 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
#> 16 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
#> 17 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> 18 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> 19 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> 20 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 21 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> 22 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
#> 23 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 24 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> 25 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> 26 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> 27 18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> 28 14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> 29 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> 30 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 31 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> 32 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4

arrange(mtcars, desc(disp))
#>     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> 2  10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> 3  14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 4  19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> 5  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> 6  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> 7  15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> 8  13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> 9  15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> 10 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 11 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
#> 12 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> 13 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 14 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> 15 21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
#> 16 18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> 17 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
#> 18 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
#> 19 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
#> 20 21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
#> 21 24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> 22 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> 23 22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> 24 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
#> 25 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> 26 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> 27 22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
#> 28 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
#> 29 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> 30 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> 31 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> 32 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

对于分组来讲，直接排序是没用的，需要在`arrange()`中指定`.by_group = TRUE`。

```r
library(pacman)
p_load(dplyr)

by_cyl <- mtcars %>% group_by(cyl)
by_cyl %>% arrange(desc(wt))
#> # A tibble: 32 x 11
#> # Groups:   cyl [3]
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1  10.4     8  460    215  3     5.42  17.8     0     0     3     4
#>  2  14.7     8  440    230  3.23  5.34  17.4     0     0     3     4
#>  3  10.4     8  472    205  2.93  5.25  18.0     0     0     3     4
#>  4  16.4     8  276.   180  3.07  4.07  17.4     0     0     3     3
#>  5  19.2     8  400    175  3.08  3.84  17.0     0     0     3     2
#>  6  13.3     8  350    245  3.73  3.84  15.4     0     0     3     4
#>  7  15.2     8  276.   180  3.07  3.78  18       0     0     3     3
#>  8  17.3     8  276.   180  3.07  3.73  17.6     0     0     3     3
#>  9  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4
#> 10  15       8  301    335  3.54  3.57  14.6     0     1     5     8
#> # ... with 22 more rows

by_cyl %>% arrange(desc(wt), .by_group = TRUE)
#> # A tibble: 32 x 11
#> # Groups:   cyl [3]
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
#>  1  24.4     4 147.     62  3.69  3.19  20       1     0     4     2
#>  2  22.8     4 141.     95  3.92  3.15  22.9     1     0     4     2
#>  3  21.4     4 121     109  4.11  2.78  18.6     1     1     4     2
#>  4  21.5     4 120.     97  3.7   2.46  20.0     1     0     3     1
#>  5  22.8     4 108      93  3.85  2.32  18.6     1     1     4     1
#>  6  32.4     4  78.7    66  4.08  2.2   19.5     1     1     4     1
#>  7  26       4 120.     91  4.43  2.14  16.7     0     1     5     2
#>  8  27.3     4  79      66  4.08  1.94  18.9     1     1     4     1
#>  9  33.9     4  71.1    65  4.22  1.84  19.9     1     1     4     1
#> 10  30.4     4  75.7    52  4.93  1.62  18.5     1     1     4     2
#> # ... with 22 more rows
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# `select()`/`rename()`

**列**选择。这个函数也有一些辅助函数，它们都是**tidyselect**中的一部分：

These functions allow you to select variables based on their names.

- `starts_with()`: Starts with a prefix.

- `ends_with()`: Ends with a suffix.

- `contains()`: Contains a literal string.

- `matches()`: Matches a regular expression.

- `num_range()`: Matches a numerical range like x01, x02, x03.

- `one_of()`: Matches variable names in a character vector.

- `everything()`: Matches all variables.

- `last_col()`: Select last variable, possibly with an offset.

`select()`和`arrange()`一样也可以包含多个列名类参数，负号表示不选择，不过表示的是**重复选择**。重复选择可以改变列的顺序。

```r
iris <- as_tibble(iris)
select(iris, Species, everything())
#> # A tibble: 150 x 5
#>    Species Sepal.Length Sepal.Width Petal.Length Petal.Width
#>    <fct>          <dbl>       <dbl>        <dbl>       <dbl>
#>  1 setosa           5.1         3.5          1.4         0.2
#>  2 setosa           4.9         3            1.4         0.2
#>  3 setosa           4.7         3.2          1.3         0.2
#>  4 setosa           4.6         3.1          1.5         0.2
#>  5 setosa           5           3.6          1.4         0.2
#>  6 setosa           5.4         3.9          1.7         0.4
#>  7 setosa           4.6         3.4          1.4         0.3
#>  8 setosa           5           3.4          1.5         0.2
#>  9 setosa           4.4         2.9          1.4         0.2
#> 10 setosa           4.9         3.1          1.5         0.1
#> # ... with 140 more rows

select(iris, -Sepal.Length, Sepal.Length)
#> # A tibble: 150 x 5
#>    Sepal.Width Petal.Length Petal.Width Species Sepal.Length
#>          <dbl>        <dbl>       <dbl> <fct>          <dbl>
#>  1         3.5          1.4         0.2 setosa           5.1
#>  2         3            1.4         0.2 setosa           4.9
#>  3         3.2          1.3         0.2 setosa           4.7
#>  4         3.1          1.5         0.2 setosa           4.6
#>  5         3.6          1.4         0.2 setosa           5  
#>  6         3.9          1.7         0.4 setosa           5.4
#>  7         3.4          1.4         0.3 setosa           4.6
#>  8         3.4          1.5         0.2 setosa           5  
#>  9         2.9          1.4         0.2 setosa           4.4
#> 10         3.1          1.5         0.1 setosa           4.9
#> # ... with 140 more rows
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## `num_range()`

注意这个有意思的顺序，默认选择是按照列从左到右的顺序来的。

```r
df <- as.data.frame(matrix(runif(100), nrow = 10))
df <- tbl_df(df[c(3, 4, 7, 1, 9, 8, 5, 2, 6, 10)])
select(df, V4:V6)
#> # A tibble: 10 x 8
#>        V4     V7     V1      V9     V8     V5     V2    V6
#>     <dbl>  <dbl>  <dbl>   <dbl>  <dbl>  <dbl>  <dbl> <dbl>
#>  1 0.648  0.880  0.880  0.00695 0.267  0.799  0.977  0.185
#>  2 0.0648 0.375  0.253  0.390   0.608  0.132  0.110  0.562
#>  3 0.337  0.434  0.906  0.239   0.772  0.548  0.999  0.731
#>  4 0.570  0.807  0.0534 0.384   0.520  0.0970 0.0962 0.661
#>  5 0.338  0.636  0.519  0.0731  0.860  0.986  0.0623 0.732
#>  6 0.499  0.0687 0.924  0.767   0.793  0.840  0.807  0.631
#>  7 0.308  0.145  0.249  0.688   0.784  0.400  0.810  0.352
#>  8 0.840  0.295  0.537  0.842   0.424  0.952  0.812  0.464
#>  9 0.0652 0.0414 0.654  0.105   0.0155 0.0595 0.202  0.891
#> 10 0.440  0.117  0.131  0.340   0.416  0.277  0.627  0.537
select(df, num_range("V", 4:6))
#> # A tibble: 10 x 3
#>        V4     V5    V6
#>     <dbl>  <dbl> <dbl>
#>  1 0.648  0.799  0.185
#>  2 0.0648 0.132  0.562
#>  3 0.337  0.548  0.731
#>  4 0.570  0.0970 0.661
#>  5 0.338  0.986  0.732
#>  6 0.499  0.840  0.631
#>  7 0.308  0.400  0.352
#>  8 0.840  0.952  0.464
#>  9 0.0652 0.0595 0.891
#> 10 0.440  0.277  0.537
```

## `group_cols()`

分组的处理。使用`select()`时只会选出用来分组的列。`mutate_at()`的重写也就没什么疑问了。

```r
starwars %>% group_by(gender) %>% select(group_cols())
#> # A tibble: 87 x 1
#> # Groups:   gender [5]
#>    gender
#>    <chr> 
#>  1 male  
#>  2 <NA>  
#>  3 <NA>  
#>  4 male  
#>  5 female
#>  6 male  
#>  7 female
#>  8 <NA>  
#>  9 male  
#> 10 male  
#> # ... with 77 more rows

gdf <- iris %>% group_by(Species)
gdf
#> # A tibble: 150 x 5
#> # Groups:   Species [3]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
#>  1          5.1         3.5          1.4         0.2 setosa 
#>  2          4.9         3            1.4         0.2 setosa 
#>  3          4.7         3.2          1.3         0.2 setosa 
#>  4          4.6         3.1          1.5         0.2 setosa 
#>  5          5           3.6          1.4         0.2 setosa 
#>  6          5.4         3.9          1.7         0.4 setosa 
#>  7          4.6         3.4          1.4         0.3 setosa 
#>  8          5           3.4          1.5         0.2 setosa 
#>  9          4.4         2.9          1.4         0.2 setosa 
#> 10          4.9         3.1          1.5         0.1 setosa 
#> # ... with 140 more rows
gdf %>% mutate_at(vars(-group_cols()), `/`, 100)
#> # A tibble: 150 x 5
#> # Groups:   Species [3]
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
#>  1        0.051      0.035        0.0140       0.002 setosa 
#>  2        0.049      0.03         0.0140       0.002 setosa 
#>  3        0.047      0.032        0.013        0.002 setosa 
#>  4        0.046      0.031        0.015        0.002 setosa 
#>  5        0.05       0.036        0.0140       0.002 setosa 
#>  6        0.054      0.039        0.017        0.004 setosa 
#>  7        0.046      0.034        0.0140       0.003 setosa 
#>  8        0.05       0.034        0.015        0.002 setosa 
#>  9        0.044      0.0290       0.0140       0.002 setosa 
#> 10        0.049      0.031        0.015        0.001 setosa 
#> # ... with 140 more rows
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## `.data$*`

这不是多此一举吗？:joy:

```r
select(mtcars, .data$disp)
#>                      disp
#> Mazda RX4           160.0
#> Mazda RX4 Wag       160.0
#> Datsun 710          108.0
#> Hornet 4 Drive      258.0
#> Hornet Sportabout   360.0
#> Valiant             225.0
#> Duster 360          360.0
#> Merc 240D           146.7
#> Merc 230            140.8
#> Merc 280            167.6
#> Merc 280C           167.6
#> Merc 450SE          275.8
#> Merc 450SL          275.8
#> Merc 450SLC         275.8
#> Cadillac Fleetwood  472.0
#> Lincoln Continental 460.0
#> Chrysler Imperial   440.0
#> Fiat 128             78.7
#> Honda Civic          75.7
#> Toyota Corolla       71.1
#> Toyota Corona       120.1
#> Dodge Challenger    318.0
#> AMC Javelin         304.0
#> Camaro Z28          350.0
#> Pontiac Firebird    400.0
#> Fiat X1-9            79.0
#> Porsche 914-2       120.3
#> Lotus Europa         95.1
#> Ford Pantera L      351.0
#> Ferrari Dino        145.0
#> Maserati Bora       301.0
#> Volvo 142E          121.0
select(mtcars, disp)
#>                      disp
#> Mazda RX4           160.0
#> Mazda RX4 Wag       160.0
#> Datsun 710          108.0
#> Hornet 4 Drive      258.0
#> Hornet Sportabout   360.0
#> Valiant             225.0
#> Duster 360          360.0
#> Merc 240D           146.7
#> Merc 230            140.8
#> Merc 280            167.6
#> Merc 280C           167.6
#> Merc 450SE          275.8
#> Merc 450SL          275.8
#> Merc 450SLC         275.8
#> Cadillac Fleetwood  472.0
#> Lincoln Continental 460.0
#> Chrysler Imperial   440.0
#> Fiat 128             78.7
#> Honda Civic          75.7
#> Toyota Corolla       71.1
#> Toyota Corona       120.1
#> Dodge Challenger    318.0
#> AMC Javelin         304.0
#> Camaro Z28          350.0
#> Pontiac Firebird    400.0
#> Fiat X1-9            79.0
#> Porsche 914-2       120.3
#> Lotus Europa         95.1
#> Ford Pantera L      351.0
#> Ferrari Dino        145.0
#> Maserati Bora       301.0
#> Volvo 142E          121.0

select(mtcars, .data$mpg : .data$disp)
#>                      mpg cyl  disp
#> Mazda RX4           21.0   6 160.0
#> Mazda RX4 Wag       21.0   6 160.0
#> Datsun 710          22.8   4 108.0
#> Hornet 4 Drive      21.4   6 258.0
#> Hornet Sportabout   18.7   8 360.0
#> Valiant             18.1   6 225.0
#> Duster 360          14.3   8 360.0
#> Merc 240D           24.4   4 146.7
#> Merc 230            22.8   4 140.8
#> Merc 280            19.2   6 167.6
#> Merc 280C           17.8   6 167.6
#> Merc 450SE          16.4   8 275.8
#> Merc 450SL          17.3   8 275.8
#> Merc 450SLC         15.2   8 275.8
#> Cadillac Fleetwood  10.4   8 472.0
#> Lincoln Continental 10.4   8 460.0
#> Chrysler Imperial   14.7   8 440.0
#> Fiat 128            32.4   4  78.7
#> Honda Civic         30.4   4  75.7
#> Toyota Corolla      33.9   4  71.1
#> Toyota Corona       21.5   4 120.1
#> Dodge Challenger    15.5   8 318.0
#> AMC Javelin         15.2   8 304.0
#> Camaro Z28          13.3   8 350.0
#> Pontiac Firebird    19.2   8 400.0
#> Fiat X1-9           27.3   4  79.0
#> Porsche 914-2       26.0   4 120.3
#> Lotus Europa        30.4   4  95.1
#> Ford Pantera L      15.8   8 351.0
#> Ferrari Dino        19.7   6 145.0
#> Maserati Bora       15.0   8 301.0
#> Volvo 142E          21.4   4 121.0
select(mtcars, mpg : disp)
#>                      mpg cyl  disp
#> Mazda RX4           21.0   6 160.0
#> Mazda RX4 Wag       21.0   6 160.0
#> Datsun 710          22.8   4 108.0
#> Hornet 4 Drive      21.4   6 258.0
#> Hornet Sportabout   18.7   8 360.0
#> Valiant             18.1   6 225.0
#> Duster 360          14.3   8 360.0
#> Merc 240D           24.4   4 146.7
#> Merc 230            22.8   4 140.8
#> Merc 280            19.2   6 167.6
#> Merc 280C           17.8   6 167.6
#> Merc 450SE          16.4   8 275.8
#> Merc 450SL          17.3   8 275.8
#> Merc 450SLC         15.2   8 275.8
#> Cadillac Fleetwood  10.4   8 472.0
#> Lincoln Continental 10.4   8 460.0
#> Chrysler Imperial   14.7   8 440.0
#> Fiat 128            32.4   4  78.7
#> Honda Civic         30.4   4  75.7
#> Toyota Corolla      33.9   4  71.1
#> Toyota Corona       21.5   4 120.1
#> Dodge Challenger    15.5   8 318.0
#> AMC Javelin         15.2   8 304.0
#> Camaro Z28          13.3   8 350.0
#> Pontiac Firebird    19.2   8 400.0
#> Fiat X1-9           27.3   4  79.0
#> Porsche 914-2       26.0   4 120.3
#> Lotus Europa        30.4   4  95.1
#> Ford Pantera L      15.8   8 351.0
#> Ferrari Dino        19.7   6 145.0
#> Maserati Bora       15.0   8 301.0
#> Volvo 142E          21.4   4 121.0
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## `rename()`

重命名。其实`select()`函数本也可以重命名，不过是在选择后，而`rename()`没有选择而是直接改名。

`rename()`的列位置要是数量。虽然我并没有看懂。🤣

```r
select(iris, petal_length = Petal.Length) %>% head()
#>   petal_length
#> 1          1.4
#> 2          1.4
#> 3          1.3
#> 4          1.5
#> 5          1.4
#> 6          1.7
select(iris, obs = starts_with('S')) %>% head()
#>   obs1 obs2   obs3
#> 1  5.1  3.5 setosa
#> 2  4.9  3.0 setosa
#> 3  4.7  3.2 setosa
#> 4  4.6  3.1 setosa
#> 5  5.0  3.6 setosa
#> 6  5.4  3.9 setosa

rename(iris, petal_length = Petal.Length) %>% head()
#>   Sepal.Length Sepal.Width petal_length Petal.Width Species
#> 1          5.1         3.5          1.4         0.2  setosa
#> 2          4.9         3.0          1.4         0.2  setosa
#> 3          4.7         3.2          1.3         0.2  setosa
#> 4          4.6         3.1          1.5         0.2  setosa
#> 5          5.0         3.6          1.4         0.2  setosa
#> 6          5.4         3.9          1.7         0.4  setosa
rename(iris, obs = starts_with('S')) %>% head()
#> Column positions must be scalar
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## 

因为已经是name格式了所以可以直接改名的原因吧。如果是字符（串）的话可以少一个感叹号，但是我心中的感叹号又加了一个……:joy_cat:

```r
library(pacman)
p_load(dplyr)

vars <- list(
  var1 = sym("cyl"),
  var2 = sym("am")
)
vars
#> $var1
#> cyl
#> 
#> $var2
#> am
class(sym("cyl"))
#> [1] "name"

list(
  var1 = "cyl",
  var2 = "am"
)
#> $var1
#> [1] "cyl"
#> 
#> $var2
#> [1] "am"

select(mtcars, !!!vars)
#>                     var1 var2
#> Mazda RX4              6    1
#> Mazda RX4 Wag          6    1
#> Datsun 710             4    1
#> Hornet 4 Drive         6    0
#> Hornet Sportabout      8    0
#> Valiant                6    0
#> Duster 360             8    0
#> Merc 240D              4    0
#> Merc 230               4    0
#> Merc 280               6    0
#> Merc 280C              6    0
#> Merc 450SE             8    0
#> Merc 450SL             8    0
#> Merc 450SLC            8    0
#> Cadillac Fleetwood     8    0
#> Lincoln Continental    8    0
#> Chrysler Imperial      8    0
#> Fiat 128               4    1
#> Honda Civic            4    1
#> Toyota Corolla         4    1
#> Toyota Corona          4    0
#> Dodge Challenger       8    0
#> AMC Javelin            8    0
#> Camaro Z28             8    0
#> Pontiac Firebird       8    0
#> Fiat X1-9              4    1
#> Porsche 914-2          4    1
#> Lotus Europa           4    1
#> Ford Pantera L         8    1
#> Ferrari Dino           6    1
#> Maserati Bora          8    1
#> Volvo 142E             4    1

vars <- c(var1 = "cyl", var2 ="am")
select(mtcars, !!vars)
#>                     var1 var2
#> Mazda RX4              6    1
#> Mazda RX4 Wag          6    1
#> Datsun 710             4    1
#> Hornet 4 Drive         6    0
#> Hornet Sportabout      8    0
#> Valiant                6    0
#> Duster 360             8    0
#> Merc 240D              4    0
#> Merc 230               4    0
#> Merc 280               6    0
#> Merc 280C              6    0
#> Merc 450SE             8    0
#> Merc 450SL             8    0
#> Merc 450SLC            8    0
#> Cadillac Fleetwood     8    0
#> Lincoln Continental    8    0
#> Chrysler Imperial      8    0
#> Fiat 128               4    1
#> Honda Civic            4    1
#> Toyota Corolla         4    1
#> Toyota Corona          4    0
#> Dodge Challenger       8    0
#> AMC Javelin            8    0
#> Camaro Z28             8    0
#> Pontiac Firebird       8    0
#> Fiat X1-9              4    1
#> Porsche 914-2          4    1
#> Lotus Europa           4    1
#> Ford Pantera L         8    1
#> Ferrari Dino           6    1
#> Maserati Bora          8    1
#> Volvo 142E             4    1
```

<sup>Created on 2019-04-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

好像**ggplot2**也有用到`expression()`类似的语法，先贴这里：

1. https://dplyr.tidyverse.org/reference/tidyeval.html
2. https://rlang.r-lib.org/reference/index.html

## Variation

```r
select_all(.tbl, .funs = list(), ...)

rename_all(.tbl, .funs = list(), ...)

select_if(.tbl, .predicate, .funs = list(), ...)

rename_if(.tbl, .predicate, .funs = list(), ...)

select_at(.tbl, .vars, .funs = list(), ...)

rename_at(.tbl, .vars, .funs = list(), ...)
```

对列的先判断再选择/命名。注意`vars()`中若包含多个条件那么就是**且**！如果想要**或**的话还是减少判定条件吧。

例子中用到了几个base函数这里介绍下：

```r
x <- "MiXeD cAsE 123"
chartr("iXs", "why", x)
#> [1] "MwheD cAyE 123"
chartr("a-cX", "D-Fw", x)
#> [1] "MiweD FAsE 123"
tolower(x)
#> [1] "mixed case 123"
toupper(x)
#> [1] "MIXED CASE 123"
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

`rename()`和`select()`很像，于是就不解释了。

# `pull()`

用来输出数据。参数为列名，不支持多个输入以及其它表达。

```r
mtcars %>% pull(-1)
#>  [1] 4 4 1 1 2 1 4 2 2 4 4 3 3 3 4 4 4 1 2 1 1 2 2 4 2 1 2 2 4 6 8 2

mtcars %>% pull(1)
#>  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
#> [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
#> [29] 15.8 19.7 15.0 21.4

mtcars %>% pull(cyl)
#>  [1] 6 6 4 6 8 6 8 4 4 6 6 8 8 8 8 8 8 4 4 4 4 8 8 8 8 4 4 4 8 6 8 4

mtcars %>% pull("hp")
#>  [1] 110 110  93 110 175 105 245  62  95 123 123 180 180 180 205 215 230
#> [18]  66  52  65  97 150 150 245 175  66  91 113 264 175 335 109

mtcars %>% pull(c(cyl,hp))
#> `var` must evaluate to a single number or a column name, not an integer
#> vector

mtcars %>% pull(cyl:hp)
#> `var` must evaluate to a single number or a column name, not an integer
#> vector
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# `mutate()`/`transmute()`

`mutate()` adds new variables and preserves existing ones; `transmute()` adds new variables and drops existing ones. Both functions preserve the number of rows of the input. New variables overwrite existing variables of the same name.

## Useful functions

因为这里辅助函数太多，所以还是记载下来：

- `+`, `-`, `log()`, etc., for their usual mathematical meanings
- `lead()`, `lag()`
- `dense_rank()`, `min_rank()`, `percent_rank()`, `row_number()`, `cume_dist()`, `ntile()`
- `cumsum()`, `cummean()`, `cummin()`, `cummax()`, `cumany()`, `cumall()`
- `na_if()`, `coalesce()`
- `if_else()`, `recode()`, `case_when()`

### lead-lag

``` r
lead(1:10, 1)
#>  [1]  2  3  4  5  6  7  8  9 10 NA

lead(1:10, 2)
#>  [1]  3  4  5  6  7  8  9 10 NA NA

lag(1:10, 1)
#>  [1] NA  1  2  3  4  5  6  7  8  9

lag(1:10, 2)
#>  [1] NA NA  1  2  3  4  5  6  7  8

x <- runif(5)
cbind(ahead = lead(x), x, behind = lag(x))
#>          ahead         x    behind
#> [1,] 0.5571471 0.8306671        NA
#> [2,] 0.5874060 0.5571471 0.8306671
#> [3,] 0.3256915 0.5874060 0.5571471
#> [4,] 0.7930587 0.3256915 0.5874060
#> [5,]        NA 0.7930587 0.3256915
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

以及`order_by()`的处理。我这里试的情况是一样，但是官方不一样，可能是更改了吧。

``` r
df <- data.frame(year = 2000:2005, value = (0:5) ^ 2)
scrambled <- df[sample(nrow(df)), ]

wrong <- mutate(scrambled, prev = lag(value))
arrange(wrong, year)
#>   year value prev
#> 1 2000     0   NA
#> 2 2001     1    0
#> 3 2002     4   25
#> 4 2003     9   16
#> 5 2004    16    4
#> 6 2005    25    1

right <- mutate(scrambled, prev = lag(value, order_by = year))
arrange(right, year)
#>   year value prev
#> 1 2000     0   NA
#> 2 2001     1    0
#> 3 2002     4    1
#> 4 2003     9    4
#> 5 2004    16    9
#> 6 2005    25   16
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

### ranking

- `row_number()`: equivalent to `rank(ties.method = "first")`
- `min_rank()`: equivalent to `rank(ties.method = "min")`
- `dense_rank()`: like `min_rank()`, but with no gaps between ranks
- `percent_rank()`: a number between 0 and 1 computed by rescaling `min_rank` to `[0, 1]`
- `cume_dist()`: a cumulative distribution function. Proportion of all values less than or equal to the current rank.
- `ntile()`: a rough rank, which breaks the input vector into `n` buckets.

``` r
x <- c(5, 1, 3, 2, 2, NA)
row_number(x)
#> [1]  5  1  4  2  3 NA
min_rank(x)
#> [1]  5  1  4  2  2 NA
dense_rank(x)
#> [1]  4  1  3  2  2 NA
percent_rank(x)
#> [1] 1.00 0.00 0.75 0.25 0.25   NA
cume_dist(x)
#> [1] 1.0 0.2 0.8 0.6 0.6  NA
ntile(x,2)
#> [1]  2  1  2  1  1 NA
ntile(x,4)
#> [1]  4  1  3  1  2 NA
ntile(x,5)
#> [1]  5  1  4  2  3 NA
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

### `cum*()`

``` r
cumsum(1:10)
#>  [1]  1  3  6 10 15 21 28 36 45 55
cumprod(1:10)
#>  [1]       1       2       6      24     120     720    5040   40320
#>  [9]  362880 3628800
cummin(c(3:1, 2:0, 4:2))
#> [1] 3 2 1 1 1 0 0 0 0
cummin(c(1:2,0:3))
#> [1] 1 1 0 0 0 0

cummax(c(3:1, 2:0, 4:2))
#> [1] 3 3 3 3 3 3 4 4 4

x <- c(1, 3, 5, 2, 2)
cummean(x)
#> [1] 1.00 2.00 3.00 2.75 2.60
cumsum(x) / seq_along(x)
#> [1] 1.00 2.00 3.00 2.75 2.60

# `cumall()` and `cumany()` return logicals
cumall(x < 5)
#> [1]  TRUE  TRUE FALSE FALSE FALSE
cumany(x == 3)
#> [1] FALSE  TRUE  TRUE  TRUE  TRUE
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

除了`cumsum()`，`cumprod()`，`cummean()`外我都没看懂……

`na_if()`

如果数据满足第二个参数里的条件那么对应的值被赋为`NA`。

``` r
na_if(1:5, 5:1)
#> [1]  1  2 NA  4  5

x <- c(1, -1, 0, 10)
100 / x
#> [1]  100 -100  Inf   10
100 / na_if(x, 0)
#> [1]  100 -100   NA   10

y <- c("abc", "def", "", "ghi")
na_if(y, "")
#> [1] "abc" "def" NA    "ghi"
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

当然也可以配合使用：

``` r
starwars %>%
  select(name, eye_color) %>%
  mutate(eye_color = na_if(eye_color, "unknown"))
#> # A tibble: 87 x 2
#>    name               eye_color
#>    <chr>              <chr>    
#>  1 Luke Skywalker     blue     
#>  2 C-3PO              yellow   
#>  3 R2-D2              red      
#>  4 Darth Vader        yellow   
#>  5 Leia Organa        brown    
#>  6 Owen Lars          blue     
#>  7 Beru Whitesun lars blue     
#>  8 R5-D4              red      
#>  9 Biggs Darklighter  brown    
#> 10 Obi-Wan Kenobi     blue-gray
#> # ... with 77 more rows

starwars %>%
  mutate_if(is.character, list(~na_if(., "unknown")))
#> # A tibble: 87 x 13
#>    name  height  mass hair_color skin_color eye_color birth_year gender
#>    <chr>  <int> <dbl> <chr>      <chr>      <chr>          <dbl> <chr> 
#>  1 Luke~    172    77 blond      fair       blue            19   male  
#>  2 C-3PO    167    75 <NA>       gold       yellow         112   <NA>  
#>  3 R2-D2     96    32 <NA>       white, bl~ red             33   <NA>  
#>  4 Dart~    202   136 none       white      yellow          41.9 male  
#>  5 Leia~    150    49 brown      light      brown           19   female
#>  6 Owen~    178   120 brown, gr~ light      blue            52   male  
#>  7 Beru~    165    75 brown      light      blue            47   female
#>  8 R5-D4     97    32 <NA>       white, red red             NA   <NA>  
#>  9 Bigg~    183    84 black      light      brown           24   male  
#> 10 Obi-~    182    77 auburn, w~ fair       blue-gray       57   male  
#> # ... with 77 more rows, and 5 more variables: homeworld <chr>,
#> #   species <chr>, films <list>, vehicles <list>, starships <list>
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

### `coalesce()`

以`NA`为判定条件的合并。

``` r
x <- sample(c(1:5, NA, NA, NA))
coalesce(x, 0L)
#> [1] 4 3 0 1 2 0 5 0

y <- c(1, 2, NA, NA, 5)
z <- c(NA, NA, 3, 4, 5)
coalesce(y, z)
#> [1] 1 2 3 4 5

vecs <- list(
  c(1, 2, NA, NA, 5),
  c(NA, NA, 3, 4, 5)
)
coalesce(!!!vecs)
#> [1] 1 2 3 4 5
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

### `if_else()`

判定条件+为`TRUE`时赋值+为`FALSE`时赋值+为`NA`时赋值。因为`NA`也算是logical的一个（严格来讲不是）。

``` r
x <- c(-5:5, NA)
if_else(x < 0, NA_integer_, x)
#>  [1] NA NA NA NA NA  0  1  2  3  4  5 NA

if_else(x < 0, "negative", "positive", "missing")
#>  [1] "negative" "negative" "negative" "negative" "negative" "positive"
#>  [7] "positive" "positive" "positive" "positive" "positive" "missing"

1 < NA
#> [1] NA
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

### `recode()`

根据向量的位置或者它们的名字更换对应的值。

``` r
char_vec <- sample(c("a", "b", "c"), 10, replace = TRUE)
recode(char_vec, a = "Apple")
#>  [1] "b"     "Apple" "Apple" "b"     "Apple" "b"     "Apple" "b"    
#>  [9] "b"     "b"

recode(char_vec, a = "Apple", b = "Banana", .default = NA_character_)
#>  [1] "Banana" "Apple"  "Apple"  "Banana" "Apple"  "Banana" "Apple" 
#>  [8] "Banana" "Banana" "Banana"

num_vec <- c(1:4, NA)
recode(num_vec, "a", "b", "c", .default = "other", .missing = "missing")
#> [1] "a"       "b"       "c"       "other"   "missing"
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

### `case_when()`

注意可能因为顺序的原因导致结果和自己的预期不一样，另外`NA`的占位符性质也得有个交代。

``` r
x <- 1:50
case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  TRUE ~ as.character(x)
)
#>  [1] "1"         "2"         "3"         "4"         "fizz"     
#>  [6] "6"         "buzz"      "8"         "9"         "fizz"     
#> [11] "11"        "12"        "13"        "buzz"      "fizz"     
#> [16] "16"        "17"        "18"        "19"        "fizz"     
#> [21] "buzz"      "22"        "23"        "24"        "fizz"     
#> [26] "26"        "27"        "buzz"      "29"        "fizz"     
#> [31] "31"        "32"        "33"        "34"        "fizz buzz"
#> [36] "36"        "37"        "38"        "39"        "fizz"     
#> [41] "41"        "buzz"      "43"        "44"        "fizz"     
#> [46] "46"        "47"        "48"        "buzz"      "fizz"

case_when(
  TRUE ~ as.character(x),
  x %%  5 == 0 ~ "fizz",
  x %%  7 == 0 ~ "buzz",
  x %% 35 == 0 ~ "fizz buzz"
)
#>  [1] "1"  "2"  "3"  "4"  "5"  "6"  "7"  "8"  "9"  "10" "11" "12" "13" "14"
#> [15] "15" "16" "17" "18" "19" "20" "21" "22" "23" "24" "25" "26" "27" "28"
#> [29] "29" "30" "31" "32" "33" "34" "35" "36" "37" "38" "39" "40" "41" "42"
#> [43] "43" "44" "45" "46" "47" "48" "49" "50"

case_when(
  x %%  5 == 0 ~ "fizz",
  x %%  7 == 0 ~ "buzz",
  x %% 35 == 0 ~ "fizz buzz"
)
#>  [1] NA     NA     NA     NA     "fizz" NA     "buzz" NA     NA     "fizz"
#> [11] NA     NA     NA     "buzz" "fizz" NA     NA     NA     NA     "fizz"
#> [21] "buzz" NA     NA     NA     "fizz" NA     NA     "buzz" NA     "fizz"
#> [31] NA     NA     NA     NA     "fizz" NA     NA     NA     NA     "fizz"
#> [41] NA     "buzz" NA     NA     "fizz" NA     NA     NA     "buzz" "fizz"

x[2:4] <- NA_real_
case_when(
  x %% 35 == 0 ~ "fizz buzz",
  x %% 5 == 0 ~ "fizz",
  x %% 7 == 0 ~ "buzz",
  is.na(x) ~ "nope",
  TRUE ~ as.character(x)
)
#>  [1] "1"         "nope"      "nope"      "nope"      "fizz"     
#>  [6] "6"         "buzz"      "8"         "9"         "fizz"     
#> [11] "11"        "12"        "13"        "buzz"      "fizz"     
#> [16] "16"        "17"        "18"        "19"        "fizz"     
#> [21] "buzz"      "22"        "23"        "24"        "fizz"     
#> [26] "26"        "27"        "buzz"      "29"        "fizz"     
#> [31] "31"        "32"        "33"        "34"        "fizz buzz"
#> [36] "36"        "37"        "38"        "39"        "fizz"     
#> [41] "41"        "buzz"      "43"        "44"        "fizz"     
#> [46] "46"        "47"        "48"        "buzz"      "fizz"
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## The point

一个可以写入、删除、覆盖；另一个可以提取。

``` r
mtcars %>%
  mutate(mpg = NULL,
         displ_l = disp / 61.0237) %>% head()
#>   cyl disp  hp drat    wt  qsec vs am gear carb  displ_l
#> 1   6  160 110 3.90 2.620 16.46  0  1    4    4 2.621932
#> 2   6  160 110 3.90 2.875 17.02  0  1    4    4 2.621932
#> 3   4  108  93 3.85 2.320 18.61  1  1    4    1 1.769804
#> 4   6  258 110 3.08 3.215 19.44  1  0    3    1 4.227866
#> 5   8  360 175 3.15 3.440 17.02  0  0    3    2 5.899347
#> 6   6  225 105 2.76 3.460 20.22  1  0    3    1 3.687092

mtcars %>%
  transmute(mpg = NULL,
            displ_l = disp / 61.0237) %>% head()
#> Warning: Unknown columns: `mpg`
#>    displ_l
#> 1 2.621932
#> 2 2.621932
#> 3 1.769804
#> 4 4.227866
#> 5 5.899347
#> 6 3.687092
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## Variation

还是不变的套路。

```r
mutate_all(.tbl, .funs, ...)

mutate_if(.tbl, .predicate, .funs, ...)

mutate_at(.tbl, .vars, .funs, ..., .cols = NULL)

transmute_all(.tbl, .funs, ...)

transmute_if(.tbl, .predicate, .funs, ...)

transmute_at(.tbl, .vars, .funs, ..., .cols = NULL)
```

这里提到了*purrr-style formulas*，不急我马上就要折腾到这里了:joy:！

```r
# The list can contain purrr-style formulas:
iris %>% mutate_if(is.numeric, list(~scale2(.), ~log(.)))
#> # A tibble: 150 x 13
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species Sepal.Length_sc…
#>           <dbl>       <dbl>        <dbl>       <dbl> <fct>              <dbl>
#>  1          5.1         3.5          1.4         0.2 setosa            -0.898
#>  2          4.9         3            1.4         0.2 setosa            -1.14 
#>  3          4.7         3.2          1.3         0.2 setosa            -1.38 
#>  4          4.6         3.1          1.5         0.2 setosa            -1.50 
#>  5          5           3.6          1.4         0.2 setosa            -1.02 
#>  6          5.4         3.9          1.7         0.4 setosa            -0.535
#>  7          4.6         3.4          1.4         0.3 setosa            -1.50 
#>  8          5           3.4          1.5         0.2 setosa            -1.02 
#>  9          4.4         2.9          1.4         0.2 setosa            -1.74 
#> 10          4.9         3.1          1.5         0.1 setosa            -1.14 
#> # … with 140 more rows, and 7 more variables: Sepal.Width_scale2 <dbl>,
#> #   Petal.Length_scale2 <dbl>, Petal.Width_scale2 <dbl>,
#> #   Sepal.Length_log <dbl>, Sepal.Width_log <dbl>, Petal.Length_log <dbl>,
#> #   Petal.Width_log <dbl>
```

# `group_by`

``` r
by_vs_am <- mtcars %>% group_by(vs, am)
by_vs_am %>% summarise(n = n())
#> # A tibble: 4 x 3
#> # Groups:   vs [2]
#>      vs    am     n
#>   <dbl> <dbl> <int>
#> 1     0     0    12
#> 2     0     1     6
#> 3     1     0     7
#> 4     1     1     7

by_cyl <- mtcars %>% group_by(cyl)

by_cyl %>%
  group_by(vs, am, add = TRUE) %>%
  group_vars()
#> [1] "cyl" "vs"  "am"

by_cyl %>%
  group_by(vs, am) %>%
  group_vars()
#> [1] "vs" "am"
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

当然，想scoped一下也可以……

# `summarize()`

## Useful functions

这里当然会有很多辅助函数的啦~

- Center: `mean()`, `median()`
- Spread: `sd()`, `IQR()`, `mad()`
- Range: `min()`, `max()`, `quantile()`
- Position: `first()`, `last()`, `nth()`,
- Count: `n()`, `n_distinct()`: a faster and more concise equivalent of `length(unique(x))`
- Logical: `any()`, `all()`

``` r
x <- 1:10
y <- 10:1

first(x)
#> [1] 1
last(y)
#> [1] 1

nth(x, 1)
#> [1] 1
nth(x, 5)
#> [1] 5
nth(x, -2)
#> [1] 9
nth(x, 11)
#> [1] NA

last(x)
#> [1] 10
# Second argument provides optional ordering
last(x, y)
#> [1] 1
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# `distinct()`

打印无重复的数据。如果参数只是一个数据框，那么会选择数据框独一无二的每一行打印；如果加上数据框内的列名，那么会按照列来，多少列都可以的，因为是`...`；又因为是`...`，写入一个值也可以不过也要distinct一下。

``` r
df <- tibble(
  x = sample(10, 100, rep = TRUE),
  y = sample(10, 100, rep = TRUE)
)
nrow(df)
#> [1] 100

nrow(distinct(df))
#> [1] 66

nrow(distinct(df, x, y))
#> [1] 66

distinct(df, x)
#> # A tibble: 10 x 1
#>        x
#>    <int>
#>  1     1
#>  2    10
#>  3     9
#>  4     3
#>  5     2
#>  6     7
#>  7     8
#>  8     4
#>  9     5
#> 10     6

distinct(df, y)
#> # A tibble: 10 x 1
#>        y
#>    <int>
#>  1     9
#>  2     2
#>  3     5
#>  4     1
#>  5     6
#>  6     7
#>  7     8
#>  8     3
#>  9    10
#> 10     4

distinct(df, y, .keep_all = TRUE)
#> # A tibble: 10 x 2
#>        x     y
#>    <int> <int>
#>  1     1     9
#>  2    10     2
#>  3     9     5
#>  4     3     1
#>  5     9     6
#>  6    10     7
#>  7     7     8
#>  8     8     3
#>  9     5    10
#> 10     9     4

distinct(df, diff = abs(x - y))
#> # A tibble: 9 x 1
#>    diff
#>   <int>
#> 1     8
#> 2     4
#> 3     2
#> 4     3
#> 5     5
#> 6     1
#> 7     0
#> 8     7
#> 9     6
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

同样地，这里的变量也可以scoped一下。

# `do()`

Do [anything](https://dplyr.tidyverse.org/reference/do.html).:sob:

# `sample_n()`/`sample_frac()`

前者是按数量抽样，后者是按与原数据行数的比例抽样，以分数（小数）形式。

# `slice()`

按行的位置抽取行。

``` r
slice(mtcars, 1L)
#>   mpg cyl disp  hp drat   wt  qsec vs am gear carb
#> 1  21   6  160 110  3.9 2.62 16.46  0  1    4    4

slice(mtcars, n())
#>    mpg cyl disp  hp drat   wt qsec vs am gear carb
#> 1 21.4   4  121 109 4.11 2.78 18.6  1  1    4    2

slice(mtcars, 5:n())
#>     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
#> 1  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
#> 2  18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
#> 3  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
#> 4  24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
#> 5  22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
#> 6  19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
#> 7  17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
#> 8  16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
#> 9  17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
#> 10 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
#> 11 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
#> 12 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
#> 13 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
#> 14 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
#> 15 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
#> 16 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
#> 17 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
#> 18 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
#> 19 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
#> 20 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
#> 21 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
#> 22 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
#> 23 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
#> 24 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
#> 25 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
#> 26 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
#> 27 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
#> 28 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

# Equivalent
# filter(mtcars, row_number() == 1L)
# 
# filter(mtcars, row_number() == n())
# 
# filter(mtcars, between(row_number(), 5, n()))
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# `tally()`/`count()`

``` r
# tally() is short-hand for summarise()
mtcars %>% tally()
#>    n
#> 1 32

mtcars %>% group_by(cyl) %>% tally()
#> # A tibble: 3 x 2
#>     cyl     n
#>   <dbl> <int>
#> 1     4    11
#> 2     6     7
#> 3     8    14

# count() is a short-hand for group_by() + tally()
mtcars %>% count(cyl)
#> # A tibble: 3 x 2
#>     cyl     n
#>   <dbl> <int>
#> 1     4    11
#> 2     6     7
#> 3     8    14

# add_tally() is short-hand for mutate()
mtcars %>% add_tally()
#> # A tibble: 32 x 12
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb     n
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <int>
#>  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4    32
#>  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4    32
#>  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1    32
#>  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1    32
#>  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2    32
#>  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1    32
#>  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4    32
#>  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2    32
#>  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2    32
#> 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4    32
#> # ... with 22 more rows

# add_count() is a short-hand for group_by() + add_tally()
mtcars %>% add_count(cyl)
#> # A tibble: 32 x 12
#>      mpg   cyl  disp    hp  drat    wt  qsec    vs    am  gear  carb     n
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <int>
#>  1  21       6  160    110  3.9   2.62  16.5     0     1     4     4     7
#>  2  21       6  160    110  3.9   2.88  17.0     0     1     4     4     7
#>  3  22.8     4  108     93  3.85  2.32  18.6     1     1     4     1    11
#>  4  21.4     6  258    110  3.08  3.22  19.4     1     0     3     1     7
#>  5  18.7     8  360    175  3.15  3.44  17.0     0     0     3     2    14
#>  6  18.1     6  225    105  2.76  3.46  20.2     1     0     3     1     7
#>  7  14.3     8  360    245  3.21  3.57  15.8     0     0     3     4    14
#>  8  24.4     4  147.    62  3.69  3.19  20       1     0     4     2    11
#>  9  22.8     4  141.    95  3.92  3.15  22.9     1     0     4     2    11
#> 10  19.2     6  168.   123  3.92  3.44  18.3     1     0     4     4     7
#> # ... with 22 more rows
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# `top_n()`

``` r
df <- data.frame(x = c(10, 4, 1, 6, 3, 1, 1))
df %>% top_n(2)
#> Selecting by x
#>    x
#> 1 10
#> 2  6

df %>% top_n(-2)
#> Selecting by x
#>   x
#> 1 1
#> 2 1
#> 3 1
```

<sup>Created on 2019-04-29 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

# Scoped

- `arrange_all()`, `arrange_at()`, and `arrange_if()`
- `distinct_all()`, `distinct_at()`, and `distinct_if()`
- `filter_all()`, `filter_at()`, and `filter_if()`
- `group_by_all()`, `group_by_at()`, and `group_by_if()`
- `select_all()`, `select_at()`, and `select_if()`