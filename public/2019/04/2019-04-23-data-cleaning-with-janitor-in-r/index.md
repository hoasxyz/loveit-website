# janitor数据清洗


> Data scientists, according to interviews and expert estimates, spend from 50 percent to 80 percent of their time mired in this more mundane labor of collecting and preparing unruly digital data, before it can be explored for useful nuggets.
>
> 根据访谈和专家的估计, 数据科学家将50%到80%的时间花在收集和准备不规范的数字数据这一更为平凡的工作中, 然后才能对其进行探索。
>
> – *“[For Big-Data Scientists, ‘Janitor Work’ Is Key Hurdle to Insight](http://www.nytimes.com/2014/08/18/technology/for-big-data-scientists-hurdle-to-insights-is-janitor-work.html)”
>
> - The New York Times, 2014*

小包也有大大的力量，**[janitor](https://github.com/sfirke/janitor)**值得拥有！虽然是数据清洗和一般的清洗一样本就是一项“脏”的工作，可是**janitor**教你便捷清洗而又不失优雅！

<center>

![janitor](https://github.com/sfirke/janitor/raw/master/man/figures/logo_small.png)

</center>

The main janitor functions:

- perfectly format data.frame column names;
- create and format frequency tables of one, two, or three variables - think an improved `table()`; and
- isolate partially-duplicate records.

<!--more-->

# 数据清洗

[示例](https://github.com/sfirke/janitor/blob/master/dirty_data.xlsx)中的乱数据包括：

- 令人不爽的列名；

- 不含数据的Excel格式的行和列；

- 被保存为数值的时间；

- 跨越多个行的断断续续的值。

``` r
library(pacman) # for loading packages
p_load(readxl, janitor, dplyr, here)

# here("dirty_data.xlsx")
roster_raw <- read_excel("E:/1R/dirty_data.xlsx") # available at http://github.com/sfirke/janitor
#> New names:
#> * Certification -> Certification...9
#> * Certification -> Certification...10
#> * Certification -> Certification...11
glimpse(roster_raw)
#> Observations: 13
#> Variables: 11
#> $ `First Name`        <chr> "Jason", "Jason", "Alicia", "Ada", "Desus"...
#> $ `Last Name`         <chr> "Bourne", "Bourne", "Keys", "Lovelace", "N...
#> $ `Employee Status`   <chr> "Teacher", "Teacher", "Teacher", "Teacher"...
#> $ Subject             <chr> "PE", "Drafting", "Music", NA, "Dean", "Ph...
#> $ `Hire Date`         <dbl> 39690, 39690, 37118, 27515, 41431, 11037, ...
#> $ `% Allocated`       <dbl> 0.75, 0.25, 1.00, 1.00, 1.00, 0.50, 0.50, ...
#> $ `Full time?`        <chr> "Yes", "Yes", "Yes", "Yes", "Yes", "Yes", ...
#> $ `do not edit! --->` <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...
#> $ Certification...9   <chr> "Physical ed", "Physical ed", "Instr. musi...
#> $ Certification...10  <chr> "Theater", "Theater", "Vocal music", "Comp...
#> $ Certification...11  <lgl> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA...

roster <- roster_raw %>%
  clean_names() %>%
  remove_empty(c("rows", "cols")) %>%
  mutate(hire_date = excel_numeric_to_date(hire_date),
         cert = coalesce(certification_9, certification_10)) %>% # from dplyr
  select(-certification_9, -certification_10) # drop unwanted columns

roster
#> # A tibble: 12 x 8
#>    first_name last_name employee_status subject hire_date  percent_allocat~
#>    <chr>      <chr>     <chr>           <chr>   <date>                <dbl>
#>  1 Jason      Bourne    Teacher         PE      2008-08-30             0.75
#>  2 Jason      Bourne    Teacher         Drafti~ 2008-08-30             0.25
#>  3 Alicia     Keys      Teacher         Music   2001-08-15             1   
#>  4 Ada        Lovelace  Teacher         <NA>    1975-05-01             1   
#>  5 Desus      Nice      Administration  Dean    2013-06-06             1   
#>  6 Chien-Shi~ Wu        Teacher         Physics 1930-03-20             0.5 
#>  7 Chien-Shi~ Wu        Teacher         Chemis~ 1930-03-20             0.5 
#>  8 James      Joyce     Teacher         English 1990-05-01             0.5 
#>  9 Hedy       Lamarr    Teacher         Science 1976-06-08             0.5 
#> 10 Carlos     Boozer    Coach           Basket~ 2015-08-05            NA   
#> 11 Young      Boozer    Coach           <NA>    1995-01-01            NA   
#> 12 Micheal    Larsen    Teacher         English 2009-09-15             0.8 
#> # ... with 2 more variables: full_time <chr>, cert <chr>
```

<sup>Created on 2019-04-23 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

配合**reprex**使用`here()`失败了，viewer中给出了一个C盘的路径，不知道为什么……

## `clean_names()`

列名的重命名有这些不同的格式，默认是全小写以`_`分开。

The desired target case (default is "snake"), indicated by these possible values:

- "snake" produces snake_case

- "lower_camel" or "small_camel" produces lowerCamel

- "upper_camel" or "big_camel" produces UpperCamel

- "screaming_snake" or "all_caps" produces ALL_CAPS

- "lower_upper" produces lowerUPPER

- "upper_lower" produces UPPERlower

- old_janitor: legacy compatibility option to preserve behavior of clean_names prior to addition of the "case" argument(janitor versions <= 0.3.1 ). Provided as a quick fix for old scripts broken by the changes to clean_names in janitor v1.0.

- "parsed", "mixed", "none": less-common cases offered by snakecase::to_any_case. See to_any_case for details.

base中也有统一规范化列名的函数`make.names()`，不过没有这个强大：

``` r
test_df <- as.data.frame(matrix(ncol = 6))
names(test_df) <- c("firstName", "ábc@!*", "% successful (2009)",
                    "REPEAT VALUE", "REPEAT VALUE", "")

janitor::clean_names(test_df)
#>   first_name abc percent_successful_2009 repeat_value repeat_value_2  x
#> 1         NA  NA                      NA           NA             NA NA

make.names(names(test_df))
#> [1] "firstName"            "ábc..."               "X..successful..2009."
#> [4] "REPEAT.VALUE"         "REPEAT.VALUE"         "X"
```

<sup>Created on 2019-04-23 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

对于单个向量有另外一个函数：

``` r
library(janitor)

x <- structure(1:3, names = c("name with space", "TwoWords", "total $ (2009)"))
x
#> name with space        TwoWords  total $ (2009) 
#>               1               2               3
make_clean_names(x)
#> [1] "x1" "x2" "x3"

name <- c("hello world","hey! you$")
make_clean_names(name)
#> [1] "hello_world" "hey_you"
```

<sup>Created on 2019-04-23 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## `remove_empty()`

移除空的行或者列：

``` r
q <- data.frame(v1 = c(1, NA, 3),
                v2 = c(NA, NA, NA),
                v3 = c("a", NA, "b"))

janitor::remove_empty(q, c("rows", "cols"))
#>   v1 v3
#> 1  1  a
#> 3  3  b
```

<sup>Created on 2019-04-23 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

另外`remove_constant()`是移除连续值的列。

``` r
janitor::remove_constant(data.frame(A=1, B=1:3))
#>   B
#> 1 1
#> 2 2
#> 3 3
```

<sup>Created on 2019-04-23 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## `excel_numeric_to_date()`

虽然我不知道这个数字到底是怎么来的，好像和`POSIXlt`有关。

```r
excel_numeric_to_date(41103)
#> [1] "2012-07-13"
excel_numeric_to_date(41103.01) # ignores decimal places, returns Date object
#> [1] "2012-07-13"
excel_numeric_to_date(41103.01, include_time = TRUE) # returns POSIXlt object
#> [1] "2012-07-13 01:14:24 EDT"
excel_numeric_to_date(41103.01, date_system = "mac pre-2011")
#> [1] "2016-07-14"
```

## `coalesce()`

``` r
library(dplyr)

# Use a single value to replace all missing values
x <- sample(c(1:5, NA, NA, NA))
coalesce(x, 0L)
#> [1] 0 1 2 0 3 0 4 5

# Or match together a complete vector from missing pieces
y <- c(1, 2, NA, NA, 5)
z <- c(NA, NA, 3, 4, 5)
coalesce(y, z)
#> [1] 1 2 3 4 5

# Supply lists by splicing them into dots:
vecs <- list(
  c(1, 2, NA, NA, 5),
  c(NA, NA, 3, 4, 5)
)
coalesce(!!!vecs)
#> [1] 1 2 3 4 5
```

<sup>Created on 2019-04-23 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

我惊了，三个感叹号什么鬼？！把列表合成向量？

# 数据审查

## `get_dupes()`

``` r
roster %>% 
  get_dupes(first_name, last_name)
#> # A tibble: 4 x 9
#>   first_name last_name dupe_count employee_status subject hire_date 
#>   <chr>      <chr>          <int> <chr>           <chr>   <date>    
#> 1 Chien-Shi~ Wu                 2 Teacher         Physics 1930-03-20
#> 2 Chien-Shi~ Wu                 2 Teacher         Chemis~ 1930-03-20
#> 3 Jason      Bourne             2 Teacher         PE      2008-08-30
#> 4 Jason      Bourne             2 Teacher         Drafti~ 2008-08-30
#> # ... with 3 more variables: percent_allocated <dbl>, full_time <chr>,
#> #   cert <chr>
```

<sup>Created on 2019-04-23 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## `tabyl()`

### 单变量

```r
roster %>%
  tabyl(subject)
#>     subject n    percent valid_percent
#>  Basketball 1 0.08333333           0.1
#>   Chemistry 1 0.08333333           0.1
#>        Dean 1 0.08333333           0.1
#>    Drafting 1 0.08333333           0.1
#>     English 2 0.16666667           0.2
#>       Music 1 0.08333333           0.1
#>          PE 1 0.08333333           0.1
#>     Physics 1 0.08333333           0.1
#>     Science 1 0.08333333           0.1
#>        <NA> 2 0.16666667            NA
```

### 双变量

用来分类的变量放在第一个。

```r
roster %>%
  filter(hire_date > as.Date("1950-01-01")) %>%
  tabyl(employee_status, full_time)
#>  employee_status No Yes
#>   Administration  0   1
#>            Coach  2   0
#>          Teacher  3   4
```

### 三变量

用来分类的变量放在了第三个？！

```r
roster %>%
  tabyl(full_time, subject, employee_status, show_missing_levels = FALSE)
#> $Administration
#>  full_time Dean
#>        Yes    1
#> 
#> $Coach
#>  full_time Basketball NA_
#>         No          1   1
#> 
#> $Teacher
#>  full_time Chemistry Drafting English Music PE Physics Science NA_
#>         No         0        0       2     0  0       0       1   0
#>        Yes         1        1       0     1  1       1       0   1
```

## `adorn_`

```r
roster %>%
  tabyl(employee_status, full_time) %>%
  adorn_totals("row") %>%
  adorn_percentages("row") %>%
  adorn_pct_formatting() %>%
  adorn_ns() %>%
  adorn_title("combined")
#>  employee_status/full_time         No        Yes
#>             Administration   0.0% (0) 100.0% (1)
#>                      Coach 100.0% (2)   0.0% (0)
#>                    Teacher  33.3% (3)  66.7% (6)
#>                      Total  41.7% (5)  58.3% (7)
```

# 其它

## `compare_df_cols()`

```r
df1 <- data.frame(a = 1:2, b = c("big", "small")) # a factor by default
df2 <- data.frame(a = 10:12, b = c("medium", "small", "big"), c = 0, stringsAsFactors = FALSE)
df3 <- df1 %>%
  dplyr::mutate(b = as.character(b))

compare_df_cols(df1, df2, df3)
#>   column_name     df1       df2       df3
#> 1           a integer   integer   integer
#> 2           b  factor character character
#> 3           c    <NA>   numeric      <NA>

compare_df_cols(df1, df2, df3, return = "mismatch")
#>   column_name    df1       df2       df3
#> 1           b factor character character
compare_df_cols(df1, df2, df3, return = "mismatch", bind_method = "rbind") # default is dplyr::bind_rows
#>   column_name    df1       df2       df3
#> 1           b factor character character
#> 2           c   <NA>   numeric      <NA>
```

另外：

```r
compare_df_cols_same(df1, df3)
#>   column_name    ..1       ..2
#> 1           b factor character
#> [1] FALSE
compare_df_cols_same(df2, df3)
#> [1] TRUE
```

## `round_half_up()`

`round()`关于5的舍取容易弄错，但是这个函数确实是四舍五入。详见：https://stackoverflow.com/questions/12688717/round-up-from-5/12688836#12688836

```r
nums <- c(2.5, 3.5)
round(nums)
#> [1] 2 4
round_half_up(nums)
#> [1] 3 4

round_half_up(3.555,2)
#> [1] 3.56
```

## `round_to_fraction()`

这个也没搞懂，先写着吧。

```r
round_to_fraction(1.6, denominator = 2)
#> [1] 1.5
round_to_fraction(pi, denominator = 7) # 22/7
#> [1] 3.142857
round_to_fraction(c(8.1, 9.2), denominator = c(7, 8))
#> [1] 8.142857 9.250000
round_to_fraction(c(8.1, 9.2), denominator = c(7, 8), digits = 3)
#> [1] 8.143 9.250
round_to_fraction(c(8.1, 9.2, 10.3), denominator = c(7, 8, 1001), digits = "auto")
#> [1]  8.1400  9.2500 10.2997
```

## `row_to_names`

行转为列名：

```r
dirt <- data.frame(X_1 = c(NA, "ID", 1:3),
           X_2 = c(NA, "Value", 4:6))

row_to_names(dirt, 2)
#>   ID Value
#> 3  1     4
#> 4  2     5
#> 5  3     6
```

## `top_levels()`

计数和计算百分数：

```r
f <- factor(c("strongly agree", "agree", "neutral", "neutral", "disagree", "strongly agree"),
            levels = c("strongly agree", "agree", "neutral", "disagree", "strongly disagree"))
top_levels(f)
#>                            f n   percent
#>        strongly agree, agree 3 0.5000000
#>                      neutral 2 0.3333333
#>  disagree, strongly disagree 1 0.1666667
top_levels(f, n = 1)
#>                         f n   percent
#>            strongly agree 2 0.3333333
#>  agree, neutral, disagree 4 0.6666667
#>         strongly disagree 0 0.0000000
```