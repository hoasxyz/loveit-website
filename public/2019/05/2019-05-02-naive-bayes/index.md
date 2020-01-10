# Naive Bayes


# Bayes’ theorem

这是一种和天气预报大致相同的概念方法。托马斯·贝叶斯（Thomas Bayes）发明了用来描述时间的概率以及如何根据附加信息修正概率的基本原则，这些原则构成了现在称为的**贝叶斯方法**（Bayesian methods）的基础。

基于贝叶斯方法的分类器是利用训练数据并根据特征取值提供的证据来计算每一个结果被观察到的概率。

**独立事件**（independent event）同时发生的概率等于它们各自概率的乘积，但是**相关事件**（dependent event）却没有这么简单。相关事件之间的关系可以用贝叶斯定理（Bayes’ theorem）来描述。如下式，**条件概率**（conditional probability）：
$$
p(A|B)=\frac{P(A\bigcap B)}{P(B)}=\frac{P(B|A)P(A)}{P(B)}
$$
<center>
<img src="/post/!image/Bayes1.jpg" alt="Bayes' theorem">
</center>

<!--more-->

# Naive Bayes

**朴素贝叶斯**（Naive Bayes）算法描述了一种将贝叶斯定理应用于分类问题的简单方法。

- 朴素贝叶斯分类

如果事件增加了Venn图的复杂性，那么可以利用朴素贝叶斯中的事件独立性的假设，假设**类条件独立**（class-conditional independence），这意味着只要事件受限于相同的类值，那么这些事件就是相互独立的。

- 拉普拉斯估计

本质上拉普拉斯估计是给频率表中的每一个计数加上一个较小的数，这样就保证每类中的每个特征发生的概率非零（别忘了分母也要加！）通常加上的数值为1。

- 朴素贝叶斯算法中使用数值特征

由于数值特征没有类别值，一个简单有效的方法就是将数值**离散化**（discretize），这就意味着将数值分到不同的分段（bin）中。基于这个原因，离散化有时也叫做分段（Binning）。最常用的分段方法就是探索用于自然分类的数据或者数据中分布的分割点（cut point）。

# Filtering mobile phone spam

仍然是一个识别的方法。不过既然这里涉及到了文本处理，因此数据的清洗和处理会占据相当大的工作量——当然是相对于朴素贝叶斯分类来说的。

``` r
library(pacman)
p_load(tm, magrittr, tidyverse, SnowballC, wordcloud, e1071, gmodels)

Sys.setlocale("LC_ALL", "English")
#> [1] "LC_COLLATE=English_United States.1252;LC_CTYPE=English_United States.1252;LC_MONETARY=English_United States.1252;LC_NUMERIC=C;LC_TIME=English_United States.1252"

sms_raw <- read.csv("E:\\1R\\Machine-Learning-with-R-datasets-master\\ML\\sms_spam.csv",
                    stringsAsFactors = FALSE)

# str(sms_raw)

sms_raw$type <- factor(sms_raw$type)

table(sms_raw$type)
#> 
#>  ham spam 
#> 4827  747

sms_corpus <- VCorpus(VectorSource(sms_raw$text))

# lapply(sms_corpus[1:2], as.character)

sms_corpus_clean <- tm_map(sms_corpus, content_transformer(tolower)) %>%
  tm_map(removeNumbers) %>%
  tm_map(removeWords, stopwords()) %>%
  tm_map(removePunctuation) %>%
  tm_map(stemDocument) %>%
  tm_map(stripWhitespace)

# replacePunctuation <- function(x) {
#   gsub("[[:punct:]]+", " ", x)
# }

sms_dtm <- DocumentTermMatrix(sms_corpus_clean)

# sms_dtm2 <- DocumentTermMatrix(sms_corpus, control = list(
#   tolower = TRUE,
#   removeNumbers = TRUE,
#   stopwords = TRUE,
#   removePunctuation = TRUE,
#   stemming = TRUE
# ))

# stopwords = function(x) { removeWords(x, stopwords()) }

sms_dtm_train <- sms_dtm[1:4169, ]
sms_dtm_test <- sms_dtm[4170:5574, ]

sms_train_labels <- sms_raw[1:4169, ]$type
sms_test_labels <- sms_raw[4170:5574, ]$type

# wordcloud(sms_corpus_clean, min.freq = 50, random.order = FALSE)

spam <- subset(sms_raw, type == "spam")
ham <- subset(sms_raw, type == "ham")

# wordcloud(spam$text, max.words = 40, scale = c(3, 0.5))
# wordcloud(ham$text, max.words = 40, scale = c(3, 0.5))

findFreqTerms(sms_dtm_train, 5) -> sms_freq_words

# str(sms_freq_words)

sms_dtm_freq_train<- sms_dtm_train[ , sms_freq_words]
sms_dtm_freq_test <- sms_dtm_test[ , sms_freq_words]

convert_counts <- function(x) {
  x <- ifelse(x > 0, "Yes", "No")
}

sms_train <- apply(sms_dtm_freq_train, MARGIN = 2,
                   convert_counts)
sms_test <- apply(sms_dtm_freq_test, MARGIN = 2,
                    convert_counts)

# 1 -----------------------------------------------------------------------

sms_classifier <- naiveBayes(sms_train, sms_train_labels)

sms_test_pred <- predict(sms_classifier, sms_test)

CrossTable(sms_test_pred, sms_test_labels,
           prop.chisq = FALSE, prop.t = FALSE,
           dnn = c('predicted', 'actual'))
#> 
#>  
#>    Cell Contents
#> |-------------------------|
#> |                       N |
#> |           N / Row Total |
#> |           N / Col Total |
#> |-------------------------|
#> 
#>  
#> Total Observations in Table:  1405 
#> 
#>  
#>              | actual 
#>    predicted |       ham |      spam | Row Total | 
#> -------------|-----------|-----------|-----------|
#>          ham |      1213 |        20 |      1233 | 
#>              |     0.984 |     0.016 |     0.878 | 
#>              |     0.993 |     0.109 |           | 
#> -------------|-----------|-----------|-----------|
#>         spam |         9 |       163 |       172 | 
#>              |     0.052 |     0.948 |     0.122 | 
#>              |     0.007 |     0.891 |           | 
#> -------------|-----------|-----------|-----------|
#> Column Total |      1222 |       183 |      1405 | 
#>              |     0.870 |     0.130 |           | 
#> -------------|-----------|-----------|-----------|
#> 
#> 

# 2 -----------------------------------------------------------------------

sms_classifier2 <- naiveBayes(sms_train, sms_train_labels,
                              laplace = 1)

sms_test_pred2 <- predict(sms_classifier2, sms_test)

CrossTable(sms_test_pred2, sms_test_labels,
           prop.chisq = FALSE, prop.t = FALSE, prop.r = FALSE,
           dnn = c('predicted', 'actual'))
#> 
#>  
#>    Cell Contents
#> |-------------------------|
#> |                       N |
#> |           N / Col Total |
#> |-------------------------|
#> 
#>  
#> Total Observations in Table:  1405 
#> 
#>  
#>              | actual 
#>    predicted |       ham |      spam | Row Total | 
#> -------------|-----------|-----------|-----------|
#>          ham |      1215 |        28 |      1243 | 
#>              |     0.994 |     0.153 |           | 
#> -------------|-----------|-----------|-----------|
#>         spam |         7 |       155 |       162 | 
#>              |     0.006 |     0.847 |           | 
#> -------------|-----------|-----------|-----------|
#> Column Total |      1222 |       183 |      1405 | 
#>              |     0.870 |     0.130 |           | 
#> -------------|-----------|-----------|-----------|
#> 
#> 
```

<sup>Created on 2019-05-02 by the [reprex package](https://reprex.tidyverse.org)0.2.1")\`)</sup>

代码涉及多种文本处理，包括创建**语料库**（corpus）、简化单词（hello、HELLO、Hello!）、**停用词**（stop word, `tm::stopwords()`）处理、创建**文档-单词矩阵**（Document Term Matrix, DTM, or TDM），由于单词在行的出现次数很少，因此可以认为是**稀疏矩阵**（sparse matrix）。

为了适当调节模型的性能，可以在`naiveBayes()`中设置`laplace = 1`。

这里的例子是离散化的字符形式，没有涉及到数值的分段。

# More

## `klaR::NaiveBayes()`