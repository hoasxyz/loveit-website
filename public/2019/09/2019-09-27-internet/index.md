# Internet


冷战期间，美苏两大超级大国的各种科技和军备竞赛，导致各大核武库均具有毁灭地球多次的可怕能力，同时也快速推动着科技的发展，特别是计算机及相关技术的极速发展，互联网的雏形在美国出现了。但是互联网如果需要继续发展，那么第一个根本要点就是如何解决不同的电脑接入同一个系统的问题。为了解决这个问题，1972 年国际互联网工作组（INWG）开始组织起草了 TELNET 协议，并于 1973 年和 1974 年分别制定了 FTP 文件传输协议和 TCP 传输控制协议。有了这三个基本的接入标准，就为日后互联网的爆发奠定了基础，因为所有的电脑都可以按照统一的标准接入互联网。

但是大量接入的电脑互相之间该如何通讯呢？这就需要给每台接入的电脑设置一个门牌号，大家都互有门牌号，你只要知道对方的门牌号，然后将信息按照统一的格式打包成数据包，并按照统一的交换标准进行数据传输。这个门牌号，我们叫 IP 地址[^1]，这是在 1983 年确立的 TCP/IP 协议，有了这个协议标准终于引爆了现代互联网时代。

[^1]:**互联网协议地址**（英语：Internet Protocol Address，又译为**网际协议地址**），缩写为**IP地址**（英语：IP Address），是分配给[网络](https://zh.wikipedia.org/wiki/網路)上使用[网际协议](https://zh.wikipedia.org/wiki/網際協議)（英语：Internet Protocol, IP）的设备的数字标签。常见的IP地址分为[IPv4](https://zh.wikipedia.org/wiki/IPv4)与[IPv6](https://zh.wikipedia.org/wiki/IPv6)两大类，但是也有其他不常用的小分类。

![networks](https://073bddbe7aa062defd37fde3-cwzdvdpfea.netdna-ssl.com/wp-content/uploads/2017/05/cloud-computing-logistics-2017-1000x640.jpg)

<!--more-->

# Domain Name

**网域名称**（英语：Domain Name，简称：Domain），简称**域名**、**网域**，是由一串用点分隔的字符组成的[互联网](https://zh.wikipedia.org/wiki/互联网)上某一台[计算机](https://zh.wikipedia.org/wiki/電子計算機)或计算机组的名称，用于在数据传输时标识计算机的电子方位。域名可以说是一个[IP地址](https://zh.wikipedia.org/wiki/IP地址)的代称，目的是为了便于记忆后者。例如，`wikipedia.org`是一个域名，和[IP地址](https://zh.wikipedia.org/wiki/IP地址)`208.80.152.2`相对应。人们可以直接访问`wikipedia.org`来代替IP地址，然后[域名系统](https://zh.wikipedia.org/wiki/域名系统)（DNS）就会将它转化成便于机器识别的IP地址。这样，人们只需要记忆`wikipedia.org`这一串带有特殊含义的字符，而不需要记忆没有含义的数字。

域名的核心是[域名系统](https://zh.wikipedia.org/wiki/域名系统)[^3]（英语：Domain Name System，[缩写](https://zh.wikipedia.org/wiki/缩写)：DNS），域名系统中的任何名称都是域名。在域名系统的层次结构中，各种域名都隶属于域名系统根域的下级。域名的第一级是[顶级域](https://zh.wikipedia.org/wiki/頂級域)，它包括[通用顶级域](https://zh.wikipedia.org/wiki/通用頂級域)，例如[.com](https://zh.wikipedia.org/wiki/.com)、[.net](https://zh.wikipedia.org/wiki/.net)和[.org](https://zh.wikipedia.org/wiki/.org)；以及[国家和地区顶级域](https://zh.wikipedia.org/wiki/國家和地區頂級域)，例如[.us](https://zh.wikipedia.org/wiki/.us)、[.cn](https://zh.wikipedia.org/wiki/.cn)和[.tk](https://zh.wikipedia.org/wiki/.tk)。顶级域名下一层是[二级域名](https://zh.wikipedia.org/wiki/二级域)，一级一级地往下。这些域名向人们提供注册服务，人们可以用它创建公开的互联网资源或运行[网站](https://zh.wikipedia.org/wiki/網站)。顶级域名的管理服务由对应的[域名注册管理机构（域名注册局）](https://zh.wikipedia.org/wiki/域名注册局)负责，注册服务通常由[域名注册商](https://zh.wikipedia.org/wiki/域名注册商)负责。

[^3]:**域名系统**（英语：**D**omain **N**ame **S**ystem，缩写：**DNS**）是[互联网](https://zh.wikipedia.org/wiki/互联网)的一项服务。它作为将[域名](https://zh.wikipedia.org/wiki/域名)和[IP地址](https://zh.wikipedia.org/wiki/IP地址)相互[映射](https://zh.wikipedia.org/wiki/映射)的一个[分布式数据库](https://zh.wikipedia.org/wiki/分布式数据库)，能够使人更方便地访问[互联网](https://zh.wikipedia.org/wiki/互联网)。DNS使用[TCP](https://zh.wikipedia.org/wiki/传输控制协议)和[UDP](https://zh.wikipedia.org/wiki/用户数据报协议)[端口](https://zh.wikipedia.org/wiki/TCP/UDP端口列表)53[[1\]](https://zh.wikipedia.org/wiki/域名系统#cite_note-1)。当前，对于每一级域名长度的限制是63个字符，域名总长度则不能超过253个字符。

![domain](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/DNS_schema.svg/525px-DNS_schema.svg.png)

域名的作用就是作为一个字符串映射到一个 IP 地址上，因为：

- IP 地址太难记了
- IP 地址数目有限（同一个 IP 上可以放 N 个域名）

后来迫于国际压力，克林顿时代的美国政府于 1998 年发表白皮书，建议由非盈利机构接管政府的域名管理职能。同年十月，成立了非盈利的 Internet 管理组织——ICANN[^2]。美国政府与 NSI 终止合同以后，ICANN 与美国政府签订协议，负责监视与 Internet 域名和地址有关的政策和协议，美国政府采取不干预政策。

[^2]: **互联网名称与数字地址分配机构**（**I**nternet **C**orporation for **A**ssigned **N**ames and **N**umbers），简称**ICANN**，是位于[美国](https://zh.wikipedia.org/wiki/美国)[加利福尼亚](https://zh.wikipedia.org/wiki/加利福尼亚)的非营利社团，主要由[互联网协会](https://zh.wikipedia.org/wiki/互联网协会)的成员组成，创建于1998年9月18日，目的是接管包括管理[域名](https://zh.wikipedia.org/wiki/域名)和[IP地址](https://zh.wikipedia.org/wiki/IP地址)的分配等与[互联网](https://zh.wikipedia.org/wiki/互联网)相关的任务，这些任务曾由其它组织（特别是[IANA](https://zh.wikipedia.org/wiki/IANA)）代表[美国政府](https://zh.wikipedia.org/wiki/美国政府)来执行，但ICANN仍受美国政府及法律管理。

ICANN 通过各个不同的合同关系对应不同的后缀域名，授权不同的注册局为全球提供域名注册等服务，而各个注册商根据不同的需求与 ICANN 授权的注册局建立代理关系。

接入互联网的第一目的是获得信息，需要获得的信息是存放在互联网某个接入主机的物理硬盘空间上的。首先我们要知道这个空间在哪里，然后通过工具把这个信息加载到你的接入设备上，比如电脑或手机。找到信息的存放地点的方式，叫寻址方式；存放信息的地址，我们叫网址。很多人把互联网的信息获取寻找方式归结为域名和 IP 地址，事实上这个分类是技术性的分类，从用户角度来讲，严格说应该分为域名、IP、第三方推荐平台（包括网站分类目录、搜索引擎、网址站等）。  

## Register

大部分注册商公司都不会仅仅靠域名注册服务来作为公司的唯一业务，一般都会延伸出服务器[^3]租用、托管或虚拟空间等业务，万网目前的云服务即是如此而来（这个我们通常叫 IDC 提供商，IDC=Internet Data Center，即互联网数据中心），当然大部分还会提供模板式自助建站服务和域名中介交易等，为企业客户提供域名注册、主机空间、网站建设或域名购买服务等。

[^3]:**服务器**（Server）指：一个管理资源并为用户提供服务的计算机软件，通常分为[文件服务器](https://zh.wikipedia.org/wiki/文件服务器)（能使用户在其它计算机访问[文件](https://zh.wikipedia.org/wiki/文件)），数据库服务器和[应用程序服务器](https://zh.wikipedia.org/wiki/应用程序服务器)。运行以上软件的[计算机](https://zh.wikipedia.org/wiki/计算机)，或称为**网络主机**（Host）。

我的第一个域名来自注册商[Namesilo](https://www.namesilo.com/)，因为可以用支付宝（我不会PayPal……）。国外买的域名比国内贵，不过没有国内杂七杂八的手续。

![namesilo](https://www.exportb2c.com/wp-content/uploads/2019/05/2019051210103389-1024x318.png)

域名有如下特性：

1. 域名是全球范围使用的 ，没有地域性限制；
2. 域名一经注册即可长期使用，当然，是指在有效期内一直续费的可以长期拥有；
3. 域名是唯一性的，如果你注册了，其他任何人均无法注册相同的域名；
4. 域名具有自然价值延续性。

## with IP

我们可以通过域名来反查 IP 地址，当然也可以通过 IP 地址来反查其对应的域名。这类域名和 IP 对应关系的查询工具有很多，也有很多网站提供类似的查询服务，比如我查网（www.wocha.com）上面就有提供。当然，并不是每个接入互联网的主机或网站都需要域名，IP 是根据一定规则自动分配的，是接入网络的基础，但要不要域名、要用什么样的域名，用户可以自己决定。你可以仅仅只用一大串的数字 IP 给客户，让你的客户靠 IP 来访问你的网站；也可以注册一个顶级的、让客户一看就记得住的域名；也可以用一个看起来跟数字串差不多的、让人永远记不住的垃圾域名；甚至用免费的二级域名都可以，这个视企业主用户品味和投入决心而定。

## WHOIS

**WHOIS**（读作“Who is”，而非缩写）是用来查询[互联网](https://zh.wikipedia.org/wiki/網際網路)中[域名](https://zh.wikipedia.org/wiki/域名)的[IP](https://zh.wikipedia.org/wiki/IP地址)以及所有者等信息的传输协议。早期的WHOIS查询多以[命令行接口](https://zh.wikipedia.org/wiki/命令列介面)（Command Line）存在，但是现在出现了一些基于[网页](https://zh.wikipedia.org/wiki/網頁)接口的简化在线查询工具，甚至可以一次向不同的[数据库](https://zh.wikipedia.org/wiki/數據庫)查询。网页接口的查询工具仍然依赖WHOIS协议向[服务器](https://zh.wikipedia.org/wiki/伺服器)发送查询请求，命令行接口的工具仍然被系统管理员广泛使用。

不过国内可以用：https://whois.aliyun.com/

# Web

## URL

**网址导航**是指将一些[互联网](https://zh.wikipedia.org/wiki/互联网)网站地址（URL）做集合，并按照网站种类分类以引导用户快速访问的一类网站的总称。

目前网址导航主要有以下几种类型：

1. 以[hao123](https://zh.wikipedia.org/wiki/Hao123)，265网址导航等为首的（其分别被[百度](https://zh.wikipedia.org/wiki/百度)公司和[谷歌](https://zh.wikipedia.org/wiki/谷歌)公司收购）大型网络公司收购的网址导航；
2. 114la等独立运营的网址导航；
3. 百度网址大全，雅虎网址大全等依靠[搜索引擎](https://zh.wikipedia.org/wiki/搜索引擎)架构运营的网址导航。

## Website

**网站**是指在[万维网](https://zh.wikipedia.org/wiki/萬維網)上，根据一定的规则，使用[HTML](https://zh.wikipedia.org/wiki/HTML)等工具制作的用于展示特定内容的相关[网页](https://zh.wikipedia.org/wiki/網頁)的集合。简单地说，**网站**是一种通信工具，就像布告栏一样，人们可以通过网站来发布自己想要公开的信息，或网站来提供相关的[网络服务](https://zh.wikipedia.org/wiki/网络服务)。人们可以通过[网页浏览器](https://zh.wikipedia.org/wiki/網頁瀏覽器)来访问网站，获取自己需要的信息或者享受网络服务。

网站一般由域名、空间服务器、DNS 域名解析、CDN 加速、网站安全、网站程序、数据库等要素组成。但是，有了这些要素还不是一个完整的网站，其核心部分是网页，如果没有网页，则没有人可以访问到你的“网站”，那网站则不存在。  

- [域名](http://hoas.xyz/post/internet/#domain-name)
  - 我的域名的域名状态（Domain Status）是“注册商设置禁止转移（_clientTransferProhibited_）”，不过可以拿到邮件发来的授权码（**Authorization Code**）对注册商namesilo提出转移注册商申请。

- 空间服务期（网站空间）。简单来说，空间就是在互联网上用于存放你的网站的网页、程序、数据库等信息的仓库。理论上来说，任何一台电脑都可以当成存放网站的空间，但正确的做法一般是采用专业的运营商或代理商提供的专用电脑主机（服务器）作为网站的空间。根据网站的访问量、数据量的不同，需要采用的空间也不同。因此常见网站空间又分为虚拟主机[^4]、虚拟空间、独立服务器、云主机、VPS 等。企业要根据需求的大小不同，采用不同的方式。
  - 虚拟主机是指在一台服务器上划分出一定的磁盘空间供用户放置站点，提供必要的站点功能、数据存放和传输功能。每一个虚拟主机都具有独立的域名和完整的 Internet 服务器功能，从感官上来说，你看不出是由一台服务器划分出来的，所以叫“虚拟主机”，也叫“虚拟空间”或“网站空间”；而相对需求大的网站，虚拟主机满足不了，则需要独占一整台的服务器，就叫作独立服务器，有的则需要多台甚至更多的服务器来支持，总之根据需求的不同而定。上文我们已经提到过，专业的域名注册商基本上都会提供服务器租用托管或虚拟主机等业务，也就是我们说的 IDC 服务商。

- DNS 域名解析。有了域名和空间，接下来最重要的就是如何让域名和空间对应起来了。每个有效的网站空间都有一个可以访问的 IP，我们说过 IP 一般人记不住，域名容易记，那么如何把你已经注册好的域名和你拥有的空间对应起来呢？这个就是我们说的网站的基本要素——DNS 域名解析，字面意义也很容易理解，就是把域名与你在互联网世界里存储网站的物理空间 IP 地址对应关联起来，让用户可以输入域名，互联网就知道你要访问的是哪个空间的 IP。
  - 举一个例子，*zh.wikipedia.org* 作为一个域名就和IP地址*198.35.26.96* 相对应。DNS就像是一个自动的电话号码簿，我们可以直接拨打*198.35.26.96* 的名字*zh.wikipedia.org* 来代替电话号码（IP地址）。DNS在我们直接调用[网站](https://zh.wikipedia.org/wiki/网站)的名字以后就会将像*zh.wikipedia.org* 一样便于人类使用的名字转化成像*198.35.26.96* 一样便于机器识别的IP地址。

- CDN[^5]加速。简单地说就是让用户访问你网站的速度变得更快。原理也很简单，专业的 CDN 加速服务商，将你的网站内容复制到分布于全国乃至于全球不同的服务器上，让访客可以就近访问你的网站，自然访问速度就快。另外，CDN 加速也不是每个网站都必须拥有，这个根据需求、网站大小和访问量大小、用户量多寡而定。

- 网站安全

- 网站程序。相对静态来说，有应用数据库的网站，可以实现实时的互动或动态读写变化的数据，那就叫动态网站。动态网站的网页地址有可能是变化或不断生成的，因此这个时候的网址又叫动态网址，而随着页面搜索引擎优化技术的不断发展，通常会将动态网址通过技术转成对搜索引擎比较友好的静态网址，我们称之为伪静态网址。

[^4]:**虚拟主机**（英语：virtual hosting）或称 **共享主机**（shared web hosting），又称**虚拟服务器**，是一种在单一主机或主机群上，实现多网域服务的方法，可以运行多个[网站](https://zh.wikipedia.org/wiki/網站)或服务的技术。虚拟主机之间完全独立，并可由用户自行管理，虚拟并非指不存在，而是指空间是由实体的服务器延伸而来，其[硬件](https://zh.wikipedia.org/wiki/硬體)系统可以是基于服务器群，或者单个服务器。
[^5]:**内容分发网络**（英语：**C**ontent **D**elivery **N**etwork或**C**ontent **D**istribution **N**etwork，缩写：**CDN**）是指一种透过[互联网](https://zh.wikipedia.org/wiki/互聯網)互相连接的计算机网络系统，利用最靠近每位用户的服务器，更快、更可靠地将音乐、图片、影片、应用程序及其他文件发送给用户，来提供高性能、可扩展性及低成本的网络内容传递给用户。

其中，DNS系统的主要记录类型有（即域名的一些解析工作）：

- 域名服务器（domain name server，又叫DNS服务器）：通常是 `ns*.***.***` 之类的网址（不过我的是`DNS*.***.***`），这个服务器负责解析下面的各种设置，也就是说，它是域名各项设置的 Boss。国内一些域名注册商通常以这一点为手段，卡住用户，比如限制你只能使用它的域名服务器，然后再限制你最多只能设置 10 项 A 记录或 MX 记录等，多了要另外收费，这种规矩实在是很扯淡；尤其是对于那些需要多个子域名的用户，这一点很不方便，国外情况好一些，至少我还没见过有哪家限制你使用特定域名服务器的；
  - 要特别提及的一点是，有些空间服务商只需要你把域名服务器设置为他们的域名服务器，剩下的所有解析问题你基本上都不用管了，你可以自由创建子域名，而不必添加 A 记录.
  - 你在域名注册查询域名并购买了[主机](https://baike.baidu.com/item/主机)服务后，你需要将域名解析到所购买的主机上，才能看到网站内容。在绝大部分情况下，更改了域名的[DNS域名服务器](https://baike.baidu.com/item/DNS域名服务器)后，并不能马上看到网站内容，而是要过几个小时，甚至一两天才能打开你的网站。
  - 当一个浏览者在浏览器地址框中打入某一个域名，或者从其他网站点击了链接来到了这个域名，浏览器向这个用户的上网接入商发出域名请求，接入商的DNS服务器要查询域名数据库，看这个域名的DNS服务器是什么。然后到DNS服务器中抓取DNS记录，也就是获取这个域名指向哪一个IP地址。在获得这个IP信息后，接入商的服务器就去这个IP地址所对应的服务器上抓取网页内容，然后传输给发出请求的浏览器。

- 主机记录（A记录）：RFC 1035定义，A记录是用于名称解析的重要记录，它将特定的主机名映射到对应主机的IP地址上。就是将域名指向主机 IP，可以将顶级域名或子域名指向特定的 IP，所以你的子域名和顶级域名可以不在同一台服务器上，比如我可以将 www.yihui.name 指向 66.147.240.177，将 test.yihui.name 指向 127.0.0.1，等等。

- MX 记录：就是邮件服务器，大家知道邮箱是 `***@***.***` 的形式，当你发邮件点 “发送” 之后，首先你的邮件服务商要根据你的收件人邮箱的域名去找它的 MX 记录，然后再把邮件发给相应的（另一家）邮件服务商，比如我的域名 yihui.name 的 MX 记录是 ASPMX.L.GOOGLE.COM，也就是 Google Apps 的邮件服务地址，当你给 xie@yihui.name 发邮件的时候，系统先去找一下 yihui.name 的 MX 记录，一看，哦，是 Google 啊，那就投递到 Google 家去，Google 收到邮件，一看，哦，要发给 xie 用户啊，那就发给 xie 的收件箱中吧。

- CNAME：即别名，这玩意儿就是个域名 “面具”，比如我把 google.yihui.name 的 CNAME 设置为 google.com，那么你们访问前者的时候实际上就在访问 Google，域名中包含的任何路径都会原封不动传递给 google.com，比如 google.yihui.name/services/ 就是在访问 google.com/services/，但你的浏览器地址栏中的地址不会显示后者，而是显示那个 “伪装” 的地址。所以只要我高兴，我可以随意制造消息，比如 “Google 换网址了，新网址是 [http://google.xiexie.name](http://google.xiexie.name/)”。

- 其它。

# References

- 谢益辉：[新手教程：建立网站的全套流程与详细解释](https://yihui.name/cn/2009/06/how-to-build-a-website-as-a-dummy/)

- [庄良基](https://baike.baidu.com/item/庄良基)：《拆掉互联网那堵墙》

# Thanks

- [Rainy Liu](https://blog.rainy.wiki/2019/06/19/bye/)

