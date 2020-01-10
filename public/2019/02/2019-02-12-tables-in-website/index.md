# Tables in Website


<script src="/rmarkdown-libs/kePrint/kePrint.js"></script>
<link href="/rmarkdown-libs/bsTable/bootstrapTable.min.css" rel="stylesheet" />
<script src="/rmarkdown-libs/htmlwidgets/htmlwidgets.js"></script>
<script src="/rmarkdown-libs/jquery/jquery.min.js"></script>
<link href="/rmarkdown-libs/datatables-css/datatables-crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/datatables-binding/datatables.js"></script>
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.min.css" rel="stylesheet" />
<link href="/rmarkdown-libs/dt-core/css/jquery.dataTables.extra.css" rel="stylesheet" />
<script src="/rmarkdown-libs/dt-core/js/jquery.dataTables.min.js"></script>
<link href="/rmarkdown-libs/crosstalk/css/crosstalk.css" rel="stylesheet" />
<script src="/rmarkdown-libs/crosstalk/js/crosstalk.min.js"></script>
<link href="/rmarkdown-libs/pagedtable/css/pagedtable.css" rel="stylesheet" />
<script src="/rmarkdown-libs/pagedtable/js/pagedtable.js"></script>

<div id="TOC">
yes
</div>

<p>Many ways of building tables in website based on different packages.</p>
<div id="kableextra" class="section level1">
<h1><a href="https://haozhu233.github.io/kableExtra/awesome_table_in_html_cn.html">kableExtra</a></h1>
<ul>
<li><p><a href="https://haozhu233.github.io/kableExtra/save_kable_and_as_image.html">Save Tables and Use them as Images</a></p></li>
<li><p><a href="https://haozhu233.github.io/kableExtra/using_kableExtra_in_radix.html">Using kableExtra in Radix</a></p></li>
</ul>
<pre class="r"><code>options(kableExtra.html.bsTable = T) 
knitr::kable(head(mtcars),&quot;html&quot;)</code></pre>
<table>
<thead>
<tr>
<th style="text-align:left;">
</th>
<th style="text-align:right;">
mpg
</th>
<th style="text-align:right;">
cyl
</th>
<th style="text-align:right;">
disp
</th>
<th style="text-align:right;">
hp
</th>
<th style="text-align:right;">
drat
</th>
<th style="text-align:right;">
wt
</th>
<th style="text-align:right;">
qsec
</th>
<th style="text-align:right;">
vs
</th>
<th style="text-align:right;">
am
</th>
<th style="text-align:right;">
gear
</th>
<th style="text-align:right;">
carb
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Mazda RX4
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.620
</td>
<td style="text-align:right;">
16.46
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
Mazda RX4 Wag
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.875
</td>
<td style="text-align:right;">
17.02
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
Datsun 710
</td>
<td style="text-align:right;">
22.8
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
93
</td>
<td style="text-align:right;">
3.85
</td>
<td style="text-align:right;">
2.320
</td>
<td style="text-align:right;">
18.61
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet 4 Drive
</td>
<td style="text-align:right;">
21.4
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.08
</td>
<td style="text-align:right;">
3.215
</td>
<td style="text-align:right;">
19.44
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet Sportabout
</td>
<td style="text-align:right;">
18.7
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
175
</td>
<td style="text-align:right;">
3.15
</td>
<td style="text-align:right;">
3.440
</td>
<td style="text-align:right;">
17.02
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
Valiant
</td>
<td style="text-align:right;">
18.1
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
225
</td>
<td style="text-align:right;">
105
</td>
<td style="text-align:right;">
2.76
</td>
<td style="text-align:right;">
3.460
</td>
<td style="text-align:right;">
20.22
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
<pre class="r"><code>knitr::kable(head(mtcars),&quot;html&quot;) %&gt;%
  kable_styling(bootstrap_options = c(&quot;striped&quot;,&quot;hover&quot;,&quot;responsive&quot;)) %&gt;%
  scroll_box(width = &quot;500px&quot;, height = &quot;200px&quot;)</code></pre>
<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:200px; overflow-x: scroll; width:500px; ">
<table class="table table-striped table-hover table-responsive" style="margin-left: auto; margin-right: auto;">
<thead>
<tr>
<th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;">
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
mpg
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
cyl
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
disp
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
hp
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
drat
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
wt
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
qsec
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
vs
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
am
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
gear
</th>
<th style="text-align:right;position: sticky; top:0; background-color: #FFFFFF;">
carb
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Mazda RX4
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.620
</td>
<td style="text-align:right;">
16.46
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
Mazda RX4 Wag
</td>
<td style="text-align:right;">
21.0
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
160
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.90
</td>
<td style="text-align:right;">
2.875
</td>
<td style="text-align:right;">
17.02
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
4
</td>
</tr>
<tr>
<td style="text-align:left;">
Datsun 710
</td>
<td style="text-align:right;">
22.8
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
108
</td>
<td style="text-align:right;">
93
</td>
<td style="text-align:right;">
3.85
</td>
<td style="text-align:right;">
2.320
</td>
<td style="text-align:right;">
18.61
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
4
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet 4 Drive
</td>
<td style="text-align:right;">
21.4
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
258
</td>
<td style="text-align:right;">
110
</td>
<td style="text-align:right;">
3.08
</td>
<td style="text-align:right;">
3.215
</td>
<td style="text-align:right;">
19.44
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
1
</td>
</tr>
<tr>
<td style="text-align:left;">
Hornet Sportabout
</td>
<td style="text-align:right;">
18.7
</td>
<td style="text-align:right;">
8
</td>
<td style="text-align:right;">
360
</td>
<td style="text-align:right;">
175
</td>
<td style="text-align:right;">
3.15
</td>
<td style="text-align:right;">
3.440
</td>
<td style="text-align:right;">
17.02
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
2
</td>
</tr>
<tr>
<td style="text-align:left;">
Valiant
</td>
<td style="text-align:right;">
18.1
</td>
<td style="text-align:right;">
6
</td>
<td style="text-align:right;">
225
</td>
<td style="text-align:right;">
105
</td>
<td style="text-align:right;">
2.76
</td>
<td style="text-align:right;">
3.460
</td>
<td style="text-align:right;">
20.22
</td>
<td style="text-align:right;">
1
</td>
<td style="text-align:right;">
0
</td>
<td style="text-align:right;">
3
</td>
<td style="text-align:right;">
1
</td>
</tr>
</tbody>
</table>
</div>
</div>
<div id="dt" class="section level1">
<h1><a href="https://rstudio.github.io/DT/">DT</a></h1>
<pre class="r"><code>datatable(iris)</code></pre>
<div id="htmlwidget-1" style="width:100%;height:auto;" class="datatables html-widget"></div>
<script type="application/json" data-for="htmlwidget-1">{"x":{"filter":"none","data":[["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31","32","33","34","35","36","37","38","39","40","41","42","43","44","45","46","47","48","49","50","51","52","53","54","55","56","57","58","59","60","61","62","63","64","65","66","67","68","69","70","71","72","73","74","75","76","77","78","79","80","81","82","83","84","85","86","87","88","89","90","91","92","93","94","95","96","97","98","99","100","101","102","103","104","105","106","107","108","109","110","111","112","113","114","115","116","117","118","119","120","121","122","123","124","125","126","127","128","129","130","131","132","133","134","135","136","137","138","139","140","141","142","143","144","145","146","147","148","149","150"],[5.1,4.9,4.7,4.6,5,5.4,4.6,5,4.4,4.9,5.4,4.8,4.8,4.3,5.8,5.7,5.4,5.1,5.7,5.1,5.4,5.1,4.6,5.1,4.8,5,5,5.2,5.2,4.7,4.8,5.4,5.2,5.5,4.9,5,5.5,4.9,4.4,5.1,5,4.5,4.4,5,5.1,4.8,5.1,4.6,5.3,5,7,6.4,6.9,5.5,6.5,5.7,6.3,4.9,6.6,5.2,5,5.9,6,6.1,5.6,6.7,5.6,5.8,6.2,5.6,5.9,6.1,6.3,6.1,6.4,6.6,6.8,6.7,6,5.7,5.5,5.5,5.8,6,5.4,6,6.7,6.3,5.6,5.5,5.5,6.1,5.8,5,5.6,5.7,5.7,6.2,5.1,5.7,6.3,5.8,7.1,6.3,6.5,7.6,4.9,7.3,6.7,7.2,6.5,6.4,6.8,5.7,5.8,6.4,6.5,7.7,7.7,6,6.9,5.6,7.7,6.3,6.7,7.2,6.2,6.1,6.4,7.2,7.4,7.9,6.4,6.3,6.1,7.7,6.3,6.4,6,6.9,6.7,6.9,5.8,6.8,6.7,6.7,6.3,6.5,6.2,5.9],[3.5,3,3.2,3.1,3.6,3.9,3.4,3.4,2.9,3.1,3.7,3.4,3,3,4,4.4,3.9,3.5,3.8,3.8,3.4,3.7,3.6,3.3,3.4,3,3.4,3.5,3.4,3.2,3.1,3.4,4.1,4.2,3.1,3.2,3.5,3.6,3,3.4,3.5,2.3,3.2,3.5,3.8,3,3.8,3.2,3.7,3.3,3.2,3.2,3.1,2.3,2.8,2.8,3.3,2.4,2.9,2.7,2,3,2.2,2.9,2.9,3.1,3,2.7,2.2,2.5,3.2,2.8,2.5,2.8,2.9,3,2.8,3,2.9,2.6,2.4,2.4,2.7,2.7,3,3.4,3.1,2.3,3,2.5,2.6,3,2.6,2.3,2.7,3,2.9,2.9,2.5,2.8,3.3,2.7,3,2.9,3,3,2.5,2.9,2.5,3.6,3.2,2.7,3,2.5,2.8,3.2,3,3.8,2.6,2.2,3.2,2.8,2.8,2.7,3.3,3.2,2.8,3,2.8,3,2.8,3.8,2.8,2.8,2.6,3,3.4,3.1,3,3.1,3.1,3.1,2.7,3.2,3.3,3,2.5,3,3.4,3],[1.4,1.4,1.3,1.5,1.4,1.7,1.4,1.5,1.4,1.5,1.5,1.6,1.4,1.1,1.2,1.5,1.3,1.4,1.7,1.5,1.7,1.5,1,1.7,1.9,1.6,1.6,1.5,1.4,1.6,1.6,1.5,1.5,1.4,1.5,1.2,1.3,1.4,1.3,1.5,1.3,1.3,1.3,1.6,1.9,1.4,1.6,1.4,1.5,1.4,4.7,4.5,4.9,4,4.6,4.5,4.7,3.3,4.6,3.9,3.5,4.2,4,4.7,3.6,4.4,4.5,4.1,4.5,3.9,4.8,4,4.9,4.7,4.3,4.4,4.8,5,4.5,3.5,3.8,3.7,3.9,5.1,4.5,4.5,4.7,4.4,4.1,4,4.4,4.6,4,3.3,4.2,4.2,4.2,4.3,3,4.1,6,5.1,5.9,5.6,5.8,6.6,4.5,6.3,5.8,6.1,5.1,5.3,5.5,5,5.1,5.3,5.5,6.7,6.9,5,5.7,4.9,6.7,4.9,5.7,6,4.8,4.9,5.6,5.8,6.1,6.4,5.6,5.1,5.6,6.1,5.6,5.5,4.8,5.4,5.6,5.1,5.1,5.9,5.7,5.2,5,5.2,5.4,5.1],[0.2,0.2,0.2,0.2,0.2,0.4,0.3,0.2,0.2,0.1,0.2,0.2,0.1,0.1,0.2,0.4,0.4,0.3,0.3,0.3,0.2,0.4,0.2,0.5,0.2,0.2,0.4,0.2,0.2,0.2,0.2,0.4,0.1,0.2,0.2,0.2,0.2,0.1,0.2,0.2,0.3,0.3,0.2,0.6,0.4,0.3,0.2,0.2,0.2,0.2,1.4,1.5,1.5,1.3,1.5,1.3,1.6,1,1.3,1.4,1,1.5,1,1.4,1.3,1.4,1.5,1,1.5,1.1,1.8,1.3,1.5,1.2,1.3,1.4,1.4,1.7,1.5,1,1.1,1,1.2,1.6,1.5,1.6,1.5,1.3,1.3,1.3,1.2,1.4,1.2,1,1.3,1.2,1.3,1.3,1.1,1.3,2.5,1.9,2.1,1.8,2.2,2.1,1.7,1.8,1.8,2.5,2,1.9,2.1,2,2.4,2.3,1.8,2.2,2.3,1.5,2.3,2,2,1.8,2.1,1.8,1.8,1.8,2.1,1.6,1.9,2,2.2,1.5,1.4,2.3,2.4,1.8,1.8,2.1,2.4,2.3,1.9,2.3,2.5,2.3,1.9,2,2.3,1.8],["setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","setosa","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","versicolor","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica","virginica"]],"container":"<table class=\"display\">\n  <thead>\n    <tr>\n      <th> <\/th>\n      <th>Sepal.Length<\/th>\n      <th>Sepal.Width<\/th>\n      <th>Petal.Length<\/th>\n      <th>Petal.Width<\/th>\n      <th>Species<\/th>\n    <\/tr>\n  <\/thead>\n<\/table>","options":{"columnDefs":[{"className":"dt-right","targets":[1,2,3,4]},{"orderable":false,"targets":0}],"order":[],"autoWidth":false,"orderClasses":false}},"evals":[],"jsHooks":[]}</script>
</div>
<div id="htmltable" class="section level1">
<h1><a href="https://cran.r-project.org/web/packages/htmlTable/vignettes/tables.html">htmlTable</a></h1>
<p>Another index: <a href="https://cran.r-project.org/web/packages/htmlTable/vignettes/general.html" class="uri">https://cran.r-project.org/web/packages/htmlTable/vignettes/general.html</a>.</p>
<pre class="r"><code>output &lt;- 
  matrix(paste(&quot;Content&quot;, LETTERS[1:16]), 
         ncol=4, byrow = TRUE)

htmlTable(output,
          header =  paste(c(&quot;1st&quot;, &quot;2nd&quot;,
                            &quot;3rd&quot;, &quot;4th&quot;), &quot;header&quot;),
          rnames = paste(c(&quot;1st&quot;, &quot;2nd&quot;,
                           &quot;3rd&quot;, &quot;4th&quot;), &quot;row&quot;),
          rgroup = c(&quot;Group A&quot;,
                     &quot;Group B&quot;),
          n.rgroup = c(2,2),
          cgroup = c(&quot;Cgroup 1&quot;, &quot;Cgroup 2&amp;dagger;&quot;),
          n.cgroup = c(2,2), 
          caption=&quot;Basic table with both column spanners (groups) and row groups&quot;,
          tfoot=&quot;&amp;dagger; A table footer commment&quot;)</code></pre>
<table class="gmisc_table" style="border-collapse: collapse; margin-top: 1em; margin-bottom: 1em;">
<thead>
<tr>
<td colspan="6" style="text-align: left;">
Basic table with both column spanners (groups) and row groups
</td>
</tr>
<tr>
<th style="border-top: 2px solid grey;">
</th>
<th colspan="2" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Cgroup 1
</th>
<th style="border-top: 2px solid grey;; border-bottom: hidden;">
 
</th>
<th colspan="2" style="font-weight: 900; border-bottom: 1px solid grey; border-top: 2px solid grey; text-align: center;">
Cgroup 2†
</th>
</tr>
<tr>
<th style="border-bottom: 1px solid grey;">
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
1st header
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
2nd header
</th>
<th style="border-bottom: 1px solid grey;" colspan="1">
 
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
3rd header
</th>
<th style="border-bottom: 1px solid grey; text-align: center;">
4th header
</th>
</tr>
</thead>
<tbody>
<tr>
<td colspan="6" style="font-weight: 900;">
Group A
</td>
</tr>
<tr>
<td style="text-align: left;">
  1st row
</td>
<td style="text-align: center;">
Content A
</td>
<td style="text-align: center;">
Content B
</td>
<td style colspan="1">
 
</td>
<td style="text-align: center;">
Content C
</td>
<td style="text-align: center;">
Content D
</td>
</tr>
<tr>
<td style="text-align: left;">
  2nd row
</td>
<td style="text-align: center;">
Content E
</td>
<td style="text-align: center;">
Content F
</td>
<td style colspan="1">
 
</td>
<td style="text-align: center;">
Content G
</td>
<td style="text-align: center;">
Content H
</td>
</tr>
<tr>
<td colspan="6" style="font-weight: 900;">
Group B
</td>
</tr>
<tr>
<td style="text-align: left;">
  3rd row
</td>
<td style="text-align: center;">
Content I
</td>
<td style="text-align: center;">
Content J
</td>
<td style colspan="1">
 
</td>
<td style="text-align: center;">
Content K
</td>
<td style="text-align: center;">
Content L
</td>
</tr>
<tr>
<td style="border-bottom: 2px solid grey; text-align: left;">
  4th row
</td>
<td style="border-bottom: 2px solid grey; text-align: center;">
Content M
</td>
<td style="border-bottom: 2px solid grey; text-align: center;">
Content N
</td>
<td style="border-bottom: 2px solid grey;" colspan="1">
 
</td>
<td style="border-bottom: 2px solid grey; text-align: center;">
Content O
</td>
<td style="border-bottom: 2px solid grey; text-align: center;">
Content P
</td>
</tr>
</tbody>
<tfoot>
<tr>
<td colspan="6">
† A table footer commment
</td>
</tr>
</tfoot>
</table>
</div>
<div id="rmarkdownpage_table" class="section level1">
<h1>rmarkdown::page_table()</h1>
<pre class="r"><code>rmarkdown::paged_table(iris)</code></pre>
<div data-pagedtable="false">
<script data-pagedtable-source type="application/json">
{"columns":[{"label":["Sepal.Length"],"name":[1],"type":["dbl"],"align":["right"]},{"label":["Sepal.Width"],"name":[2],"type":["dbl"],"align":["right"]},{"label":["Petal.Length"],"name":[3],"type":["dbl"],"align":["right"]},{"label":["Petal.Width"],"name":[4],"type":["dbl"],"align":["right"]},{"label":["Species"],"name":[5],"type":["fctr"],"align":["left"]}],"data":[{"1":"5.1","2":"3.5","3":"1.4","4":"0.2","5":"setosa"},{"1":"4.9","2":"3.0","3":"1.4","4":"0.2","5":"setosa"},{"1":"4.7","2":"3.2","3":"1.3","4":"0.2","5":"setosa"},{"1":"4.6","2":"3.1","3":"1.5","4":"0.2","5":"setosa"},{"1":"5.0","2":"3.6","3":"1.4","4":"0.2","5":"setosa"},{"1":"5.4","2":"3.9","3":"1.7","4":"0.4","5":"setosa"},{"1":"4.6","2":"3.4","3":"1.4","4":"0.3","5":"setosa"},{"1":"5.0","2":"3.4","3":"1.5","4":"0.2","5":"setosa"},{"1":"4.4","2":"2.9","3":"1.4","4":"0.2","5":"setosa"},{"1":"4.9","2":"3.1","3":"1.5","4":"0.1","5":"setosa"},{"1":"5.4","2":"3.7","3":"1.5","4":"0.2","5":"setosa"},{"1":"4.8","2":"3.4","3":"1.6","4":"0.2","5":"setosa"},{"1":"4.8","2":"3.0","3":"1.4","4":"0.1","5":"setosa"},{"1":"4.3","2":"3.0","3":"1.1","4":"0.1","5":"setosa"},{"1":"5.8","2":"4.0","3":"1.2","4":"0.2","5":"setosa"},{"1":"5.7","2":"4.4","3":"1.5","4":"0.4","5":"setosa"},{"1":"5.4","2":"3.9","3":"1.3","4":"0.4","5":"setosa"},{"1":"5.1","2":"3.5","3":"1.4","4":"0.3","5":"setosa"},{"1":"5.7","2":"3.8","3":"1.7","4":"0.3","5":"setosa"},{"1":"5.1","2":"3.8","3":"1.5","4":"0.3","5":"setosa"},{"1":"5.4","2":"3.4","3":"1.7","4":"0.2","5":"setosa"},{"1":"5.1","2":"3.7","3":"1.5","4":"0.4","5":"setosa"},{"1":"4.6","2":"3.6","3":"1.0","4":"0.2","5":"setosa"},{"1":"5.1","2":"3.3","3":"1.7","4":"0.5","5":"setosa"},{"1":"4.8","2":"3.4","3":"1.9","4":"0.2","5":"setosa"},{"1":"5.0","2":"3.0","3":"1.6","4":"0.2","5":"setosa"},{"1":"5.0","2":"3.4","3":"1.6","4":"0.4","5":"setosa"},{"1":"5.2","2":"3.5","3":"1.5","4":"0.2","5":"setosa"},{"1":"5.2","2":"3.4","3":"1.4","4":"0.2","5":"setosa"},{"1":"4.7","2":"3.2","3":"1.6","4":"0.2","5":"setosa"},{"1":"4.8","2":"3.1","3":"1.6","4":"0.2","5":"setosa"},{"1":"5.4","2":"3.4","3":"1.5","4":"0.4","5":"setosa"},{"1":"5.2","2":"4.1","3":"1.5","4":"0.1","5":"setosa"},{"1":"5.5","2":"4.2","3":"1.4","4":"0.2","5":"setosa"},{"1":"4.9","2":"3.1","3":"1.5","4":"0.2","5":"setosa"},{"1":"5.0","2":"3.2","3":"1.2","4":"0.2","5":"setosa"},{"1":"5.5","2":"3.5","3":"1.3","4":"0.2","5":"setosa"},{"1":"4.9","2":"3.6","3":"1.4","4":"0.1","5":"setosa"},{"1":"4.4","2":"3.0","3":"1.3","4":"0.2","5":"setosa"},{"1":"5.1","2":"3.4","3":"1.5","4":"0.2","5":"setosa"},{"1":"5.0","2":"3.5","3":"1.3","4":"0.3","5":"setosa"},{"1":"4.5","2":"2.3","3":"1.3","4":"0.3","5":"setosa"},{"1":"4.4","2":"3.2","3":"1.3","4":"0.2","5":"setosa"},{"1":"5.0","2":"3.5","3":"1.6","4":"0.6","5":"setosa"},{"1":"5.1","2":"3.8","3":"1.9","4":"0.4","5":"setosa"},{"1":"4.8","2":"3.0","3":"1.4","4":"0.3","5":"setosa"},{"1":"5.1","2":"3.8","3":"1.6","4":"0.2","5":"setosa"},{"1":"4.6","2":"3.2","3":"1.4","4":"0.2","5":"setosa"},{"1":"5.3","2":"3.7","3":"1.5","4":"0.2","5":"setosa"},{"1":"5.0","2":"3.3","3":"1.4","4":"0.2","5":"setosa"},{"1":"7.0","2":"3.2","3":"4.7","4":"1.4","5":"versicolor"},{"1":"6.4","2":"3.2","3":"4.5","4":"1.5","5":"versicolor"},{"1":"6.9","2":"3.1","3":"4.9","4":"1.5","5":"versicolor"},{"1":"5.5","2":"2.3","3":"4.0","4":"1.3","5":"versicolor"},{"1":"6.5","2":"2.8","3":"4.6","4":"1.5","5":"versicolor"},{"1":"5.7","2":"2.8","3":"4.5","4":"1.3","5":"versicolor"},{"1":"6.3","2":"3.3","3":"4.7","4":"1.6","5":"versicolor"},{"1":"4.9","2":"2.4","3":"3.3","4":"1.0","5":"versicolor"},{"1":"6.6","2":"2.9","3":"4.6","4":"1.3","5":"versicolor"},{"1":"5.2","2":"2.7","3":"3.9","4":"1.4","5":"versicolor"},{"1":"5.0","2":"2.0","3":"3.5","4":"1.0","5":"versicolor"},{"1":"5.9","2":"3.0","3":"4.2","4":"1.5","5":"versicolor"},{"1":"6.0","2":"2.2","3":"4.0","4":"1.0","5":"versicolor"},{"1":"6.1","2":"2.9","3":"4.7","4":"1.4","5":"versicolor"},{"1":"5.6","2":"2.9","3":"3.6","4":"1.3","5":"versicolor"},{"1":"6.7","2":"3.1","3":"4.4","4":"1.4","5":"versicolor"},{"1":"5.6","2":"3.0","3":"4.5","4":"1.5","5":"versicolor"},{"1":"5.8","2":"2.7","3":"4.1","4":"1.0","5":"versicolor"},{"1":"6.2","2":"2.2","3":"4.5","4":"1.5","5":"versicolor"},{"1":"5.6","2":"2.5","3":"3.9","4":"1.1","5":"versicolor"},{"1":"5.9","2":"3.2","3":"4.8","4":"1.8","5":"versicolor"},{"1":"6.1","2":"2.8","3":"4.0","4":"1.3","5":"versicolor"},{"1":"6.3","2":"2.5","3":"4.9","4":"1.5","5":"versicolor"},{"1":"6.1","2":"2.8","3":"4.7","4":"1.2","5":"versicolor"},{"1":"6.4","2":"2.9","3":"4.3","4":"1.3","5":"versicolor"},{"1":"6.6","2":"3.0","3":"4.4","4":"1.4","5":"versicolor"},{"1":"6.8","2":"2.8","3":"4.8","4":"1.4","5":"versicolor"},{"1":"6.7","2":"3.0","3":"5.0","4":"1.7","5":"versicolor"},{"1":"6.0","2":"2.9","3":"4.5","4":"1.5","5":"versicolor"},{"1":"5.7","2":"2.6","3":"3.5","4":"1.0","5":"versicolor"},{"1":"5.5","2":"2.4","3":"3.8","4":"1.1","5":"versicolor"},{"1":"5.5","2":"2.4","3":"3.7","4":"1.0","5":"versicolor"},{"1":"5.8","2":"2.7","3":"3.9","4":"1.2","5":"versicolor"},{"1":"6.0","2":"2.7","3":"5.1","4":"1.6","5":"versicolor"},{"1":"5.4","2":"3.0","3":"4.5","4":"1.5","5":"versicolor"},{"1":"6.0","2":"3.4","3":"4.5","4":"1.6","5":"versicolor"},{"1":"6.7","2":"3.1","3":"4.7","4":"1.5","5":"versicolor"},{"1":"6.3","2":"2.3","3":"4.4","4":"1.3","5":"versicolor"},{"1":"5.6","2":"3.0","3":"4.1","4":"1.3","5":"versicolor"},{"1":"5.5","2":"2.5","3":"4.0","4":"1.3","5":"versicolor"},{"1":"5.5","2":"2.6","3":"4.4","4":"1.2","5":"versicolor"},{"1":"6.1","2":"3.0","3":"4.6","4":"1.4","5":"versicolor"},{"1":"5.8","2":"2.6","3":"4.0","4":"1.2","5":"versicolor"},{"1":"5.0","2":"2.3","3":"3.3","4":"1.0","5":"versicolor"},{"1":"5.6","2":"2.7","3":"4.2","4":"1.3","5":"versicolor"},{"1":"5.7","2":"3.0","3":"4.2","4":"1.2","5":"versicolor"},{"1":"5.7","2":"2.9","3":"4.2","4":"1.3","5":"versicolor"},{"1":"6.2","2":"2.9","3":"4.3","4":"1.3","5":"versicolor"},{"1":"5.1","2":"2.5","3":"3.0","4":"1.1","5":"versicolor"},{"1":"5.7","2":"2.8","3":"4.1","4":"1.3","5":"versicolor"},{"1":"6.3","2":"3.3","3":"6.0","4":"2.5","5":"virginica"},{"1":"5.8","2":"2.7","3":"5.1","4":"1.9","5":"virginica"},{"1":"7.1","2":"3.0","3":"5.9","4":"2.1","5":"virginica"},{"1":"6.3","2":"2.9","3":"5.6","4":"1.8","5":"virginica"},{"1":"6.5","2":"3.0","3":"5.8","4":"2.2","5":"virginica"},{"1":"7.6","2":"3.0","3":"6.6","4":"2.1","5":"virginica"},{"1":"4.9","2":"2.5","3":"4.5","4":"1.7","5":"virginica"},{"1":"7.3","2":"2.9","3":"6.3","4":"1.8","5":"virginica"},{"1":"6.7","2":"2.5","3":"5.8","4":"1.8","5":"virginica"},{"1":"7.2","2":"3.6","3":"6.1","4":"2.5","5":"virginica"},{"1":"6.5","2":"3.2","3":"5.1","4":"2.0","5":"virginica"},{"1":"6.4","2":"2.7","3":"5.3","4":"1.9","5":"virginica"},{"1":"6.8","2":"3.0","3":"5.5","4":"2.1","5":"virginica"},{"1":"5.7","2":"2.5","3":"5.0","4":"2.0","5":"virginica"},{"1":"5.8","2":"2.8","3":"5.1","4":"2.4","5":"virginica"},{"1":"6.4","2":"3.2","3":"5.3","4":"2.3","5":"virginica"},{"1":"6.5","2":"3.0","3":"5.5","4":"1.8","5":"virginica"},{"1":"7.7","2":"3.8","3":"6.7","4":"2.2","5":"virginica"},{"1":"7.7","2":"2.6","3":"6.9","4":"2.3","5":"virginica"},{"1":"6.0","2":"2.2","3":"5.0","4":"1.5","5":"virginica"},{"1":"6.9","2":"3.2","3":"5.7","4":"2.3","5":"virginica"},{"1":"5.6","2":"2.8","3":"4.9","4":"2.0","5":"virginica"},{"1":"7.7","2":"2.8","3":"6.7","4":"2.0","5":"virginica"},{"1":"6.3","2":"2.7","3":"4.9","4":"1.8","5":"virginica"},{"1":"6.7","2":"3.3","3":"5.7","4":"2.1","5":"virginica"},{"1":"7.2","2":"3.2","3":"6.0","4":"1.8","5":"virginica"},{"1":"6.2","2":"2.8","3":"4.8","4":"1.8","5":"virginica"},{"1":"6.1","2":"3.0","3":"4.9","4":"1.8","5":"virginica"},{"1":"6.4","2":"2.8","3":"5.6","4":"2.1","5":"virginica"},{"1":"7.2","2":"3.0","3":"5.8","4":"1.6","5":"virginica"},{"1":"7.4","2":"2.8","3":"6.1","4":"1.9","5":"virginica"},{"1":"7.9","2":"3.8","3":"6.4","4":"2.0","5":"virginica"},{"1":"6.4","2":"2.8","3":"5.6","4":"2.2","5":"virginica"},{"1":"6.3","2":"2.8","3":"5.1","4":"1.5","5":"virginica"},{"1":"6.1","2":"2.6","3":"5.6","4":"1.4","5":"virginica"},{"1":"7.7","2":"3.0","3":"6.1","4":"2.3","5":"virginica"},{"1":"6.3","2":"3.4","3":"5.6","4":"2.4","5":"virginica"},{"1":"6.4","2":"3.1","3":"5.5","4":"1.8","5":"virginica"},{"1":"6.0","2":"3.0","3":"4.8","4":"1.8","5":"virginica"},{"1":"6.9","2":"3.1","3":"5.4","4":"2.1","5":"virginica"},{"1":"6.7","2":"3.1","3":"5.6","4":"2.4","5":"virginica"},{"1":"6.9","2":"3.1","3":"5.1","4":"2.3","5":"virginica"},{"1":"5.8","2":"2.7","3":"5.1","4":"1.9","5":"virginica"},{"1":"6.8","2":"3.2","3":"5.9","4":"2.3","5":"virginica"},{"1":"6.7","2":"3.3","3":"5.7","4":"2.5","5":"virginica"},{"1":"6.7","2":"3.0","3":"5.2","4":"2.3","5":"virginica"},{"1":"6.3","2":"2.5","3":"5.0","4":"1.9","5":"virginica"},{"1":"6.5","2":"3.0","3":"5.2","4":"2.0","5":"virginica"},{"1":"6.2","2":"3.4","3":"5.4","4":"2.3","5":"virginica"},{"1":"5.9","2":"3.0","3":"5.1","4":"1.8","5":"virginica"}],"options":{"columns":{"min":{},"max":[10]},"rows":{"min":[10],"max":[10]},"pages":{}}}
  </script>
</div>
</div>
