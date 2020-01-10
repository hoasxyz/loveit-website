# Notes

  <img src="http://www.makeraid.cn/wp-content/uploads/2017/09/36%E4%B8%AA%E9%AB%98%E9%A2%91%E9%97%AE%E9%A2%98-%E5%A4%A7%E5%9B%BE.jpg" alt="problem" width="100%" height="100%">
<!--more-->

# Keeping Exploring!

  How to...

  * add a web-fitted tabulate built by `.Rmd` file?
  
  * [generate a toc](https://github.com/olOwOlo/hugo-theme-even/issues/100) in a `.Rmd` file?
  
  * generate a normal tabulate(`.Rmd` file) just like `.md` and `Rmarkdown` file?
  
  * add abstract to one blog shaped by `.Rmd` file?
  
  * switch to different websites? For example, [Chinese&English web](http://dapengde.com/archives/15265)?
  
  * create one site with multistyle?
  
  * use the icons in [iconfont](https://www.iconfont.cn/?spm=a313x.7781069.1998910419.d4d0a486a)?
  
  * add page scroll progress indicator in posts?
  
    - Without Js: https://codepen.io/MadeByMike/pen/ZOrEmr ; https://www.w3cplus.com/css/pure-css-create-scroll-indicator.html.
    
    - With Js: https://codepen.io/derekjp/pen/pJzpxB
    
    - https://webdesign.tutsplus.com/tutorials/how-to-build-a-page-scroll-progress-indicator-with-jquery-and-svg--cms-20881
    
    - Demo: https://infinum.co/the-capsized-eight/progress-bar-in-rails
  
  * add live 2D model in hugo website? In hexo: https://yq.aliyun.com/articles/653992/.
  
  * Something may appear sometime somewhere...

# Continent Found!

* Go-html-template learning:
  
  - https://www.cnblogs.com/f-ck-need-u/p/10053124.html#%E5%8E%BB%E9%99%A4%E7%A9%BA%E7%99%BD ;
  
  - https://cloud.tencent.com/developer/section/1145004.
  
* Keeping navigating!
  
# Treasure

 * Too add [annotation](https://www.imooc.com/article/23400) in markdown, [underline](https://blog.olowolo.com/post/hugo-even-preview/index.md) in markdown and add [footnotes](http://www.ghostchina.com/markdown-guide/) in markdown.

 * Insert audios in website. See <a target="_blank" title="索引" href="/post/terrylin/index.html#索引">御龙将军（uncover）</a> or [御龙将军（cover）](https://hoas.xyz/post/terrylin/#索引).

 * Add one [comment area](https://www.smslit.top/2018/07/08/hugo-valine/) in hugo.

 * If you changed any file under `/src/`, you need to rebuild.

```cmd
In cmd.exe:

C:\Users\Hoas>E:

E:\>cd E:\1R\website\themes\hugo-theme-even\src\css

yarn install

yarn build
```

* [Output Markdown format](https://blog.olowolo.com/post/hugo-quick-start/#%E7%BB%B4%E5%8C%85%E5%AD%90%E4%BB%80%E4%B9%88%E9%83%BD%E7%9F%A5%E9%81%93).

* Add [canvas-nest.js](https://github.com/hustcc/canvas-nest.js) in website. Create new folder `js/` in your `static/` file, copying the js file in `js/` and add one command in your `config.toml`:

```toml
  customJS = ['canvas-nest.mod.js']
  
  # Advice: if you change the color of the theme, you are supposed to modify the color of canvas-nest in `canvas-nest.mod.js` file.
```

* Add [comment.js add-in](https://blog.yuanbin.me/posts/2018-08/2018-08-19_16-59-31/) in [even](https://github.com/olOwOlo/hugo-theme-even).

* Change the style of cursor in website. In `/src/css/_partial/_post/_content.scss` file, add these in the file, but only the latter effects. More knowledge about cursor:https://css-tricks.com/almanac/properties/c/cursor/#browser-support ; http://www.w3school.com.cn/cssref/pr_class_cursor.asp.

```css
body {cursor: url(/cursor/cursor_7.png), auto;}
/** 链接指针样式**/
a:hover{cursor:url(/cursor/cursor_8.png), pointer;}
```

* Change the type of scroll bars: https://blog.csdn.net/zh_rey/article/details/72473284 ; http://www.webhek.com/post/scrollbar.html.

* Add `timeago` in `footer.html` file: http://www.nov.im/456.html. And the duration of one web page: https://my.oschina.net/softsky/blog/228681 ; https://blog.csdn.net/superit401/article/details/72900792.

```html
<span class="author">
{{if .Site.Copyright }}{{ .Site.Copyright | safeHTML }}{{ else }}{{ .Site.Author.name | safeHTML }}{{ end }}
<center>
<span id="showsectime"></span>
<script type="text/javascript">
function NewDate(str) { 
str = str.split('-'); 
var date = new Date(); 
date.setUTCFullYear(str[0], str[1] - 1, str[2]); 
date.setUTCHours(0, 0, 0, 0); 
return date; 
} 
function showsectime() {
var birthDay =NewDate("2018-12-30");
var today=new Date();
var timeold=today.getTime()-birthDay.getTime();
var sectimeold=timeold/1000
var secondsold=Math.floor(sectimeold);
var msPerDay=24*60*60*1000; var e_daysold=timeold/msPerDay;
var daysold=Math.floor(e_daysold);
var e_hrsold=(daysold-e_daysold)*-24;
var hrsold=Math.floor(e_hrsold);
var e_minsold=(hrsold-e_hrsold)*-60;
var minsold=Math.floor((hrsold-e_hrsold)*-60); 
var seconds=Math.floor((minsold-e_minsold)*-60).toString();
document.getElementById("showsectime").innerHTML = "本站已安全运行"+daysold+"天"+hrsold+"小时"+minsold+"分"+seconds+"秒";
setTimeout(showsectime, 1000);
}showsectime();
</script>
    </span>
</center>
  </span>
</div>
```
- Another way to add icons similar in Github: https://shields.io/category/coverage.

```markdown
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)
```

[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors)

- Another way to add your personal image:

```markdown
<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table><tr><td align="center"><a href="https://hoas.xyz/"><img src="https://github.com/hoasxyz/MarkdownPhotos/blob/master/Terry%20Lin/%E7%82%AB%E7%82%AB.jpg?raw=true" width="100px;" alt="Terry Lin"/><br /><sub><b>Terry Lin</b></sub></a><br /><a href="https://github.com/XSLiuLab/Beacon/commits?author=ShixiangWang" title="Code">💻</a> <a href="#ideas-ShixiangWang" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-ShixiangWang" title="Maintenance">🚧</a></td></tr></table>
<!-- ALL-CONTRIBUTORS-LIST:END -->
```

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore -->
<table><tr><td align="center"><a href="https://hoas.xyz/"><img src="https://github.com/hoasxyz/MarkdownPhotos/blob/master/Terry%20Lin/%E7%82%AB%E7%82%AB.jpg?raw=true" width="100px;" alt="Terry Lin"/><br /><sub><b>Terry Lin</b></sub></a><br /><a href="https://github.com/XSLiuLab/Beacon/commits?author=ShixiangWang" title="Code">💻</a> <a href="#ideas-ShixiangWang" title="Ideas, Planning, & Feedback">🤔</a> <a href="#maintenance-ShixiangWang" title="Maintenance">🚧</a></td></tr></table>
<!-- ALL-CONTRIBUTORS-LIST:END -->

- One fast and free [CDN](http://raw.githack.com/) can be used with github!
- Embed Slides in Your Blog: 

  - https://timmastny.rbind.io/blog/embed-slides-knitr-blogdown/;
  
  - https://portfolio.peter-baumgartner.net/2018/07/21/presentations-with-xaringan/;
  
  - https://stackoverflow.com/questions/51459120/blogdown-xaringan-does-not-work-after-using-chakra-option.
- Add `pangu.js`(盘古之白): https://yihui.name/cn/2017/05/pangu/
- Whe in `footer.html` file. in `footer.html` file.n you do not want to write a git commit:https://d.cosx.org/d/420396-git-commit