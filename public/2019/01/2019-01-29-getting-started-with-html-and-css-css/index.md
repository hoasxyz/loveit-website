# Getting Started with HTML and CSS -- CSS

  Learning abstract from [*Head First HTML and CSS, 2nd Edition*](http://file.allitebooks.com/20150518/Head%20First%20HTML%20and%20CSS,%202nd%20Edition.pdf).
<img src="https://www.cfideas.com/wp-content/uploads/2018/08/html5-css3.png" alt="HTML&CSS" width="100%" height="100%">
<!--more-->

<center>
# Adding a Little Style
</center>

  The priority level of CSS is:https://developer.mozilla.org/zh-CN/docs/Web/CSS/Specificity#%E4%BC%98%E5%85%88%E7%BA%A7%E6%98%AF%E5%A6%82%E4%BD%95%E8%AE%A1%E7%AE%97%E7%9A%84%EF%BC%9F.

  The basic construct of HTML is:
  
  <img src="../!image/HTMLconstruct.png" alt="HTML&CSS" width="100%" height="100%">
  
   there are lots of properties that can be set on elements, certainly more than you’d want to memorize, in any case. So you can refer to http://file.allitebooks.com/20180505/CSS%20Pocket%20Reference,%205th%20Edition.pdf.
   
## p {}

  `p {}` select all the paragraphs in the same HTML. But the style of `<q>` element in paragraphs is not changed. eg.
  
```html
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Head First Lounge</title>
<style>
p {
 color: maroon;
}
</style>
</style>
</head>
...
</html>
```
  
## h1,h2 {}

  To write a rule for more than one element, just put commas between the selectors, like “h1, h2”.
  
```html
<style>
h1, h2 {
 font-family: sans-serif;
 color: gray;
 border-bottom: 1px solid black;
}
</style>
```
  
  Separate and specify an other rule just for `<h1>`:
  
```html
<style>
h1, h2 {
 font-family: sans-serif;
 color: gray;
}
h1 {
 border-bottom: 1px solid black;
}
<!--An `underline` is only shown under the text itself. -->
</style>
```

## CSS file

  CSS file only contains CSS.
  
```css
h1, h2 {
 font-family: sans-serif;
 color: gray;
 }
h1 {
 border-bottom: 1px solid black;
 }
p {
 color: maroon;
 }

```

  To link a CSS file in HTML file:
  
```html
<!doctype html>
<html>
 <head>
 <meta charset="utf-8">
 <title>Head First Lounge</title>
 <link type="text/css" rel="stylesheet" href="lounge.css">
 <!--<style> No need!
 </style>-->
 </head>
...
</html>
```
   To write a comment in your CSS, just enclose it between `/*` and `*/`.  eg.
   
```css
/* this rule will have no effect because it's in a comment:
p { color: blue; } */

```

## class

```css
p.greentea {
 color: green;
 }

/* If you want all elements that are in the greentea class to have one style.*/
.greentea {
 color: green;
 }
```

```html
<p class="greentea">
 <img src="../images/green.jpg" alt="Green Tea">
 Chock full of vitamins and minerals, this elixir combines the healthful benefits of green tea with a twist of chamomile blossoms and ginger root.
</p>

<!--Elements can be in more than one class.-->
<p class="greentea raspberry blueberry">
```

## `@font-face`

  This rule allows you to define the name and location of a font that can then be used in your page. And the actual format used to store the fonts isn’t quite yet a standard. There are some common format:
  
  * TrueType fonts: `.ttf`
  
  * OpenType fonts: `.otf`
  
  * Embedded OpenType fonts: `.eot`
  
  * SVG fonts: `.svg`
  
  * Web open font format: `.woff`

```css
@font-face {
	font-family: "Emblema One";
	src: url("http://wickedlysmart.com/hfhtmlcss/chapter8/journal/EmblemaOne-Regular.woff"), 
	     url("http://wickedlysmart.com/hfhtmlcss/chapter8/journal/EmblemaOne-Regular.ttf"); 
}
body {
  font-family:     Verdana, Geneva, Arial, sans-serif;
  font-size:       small;
}
h1, h2 {
  color:           #cc6600;
  border-bottom:   thin dotted #888888;
}
h1 {
  font-family:     "Emblema One", sans-serif;
  font-size:       220%;
}
h2 {
  font-size:       130%;
  font-weight:     normal;
}
blockquote {
  font-style:      italic;
}
```

## handling with fonts

  Font server recommendation: [FontSquirrel](http://www.fontsquirrel.com/).
  
  Adjusting font sizes:
  
  * px.
  
  * %.
  
  * em.

```css
body {
 font-size: 14px;
}

/*Here we’ve specified a body font size in pixels, and a level-one heading as 150%. */
h1 {
 font-size: 150%;
}

/*Your <h2> headings will be 1.2 times the font size of the parent element, which in this case is 1.2 times 14px, which is about 17px.*/
h2 {
 font-size: 1.2em;
}

/*More...
xx-small
x-small
small
medium
large
x-large
xx-large*/
body {
 font-size: small;
}
```

```css
h1 {
font-weight: bold;
font-style: italic;
}
h2 {
font-weight: normal;
font-style: oblique;
}
```

## web colors

  * Specify color by name.
  
```css
body {
 background-color: silver;
}
```

  * Specify color in red, green, and blue values.

```css
body {
 background-color: rgb(80%, 40%, 0%);
}
body {
 background-color: rgb(204, 102, 0);
}
```
  
  * Specify color using hexadecimal(hex) codes.
  
```css
body {
 background-color: #cc6600;
}
```

{{% admonition info "The two-minute guide to hex codes" %}}

Each set of two digits represents a number from 0 to 255.

<img src="/post/!image/hexrgb.png" alt="rgb" width="100%" height="100%">
<img src="/post/!image/hexfinger.png" alt="finger" width="100%" height="100%">
<img src="/post/!image/hexnumber.png" alt="number" width="100%" height="100%">
<img src="/post/!image/hexsamenumber.png" alt="same number" width="100%" height="100%">
{{% /admonition %}}

<center>
# Getting Intimate with Elements
</center>

## the box model

  The box model is how CSS sees elements. CSS treats every single element as if it were represented by a box. Let’s see what that means.
  
  <img src="/post/!image/boxmodel.png" alt="box model" width="100%" height="100%">
 
 The elements of the box model:
 
 * content,
 
 * padding,
 
 * border,
 
 * margin.
 
  <img src="/post/!image/boxmodelconstruct.png" alt="box model construct" width="100%" height="100%">
  
```css
 .guarantee {
 line-height: 1.9em;
 font-style: italic;
 font-family: Georgia, "Times New Roman", Times, serif;
 color: #444444;
 border-color: black;
 border-width: 1px;
 border-style: solid;
 background-color: #a7cece;
 padding: 25px;
 margin: 30px;
 background-image: url(images/background.gif);
 background-repeat: no-repeat;
 background-position: top left;
 }
```

  We refer to [*Head First HTML and CSS, 2nd Edition*](http://file.allitebooks.com/20150518/Head%20First%20HTML%20and%20CSS,%202nd%20Edition.pdf) for more settings of border.
  
## select by id

```html
<p id="footer">Please steal this page, it isn't copyrighted in any way</p> 
```

```css
/*This selects any element that has the id “footer”.*/
#footer {
 color: red;
}

/*This selects a <p> element if it has the id “footer”.*/
p#footer {
 color: red;
}
```

  The difference of naming rules of id and class: Class names should begin with a letter, but id names can start with a number or a letter. Both id and class names can contain letters and numbers as well as the _ character, but no spaces.
  
## out of browser

  If you want to tailor your page’s style to the type of device your page is being displayed on (desktops, laptops, tablets, smartphones, or even printed versions of your pages). 
  
```html
<!--Here our query specifies anything with a screen (as opposed to, say, a printer, or 3D glasses, or a braille reader) and any device that has a width of at most 480 pixels. -->
<link href="lounge-mobile.css" rel="stylesheet" media="screen and (max-device-width: 480px)">
```

  Likewise, we could create a query that matches the device if it is a printer, like this:
  
```html
<!--The lounge-print.css file is only going to be used if the media type is “print”, which means we’re viewing it on a printer. -->
<link href="lounge-print.css" rel="stylesheet" media="print">
```

  There are a variety of propeties you can use in your queries, like `mindevice-width`, `max-device-width` (which we just used), and the `orientation` of the display (landscape or portrait), to name just a few. And keep in mind you can add as many <link> tags to your HTML as necessary to cover all the devices you need to. 
  
  Add media queries right into your CSS:

```css
/*These rules will be used if the screen is wider than 480px*/
@media screen and (min-device-width: 481px) {
 #guarantee {
 margin-right: 250px;
 }
}

/*These rules will be used if the screen is 480px or less...*/
@media screen and (max-device-width: 480px) {
 #guarantee {
 margin-right: 30px;
 }
}
@media print {
 body {
 font-family: Times, "Times New Roman", serif;
 }
}
p.specials {
 color: red;
}
```

<center>
# Advanced Web Construction
</center>

## identifying the logical sections -- `<div>`

  Use, don’t abuse, `<div>`s in your pages. Add more structure where it helps you separate a page into logical sections for clarity and styling. Adding `<div>`s just for the sake of creating a lot of structure in your pages complicates them with no real benefit.

  <img src="/post/!image/divstyle.png" alt="div style" width="100%" height="100%">

  <img src="/post/!image/divaddsos.png" alt="adding structure on structure">
  
```html
<div id="elixirs">
...
</div> 
```

```css
#elixirs {
 border-width: thin;
 border-style: solid;
 border-color: #007e7e;
 width: 200px;
 padding-right: 20px;
 padding-bottom: 20px;
 padding-left: 20px;
 margin-left: 20px;
 text-align: center; /* `text-align` will align all the **inline content** in a block element.*/
 /* And the `text-align` property should be set on **block elements** only. */
 background-image: url(images/cocktail.gif);
 background-repeat: repeat-x;
}

}
```

## select descendants
  
```css
/*This rule says to select any `<h2>` that is a descendant of a `<div>`, with space.*/
div h2 {
 color: black;
}

/*This rule says to select any `<h2>` that is a descendant of an element with the id “elixirs”.*/
#elixirs h2 {
 color: black;
}
```

## shortcut

  <img src="/post/!image/shortcut1.png" alt="short cut2">

  <img src="/post/!image/shortcut2.png" alt="short cut2">
  
  For fonts:
  
  <img src="/post/!image/shortcut3.png" alt="short cut3">
  
  <img src="/post/!image/shortcut4.png" alt="short cut4">
  
## `<span>`

  `<span>` elements give you a way to logically separate inline content in the same way that `<div>`s allow you to create logical separation for block-level content. 
  
```html
<ul>
<li><span class="cd">Buddha Bar</span>, <span class="artist">Claude Challe</span></li>
<li>When It Falls, Zero 7</li>
<li>Earth 7, L.T.J. Bukem</li>
<li>Le Roi Est Mort, Vive Le Roi!, Enigma</li>
<li>Music for Airports, Brian Eno</li>
</ul>
```

```css
.cd {
 font-style: italic;
}

.artist {
 font-weight: bold;
}
```

## for `<a>`

```css
a:link {
 color: green;
}
a:visited {
 color: red;
}
a:hover {
 color: yellow;
}
```

  Add these rules to the bottom of your “lounge.css” file and then save and reload “lounge.html”. Play around with the links to see them in each state. Note that you might have to clear your browser history to see the unvisited color (green). 
  
## Pseudo-class

  

```css
/*On these two, we’re setting the color. For unvisited links, a nice aquamarine… */
#elixirs a:link {
 color: #007e7e;
}

/*…and for visited links we’re using a dark gray. */
#elixirs a:visited {
 color: #333333;
}

/*Now for the really interesting rule. When the user is hovering over the link, we’re changing the background to red. This makes the link loo highlighted when you pass the mouse over it. Give it a try*/
#elixirs a:hover {
 background: #f88396;
 color: #0d5353;
}
```

## the cascade

  Here’s just one last piece of information you need to understand the cascade. You already know about using multiple stylesheets to either better organize your styles or to support different types of devices. But there are actually some other stylesheets hanging around when your users visit your pages. Let’s take a look:
  
  <img src="/post/!image/cascade.png" alt="understanding for cascade" width="100%" height="100%">
  
   as the page authors, we can use multiple stylesheets with our HTML. And the user might also supply his own styles, and then the browser has its default styles, too. And on top of all that, we might have multiple selectors that apply to the same element. How do we figure out which styles an element gets?
   
  That’s actually another way of asking what cascade does. The cascade is the way the browser decides, given a bunch of styles in a bunch of stylesheets, which style is going to be used. To answer that question, we need to bring everything together—all the various stylesheets hanging around, the rules, and the individual property declarations in those rules.

<center>
# HTML5 Markup
</center>

  There are many new markups that can substitute `<div>`.
  
## navigation

```html
<header>
  <nav>
 <ul>
 <li><a href="index.html">HOME</a></li>
 <li class="selected"><a href="blog.html">BLOG</a></li>
 <li><a href="">INVENTIONS</a></li>
 <li><a href="">RECIPES</a></li>
 <li><a href="">LOCATIONS</a></li>
 </ul>
 </nav>
</header>
```

  And you should add CSS style:
  
```css
nav {
 background-color: #efe5d0;
 margin: 10px 10px 0px 10px;
}
nav ul {
 margin: 0px;
 list-style-type: none;
 padding: 5px 0px 5px 0px;
}
nav ul li {
 display: inline;
 padding: 5px 10px 5px 10px;
}
nav ul li a:link, nav ul li a:visited {
 color: #954b4b;
 border-bottom: none;
 font-weight: bold;
}
nav ul li.selected {
 background-color: #c8b99c;
}
```

## video

  <img src="/post/!image/video1.png" alt="How does the video element work?" width="100%" height="100%">
  
  How to juggle all those video formats? In either case, you can use one `<source>` element (not to be confused with the src attribute) per format inside a `<video>` element to provide a set of videos, each with its own format, and let the browser pick the first one it supports. Like this:

```html 
<video controls autoplay width="512" height="288"
 ~~src="video/tweetsip.mp4"~~>
 <source src="video/tweetsip.mp4">
 <source src="video/tweetsip.webm">
 <source src="video/tweetsip.ogv">
 <p>Sorry, your browser doesn't support the video element</p>
</video>
```

<center>
# Arranging Elements
</center>

## flow

  The Flow is what gives a CSS master his power. Flow is actually what the browser uses to lay out a page of HTML elements. The browser starts at the top of any  HTML file and follows the flow of elements from top to bottom, displaying each element it encounters.
  
## float

  The `float` property first takes an element and floats it as far left or right as it can (based on the value of float). It then flows all the content below it around the element. 
  
### How to float an element?
  
  - First, give it an identity(id). For example, id = "amazing".
  
  - Now give it a width.
  
```css
#amazing {
 width: 200px;
}
```
  
  - Now float it.  It also removes the paragraph from the flow, like it’s floating on the page.  Because the floated paragraph has been removed from the normal flow, the block elements are filled in, like the paragraph isn’t even there. But when the inline elements are positioned, they respect the boundaries of the floated element. So they are flowed around it.

```css
#amazing {
 width: 200px;
 float: right;
}
```
  
### solving the overlap problem

<img src="/post/!image/solveoverlap.png" alt="solve overlap" width="100%" height="100%">

```css
#footer {
 background-color: #675c47;
 color: #efe5d0;
 text-align: center;
 padding: 15px;
 margin: 10px;
 font-size: 90%;
 clear: right;
}
```

## Jello

  Jello layouts lock down the width of the content area in the page, but center it in the browser.

```css
#allcontent {
 width: 800px;
 padding-top: 5px;
 padding-bottom: 5px;
 background-color: #675c47;
 /*below*/
 margin-left: auto;
 margin-right: auto;
}
```

## absolute positioning

```css
#sidebar {
 position: absolute;
 top: 100px;
 right: 200px;
 width: 280px;
}
```
## CSS table display

  CSS table display allows you to display block elements in a table with rows and columns (you’ll see how in just a sec), and, by putting your content in a CSS table, you can easily create multicolumn designs with HTML and CSS.
  
```html
...
<div id="tableContainer">
 <div id="tableRow">
 <div id="main">
 ...
 </div>
 <div id="sidebar">
 ...
 </div>
 </div>
</div>
...
```
```css
#tableContainer {
 display: table;
 border-spacing: 10px;
}
#tableRow {
 display: table-row;
}
#main {
 display: table-cell;
 background: #efe5d0 url(images/background.gif) top left;
 font-size: 105%;
 padding: 15px;
 ~~margin: 0px 10px 10px 10px;~~
 vertical-align: top;
}
#sidebar {
 display: table-cell;
 background: #efe5d0 url(images/background.gif) bottom right;
 font-size: 105%;
 padding: 15px;
 ~~margin: 0px 10px 10px 10px;~~
 vertical-align: top;
}

#header {
 background-color: #675c47;
 ~~margin: 10px;~~
 margin: 10px 10px 0px 10px;
 height: 108px;
}
#footer {
 background-color: #675c47;
 color: #efe5d0;
 text-align: center;
 padding: 15px;
 ~~margin: 10px;~~
 margin: 0px 10px 10px 10px;
 font-size: 90%;
}
```

### insert photos
  And photos can also float in web pages using <div>:
  
```html
<div id="award">
 <img src="images/award.gif"
 alt="Roaster of the Year award">
</div>
```

```css
#award {
 position: absolute;
 top: 30px;
 left: 365px;
}
```

  How does fixed positioning work?
  
```css
#coupon {
 position: fixed;
 top: 300px;
 left: 100px;
}
```
