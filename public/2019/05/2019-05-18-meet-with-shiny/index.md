# 初识Shiny

来，点一首[相见恨晚](http://www.koowo.com:8080/yinyue/916888)。

原来我[苦苦找寻](https://hoas.xyz/post/using-r-in-cs/)的C#与R的结合竟然是这个……

<center>
![shiny](https://d33wubrfki0l68.cloudfront.net/865224e7bf1ce74ecb724244a454dda8d7f6ad77/e76f3/images/2019-01-07-shiny-contest.png)
</center>

<!--more-->

# 布局

承袭**所见即所思**的思想，shiny的布局有时候让我感到很困惑，因为官方网站上也没有具体的示例，只有自己亲测布局。布局的解析就拿这次部署的[App](https://hoas.shinyapps.io/xajModel/)来展示：

`ui.R`:

```r
tagList(
  tags$head(
    # 设置标题样式
  ),
  
  h1(
    # 设置标题
  ),
  
  navbarPage(
    theme = shinythemes::themeSelector(),
    'label',
    tabPanel( # 第一同级
      'id',
      icon,
      sidebarLayout(
        sidebarPanel( # 不放sidebar也行的！
          width,
          ...
        )
      ),
      
      mainPanel(
        width,
        ...
      )
    ),
    
    tabPanel( # 第二同级
      mainPanel(
        tabsetPanel(
          'id', # 好像为必须，不然会报错！
          tabPanel(...),
          tabPanel(...),
          tabPanel(...),
        )
      ),
      column(
        width,
        wellPanel( # 好像不能设置宽度，column可以，默认为铺满
          tabsetPanel(...)
        )
      )
    ),
    
    tabPanel( # 第三同级
      ...,
      mainPanel(
        tabsetPanel(...)
      )
    ),
    
    tabPanel( # 第四同级
      ...,
      mainPanel(...),
      column(
        wellPanel(tabsetPanel(...))
      )
    ),
    
    tabPanel( # 第五同级
      ...,
      mainPanel(...)
    ),
    
    tabPanel( # 第六同级
      ...,
      mainPanel(
        tabsetPanel(
          ...,
          tabPanel(
            column(...),
            column(...),
            column(...)
          ),
          tabPanel(...) # 同上
        )
      )
    )
  )
)
```

