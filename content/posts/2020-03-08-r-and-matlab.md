---
title: R & MATLAB
author: hoas
date: '2020-03-08'
slug: r-and-matlab
categories:
  - notes
tags:
  - R
  - MATLAB
lastmod: '2020-03-08T12:40:12+08:00'
description: ''
show_in_homepage: yes
show_description: no
license: ''
featured_image: ''
featured_image_preview: ''
comment: no
toc: yes
autoCollapseToc: no
math: yes
---

作为R & MATLAB的迁移笔记，主要目的是将R的结构迁移至对应的MATLAB结构。

## 数据结构

### 向量

R语言属于**函数式编程**，所有的格式都要用函数表示；MATLAB则更侧重于矩阵结构。

#### R

R中的所有类型（数值型、字符型、逻辑型）向量虽然也是一维数组，但是默认为行向量。

R中的Boolean值必须是首字母大写或者是全字母大写。R索引的时候用方括号，并且引子也要遵从函数式编程。R中单双引号完全等价（需要匹配）。

```r
a <- c(1, 2, 5, 3, 6, -2, 4)
b <- c("one", "two", "three")
c <- c(TRUE, TRUE, TRUE, FALSE, TRUE, FALSE)

> class(a)
[1] "numeric"
> class(b)
[1] "character"
> class(c)
[1] "logical"

# 索引
> a[2]
[1] 2
> a[c(3,4)]
[1] 5 3
```

#### MATLAB

MATLAB从向量开始就被定义为数组，虽然也是一维行向量。

MATLAB中的Boolean值都要小写，如果行末不加分号，那么运行后会在命令行窗口显示结果。MATLAB索引直接用小括号。MATLAB中单引号为**字符数组构造符号**，因此单引号系列要用`{}`（元胞）括起，双引号为**字符串构造符号**，以`[]`括起。

```matlab
a = [1, 2, 3, 4, 5, 6];
b = ["one", "two", "three"];
c = [true, true, true, false, true, false];
d = ['one', 'two', 'three'];

a =
     1     2     3     4     5     6
b = 
  1×3 string 数组
    "one"    "two"    "three"
c =
  1×6 logical 数组
   1   1   1   0   1   0
d =
    'onetwothree'
   
>> whos a
  Name      Size            Bytes  Class     Attributes

  a         1x6                48  double              

>> class(b)
ans =
    'string'
    
% 索引
>> a(1)
ans =
     1
>> a(2:4)
ans =
     2     3     4
```

### 数据框

个人认为数据框才是一切**数值运算**的核心。

#### R

```r
tbl <- tibble::tibble(patientID = c(1, 2, 3, 4),
       age = c(25, 34, 28, 52),
       diabetes = c("Type1", "Type2", "Type1", "Type1"),
       status = c("Poor", "Improved", "Excellent", "Poor"),
       boolean = c(TRUE, TRUE, FALSE, FALSE))


tbl
#> # A tibble: 4 x 5
#>   patientID   age diabetes status    boolean
#>       <dbl> <dbl> <chr>    <chr>     <lgl>  
#> 1         1    25 Type1    Poor      TRUE   
#> 2         2    34 Type2    Improved  TRUE   
#> 3         3    28 Type1    Excellent FALSE  
#> 4         4    52 Type1    Poor      FALSE
```

#### MATLAB

MATLAB中离`data.frame`最接近是数据结构是`table`。搭建完`table`后，可以实现类似R中的[表格运算](https://hoas.netlify.com/post/summary-of-course-design/#%E8%A1%A8%E6%A0%BC%E8%BF%90%E7%AE%97)。

```matlab
LastName = {'Sanchez';'Johnson';'Li';'Diaz';'Brown'};
Age = [38;43;38;40;49];
Smoker = logical([1;0;1;0;1]);
Height = [71;69;64;67;64];
Weight = [176;163;131;133;119];
BloodPressure = [124 93; 109 77; 125 83; 117 75; 122 80];
BalaBala = ["a";"b";"c";"d";"e"];

t = table(LastName, Age, Smoker, Height, Weight, BloodPressure, BalaBala);

>> t
t =
  5×7 table
    LastName     Age    Smoker    Height    Weight    BloodPressure    BalaBala
    _________    ___    ______    ______    ______    _____________    ________
    'Sanchez'    38     true        71       176       124     93        "a"   
    'Johnson'    43     false       69       163       109     77        "b"   
    'Li'         38     true        64       131       125     83        "c"   
    'Diaz'       40     false       67       133       117     75        "d"   
    'Brown'      49     true        64       119       122     80        "e"  
    
% 数组属性的查询（可补充）
>> t.Properties
ans = 
  TableProperties - 属性:
             Description: ''
                UserData: []
          DimensionNames: {'Row'  'Variables'}
           VariableNames: {'LastName'  'Age'  'Smoker'  'Height'  'Weight'  'BloodPressure'  'BalaBala'}
    VariableDescriptions: {}
           VariableUnits: {}
      VariableContinuity: []
                RowNames: {}
        CustomProperties: 未设置自定义属性。
请使用 addprop 和 rmprop 修改 CustomProperties。

% 数组变量的查询
>> t.Variables
ans = 
  5×8 string 数组
    "Sanchez"    "38"    "true"     "71"    "176"    "124"    "93"    "a"
    "Johnson"    "43"    "false"    "69"    "163"    "109"    "77"    "b"
    "Li"         "38"    "true"     "64"    "131"    "125"    "83"    "c"
    "Diaz"       "40"    "false"    "67"    "133"    "117"    "75"    "d"
    "Brown"      "49"    "true"     "64"    "119"    "122"    "80"    "e"
    
% 内部元素索引
>> t.LastName{1}
ans =
    'Sanchez'
>> t.LastName(1)
ans =
  1×1 cell 数组
    {'Sanchez'}
    
>> t.Height{1}
此类型的变量不支持使用花括号进行索引。时
>> t.Height(1)
ans =
    71
    
>> t.BalaBala{1}
ans =
    'a'
>> t.BalaBala(1)
ans = 
    "a"
```

`table`也可以预分配：

```matlab
sz = [4 3];
varTypes = {'double','datetime','string'};
varNames = {'Temperature','Time','Station'};
t2 = table('Size',sz,'VariableTypes',varTypes,'VariableNames',varNames);

>> t2
t2 =
  4×3 table
    Temperature    Time     Station 
    ___________    ____    _________
         0         NaT     <missing>
         0         NaT     <missing>
         0         NaT     <missing>
         0         NaT     <missing>
```

手动添加元素时需要使用元胞（cell）：

```matlab
>> t2(1,:) = {75 datetime('now') "S1"}
t2 =
  4×3 table
    Temperature           Time             Station 
    ___________    ___________________    _________
        75         2020-03-08 14:26:13    "S1"     
         0                         NaT    <missing>
         0                         NaT    <missing>
         0                         NaT    <missing>
```

也可以新建时直接指定`table`的变量名称。这里需要注意一下，MATLAB中的函数不能随便跨行，如果因为格式限制则需要使用`...`进行换行。

```matlab
T = table(categorical({'M';'F';'M'}),[45;32;34],...
          {'NY';'CA';'MA'},logical([1;0;0]),...
          'VariableNames',{'Gender','Age','State','Vote'})
          
T =
  3×4 table
    Gender    Age    State    Vote 
    ______    ___    _____    _____
      M       45     'NY'     true 
      F       32     'CA'     false
      M       34     'MA'     false
      
% 也可以加上行名：
T = table(categorical({'M';'F';'M'}),[45;32;34],logical([1;0;0]),...
          'VariableNames',{'Gender','Age','Vote'},...
          'RowNames',{'NY';'CA';'MA'})
          
T=3×3 table
          Gender    Age    Vote 
          ______    ___    _____

    NY      M       45     true 
    CA      F       32     false
    MA      M       34     false
    
% 行/列名索引
>> T('NY', :)
ans =
  1×3 table
          Gender    Age    Vote 
          ______    ___    _____
    NY      M       45     true 
    
>> T(1, :)
ans =
  1×3 table
          Gender    Age    Vote 
          ______    ___    _____
    NY      M       45     true 
    
>> T(:, 1)
ans =
  3×1 table
          Gender
          ______
    NY      M   
    CA      F   
    MA      M  
    
>> T([1,2], :)
ans =
  2×3 table
          Gender    Age    Vote 
          ______    ___    _____
    NY      M       45     true 
    CA      F       32     false
    
>> T(:, [1, 2])
ans =
  3×2 table
          Gender    Age
          ______    ___
    NY      M       45 
    CA      F       32 
    MA      M       34 

>> T({'NY', 'CA'}, :)
ans =
  2×3 table
          Gender    Age    Vote 
          ______    ___    _____
    NY      M       45     true 
    CA      F       32     false
    
>> T(["NY", "CA"], :)
ans =
  2×3 table
          Gender    Age    Vote 
          ______    ___    _____
    NY      M       45     true 
    CA      F       32     false
    
>> T.Properties.DimensionNames{1}
ans =
    'Row'
>> T
T =
  3×3 table
          Gender    Age    Vote 
          ______    ___    _____
    NY      M       45     true 
    CA      F       32     false
    MA      M       34     false
>> T.Properties.DimensionNames{1} = 'LastNames'
T =
  3×3 table
          Gender    Age    Vote 
          ______    ___    _____
    NY      M       45     true 
    CA      F       32     false
    MA      M       34     false
```

<!--more-->

