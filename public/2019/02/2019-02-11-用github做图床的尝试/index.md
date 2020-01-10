# 用GitHub做图床的尝试

  
  网站的基本建设和美化就到今儿结束了吧！搜索不会添加，好看的css也不会弄……是不是该安慰一下自己，朴素点最好呢？在建设的最后也尝试用GitHub做做图床吧。之前看过[别的做图床的方法](https://www.zhihu.com/question/21065229)，七牛云的不会用，什么都不会用，笨得自己都捉急。想想还是用GitHub吧，确实麻烦点，但是也是有好处的。
  
* 缺点：
  
  - 图片还是得在local一遍再push上去，比较麻烦。
  
  - 有些稍微私密的图片还得付费。
  
* 优点：
  
  - 空间无限。
  
  - 手机腾内存！！
  
  - 链接永久有效。

![林志炫《烟花易冷》](https://github.com/hoasxyz/MarkdownPhotos/blob/master/Terry%20Lin/%E7%83%9F%E8%8A%B1%E6%98%93%E5%86%B7.jpg?raw=true)
<!--more-->

## git-bash&git-cmd

  如果安装了Git For Windows，那么安装目录下会有这两个exe

  - git-bash.exe

  - git-cmd.exe

  顾名思义，bash是linux风格的命令行，路径也是linux式的，可以使用windows和linux的命令；cmd是windows风格的命令行，可以使用windows命令。此外，还有一个最大的不同点，git-cmd是天生就带了系统的PATH环境变量，这一点会导致如果你运行某些脚本的时候，如果依赖某些安装的程序，如python、node这些，git-bash就会提示不存在对应的命令，而git-cmd可以正确运行。git中的bash是在cmd的之前基础上增添一些新的命令与功能，保留了cmd的命令和功能，所以更加推荐使用bash
  
  所以基本上是通过git-cmd完成的以下操作。在cmd里所有的操作在git-bash中都可以执行，因此本质上来说：git bash是一个封装过的cmd命令行，并在其中加入了指向bash环境的环境变量。因此cmd命令行本身的环境变量它也有，自然就能使用dos命令了。但是在封装的过程中，windows可能对调用自己cmd命令行控件的第三方应用设了限制，所以说是大部分可以用的……吧？
  
## repo

  之前不知道那些命令是干嘛的，自从在hugo中用到了cmd……
  
```cmd
E:\1R\mdphotos>echo "# MarkdownPhotos" >> README.md

E:\1R\mdphotos>git init
Initialized empty Git repository in E:/1R/mdphotos/.git/

E:\1R\mdphotos>git add README.md

E:\1R\mdphotos>git commit -m "first commit"
[master (root-commit) d675236] first commit
 1 file changed, 1 insertion(+)
 create mode 100644 README.md

E:\1R\mdphotos>git remote add origin https://github.com/hoasxyz/MarkdownPhotos.git

E:\1R\mdphotos>git push -u origin master
fatal: unable to access 'https://github.com/hoasxyz/MarkdownPhotos.git/': error setting certificate verify locations:
  CAfile: E:/!Learning_R_is_awesome!/Git/mingw64/ssl/certs/ca-bundle.crt
  CApath: none
```
  哦豁又出错了，[这里](https://blog.csdn.net/sdhongjun/article/details/52144253)找到了答案，我还是在cmd中用的。
  
```cmd
E:\1R\mdphotos>git config --system http.sslcainfo "E:\1R\Git\mingw64\ssl\certs\ca-bundle.crt"

E:\1R\mdphotos>git push -u origin master
Enumerating objects: 6, done.
Counting objects: 100% (6/6), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (6/6), 457 bytes | 228.00 KiB/s, done.
Total 6 (delta 0), reused 0 (delta 0)
To https://github.com/hoasxyz/MarkdownPhotos.git
 * [new branch]      master -> master
Branch 'master' set up to track remote branch 'master' from 'origin'.
```

  上图就是在repo中引用的链接~