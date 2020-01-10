# Decision Trees and Rules


# Decision trees

第三章依旧是分类，依旧很强大。**决策树**（decision trees）利用**树形结构**（tree structure）对特征和潜在结果之间的关系建立模型。比如要考虑工作机会从**根节点**（root nodes）开始，然后遍历**决策节点**（decision nodes），决策节点要求基于工作的属性做出选择，，这些选择通过用只是决策潜在结果的**分枝**（branches）来划分数据，可以用结果yes或no来描述。尽管在默写案例中，可能不只两种结果，在这种情况下，可以做出最终的决策，决策树在**叶节点**（leaf note, 也称终端节点）终止，业绩点表示因一系列决策而采取的行动。对于预测模型，叶节点提供了决策树中给定系列事件的预期结果。

<center>
<img src="/post/!image/decision_trees.png" alt="decision trees">
</center>

## Divide and conquer

决策树的建立采用一种称为**递归划分**（recursive partitioning）的探索法。这种方法也通常称为分而治之（divide and conquer），因为它将数据分解为子集，然后反复分解成更小的子集，以此类推，直到当算法决定数据内的子集足够均匀或者另一种停止准则已经满足是，该过程才停止。

假设你受雇于好莱坞电影制片厂，拥有可以邀请到许多一线明星的能力。因为业务繁忙你的桌上常常堆放着一沓剧本。你决定研究一个决策树算法来预测一部有潜力的电影是否会落入：

- Critical Success
- Mainstream Hit
- Box Office Bust

<center>
<img src="/post/!image/estimate_buget.png" alt="estimate buget">
</center>

<!--more-->

你可能已经注意到对角线可以更加清晰地划分数据，这是因为决策树算法采用**轴平行**（axis-parallel splits）来表现知识的局限性。每一次分割只考虑一个特征的是是是，可以防止决策树形成更复杂的决策边界。

另外你需要去根据如上图所示的问题进行定量地分区以进行分类，因为没有什么可以阻止决策树进行无限制地分类，但是决策树也不能太宽泛地概括数据。

<center>
<img src="/post/!image/buget_desicion_trees.png" alt="buget decision trees">
</center>

# The C5.0 decision tree algorithm

决策树有很多实现，但最着名的是**C5.0算法**（C5.0 algorithm） 。该算法由计算机科学家J. Ross Quinlan开发，作为其先前算法C4.5的改进版本（C4.5本身是对其迭代二叉树3代（Iterative Dichotomiser 3, ID3）算法的改进）。虽然Quinlan向商业客户销售C5.0，但该算法的单线程版本的源代码已公开，因此已被纳入诸如R等程序中。

## Choosing the best split

决策树面临的第一个挑战就是确定根据那个特征进行分割，前面的示例中我们得到的分区主要包含来源于一个单一类的案例。一个案例自己仅包含单个类的程度称为**纯度**（purity），由单个类构成的任意子集都认为是**纯的**（pure）。

C5.0算法在一个类值集合中使用**熵**（entropy），熵是一个量化随机性或者无序性的信息论中借用的概念，具有高熵值的集合是非常多样化的，且提供的关于坑恩属于这些集合的其他项的信息很少，因为没有明显的共同性。决策树希望找打可以降低熵值的分割，最终增加组内的同质性。

通常情况下熵以**位**（bit）为单位。如果只有两个可能的类，那么熵值的范围为0 ~ 1；对于n个类，熵值的范围为0 ~ $log_{2}(n)$。

熵定义为：

$$
Entropy(S) = \sum_{i=1}^c - p_ilog_2(p_i)
$$

In this formula, for a given segment of data (S), the term c refers to the number of class levels and pi refers to the proportion of values falling into class level i. For example, suppose we have a partition of data with two classes: red (60 percent) and white (40 percent). We can calculate the entropy as follows:

```r
-0.60 * log2(0.60) - 0.40 * log2(0.40)
```

```r
curve(-x * log2(x) - (1 - x) * log2(1 - x),
      col = "red", xlab = "x", ylab = "Entropy", lwd = 4)
```

熵的峰值在0.5时，五五分割导致了最大熵值，当一个类相对其他类越来越占主导地位的时候，熵值会逐渐减小到0。

为了使用熵来确定最优特征以进行分割，决策树计算由每个可能的特征的分割所引起的同质性（均匀性）变化，该计算称为**信息增益**（information gain）。对于特征F：

$$
InfoGain(S_2) = Entropy(S_1) - Entropy(S_2)
$$

~~哎呦，不想打字了，直接上英文吧……~~

One complication is that after a split, the data is divided into more than one partition. Therefore, the function to calculate $Entropy(S_2)$ needs to consider the total entropy across all of the partitions. It does this by weighing each partition's entropy by the proportion of records falling into the partition. This can be stated in a formula as:


$$
Entropy(S\_2) = \sum_{i = 1}^n w_i Entropy(P_i)
$$

In simple terms, the total entropy resulting from a split is the sum of the entropy of each of the n partitions weighted by the proportion of examples falling in the partition ($w_i$).

The higher the information gain, the better a feature is at creating homogeneous groups after a split on this feature. If the information gain is zero, there is no reduction in entropy for splitting on this feature. On the other hand, the maximum information gain is equal to the entropy prior to the split. This would imply that the entropy after the split is zero, which means that the split results in completely homogeneous groups.

## Pruning the decision tree

A decision tree can continue to grow indefinitely, choosing splitting features and dividing the data into smaller and smaller partitions until each example is perfectly classified or the algorithm runs out of features to split on. However, if the tree grows overly large, many of the decisions it makes will be overly specific and the model will be overfitted to the training data. The process of **pruning**(修剪) a decision tree involves reducing its size such that it generalizes better to unseen data.

1. **Early stopping**（提前停止法） or **pre-pruning**（预剪枝法）. This solution is to stop the tree from growing once it reaches a certainnumber of decisions or when the decision nodes contain only a small number of examples. As the tree avoids doing needless work, this is an appealing strategy. However, one downside to this approach is that there is no way to know whether the tree will miss subtle, but important patterns that it would have learned had it grown to a larger size.

2. **Post-pruning**（后剪枝法）. which involves growing a tree that is intentionally too large and pruning leaf nodes to reduce the size of the tree to a more appropriate level. This is often a more effective approach than pre-pruning, because it is quite difficult to determine the optimal depth of a decision tree without growing it first. Pruning the tree later on allows the algorithm to be certain that all the important data structures were discovered.

One of the benefits of the C5.0 algorithm is that it is opinionated about pruning— it takes care of many decisions automatically using fairly reasonable defaults. Its overall strategy is to post-prune the tree. It first grows a large tree that overfits the training data. Later, the nodes and branches that have little effect on the classification errors are removed. In some cases, entire branches are moved further up the tree or replaced by simpler decisions. These processes of grafting branches are known as **subtree raising**（子树提升） and **subtree replacement**（子树替换）, respectively.

# Example

银行通过决策树的方式紧缩贷款体系，并转向机器学习来更准确地识别高风险贷款。

``` r
library(pacman)
p_load(C50, here)

credit <- read.csv("E:/1R/Machine-Learning-with-R-datasets-master/ML/credit.csv")


# prepare -----------------------------------------------------------------

table(credit$checking_balance)
#> 
#>     < 0 DM   > 200 DM 1 - 200 DM    unknown 
#>        274         63        269        394

table(credit$savings_balance)
#> 
#>      < 100 DM     > 1000 DM  101 - 500 DM 501 - 1000 DM       unknown 
#>           603            48           103            63           183

table(credit$default)
#> 
#>   1   2 
#> 700 300

set.seed(122)

train_sample <- sample(1000, 900)

credit_train <- credit[train_sample, ]
credit_test <- credit[-train_sample, ]

prop.table(table(credit_train$default))
#> 
#>         1         2 
#> 0.6966667 0.3033333

# train -------------------------------------------------------------------

credit_model <- C5.0(credit_train[-17], as.factor(credit_train$default))
credit_model
#> 
#> Call:
#> C5.0.default(x = credit_train[-17], y = as.factor(credit_train$default))
#> 
#> Classification Tree
#> Number of samples: 900 
#> Number of predictors: 20 
#> 
#> Tree size: 46 
#> 
#> Non-standard options: attempt to group attributes
summary(credit_model)
#> 
#> Call:
#> C5.0.default(x = credit_train[-17], y = as.factor(credit_train$default))
#> 
#> 
#> C5.0 [Release 2.07 GPL Edition]      Sat May 04 16:15:37 2019
#> -------------------------------
#> 
#> Class specified by attribute `outcome'
#> 
#> Read 900 cases (21 attributes) from undefined.data
#> 
#> Decision tree:
#> 
#> checking_balance = unknown: 1 (351/41)
#> checking_balance in {< 0 DM,> 200 DM,1 - 200 DM}:
#> :...credit_history in {fully repaid,fully repaid this bank}:
#>     :...dependents > 1: 2 (11/1)
#>     :   dependents <= 1:
#>     :   :...savings_balance in {> 1000 DM,501 - 1000 DM,unknown}: 1 (10/1)
#>     :       savings_balance in {< 100 DM,101 - 500 DM}:
#>     :       :...purpose in {business,car (new),domestic appliances,education,
#>     :           :           furniture,others,radio/tv,repairs}: 2 (41/8)
#>     :           purpose in {car (used),retraining}: 1 (5)
#>     credit_history in {critical,delayed,repaid}:
#>     :...months_loan_duration <= 22:
#>         :...other_debtors = guarantor:
#>         :   :...purpose in {business,car (used),domestic appliances,education,
#>         :   :   :           furniture,others,radio/tv,repairs,
#>         :   :   :           retraining}: 1 (24)
#>         :   :   purpose = car (new):
#>         :   :   :...credit_history in {critical,delayed}: 2 (3)
#>         :   :       credit_history = repaid: 1 (2)
#>         :   other_debtors in {co-applicant,none}:
#>         :   :...credit_history in {critical,delayed}: 1 (89/18)
#>         :       credit_history = repaid:
#>         :       :...savings_balance in {> 1000 DM,501 - 1000 DM,
#>         :           :                   unknown}: 1 (42/8)
#>         :           savings_balance = 101 - 500 DM:
#>         :           :...existing_credits > 1: 2 (3)
#>         :           :   existing_credits <= 1:
#>         :           :   :...property in {building society savings,
#>         :           :       :            unknown/none}: 2 (6/1)
#>         :           :       property in {other,real estate}: 1 (8)
#>         :           savings_balance = < 100 DM:
#>         :           :...checking_balance = > 200 DM:
#>         :               :...property in {building society savings,other,
#>         :               :   :            unknown/none}: 1 (8)
#>         :               :   property = real estate:
#>         :               :   :...job = skilled employee: 1 (4/1)
#>         :               :       job in {mangement self-employed,
#>         :               :               unemployed non-resident,
#>         :               :               unskilled resident}: 2 (3)
#>         :               checking_balance = < 0 DM:
#>         :               :...existing_credits > 1: 2 (3)
#>         :               :   existing_credits <= 1:
#>         :               :   :...purpose in {business,domestic appliances,
#>         :               :       :           radio/tv}: 1 (15/5)
#>         :               :       purpose in {car (new),car (used),education,
#>         :               :       :           others,repairs,
#>         :               :       :           retraining}: 2 (22/5)
#>         :               :       purpose = furniture:
#>         :               :       :...months_loan_duration <= 15: 1 (12/2)
#>         :               :           months_loan_duration > 15: [S1]
#>         :               checking_balance = 1 - 200 DM:
#>         :               :...telephone = yes: 1 (12/2)
#>         :                   telephone = none:
#>         :                   :...installment_plan in {bank,stores}: 2 (3)
#>         :                       installment_plan = none:
#>         :                       :...job in {mangement self-employed,
#>         :                           :       unemployed non-resident,
#>         :                           :       unskilled resident}: 1 (10/1)
#>         :                           job = skilled employee:
#>         :                           :...amount <= 2101: 2 (10/2)
#>         :                               amount > 2101: 1 (3)
#>         months_loan_duration > 22:
#>         :...checking_balance = > 200 DM:
#>             :...dependents <= 1: 1 (15/2)
#>             :   dependents > 1: 2 (2)
#>             checking_balance in {< 0 DM,1 - 200 DM}:
#>             :...savings_balance = > 1000 DM: 1 (4/1)
#>                 savings_balance = 501 - 1000 DM: 2 (4/1)
#>                 savings_balance = 101 - 500 DM:
#>                 :...employment_length in {> 7 yrs,4 - 7 yrs,
#>                 :   :                     unemployed}: 1 (14/3)
#>                 :   employment_length in {0 - 1 yrs,1 - 4 yrs}: 2 (13/2)
#>                 savings_balance = unknown:
#>                 :...checking_balance = < 0 DM: 2 (11/2)
#>                 :   checking_balance = 1 - 200 DM: 1 (17)
#>                 savings_balance = < 100 DM:
#>                 :...other_debtors = co-applicant:
#>                     :...employment_length in {> 7 yrs,1 - 4 yrs,
#>                     :   :                     4 - 7 yrs}: 2 (5)
#>                     :   employment_length in {0 - 1 yrs,unemployed}: 1 (3)
#>                     other_debtors = guarantor:
#>                     :...checking_balance = < 0 DM: 1 (7/1)
#>                     :   checking_balance = 1 - 200 DM: 2 (2)
#>                     other_debtors = none:
#>                     :...installment_rate > 2:
#>                         :...residence_history <= 1: 1 (7/2)
#>                         :   residence_history > 1: 2 (58/12)
#>                         installment_rate <= 2:
#>                         :...housing = for free: 1 (6)
#>                             housing in {own,rent}:
#>                             :...dependents > 1: 2 (3)
#>                                 dependents <= 1:
#>                                 :...credit_history = critical: 2 (3)
#>                                     credit_history in {delayed,repaid}:
#>                                     :...telephone = none: 1 (11/3)
#>                                         telephone = yes: 2 (9/3)
#> 
#> SubTree [S1]
#> 
#> employment_length in {0 - 1 yrs,4 - 7 yrs}: 1 (2)
#> employment_length in {> 7 yrs,1 - 4 yrs,unemployed}: 2 (4)
#> 
#> 
#> Evaluation on training data (900 cases):
#> 
#>      Decision Tree   
#>    ----------------  
#>    Size      Errors  
#> 
#>      46  128(14.2%)   <<
#> 
#> 
#>     (a)   (b)    <-classified as
#>    ----  ----
#>     590    37    (a): class 1
#>      91   182    (b): class 2
#> 
#> 
#>  Attribute usage:
#> 
#>  100.00% checking_balance
#>   61.00% credit_history
#>   53.56% months_loan_duration
#>   44.78% savings_balance
#>   44.67% other_debtors
#>   14.44% purpose
#>   12.22% dependents
#>   10.78% installment_rate
#>    8.33% existing_credits
#>    7.22% residence_history
#>    6.44% telephone
#>    4.56% employment_length
#>    3.56% housing
#>    3.33% job
#>    3.22% property
#>    2.89% installment_plan
#>    1.44% amount
#> 
#> 
#> Time: 0.0 secs

# evaluate ----------------------------------------------------------------

credit_pred <- predict(credit_model, credit_test)

library(gmodels)

CrossTable(credit_test$default, credit_pred,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))
#> 
#>  
#>    Cell Contents
#> |-------------------------|
#> |                       N |
#> |         N / Table Total |
#> |-------------------------|
#> 
#>  
#> Total Observations in Table:  100 
#> 
#>  
#>                | predicted default 
#> actual default |         1 |         2 | Row Total | 
#> ---------------|-----------|-----------|-----------|
#>              1 |        61 |        12 |        73 | 
#>                |     0.610 |     0.120 |           | 
#> ---------------|-----------|-----------|-----------|
#>              2 |        11 |        16 |        27 | 
#>                |     0.110 |     0.160 |           | 
#> ---------------|-----------|-----------|-----------|
#>   Column Total |        72 |        28 |       100 | 
#> ---------------|-----------|-----------|-----------|
#> 
#> 

# improve -----------------------------------------------------------------

credit_boost10 <- C5.0(credit_train[-17], as.factor(credit_train$default),
                       trials = 10)
credit_boost10
#> 
#> Call:
#> C5.0.default(x = credit_train[-17], y =
#>  as.factor(credit_train$default), trials = 10)
#> 
#> Classification Tree
#> Number of samples: 900 
#> Number of predictors: 20 
#> 
#> Number of boosting iterations: 10 
#> Average tree size: 42.4 
#> 
#> Non-standard options: attempt to group attributes

summary(credit_boost10)
#> 
#> Call:
#> C5.0.default(x = credit_train[-17], y =
#>  as.factor(credit_train$default), trials = 10)
#> 
#> 
#> C5.0 [Release 2.07 GPL Edition]      Sat May 04 16:15:37 2019
#> -------------------------------
#> 
#> Class specified by attribute `outcome'
#> 
#> Read 900 cases (21 attributes) from undefined.data
#> 
#> -----  Trial 9:  -----
#> 
#> Decision tree:
#> 
#> checking_balance = unknown:
#> :...employment_length in {> 7 yrs,4 - 7 yrs}: 1 (76.4/2.3)
#> :   employment_length in {0 - 1 yrs,1 - 4 yrs,unemployed}:
#> :   :...months_loan_duration <= 24: 1 (115.1/23.5)
#> :       months_loan_duration > 24:
#> :       :...dependents <= 1: 2 (37.4/14.4)
#> :           dependents > 1: 1 (4.3)
#> checking_balance in {< 0 DM,> 200 DM,1 - 200 DM}:
#> :...savings_balance in {> 1000 DM,501 - 1000 DM,unknown}:
#>     :...credit_history in {delayed,fully repaid}: 1 (12.6/2)
#>     :   credit_history in {critical,fully repaid this bank,repaid}:
#>     :   :...amount > 5848: 2 (18.7/6.7)
#>     :       amount <= 5848:
#>     :       :...installment_rate <= 3: 1 (43.3/5.9)
#>     :           installment_rate > 3:
#>     :           :...residence_history <= 3:
#>     :               :...residence_history <= 1: 1 (6)
#>     :               :   residence_history > 1: 2 (29.8/9.1)
#>     :               residence_history > 3:
#>     :               :...months_loan_duration <= 33: 1 (27.6/2.2)
#>     :                   months_loan_duration > 33: 2 (2.3)
#>     savings_balance in {< 100 DM,101 - 500 DM}:
#>     :...months_loan_duration > 47: 2 (26.5/2.3)
#>         months_loan_duration <= 47:
#>         :...purpose in {domestic appliances,education}: 2 (24/8.4)
#>             purpose in {others,repairs,retraining}: 1 (25.8/9.3)
#>             purpose = car (used):
#>             :...amount > 9283: 2 (4.3)
#>             :   amount <= 9283:
#>             :   :...age <= 70: 1 (30.1/2)
#>             :       age > 70: 2 (2.2/0.2)
#>             purpose = business:
#>             :...age > 46: 2 (7)
#>             :   age <= 46:
#>             :   :...savings_balance = 101 - 500 DM: 1 (6.9/0.4)
#>             :       savings_balance = < 100 DM:
#>             :       :...credit_history in {delayed,
#>             :           :                  fully repaid this bank}: 2 (6.1)
#>             :           credit_history in {critical,fully repaid,repaid}:
#>             :           :...age <= 34: 1 (18.5/1.6)
#>             :               age > 34: 2 (10.2/2.6)
#>             purpose = car (new):
#>             :...other_debtors in {co-applicant,guarantor}: 2 (19.4/4.4)
#>             :   other_debtors = none:
#>             :   :...credit_history = critical: 1 (23/8.6)
#>             :       credit_history in {delayed,fully repaid,
#>             :       :                  fully repaid this bank}: 2 (21.1/6.5)
#>             :       credit_history = repaid:
#>             :       :...months_loan_duration > 40: 1 (3)
#>             :           months_loan_duration <= 40:
#>             :           :...personal_status in {divorced male,
#>             :               :                   female}: 2 (22.3/5)
#>             :               personal_status in {married male,
#>             :                                   single male}: 1 (31.3/12.7)
#>             purpose = furniture:
#>             :...other_debtors = guarantor: 1 (6.8)
#>             :   other_debtors in {co-applicant,none}:
#>             :   :...personal_status = married male: 1 (4.6)
#>             :       personal_status in {divorced male,female,single male}:
#>             :       :...months_loan_duration > 27: 2 (11.6)
#>             :           months_loan_duration <= 27:
#>             :           :...job in {mangement self-employed,
#>             :               :       unemployed non-resident}: 2 (14.9/5)
#>             :               job = unskilled resident: 1 (20.6/8.9)
#>             :               job = skilled employee:
#>             :               :...age <= 53: 1 (54.8/20.2)
#>             :                   age > 53: 2 (3.6)
#>             purpose = radio/tv:
#>             :...months_loan_duration > 36: 2 (7.1)
#>                 months_loan_duration <= 36:
#>                 :...other_debtors in {co-applicant,guarantor}: 1 (15.5/2.5)
#>                     other_debtors = none:
#>                     :...employment_length in {> 7 yrs,4 - 7 yrs}: 1 (24.8/4.9)
#>                         employment_length in {0 - 1 yrs,
#>                         :                     unemployed}: 2 (25.9/6.5)
#>                         employment_length = 1 - 4 yrs:
#>                         :...installment_plan = bank: 2 (4)
#>                             installment_plan = stores: 1 (2.5)
#>                             installment_plan = none:
#>                             :...savings_balance = < 100 DM: 1 (30.3/12.5)
#>                                 savings_balance = 101 - 500 DM: 2 (1.8)
#> 
#> 
#> Evaluation on training data (900 cases):
#> 
#> Trial        Decision Tree   
#> -----      ----------------  
#>    Size      Errors  
#> 
#>    0     46  128(14.2%)
#>    1     28  202(22.4%)
#>    2     33  184(20.4%)
#>    3     44  184(20.4%)
#>    4     38  190(21.1%)
#>    5     47  190(21.1%)
#>    6     53  189(21.0%)
#>    7     45  196(21.8%)
#>    8     47  197(21.9%)
#>    9     43  168(18.7%)
#> boost             37( 4.1%)   <<
#> 
#> 
#>     (a)   (b)    <-classified as
#>    ----  ----
#>     625     2    (a): class 1
#>      35   238    (b): class 2
#> 
#> 
#>  Attribute usage:
#> 
#>  100.00% checking_balance
#>  100.00% months_loan_duration
#>  100.00% foreign_worker
#>   99.67% purpose
#>   98.11% amount
#>   97.11% other_debtors
#>   95.00% credit_history
#>   87.00% property
#>   86.44% employment_length
#>   86.44% installment_plan
#>   83.11% dependents
#>   77.33% savings_balance
#>   75.33% installment_rate
#>   74.11% housing
#>   70.00% job
#>   67.11% existing_credits
#>   63.44% age
#>   52.67% personal_status
#>   49.78% residence_history
#>   23.33% telephone
#> 
#> 
#> Time: 0.1 secs

credit_boost_pred10 <- predict(credit_boost10, credit_test)

CrossTable(credit_test$default, credit_boost_pred10,
           prop.chisq = FALSE, prop.c = FALSE, prop.r = FALSE,
           dnn = c('actual default', 'predicted default'))
#> 
#>  
#>    Cell Contents
#> |-------------------------|
#> |                       N |
#> |         N / Table Total |
#> |-------------------------|
#> 
#>  
#> Total Observations in Table:  100 
#> 
#>  
#>                | predicted default 
#> actual default |         1 |         2 | Row Total | 
#> ---------------|-----------|-----------|-----------|
#>              1 |        62 |        11 |        73 | 
#>                |     0.620 |     0.110 |           | 
#> ---------------|-----------|-----------|-----------|
#>              2 |        10 |        17 |        27 | 
#>                |     0.100 |     0.170 |           | 
#> ---------------|-----------|-----------|-----------|
#>   Column Total |        72 |        28 |       100 | 
#> ---------------|-----------|-----------|-----------|
#> 
#> 
```

<sup>Created on 2019-05-04 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>
