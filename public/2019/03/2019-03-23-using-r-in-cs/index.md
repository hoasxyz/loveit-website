# C#调用R


很多时候都不能避免不尽人意，这个时候不要轻易恋战，到了不得不改变策略的时候，不要再去纠结……

我不是很喜欢C系列的语言，虽然只上过俩。C# 可以创建窗体运用，这是很好的，是 R 所没有的能力。另外，R 的可视化能力是 C# 不能比的。我想结合它们的优点，但又是毫无成果地失败了。

感觉自己很长时间来一直在打败仗，心态优点崩，似乎很多事情能不能搞定也不是我能决定的。但是至少我想去获得更多，尽管碰到了许多死胡同。所以我应该如何去权衡这两个的利害？这个问题如同我遇到的死胡同一样，没人告诉我……

<!--more-->

# 希望

四年前的一篇[文章](https://www.cnblogs.com/smilejian/p/4750235.html)吸引了我的目光，让我认为达到上述结合两者有点的目的很简单：你只需要在 C# 项目中添加`R.Net`引用，再调用`R.Net`代码就可以完美解决。这样，就可以稍稍多点功夫就可以抛弃繁重的 C# 语法。然后就“自然而然”地失败了。

在接下来的尝试中，我发现似乎并不需要修改（因为没有一篇我搜索到的文章提及）visual studio，只用在解决方案管理器的引用中的管理 NuGet 中添加`R.Net`。

在那篇文章的索引里，有一篇文章讲了两种调用方法，第一种我去找的时候已经物是人非，第二种……

# 错误

我遇到的问题很多人都不感兴趣。说白了就是我没有找到一个比较符合我所在情况的教程或者记录的文章。如果有大多都是我看不懂的。

> `System.NullReferenceException`:“未将对象引用设置到对象的实例。”

这个问题有许多因素的，有人归纳地比较全面但是仍然没有解决我的问题：

- https://blog.csdn.net/u010926964/article/details/41748063
- https://blog.csdn.net/lsaejn/article/details/78499774
- https://www.cnblogs.com/cyq1162/archive/2011/07/24/2115388.html

然后这里还有`R.Net`的不全面的指导：http://jmp75.github.io/rdotnet/index.html

# 可能的解决方案

我貌似遇到了很多人都遇到的问题：

1. https://stackoverflow.com/questions/49983252/how-to-solve-rdotnet-rengine-nullreference-exception
2. https://blog.csdn.net/cyb6100300115/article/details/12835819
3. https://coders-corner.net/2015/11/01/use-r-in-c/ （这里给出了另一种比较新的写法，然并卵）
4. https://stackoverflow.com/questions/19725649/i-am-trying-to-make-rdotnet-work-with-c-and-i-am-encountering-problems
5. https://stackoverflow.com/questions/49983252/how-to-solve-rdotnet-rengine-nullreference-exception

不过上述网站中有人解决了这个问题（甚至还有的没遇到过……）——**降低 R 的版本**。

于是这次我遇到的问题就变成了：

> 你是否愿意重装一个低版本的 R 去**尝试**在 C# 中的调用？

