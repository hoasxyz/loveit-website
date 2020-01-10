# Use Icons with Iconfont


  To decorate your website using icons in [iconfont](https://www.iconfont.cn/), what you should do firstly is to read [the documents of iconfont](https://www.iconfont.cn/help/detail?spm=a313x.7781069.1998910419.15&helptype=code). And this post mainly introduces the usage of iconfont in hugo.

![iconfont](https://themebetter.com/uploads/2018/01/iconfont-0.jpg)
<!--more-->

# Steps

  First, there are lots of fancy icons that attract you in iconfont. And you can "purchase some freely for [one project](https://www.iconfont.cn/manage/index?manage_type=myprojects&projectId=1039822) in your shopping cart.
  
  To quote as Unicode, its application steps are:

  - Generate the code and click to duplicate the code. Paste them after the source code of the template in `_iconfont.scss` file:

```scss
@font-face {
  font-family: 'iconfont';

  src: url('../fonts/iconfont/iconfont.eot');
  src: url('../fonts/iconfont/iconfont.eot#iefix') format('embedded-opentype'), // not '?#iefix', because webpack will add '?hash=[hash]'
  url('../fonts/iconfont/iconfont.woff') format('woff'),
  url('../fonts/iconfont/iconfont.ttf') format('truetype'),
  url('../fonts/iconfont/iconfont.svg#iconfont') format('svg');
}

@font-face {
  font-family: 'iconfont';  /* project id 1039822 */
  src: url('//at.alicdn.com/t/font_1039822_ndzwog2io3l.eot');
  src: url('//at.alicdn.com/t/font_1039822_ndzwog2io3l.eot?#iefix') format('embedded-opentype'),
  url('//at.alicdn.com/t/font_1039822_ndzwog2io3l.woff2') format('woff2'),
  url('//at.alicdn.com/t/font_1039822_ndzwog2io3l.woff') format('woff'),
  url('//at.alicdn.com/t/font_1039822_ndzwog2io3l.ttf') format('truetype'),
  url('//at.alicdn.com/t/font_1039822_ndzwog2io3l.svg#iconfont') format('svg');
}
```

  - Define the style of iconfont usage.
  
```scss
%base-iconfont {
  font-family: "iconfont" !important;
  speak: none;
  font-style: normal;
  font-weight: normal;
  font-variant: normal;
  text-transform: none;
  line-height: 1;

  -webkit-text-stroke-width: 0.2px;
  cursor: pointer;

  /* Enable Ligatures ================ */
  letter-spacing: 0;
  font-feature-settings: "liga";
  font-variant-ligatures: discretionary-ligatures;

  /* Better Font Rendering =========== */
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

.iconfont {
  @extend %base-iconfont;
}
```

  - Copy the individual code of icon into pages -- `single.html` and `summary.html`.

{{< highlight go-html-template "linenos=table,hl_lines=6 10 16 17,linenostart=3" >}}
<!--header in single.html-->
    <header class="post-header">
      <h1 class="post-title">{{ .Title }}</h1>

      <div class="post-meta">
        <span class="post-time"> <i class="iconfont">&#xe664;</i> {{ .Date.Format (.Site.Params.dateFormatToUse | default "2006-01-02") }} </span>
        {{ with .Params.categories -}}
          <div class="post-category">
            {{ range . -}}
          &nbsp;   <i class="iconfont">&#xe68b;</i>
              <a href="{{ "categories" | relLangURL }}/{{ . | urlize }}/"> {{ . }} </a>
            {{ end -}}
          </div>
        {{- end }}
        {{- if .Site.Params.moreMeta }}
          <span class="more-meta"> &nbsp; <i class="iconfont">&#xe75c;</i> {{ T "wordCount" .WordCount }} </span>
          <span class="more-meta"> &nbsp; <i class="iconfont">&#xe686;</i> {{ T "readingTime" .ReadingTime }} </span>
        {{- end }}
        {{ if and .Site.Params.busuanzi.enable .Site.Params.busuanzi.pagePV -}}
          {{ $valueSpan := printf `<span id="busuanzi_value_page_pv"><img src="%s" alt="spinner.svg"/></span>` ("img/spinner.svg" | relURL) -}}
          <span id="busuanzi_container_page_pv" class="more-meta"> {{ printf (T "pagePV") $valueSpan | safeHTML }} </span>
        {{- end }}
      </div>
    </header>
{{</ highlight >}}

{{< highlight go-html-template "linenos=table,hl_lines=6,linenostart=44" >}}
<!--footer in single.html-->
    <footer class="post-footer">
      {{ with .Params.tags -}}
        <div class="post-tags">
          {{ range . -}}
            <i class="iconfont">&#xe8c4;</i>
            <a href="{{ "tags" | relLangURL }}/{{ . | urlize }}/">{{ . }}</a>
          {{ end -}}
        </div>
      {{- end -}}
{{</ highlight >}}

{{% admonition type="warning" title="Pay Attention!" %}}
* If your template has been updated, you may check out what we discussed has been modified.

* If you change the icons in your project, you are supposed to change `@font-face` in your `_iconfont.scss` file and rebuild your website.
{{% /admonition %}}

# Thanks

  Thanks for the help of warmhearted [yixuju](https://www.yixuju.cn/)! Without his help, I cannot decorate my website with many cute icons.
  
# Index

- More `@font-face` in `.css` file: https://codeday.me/bug/20170905/66080.html.

- Using more self-defined fonts by `@font-face`: https://codeday.me/bug/20170906/67527.html.  

- [Hexo-next theme](https://github.com/iissnan/hexo-theme-next) continuously updating: https://inspurer.github.io/2018/11/11/hexo-next%E4%B8%BB%E9%A2%98%E4%BC%98%E5%8C%96/.