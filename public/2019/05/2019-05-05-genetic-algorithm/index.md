# Genetic Algorithm


# Genetic algorithm

**遗传算法**（Genetic Algorithm, GA）起源于对生物系统所进行的计算机模拟研究。它是模仿自然界生物进化机制发展起来的随机全局搜索和优化方法，借鉴了达尔文的进化论和孟德尔的遗传学说。其本质是一种高效、并行、全局搜索的方法，能在搜索过程中自动获取和积累有关搜索空间的知识，并自适应地控制搜索过程以求得最佳解。

**遗传算法的多变异性和遗传算子的设计能够有效时遗传算法跳出局部解而找到全局最佳解，并且合适的遗传算子选择设计能够缩短算法运行时间，使算法更加有效**。遗传算法的局限性也相当明显，遗传算法最大的局限就在于算法自身的编码，对于一些问题来说遗传算法的编码过程很复杂，而且遗传算子的设计也是必须要参考到很多现实问题因素。R语言有遗传算法的包，一共两个。一个包叫作**mcga**包；另一个包叫做**genalg**包，下面我们分别使用两个包来求解。

一个非常有趣的故事：[内存中的进化](https://songshuhui.net/archives/10462)。

## Terminology

- 基因型(genotype)：性状染色体的内部表现；

- 表现型(phenotype)：染色体决定的性状的外部表现，或者说，根据基因型形成的个体的外部表现；

- 进化(evolution)：种群逐渐适应生存环境，品质不断得到改良。生物的进化是以种群的形式进行的。

- 适应度(fitness)：度量某个物种对于生存环境的适应程度。

- 选择(selection)：以一定的概率从种群中选择若干个个体。一般，选择过程是一种基于适应度的优胜劣汰的过程。

- 复制(reproduction)：细胞分裂时，遗传物质DNA通过复制而转移到新产生的细胞中，新细胞就继承了旧细胞的基因。

- 交叉(crossover)：两个染色体的某一相同位置处DNA被切断，前后两串分别交叉组合形成两个新的染色体。也称基因重组或杂交；

- 变异(mutation)：复制时可能（很小的概率）产生某些复制差错，变异产生新的染色体，表现出新的性状。

- 编码(coding)：DNA中遗传信息在一个长链上按一定的模式排列。遗传编码可看作从表现型到基因型的映射。

- 解码(decoding)：基因型到表现型的映射。

- 个体(individual)：指染色体带有特征的实体；

- 种群(population)：个体的集合，该集合内个体数称为种群的大小。

遗传算法中每一条染色体，对应着遗传算法的一个解决方案，一般我们用**适应性函数**（fitness function）来衡量这个解决方案的优劣。所以从一个基因组到其解的适应度形成一个映射。可以把遗传算法的过程看作是一个在多元函数里面求最优解的过程。可以这样想象，这个多维曲面里面有数不清的“山峰”，而这些山峰所对应的就是局部最优解。而其中也会有一个“山峰”的海拔最高的，那么这个就是全局最优解。而遗传算法的任务就是尽量爬到最高峰，而不是陷落在一些小山峰。（另外，值得注意的是遗传算法不一定要找“最高的山峰”，如果问题的适应度评价越小越好的话，那么全局最优解就是函数的最小值，对应的，遗传算法所要找的就是“最深的谷底”。）

> 不管袋鼠的黑白肥瘦高矮、不管它们喜欢吃什么食物，[我们](https://blog.csdn.net/u010451580/article/details/51178225)由始至终都只关心一件事情：**袋鼠在哪里**？
>
> 把那些总是原地踏步和爱走下坡路的袋鼠射杀，这就是遗传算法的精粹！

<!--more-->

## 物竞——适应度函数（fitness function）

而对于这个问题，这个衡量的标准比较容易制定：袋鼠所在的海拔高度。（因为你单纯地希望袋鼠爬得越高越好。）所以我们直接用袋鼠的海拔高度作为它们的适应性评分。即适应度函数直接返回函数值就行了。

## 天择——选择函数（selection）

自然界中，越适应的个体就越有可能繁殖后代。但是也不能说适应度越高的就肯定后代越多，只能是从概率上来说更多。（毕竟有些所处海拔高度较低的袋鼠很幸运，逃过了你的眼睛。）那么我们怎么来建立这种概率关系呢？一个方法是通过评分占比来确定。

另外还有别的机制，例如**精英选择机制**。

## Heredity and variation

这两个步骤就是使得子代不同于父代的根本原因（注意，并不是说子代优于父代，只有经过自然的选择后，才会出现子代优于父代的倾向。）。对于这两种遗传操作，二进制编码和浮点型编码在处理上有很大的差异，其中二进制编码的遗传操作过程，比较类似于自然界里面的过程。

#### Recombination/crossover

**基因重组/交叉**（recombination/crossover）发生在减数第一次分裂前期（四分体时期）和减数第一次分裂后期。

1. 二进制编码。和高中所学完全一样。

2. 浮点型编码。 如果一条基因中含有多个浮点数编码，那么也可以用跟上面类似的方法进行基因交叉，不同的是进行交叉的基本单位不是二进制码，而是浮点数。而如果对于单个浮点数的基因交叉，就有其它不同的重组方式了，比如中间重组：随机产生就能得到介于父代基因编码值和母代基因编码值之间的值作为子代基因编码的值。比如5.5和6交叉，产生5.7，5.6。

#### Mutation

任何时候都可能发生**基因突变**（mutation），不过最常见的情况是DNA复制时期，即细胞分裂期间，包括有丝分裂和减数分裂。

1. 二进制编码。几乎一样。
2. 浮点型编码。一般是对原来的浮点数随机增加或者减少一个小随机数。当然，这个小随机数也有大小之分，我们一般管它叫“**步长**”。（想想“袋鼠跳”问题，袋鼠跳的长短就是这个步长。）一般来说步长越大，开始时进化的速度会比较快，但是后来比较难收敛到精确的点上。而小步长却能较精确的收敛到一个点上。所以很多时候为了加快遗传算法的进化速度，而又能保证后期能够比较精确地收敛到最优解上面，会采取**动态改变步长**的方法。这个过程与**模拟退火**过程比较相类似。

为什么说这是使得子代不同于父代的根本原因呢？因为通过编码的变化（**编码意味着袋鼠的海拔高度**），子代袋鼠的海拔高度也在进行相应的变化，而且根据物竞天择，越好的编码越容易被选择从而产生趋向优秀的子代。趋向最优的过程就是编码不断更新换代的过程。

## More

1. 编码原则：

   - 完备性（completeness）：问题空间的所有解都能表示为所设计的基因型；
   - 健全性（soundness）：任何一个基因型都对应于一个可能解；
   - 非冗余性（non-redundancy）：问题空间和表达空间一一对应。

2. 适应度函数

   适应度函数的选取直接影响遗传算法的收敛速度以及能否找到最优解。一般而言，适应度函数是由目标函数变换而成的。若设计不当：

   - 进化初期，个别超常个体控制选择过程；
   - 进化末期，个体差异太小导致陷入局部极值。

   比如，其它山上在半山腰上的袋鼠可能比在珠峰上的高，珠峰上的袋鼠由此被淘汰。

# `mcga::mcga()`

```r
mcga(popsize, chsize, crossprob = 1.0, mutateprob = 0.01, 
	 elitism = 1, minval, maxval, maxiter = 10, evalFunc)
```

| Arguments    | Meaning                                                      |
| ------------ | ------------------------------------------------------------ |
| `popsize`    | Number of chromosomes.<br />个体数量，即染色体个数。         |
| `chsize`     | Number of parameters.<br />基因数量，即限参数数量。          |
| `crossprob`  | Crossover probability. By default it is 1.0<br />基因重组/交叉的可能性。 |
| `mutateprob` | Mutation probability. By default it is 0.01<br />基因突变的概率。 |
| `elitism`    | Number of best chromosomes to be copied directly into next generation. By default it is 1<br />精英数量，直接复制到下一代的染色体数量。 |
| `minval`     | The lower bound of the randomized initial population. This is not a constraint for parameters.<br />随机生成初始种群的下边界值。 |
| `maxval`     | The upper bound of the randomized initial population. This is not a constraint for parameters.<br />随机生成初始种群的上边界值。 |
| `maxiter`    | The maximum number of generations. By default it is 10<br />繁殖次数，即迭代次数。 |
| `evalFunc`   | An R function. By default, each problem is a minimization.<br />适应度函数，用于对个体进行评价。 |

| Values       | Meaning                                                      |
| ------------ | ------------------------------------------------------------ |
| `population` | Sorted population resulted after generations.<br />每（迭）代计算后的结果。 |
| `costs`      | Cost values for each chromosomes in the resulted population.<br />[据说](http://blog.fens.me/algorithm-ga-r/)是每次迭代的计算时间。 |

这个函数一般用来解决无约束问题，就像给出的示例一样。不过这个示例的结果可能因为迭代次数较少，返回的`population`的第一个参数误差太大。

```r
> library(pacman)
> p_load(mcga, GA, foreach, iterators)
> 
> # 1 -----------------------------------------------------------------------
> 
> f1 <- function(x) {
+   return((x[1] - 7)^2 + (x[2] - 77)^2 + (x[3] - 777)^2 + (x[4] - 7777)^2 + (x[5] - 77777)^2)
+ }
> m1 <- mcga(
+   popsize = 200,
+   chsize = 5,
+   minval = 0.0,
+   maxval = 999999999.9,
+   maxiter = 3000,
+   crossprob = 1.0,
+   mutateprob = 0.01,
+   evalFunc = f1
+ )
> 
> cat("Best chromosome:\n")
Best chromosome:
> print(m1$population[1, ])
[1]     6.999907    77.127852   776.999710  7776.996806 77776.999920
> cat("Cost: ", m1$costs[1], "\n")
Cost:  0.01635653 
```

# `mcga::mcga2()`

```r
mcga2(fitness, ..., min, max,
  population = gaControl("real-valued")$population,
  selection = gaControl("real-valued")$selection,
  crossover = byte_crossover, mutation = byte_mutation, popSize = 50,
  pcrossover = 0.8, pmutation = 0.1, elitism = base::max(1, round(popSize
  * 0.05)), maxiter = 100, run = maxiter, maxFitness = Inf,
  names = NULL, parallel = FALSE, monitor = gaMonitor, seed = NULL)
```

| Arguments    | Meaning                                                      |
| ------------ | ------------------------------------------------------------ |
| `fitness`    | The goal function to be maximized                            |
| `...`        | Additional arguments to be passed to the fitness function<br />需要传递给适应度函数的参数。 |
| `min`        | Vector of lower bounds of variables                          |
| `max`        | Vector of upper bounds of variables                          |
| `population` | Initial population. It is `gaControl("real-valued")$population` by default. |
| `selection`  | Selection operator. It is `gaControl("real-valued")$selection` by default. |
| `crossover`  | Crossover operator. It is `byte_crossover` by default.       |
| `mutation`   | Mutation operator. It is `byte_mutation` by default. Other values can be given including `byte_mutation_random`, `byte_mutation_dynamic` and `byte_mutation_random_dynamic` |
| `popSize`    | Population size. It is 50 by default<br />个体数量。         |
| `pcrossover` | Probability of crossover. It is 0.8 by default               |
| `pmutation`  | Probability of mutation. It is 0.1 by default                |
| `elitism`    | Number of elitist solutions. It is `base::max(1, round(popSize*0.05))` by default |
| `maxiter`    | Maximum number of generations. It is 100 by default          |
| `run`        | The genetic search is stopped if the best solution has not any improvements in last `run` generations. By default it is `maxiter` |
| `maxFitness` | Upper bound of the fitness function. By default it is Inf<br />适应度函数上界。 |
| `names`      | Vector of names of the variables. By default it is `NULL`<br />传递给函数的参数的名称。 |
| `parallel`   | If TRUE, fitness calculations are performed parallel. It is FALSE by default<br />666！ |
| `monitor`    | The monitoring function for printing some information about the current state of the genetic search. It is `gaMonitor` by default |
| `seed`       | The seed for random number generating. It is `NULL` by default |

Returns an object of class(数据类型) `ga-class`.

```r
> f3 <- function(x) {
+   return(-sum((x - 5)^2))
+ }
> 
> myga <- mcga2(
+   fitness = f3, popSize = 100, maxiter = 300,
+   min = rep(-50, 5), max = rep(50, 5)
+ )
GA | iter = 1 | Mean = -4284.1308 | Best =  -511.7906
GA | iter = 2 | Mean = -3315.5422 | Best =  -511.7906
......
GA | iter = 299 | Mean = -31.811291118 | Best =  -0.001656911
GA | iter = 300 | Mean = -63.613155382 | Best =  -0.001628129
> 
> print(myga@solution)
           x1       x2      x3       x4       x5
[1,] 5.012699 5.002951 5.00023 4.983183 4.965718
> 
> f3(myga@solution) == myga@fitnessValue
[1] TRUE


> f2 <- function(x) {
+   x * sin(10 * pi * x) - 2
+ }
> 
> m2 <- mcga2(
+   fitness = f2,
+   popSize = 100,
+   maxiter = 300,
+   min = -1,
+   max = 2
+ )
GA | iter = 1 | Mean = -2.0356536 | Best = -0.1686612
GA | iter = 2 | Mean = -1.7556058 | Best = -0.1578063
......
GA | iter = 299 | Mean = -0.1690270 | Best = -0.1497262
GA | iter = 300 | Mean = -0.1747869 | Best = -0.1497262
> 
> print(m2@solution)
           x1
[1,] 1.850547
```

# `genalg::rbga()`

```r
rbga(stringMin=c(), stringMax=c(),
     suggestions=NULL,
     popSize=200, iters=100,
     mutationChance=NA,
     elitism=NA,
     monitorFunc=NULL, evalFunc=NULL,
     showSettings=FALSE, verbose=FALSE)
```

| Arguments        | Meaning                                                      |
| ---------------- | ------------------------------------------------------------ |
| `stringMin`      | vector with minimum values for each gene.                    |
| `stringMax`      | vector with maximum values for each gene.                    |
| `suggestions`    | optional list of suggested chromosomes                       |
| `popSize`        | the population size.                                         |
| `iters`          | the number of iterations.                                    |
| `mutationChance` | the chance that a gene in the chromosome mutates. By default 1/(size+1). It affects the convergence rate and the probing of search space: a low chance results in quicker convergence, while a high chance increases the span of the search space. |
| `elitism`        | the number of chromosomes that are kept into the next generation. By default is about 20% of the population size. |
| `monitorFunc`    | Method run after each generation to allow monitoring of the optimization |
| `evalFunc`       | User supplied method to calculate the evaluation function for the given chromosome |
| `showSettings`   | if true the settings will be printed to screen. By default False. |
| `verbose`        | if true the algorithm will be more verbose. By default False. |

默认为求最小。

```r
rbga(stringMin = c( 30,  4, 20, 15, 0.02, 0.1, 10, 0.1, 0.01, 0.01, 0.980, 0.5, 0.01),
     stringMax = c(150, 60, 50, 60, 0.50, 5.0, 50, 1.5, 0.50, 0.50, 1.000, 1.0, 1.0),
     popSize = 50, iters = 10, mutationChance = 0.05,
     evalFunc = xaj.model.min, verbose = TRUE)
```

