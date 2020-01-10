# R语言自然语言处理：中文分词


![NPL](https://i.ytimg.com/vi/fOvTtapxa9c/maxresdefault.jpg)

觉得这个配上词云会很好玩，因为看过[很多篇](https://mp.weixin.qq.com/s/GREbllksFWlC8jdEiJmlkg)有趣的分词+词云的操作了，让我也试一试！

这个时候发现我把自己写了比较长时间的`crawl.R` remove 了……真的是看不懂我自己的操作，如果想写又得再来一遍，我再一次用自己的“实力”证明了这个公式：

> 人笨 + 爱折腾 = 作死

<!--more-->

# 简单分词

``` c
library(pacman)
p_load(jiebaR,reprex)

en = "R is my favorite programming language."
cn = "我想写一本书，名字叫做《R语言高效数据处理》。"
segment(en,worker())
#> [1] "R"           "is"          "my"          "favorite"    "programming"
#> [6] "language"
segment(cn,worker())
#>  [1] "我"       "想"       "写"       "一"       "本书"     "名字"    
#>  [7] "叫做"     "R语言"    "高效"     "数据处理"
show_dictpath()
#> [1] "E:/R-3.5.3/library/jiebaRD/dict"
```

<sup>Created on 2019-03-14 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

这里可以进行很简单的分词操作，**jiebaR**包本来就有一些词典在里面，不过也可以通过上述命令添加。

自定义词典的话看这里：https://mp.weixin.qq.com/s/H6ZKEZhxBprQk8qinIrPww 。

# 词性标注

利用R语言来做词性标注，并利用标注来做命名实体识别。首先需要明确词性标注的概念，就是要把中文分词后的每一个词，确定其性质。是名词？动词？还是形容词？如果是名词，是人名、地名还是机构团体名称？对这些词性进行更为细致的标注，有助于我们对信息进行提取（有的时候动词和形容词其实不包含我们感兴趣的信息，但是名词却非常重要）。此外，也有利于我们了解作者的用词习惯（这个时候，名词又不一定重要了，一个人的行文习惯可以体现在他经常用的动词和形容词）。 因为我们是用**jiebaR**来做分词，根据官方文档说明，它的标注是根据北大《人民日报》语料库进行训练的，最后的标准整理为ICTPOS3.0词性标记集，内容如下：

```c
n 名词
    nr 人名
        nr1 汉语姓氏
        nr2 汉语名字
        nrj 日语人名
        nrf 音译人名
    ns 地名
    　nsf 音译地名
    nt 机构团体名
    nz 其它专名
    nl 名词性惯用语
    ng 名词性语素

t 时间词
　　tg 时间词性语素

s 处所词

f 方位词

v 动词
    vd 副动词
    vn 名动词
    vshi 动词“是”
    vyou 动词“有”
    vf 趋向动词
    vx 形式动词
    vi 不及物动词（内动词）
    vl 动词性惯用语
    vg 动词性语素
a 形容词
    ad 副形词
    an 名形词
    ag 形容词性语素
    al 形容词性惯用语
b 区别词
    bl 区别词性惯用语
z 状态词
r 代词
    rr 人称代词
    rz 指示代词
        rzt 时间指示代词
        rzs 处所指示代词
        rzv 谓词性指示代词
    ry 疑问代词
        ryt 时间疑问代词
        rys 处所疑问代词
        ryv 谓词性疑问代词
    rg 代词性语素
m 数词
    mq 数量词
q 量词
    qv 动量词
    qt 时量词
```

## 实践

我们要做词性标注的输入，既可以是一大段没有经过分词处理字符串，也可以是已经分词完毕的分词结果（也就是字符向量）。我们先介绍第一种情况，就是没有经过分词的大段字符串，要完成分词，然后对每个词都进行词性标注。

### 无分词处理

我们得到的`tag_result`实质上是一个带属性的向量，这样其实不是特别好用。因此我要把它变成数据框的格式，方便以后利用。

``` c
library(pacman)
p_load(jiebaR,tidyverse)

en = "R is my favorite programming language."
cn = "我想写一本书，名字叫做《R语言高效数据处理，然后让我的女朋友学习。"

tag_worker = worker(type = "tag")    #构造分词标注器

tag_result = tagging(cn,tag_worker)   #进行分词标注

tag_result            #查看结果
#>          r          v          v          x          n          n 
#>       "我"       "想"       "写"     "一本"       "书"     "名字" 
#>          v        eng          a          n          c          v 
#>     "叫做"    "R语言"     "高效" "数据处理"     "然后"       "让" 
#>          r         uj          n          v 
#>       "我"       "的"   "女朋友"     "学习"

tag_worker            #查看结果+1
#> Worker Type:  Jieba Segment
#> 
#> Default Method  :  tag
#> Detect Encoding :  TRUE
#> Default Encoding:  UTF-8
#> Keep Symbols    :  FALSE
#> Output Path     :  
#> Write File      :  TRUE
#> By Lines        :  FALSE
#> Max Word Length :  20
#> Max Read Lines  :  1e+05
#> 
#> Fixed Model Components:  
#> 
#> $dict
#> [1] "E:/R-3.5.3/library/jiebaRD/dict/jieba.dict.utf8"
#> 
#> $user
#> [1] "E:/R-3.5.3/library/jiebaRD/dict/user.dict.utf8"
#> 
#> $hmm
#> [1] "E:/R-3.5.3/library/jiebaRD/dict/hmm_model.utf8"
#> 
#> $stop_word
#> NULL
#> 
#> $user_weight
#> [1] "max"
#> 
#> $timestamp
#> [1] 1552566498
#> 
#> $default $detect $encoding $symbol $output $write $lines $bylines can be reset.

str(tag_result)  #查看数据类型
#>  Named chr [1:16] "我" "想" "写" "一本" "书" "名字" "叫做" "R语言" ...
#>  - attr(*, "names")= chr [1:16] "r" "v" "v" "x" ...

enframe(tag_result) -> tag_table  #转换数据存储格式

tag_table
#> # A tibble: 16 x 2
#>    name  value   
#>    <chr> <chr>   
#>  1 r     我      
#>  2 v     想      
#>  3 v     写      
#>  4 x     一本    
#>  5 n     书      
#>  6 n     名字    
#>  7 v     叫做    
#>  8 eng   R语言   
#>  9 a     高效    
#> 10 n     数据处理
#> 11 c     然后    
#> 12 v     让      
#> 13 r     我      
#> 14 uj    的      
#> 15 n     女朋友  
#> 16 v     学习
```

<sup>Created on 2019-03-14 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

### 分词处理

结果和上面一样。

``` c
library(pacman)
p_load(jiebaR,tidyverse)

en = "R is my favorite programming language."
cn = "我想写一本书，名字叫做《R语言高效数据处理，然后让我的女朋友学习。"


tag_worker = worker(type = "tag")    #构造分词标注器

tag_result = tagging(cn,tag_worker)   #进行分词标注

tag_result            #查看结果
#>          r          v          v          x          n          n 
#>       "我"       "想"       "写"     "一本"       "书"     "名字" 
#>          v        eng          a          n          c          v 
#>     "叫做"    "R语言"     "高效" "数据处理"     "然后"       "让" 
#>          r         uj          n          v 
#>       "我"       "的"   "女朋友"     "学习"

seg_cn <- segment(cn,worker())

vector_tag(seg_cn,tag_worker)
#>          r          v          v          x          n          n 
#>       "我"       "想"       "写"     "一本"       "书"     "名字" 
#>          v        eng          a          n          c          v 
#>     "叫做"    "R语言"     "高效" "数据处理"     "然后"       "让" 
#>          r         uj          n          v 
#>       "我"       "的"   "女朋友"     "学习"
```

<sup>Created on 2019-03-14 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

## 命名实体识别

我们识别罕见的南方周刊上一篇关于炫炫的文章[《现场信徒》](http://www.nfpeople.com/article/7329)：

``` c
library(pacman)
p_load(jiebaR, tidyverse,wordcloud2)

tag_worker <- worker(type = "tag")
cn <- "林志炫拥有一副为音乐而生的身体。他的上半身几乎每一个器官都能共鸣，上至额窦，下至小腹。闲暇时，这位土木工程专业出身的理工男热衷于与医生讨论“我的身体还有哪里能共鸣”。多年的训练让他对发声部位的操控越发娴熟，在即将举行的“One Take 2.0”巡回演唱会上，他按照器官共鸣顺序排出歌单，希望把《我是歌手》和《歌手》两季难度最高的歌曲集中到两小时一次唱完。这需要缜密规划，才能在唱完最后一个音符时，每个部位刚好使用到极限。任何形式的“加唱”，都会影响演出效果。
...
苦行僧一般的生活，他甘之如饴，也会将其延续下去，直到命运收回他的嗓子。命运什么时候动手呢？考虑到他已不是第一次撞见幸运，他乐观地想，也许明天，也许永远不会。"
tagging(cn, tag_worker) %>%
  enframe() %>%
  dplyr::filter(name == "n") -> tag_names

tag_names %>%
  count(value) %>% # 对名词进行计数
  arrange(desc(n)) %>% # 降序排列
  wordcloud2(size = 0.8, fontFamily = "宋体", color = "random-light", backgroundColor = "black")
#> # A tibble: 271 x 2
#>    value     n
#>    <chr> <int>
#>  1 音乐     25
#>  2 现场     22
#>  3 歌手     16
#>  4 声音     10
#>  5 专辑     10
#>  6 歌曲      8
#>  7 人        8
#>  8 身体      8
#>  9 时        8
#> 10 唱歌      6
#> # ... with 261 more rows
```

<sup>Created on 2019-03-14 by the [reprex package](https://reprex.tidyverse.org) (v0.2.1)</sup>

![](https://github.com/hoasxyz/mdphotos/raw/master/Terry%20Lin/wc2.png)

实际运用中，想必还是会有很多障碍。大家要记得，在用户自定义词库中，我们是可以给词性进行标注的！也就是我们的词想要识别成什么，我们自己可以说了算。这在垂直领域的运用中，是相当有用的。至于应该如何设置标注，大家可以观察原始词库的格式，然后对文本文件进行修饰。原始文件的位置在哪里？请直接键入`DICTPATH`，你会找到路径，然后用文本格式来查看这个文件即可。然后按照相应格式，来更改用户词典（同一个文件目录下的`user.dict.utf8`）。 我[^n]还是认为，**算法是不可能超越词库的，多在词库下功夫，算法才能够发挥效用**。应该想方设法构建更加优秀的自定义词库，并进行面向业务的精准标注，才能够在实际应用中获得好的效果。

# 更多

关键词提取：https://mp.weixin.qq.com/s/XJk5nEaGENgms-LpkAMjag 。

[^n]: **黄天元**，复旦大学博士在读，目前研究涉及文本挖掘、社交网络分析和机器学习等。希望与大家分享学习经验，推广并加深R语言在业界的应用。

