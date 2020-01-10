# k-NN


# Machine Learning

如果机器能够获取经验并且能够利用它们，在以后的类似经验中能够提高它的表现，这就称为**机器学习**。机器学习是使用数据对模型进行训练，让它针对某种性能指标形成决策。

机器学习的研究领域是发明计算机算法，把数据转化为智能行动。是[人工智能](https://zh.wikipedia.org/wiki/%E4%BA%BA%E5%B7%A5%E6%99%BA%E8%83%BD)的一个分支。人工智能的研究历史有着一条从以“[推理](https://zh.wikipedia.org/wiki/%E6%8E%A8%E7%90%86)”为重点，到以“[知识](https://zh.wikipedia.org/wiki/%E7%9F%A5%E8%AF%86)”为重点，再到以“[学习](https://zh.wikipedia.org/wiki/%E5%AD%A6%E4%B9%A0)”为重点的自然、清晰的脉络。显然，机器学习是实现人工智能的一个途径，即以机器学习为手段解决人工智能中的问题。机器学习是许多学科的综合，更是这些综合的代名词，目前尚未出现机器学习的准确定义。

计算机利用**模型**来概括存储的原始数据。**数据存储**更偏向记忆存储，利用观测值和提供**推理**的依据。

用模型来拟合数据集的过程称为**训练**。当模型被训练后，数据就转换为一中汇总了原始信息的抽象形式。

**预测模型**是指利用数据集中的其他数值来预测另一个值，**有监督学习**是指训练一个预测模型的过程。监督说白了就是给出一组数据，有监督学习算法尝试最优化一个函数（模型）来找出属性值之间的组合方式，最终据此给出目标值。

- 常见的有监督学习任务是预测案例属于哪一个类别，称为**分类**。在分类中，被预测的目标特征是一个称为**类**（class，近似R中的factor）的分类特征，他可以被分为不同的类别，这些类别称为**水平**（level，近似R中的level）。

- 除此之外有监督学习算法还可以预测数值数据，称为**数值预测模型**。

**描述性模型**通过新而有趣的方式总结数据并获得洞察，学习任务从这些洞察中获益。因为描述性模型没有学习目标，所以训练该类模型称为**无监督学习**。

- 称为**模式发现**的描述性模型任务用来识别数据之间联系的紧密性。比如模式发现对零售商的交易购买数据进行**购物篮分析**，用来改进商场销售策略。
- 描述性模型中把数据集按照类型分组的任务称为**聚类**。有时候用作**细分分析**，即识别具有类似行为或者人口统计信息的人群，使得广告活动能够针对目标受众。

最后，**元学习**（meta-learner）的机器学习算法不与具体学习任务相关联，而是专注于学习如何更有效。元学习算法应用于某些学习的结果来指示其它的学习。

<!--more-->

# Lazy Learning

当你在一个完全黑暗的餐厅里用餐时，你的视觉感官被除去了，你可以在增强味觉和嗅觉的基础上使用一种全新的方式去感受食物的美味。

食物尝起来味道如何？这是一个探索的过程，如果一个食物闻起来像只鸭子，并且吃起来也想只鸭子，那么你很可能在吃鸭子。

**近邻分析器**就是把无标记的案例归类为与它们最相似的带有标记的案例所在的类。

- 如果一个概念很难定义，但是当你看到它时你知道它是什么，那么近邻分类可能就是合适的方法；

- 如果数据是噪声数据，组与组之间没有明确的界限，那么近邻算法很难确定其边界。

# $k$-Nearest Neighbor, $k$NN

$k$NN算法采用**欧氏距离**，使用数据时，通常把特征的度量（类）标准化，因为美食家们研究过，甜度（sweetness）和脆度（crunchiness）的度量大致都是在1~10范围内，而辛辣度（spiciness）如果用史高维尔指标衡量的话，可以从0（完全不辣）到超过100万（最辣）。

1. **min-max标准化**(min-max normalization)：原始值到原始最小值的距离有多远。

$$
X_{new} = \frac{X-min(X)}{max(X)-min(X)}
$$



2. **z-分数标准化**（z-score standardization)。

$$
X_{new} = \frac{X-\mu}{\sigma}
$$

欧氏距离不是为**名义数据**定义的，如果要计算名义特征之间的距离，常常将它们转化为数值型格式。一中典型的解决方法就是**哑变量编码**（dummy coding）。一个具有n个类别的名义特征可以通过对特征（n-1）个水平创建二元指示变量来进行哑变量编码。

如果名义特征是有序的，那么也可以对类别编号并且应用min-max标准化（0,0.5,1)。需要注意的是只有当类别之间的步长相等时才可以使用该方法。

由于**懒惰学习**（lazy learning）并不是在学习什么，而仅仅是一字不差地存储训练数据，这样训练阶段并不是实际训练什么，所以就会很快；但是进行预测的过程相对于训练往往会变得很慢，因为懒惰学习高度依赖于训练实例而不是一个抽象的模型，所以又被称为基于实例的学习（instance-based learning）或者机械学习（rote learning）。

由于该算法不会建立一个模型，因此该方法被归类为非参数（non-parametric）学习方法。

## Diagnosing breast cancer

但其实在使用R的过程中顾不上这些，因为R包本身就是模型，你只需要知道输入和输出就可以了。

需要注意的是对数据的处理，首先要做好factor的levels分类。然后用前469个数据作为训练数据集，剩下的100个数据作为测试数据集。采用min-max标准化数值数据。

由第一次分类出的数据可以得知，左上角单元格表示**真阴性**（true negative）结果；右下角表示**真阳性**（true positive）结果，表示分类器和临床确定的标签一致认为肿块是恶性的情形。左下角表示**假阴性**（false negative）的结果，这种情况下预测值是良性的，但却是恶性的；而右上角相反，表示假阳性（false positive）的结果。

``` r
library(pacman)
p_load(class, gmodels, magrittr, tidyverse)

# 1 -----------------------------------------------------------------------

wbcd <- read.csv("E:\\1R\\Machine-Learning-with-R-datasets-master\\ML\\wisc_bc_data.csv") %>%
  select(-1)

table(wbcd$diagnosis)
#> 
#>   B   M 
#> 357 212

wbcd$diagnosis <- factor(wbcd$diagnosis, levels = c("B", "M"),
                         labels = c("Benign", "Malignant"))

round(prop.table(table(wbcd$diagnosis))*100, digits = 1)
#> 
#>    Benign Malignant 
#>      62.7      37.3

summary(wbcd[c("radius_mean", "area_mean", "smoothness_mean")])
#>   radius_mean       area_mean      smoothness_mean  
#>  Min.   : 6.981   Min.   : 143.5   Min.   :0.05263  
#>  1st Qu.:11.700   1st Qu.: 420.3   1st Qu.:0.08637  
#>  Median :13.370   Median : 551.1   Median :0.09587  
#>  Mean   :14.127   Mean   : 654.9   Mean   :0.09636  
#>  3rd Qu.:15.780   3rd Qu.: 782.7   3rd Qu.:0.10530  
#>  Max.   :28.110   Max.   :2501.0   Max.   :0.16340

normalize <- function(x){
  return((x-min(x))/(max(x)-min(x)))
}

wbcd_n <- as.data.frame(lapply(wbcd[2:31], normalize))

summary(wbcd_n$area_mean)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>  0.0000  0.1174  0.1729  0.2169  0.2711  1.0000

wbcd_train <- wbcd_n[1:469, ]
wbcd_test <- wbcd_n[470:569, ]

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

wbcd_test_pred <- knn(train = wbcd_train, test = wbcd_test,
                      cl = wbcd_train_labels, k = 21)

CrossTable(x = wbcd_test_labels, y = wbcd_test_pred,
           prop.chisq = FALSE)
#> 
#>  
#>    Cell Contents
#> |-------------------------|
#> |                       N |
#> |           N / Row Total |
#> |           N / Col Total |
#> |         N / Table Total |
#> |-------------------------|
#> 
#>  
#> Total Observations in Table:  100 
#> 
#>  
#>                  | wbcd_test_pred 
#> wbcd_test_labels |    Benign | Malignant | Row Total | 
#> -----------------|-----------|-----------|-----------|
#>           Benign |        77 |         0 |        77 | 
#>                  |     1.000 |     0.000 |     0.770 | 
#>                  |     0.975 |     0.000 |           | 
#>                  |     0.770 |     0.000 |           | 
#> -----------------|-----------|-----------|-----------|
#>        Malignant |         2 |        21 |        23 | 
#>                  |     0.087 |     0.913 |     0.230 | 
#>                  |     0.025 |     1.000 |           | 
#>                  |     0.020 |     0.210 |           | 
#> -----------------|-----------|-----------|-----------|
#>     Column Total |        79 |        21 |       100 | 
#>                  |     0.790 |     0.210 |           | 
#> -----------------|-----------|-----------|-----------|
#> 
#> 

# 2 -----------------------------------------------------------------------

wbcd_z <- as.data.frame(scale(wbcd[-1]))

summary(wbcd_z$area_mean)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#> -1.4532 -0.6666 -0.2949  0.0000  0.3632  5.2459

wbcd_train_z <- wbcd_z[1:469, ]
wbcd_test_z <- wbcd_z[470:569, ]

wbcd_train_labels <- wbcd[1:469, 1]
wbcd_test_labels <- wbcd[470:569, 1]

wbcd_test_pred_z <- knn(train = wbcd_train_z, test = wbcd_test_z,
                        cl = wbcd_train_labels, k = 21)

CrossTable(x = wbcd_test_labels, y = wbcd_test_pred_z,
           prop.chisq = FALSE)
#> 
#>  
#>    Cell Contents
#> |-------------------------|
#> |                       N |
#> |           N / Row Total |
#> |           N / Col Total |
#> |         N / Table Total |
#> |-------------------------|
#> 
#>  
#> Total Observations in Table:  100 
#> 
#>  
#>                  | wbcd_test_pred_z 
#> wbcd_test_labels |    Benign | Malignant | Row Total | 
#> -----------------|-----------|-----------|-----------|
#>           Benign |        77 |         0 |        77 | 
#>                  |     1.000 |     0.000 |     0.770 | 
#>                  |     0.975 |     0.000 |           | 
#>                  |     0.770 |     0.000 |           | 
#> -----------------|-----------|-----------|-----------|
#>        Malignant |         2 |        21 |        23 | 
#>                  |     0.087 |     0.913 |     0.230 | 
#>                  |     0.025 |     1.000 |           | 
#>                  |     0.020 |     0.210 |           | 
#> -----------------|-----------|-----------|-----------|
#>     Column Total |        79 |        21 |       100 | 
#>                  |     0.790 |     0.210 |           | 
#> -----------------|-----------|-----------|-----------|
#> 
#> 

# table(actual = wbcd_test_labels, predictedclass = wbcd_test_pred_z)

# 3 -----------------------------------------------------------------------

wbcd_test_pred_z <- knn(train = wbcd_train_z, test = wbcd_test_z,
                        cl = wbcd_train_labels, k = 20)

CrossTable(x = wbcd_test_labels, y = wbcd_test_pred_z,
           prop.chisq = FALSE)
#> 
#>  
#>    Cell Contents
#> |-------------------------|
#> |                       N |
#> |           N / Row Total |
#> |           N / Col Total |
#> |         N / Table Total |
#> |-------------------------|
#> 
#>  
#> Total Observations in Table:  100 
#> 
#>  
#>                  | wbcd_test_pred_z 
#> wbcd_test_labels |    Benign | Malignant | Row Total | 
#> -----------------|-----------|-----------|-----------|
#>           Benign |        77 |         0 |        77 | 
#>                  |     1.000 |     0.000 |     0.770 | 
#>                  |     0.975 |     0.000 |           | 
#>                  |     0.770 |     0.000 |           | 
#> -----------------|-----------|-----------|-----------|
#>        Malignant |         2 |        21 |        23 | 
#>                  |     0.087 |     0.913 |     0.230 | 
#>                  |     0.025 |     1.000 |           | 
#>                  |     0.020 |     0.210 |           | 
#> -----------------|-----------|-----------|-----------|
#>     Column Total |        79 |        21 |       100 | 
#>                  |     0.790 |     0.210 |           | 
#> -----------------|-----------|-----------|-----------|
#> 
#> 
```

<sup>Created on 2019-05-01 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

随后根据z-分数标准化进行训练和测试，竟然结果和min-max一样……不过你可以通过改变k值来优化性能，一般k值取数据长度的开平方。

# More $k$-NN

## `kknn::kknn()`

## `caret::train()`

