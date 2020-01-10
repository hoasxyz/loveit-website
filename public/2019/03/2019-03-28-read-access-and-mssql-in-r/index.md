# R语言读取Access和MS SQL


用 R 语言读取 Access和MS SQL 的经历，通过 ODBC 。十分感谢万飚老师的帮助！

> **ODBC**（**Open Database Connectivity**，开放数据库互连）提供了一种标准的[API](https://zh.wikipedia.org/wiki/%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%E6%8E%A5%E5%8F%A3)（[应用程序编程接口](https://zh.wikipedia.org/wiki/%E5%BA%94%E7%94%A8%E7%A8%8B%E5%BA%8F%E7%BC%96%E7%A8%8B%E6%8E%A5%E5%8F%A3)）方法来访问[数据库管理系统](https://zh.wikipedia.org/wiki/%E6%95%B0%E6%8D%AE%E5%BA%93%E7%AE%A1%E7%90%86%E7%B3%BB%E7%BB%9F)（DBMS）。这些API利用[SQL](https://zh.wikipedia.org/wiki/SQL)来完成其大部分任务。ODBC本身也提供了对SQL语言的支持，用户可以直接将SQL语句送给ODBC。ODBC的设计者们努力使它具有最大的独立性和开放性：与具体的编程语言无关，与具体的数据库系统无关，与具体的操作系统无关。

ODBC可以在`控制面板`--`ODBC`中打开。

<!--more-->

# 基本配置信息

- win 10 ，x64 系统
- O365ProPlusRetail，x64 **体系架构**
- 64和32位的 R 
- MS SQL 2014

# Access

## 报错一

```c
Warning messages:
1: In odbcDriverConnect(con, ...) :
  [RODBC] ERROR: state IM002, code 0, message [Microsoft][ODBC 驱动程序管理器] 未发现数据源名称并且未指定默认驱动程序
2: In odbcDriverConnect(con, ...) : ODBC connection failed
```

这个问题分数据源和默认驱动程序两部分。

### 数据源

在控制面板管理工具中的`ODBC`处——设置 ODBC 数据源。这里分为32位和64位，但是我没有明白明确的区别，不过这个不重要。

随便点开一个可以发现`DSN`和驱动程序。我的电脑上默认的三个数据源都是不能配置的，只能添加和删除。点开添加，发现32位的 ODBC 的驱动程序比较齐全而64位的就仨（因为我装了 SQL）。

### 驱动程序

接上，可以看到驱动程序。我的电脑需要安装一个和office没有保持同一个体系架构的`engine`——Microsoft Access Database Engine 2010 Redistributable。装好后驱动程序就有了，添加后也有了`.accdb`后缀的驱动程序（`driver`）。

注意这里是2010版本的，我曾经尝试过16版本的，failed。如果装了64位的engine，那么会**在64位的 ODBC 中进行添加操作会出现64位的数据源**。当然我们这里是32位。

添加好后，需要在自定义的数据源里选择你要导入的数据库——这也是万老师说的使用 ODBC 的缺点，每次都要设置。没设置的情况尚未测试。

## 报错二

```c
Warning messages:
1: In RODBC::odbcDriverConnect("DSN=hoas") :
  [RODBC] ERROR: state IM014, code 0, message [Microsoft][ODBC 驱动程序管理器] 在指定的 DSN 中，驱动程序和应用程序之间的体系结构不匹配
2: In RODBC::odbcDriverConnect("DSN=hoas") : ODBC connection failed
```

其实按照上述报错一的操作已经么得这个问题了，网上有很多人测试说要用32位的 R ，但是我这里测试后两个都行。至于这个驱动程序和应用程序分别是什么，我不太清楚。老师的意思应该是`engine`就是驱动，因为我装的是32位的驱动，创建了32位的数据源，然后调用成功，**尽管我的 office 和 R 都是64位的**。如果要我强行解释，那么我会说向下兼容……

对了，R 中要设置的好像是工作路径要和数据库一致。

## 读取

这里试了两种最后成功了的方法：

``` c
library(RODBC)
a <- odbcConnect("hoas")
acc <- odbcConnectAccess2007(access.file = "E:/1R/Database1.accdb",uid = "hoas")
# conn <- odbcDriverConnect("Driver={Microsoft Access Driver (*.mdb, *.accdb)};DBQ='E:/1R/Database1.accdb'") 

a
#> RODBC Connection 1
#> Details:
#>   case=nochange
#>   DSN=hoas
#>   DBQ=E:\1R\Database1.accdb
#>   DriverId=25
#>   FIL=MS Access
#>   MaxBufferSize=2048
#>   PageTimeout=5
acc
#> RODBC Connection 2
#> Details:
#>   case=nochange
#>   DBQ=E:\1R\Database1.accdb
#>   Driver={Microsoft Access Driver (*.mdb, *.accdb)}
#>   DriverId=25
#>   FIL=MS Access
#>   MaxBufferSize=2048
#>   PageTimeout=5
#>   UID=admin
sqlFetch(a, "T_Class")
#>    ClassCode ClassName MajorCode
#> 1      61121   生物061    110002
#> 2      71111   食品071    110001
#> 3      71121   生物071    110002
#> 4      71211 计算机071    120001
#> 5      71212 计算机072    120001
#> 6      71221   软件071    120002
#> 7      81221   软件081    120002
#> 8      91105   软件091    120001
#> 9      91109   软件092    120002
#> 10    222222   软件089    120002
sqlFetch(acc, "T_Course")
#>    CourseCode         CourseName Credit    Academy ClassTime LabTime
#> 1      100002           数学分析      3     理学院        32      16
#> 2      100003       空间解析几何      3     理学院        48       0
#> 3      100004       数学专业导论      1     理学院        20      12
#> 4      110001         生物信息学      2   化工学院        32       8
#> 5      110002       分析化学概论      4   化工学院        48      16
#> 6      110003           物理化学      4   化工学院        48      16
#> 7      110006 食品分析与卫生检验      2   化工学院        20      12
#> 8      120001         计算机原理      3 计算机学院        30      19
#> 9      120002   数据库原理及应用      4 计算机学院        32      35
#> 10     120003           软件工程      3 计算机学院        32      17
#> 11     130001           体育舞蹈      2     文学院        20      18
#> 12     130002             武术史      2     文学院        32       0
#> 13     130004       竞技武术理论      2     文学院        32       0
#> 14     130005         伤科推拿学      2     文学院        16      16
#> 15     150001               软件      3     计算机        48      32
#> 16     500001               历史      1     文学院        10       0
#> 17     700003               政治      2   所有学院        20      10
#>    TotalStudent Teacher Description
#> 1           100  王志民          NA
#> 2            80  赵可霞          NA
#> 3           140  毛芝闻          NA
#> 4            60  白瑞欣          NA
#> 5            80    刘洁          NA
#> 6           130    张超          NA
#> 7            70  马建军          NA
#> 8            80    王岚          NA
#> 9           100    李明          NA
#> 10           80  李政道          NA
#> 11           20    杜岚          NA
#> 12           50  石明明          NA
#> 13           70    萧玄          NA
#> 14           15  宋小波          NA
#> 15           NA      黄          NA
#> 16           NA    章立          NA
#> 17           NA    王磊          NA

odbcClose(a)
odbcClose(acc)
```

<sup>Created on 2019-03-28 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)

# MS SQL

这里设置下32位的dBASE files数据源就行了，服务器为`(local)`，然后再添加一个数据库就行了。

``` r
library(RODBC)
a <- odbcConnect("test")
a
#> RODBC Connection 1
#> Details:
#>   case=nochange
#>   DSN=test
#>   UID=
#>   Trusted_Connection=Yes
#>   WSID=HOAS-XYZ-RESCUE
#>   DATABASE=SchoolDB
sqlFetch(a, "dbo.Grade")
#>    StudentCode CourseCode Grade          WriteStamp
#> 1         1101        101  86.0 2010-06-10 10:23:12
#> 2         1101        103  94.0 2010-06-15 08:10:30
#> 3         1101        106  47.0 2011-06-15 09:30:05
#> 4         1102        101  80.0 2010-06-10 10:23:40
#> 5         1102        105  76.0 2011-12-22 10:12:10
#> 6         1103        102  76.0 2011-01-22 22:15:12
#> 7         1103        108  65.0 2011-01-22 21:10:45
#> 8         1103        113    NA 2011-09-02 11:10:15
#> 9         2101        109  58.0 2011-01-22 10:05:20
#> 10        2101        111  70.0 2011-06-15 12:10:13
#> 11        2101        113  84.5 2011-09-02 11:10:10
#> 12        2202        101  88.0 2010-06-10 10:24:20
#> 13        2202        106  67.0 2011-06-15 09:30:30
#> 14        2202        113    NA 2011-09-02 11:11:11
#> 15        2202        115  90.5 2010-12-30 09:40:20
#> 16        3101        112  88.0 2011-06-15 07:30:30
#> 17        3101        114  60.0 2010-12-30 22:30:04
#> 18        3104        101  98.0 2010-06-10 10:24:50
#> 19        3104        105  87.7 2011-12-22 10:12:40
#> 20        3104        107  90.0 2011-06-22 09:20:25
#> 21        4101        111  97.0 2011-06-15 12:10:45
#> 22        4102        103 100.0 2010-06-15 08:10:50
#> 23        4102        106  95.0 2011-06-15 09:31:10
#> 24        4102        113    NA 2011-09-02 11:12:30
#> 25        6101        105  70.0 2011-12-22 10:13:10
#> 26        6101        113    NA 2011-09-02 11:13:05
#> 27        6102        108  65.0 2011-01-22 21:11:20
#> 28        6102        109  55.0 2011-01-22 10:06:10
#> 29        7102        104  80.0 2011-06-19 21:20:35
#> 30        7102        108  78.0 2011-01-22 21:12:01
#> 31        7102        110  60.5 2011-07-10 20:10:44
#> 32        8101        103  90.0 2011-06-15 08:11:00
#> 33        8101        106  88.0 2011-06-15 09:32:50
#> 34        8101        113    NA 2011-09-02 11:13:10
#> 35        8103        115  96.0 2010-12-30 09:41:10
```

<sup>Created on 2019-04-01 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

