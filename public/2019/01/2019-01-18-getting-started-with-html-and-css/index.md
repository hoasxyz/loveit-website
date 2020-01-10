# Getting Started with HTML and CSS -- HTML


  It's learning abstract from [*Head First HTML and CSS, 2nd Edition*](http://file.allitebooks.com/20150518/Head%20First%20HTML%20and%20CSS,%202nd%20Edition.pdf).
<img src="/post/!image/HTML&CSS.png" alt="HTML&CSS" width="100%" height="100%">
<!--more-->
<center>
# Relative Path(HT)
</center>

  A relative path is a link that points to other files on your website relative to the web page you’re linking from. 
  
{{% admonition warning "warning" %}}
Blank space isn't permitted in the names of files and folders.
{{% /admonition %}}

## for `.html` file

```html
<a href="directions.html">detailed directions</a>
```

 * `href` means hypertextreference.
 
 * the `directions.html` file must be in the same parent file as the `.html` file.
 
 * use dot dot `..` to trace the parent file.

    * if you want to go up two folders, you’d type `../..` and so on.
    
    * the limit to how far up you can go -- the root of your website.
    
    * in web pages you always use `/` (forward slash). Don’t use `\` (backslash). 
    
 
```html
<a href="../lounge.html"> Back to the Lounge</a>
```
    
## for images

```html
<img src="drinks.gif">
```

{{% admonition warning "warning" %}}
In **blogdown**/hugo, the root file is `public`. And the posts are in `public/post`.
{{% /admonition %}}

<center>
# Web Page Construction
</center>

## citation/quotation

  Some browsers use double quotes as the default style of citation, some use italics, and some use nothing at all. The only way to really determine how they’ll look is to style them yourself.

### `<q>`

  * The difference between `<q>` and double quotation marks `""`.
  
  * `<q>` is applied in **inline** citation, as a part of one paragraph.
  
### `<blockquote>`

  * `<blockquote>` is applied in **block** citation, as another paragraph, which has the indent automatically.
  
  * `<q>` can be inserted in `<blockquote>`.
  
  * Linebreak elements `<br>`(or`<br/>`) can be used in `<blockquote>`.
  
## void element

  Elements that don’t have any content by design are called void elements. When you need to use a void element, like `<br>` or `<img>`, you only use an opening tag. This is a convenient shorthand that reduces the amount of markup in your HTML.
  
## list

  Put each **l**ist **i**tem in an `<li>` element. eg.
  
```html
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
```
---
  - ordered list

  Enclose the list items with the `<ol>` element. eg.
  
```html
<ol start="5">
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol>

<ol type="a"> <!--or `A`-->
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol>

<ol type="i"> <!--or `I`-->
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol>
```

<ol start="5">
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol>

<ol type="a">
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol>

<ol type="i"> <!--or `I`-->
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ol> 

---

  - unordered list

  Enclose the list items with the `<ul>` element.
  
```html
<ul>
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ul>
```

<ul>
      <li>Walla Walla, WA</li> 
      <li>Magic City, ID</li> 
      <li>Bountiful, UT</li>
      <li>Last Chance, CO</li>
      <li>Truth or Consequences, NM</li>
      <li>Why, AZ</li> 
</ul>

```html
<ul type="disc">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="circle">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="square">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  
```

<ul type="disc">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="circle">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul>  

<ul type="square">
 <li>苹果</li>
 <li>香蕉</li>
 <li>柠檬</li>
 <li>桔子</li>
</ul> 

---

  - nested list

```html
<ul>
  <li>咖啡</li>
  <li>茶
    <ul>
    <li>红茶</li>
    <li>绿茶
      <ul>
      <li>中国茶</li>
      <li>非洲茶</li>
      </ul>
    </li>
    </ul>
  </li>
  <li>牛奶</li>
</ul>
```

<ul>
  <li>咖啡</li>
  <li>茶
    <ul>
    <li>红茶</li>
    <li>绿茶
      <ul>
      <li>中国茶</li>
      <li>非洲茶</li>
      </ul>
    </li>
    </ul>
  </li>
  <li>牛奶</li>
</ul>

```html
<ol>
 <li>Charge Segway</li>
 <li>Pack for trip
 <ul>
 <li>cell phone</li>
 <li>iPod</li>
 <li>digital camera</li>
 <li>a protein bar</li>
 </ul>
 </li>
 <li>Call mom</li>
</ol>
```

<ol>
 <li>Charge Segway</li>
 <li>Pack for trip
 <ul>
 <li>cell phone</li>
 <li>iPod</li>
 <li>digital camera</li>
 <li>a protein bar</li>
 </ul>
 </li>
 <li>Call mom</li>
</ol>

---

  - definition list

  Each item in the list has definition terms `<dt>` and definition description `<dd>`.

```html
<dl>
 <dt>Burma Shave Signs</dt>
 <dd>Road signs common in the U.S. in
the 1920s and 1930s advertising shaving
products.</dd>
 <dt>Route 66</dt>
 <dd>Most famous road in the U.S. highway
system.</dd>
</dl>
```

<dl>
 <dt>Burma Shave Signs</dt>
 <dd>Road signs common in the U.S. in
the 1920s and 1930s advertising shaving
products.</dd>
 <dt>Route 66</dt>
 <dd>Most famous road in the U.S. highway
system.</dd>
</dl>

## character entity

  for any character that is considered “special” or that you’d like to use in your web page, but that may not be a typeable character in your editor (like a copyright symbol), you just look up the abbreviation and then type it into your HTML. For example, the > character’s abbreviation is `&gt;` and the < character’s is `&lt;`. 
  
  If you’d like to have an `&` in your HTML content, use the character entity `&amp;` instead of the `&` character itself.

```html
  The &lt;html&gt; element rocks. And &amp;.
```

  The &lt;html&gt; element rocks. And &amp;.
  
  And other common ones are available at: http://www.w3schools.com/tags/ref_entities.asp. Or, for a more exhaustive list, use this URL: http://www.unicode.org/charts/.

## id

  <a href="#relative-path-ht">Back to top(the same web page)</a>. And before this, you should know the id of each point you want to arrive.
  
  Insert audio in website? You can use the two kind of links:
  
```html
 <a target="_blank" title="索引" href="/post/terrylin/index.html#索引">御龙将军（uncover）</a> 
 or [御龙将军（cover）](https://hoas.xyz/post/terrylin/#索引).
```
  
  <a target="_blank" title="索引" href="/post/terrylin/index.html#索引">御龙将军（uncover）</a> or [御龙将军（cover）](https://hoas.xyz/post/terrylin/#索引).
  
   If you give the name `_blank` to the targets in all your `<a>` elements, then each link will open in a new blank window. However, this is a good question because it brings up an important point: you don’t actually have to name your target `_blank`. If you give it another name, say, `coffee`, then all links with the target name `coffee` will open in the same window. The reason is that when you give your target a specific name, like `coffee`, you are really naming the new window that will be used to display the page at the link. `_blank` is a special case that tells the browser to always use a new window.

## image

  the `<img>` element is an inline element. To make links out of images, for example:

```html
<a href="https://www.bilibili.com/video/av26844990?from=search&seid=4942272683409810113">
 <img src="/post/!image/terrylin.jpg"
 alt="林志炫">
</a>
```

<a href="../terrylin/index.html#御龙将军">
 <img src="../!image/terrylin.jpg"
 alt="林志炫">
</a>

  In this example the link fails because [`fancybox = true`](https://github.com/fancyapps/fancybox).
  
  A width of less than 800 pixels is a good rule of thumb for the size of photo images in a web page. And more details of different formats of images(JPEG,GIF,PNG) are in the book.

<center>  
# Getting Serious with HTML
</center>

  When the browser sees: `<!doctype html>`, it assumes you’re using standard HTML. No more getting all hung up on version numbers or where the standard is located. If you insert the `<!doctype html>` in the `.html` file, this page will be updated to HTML5.
  
## backwards compatibility

  Backwards compatibility means that we can keep adding new stuff to HTML, and the browsers will (eventually) support this new stuff, but they’ll also keep supporting the old stuff. So the HTML pages you’re writing today will keep working, even after new features have been added later.
  
## the W3C validator

  There are three ways you can check your HTML/web by using [the W3C validator](https://validator.w3.org/): 

  * If your page is on the Web, then you can type in the URL here(Validate by URI) and click the Check button, and the service will retrieve your HTML and check it.
  
  * You can choose the second tab(Validate by File Upload), and upload a file from your computer. When you’ve selected the file, click Check, and the browser will upload the page for the service to check.
  
  * Or, choose the third tab(Validate by direct input), and copy and paste your
HTML into the form on that tab. Then click Check and the service will check your HTML.

## specify the character encoding

  Luckily, the world has now standardized on the Unicode character encoding. With Unicode, we can represent all languages with one type of encoding. But, given there are other encodings out there, we still need to tell the browser we’re using Unicode (or another encoding of your choice). To specify Unicode for your web pages, you’ll need a `<meta>` tag in your HTML that looks like this:
   
  `<meta charset="utf-8">`
  
  The `<meta>` tag belongs in the `<head>` element and you shoudl add this line above any other elements in the `<head>` element. And "utf-8" is the version we use for web pages.
  
## alt attribute

  *  If your image is broken for some reason (say, your image server goes down, or your connection is really slow), the alt attribute will (in most browsers) show the alt text you’ve specified in place of the image.
  
  *  For vision-impaired users who are using a screen reader to read the page, the screen reader will read the alt text to the user, which helps them understand the page better.
  
<center>
# Interactive
</center>

## different inputs

  One simple form:

```html
<form action="https://www.douban.com/"
 method="POST">
 <p>Just type in your name (and click Submit) to
 enter the contest: <br>
 First name: <input type="text" name="firstname" value=""> <br>
 Last name: <input type="text" name="lastname" value=""> <br>
 <input type="submit">
 </p>
 </form>
```

<form action="https://www.douban.com/"
 method="POST">
 <p>Just type in your name (and click Submit) to
 enter the contest: <br>
 First name: <input type="text" name="firstname" value=""> <br>
 Last name: <input type="text" name="lastname" value=""> <br>
 <input type="submit">
 </p>
 </form>
 
  What can go in a form?
  
  - text input
  
```html
  <input type="text" name="fullname">
```
  <input type="text" name="fullname">
  
  - submit input
  
```html
<input type="submit" value="Submit">
```

<input type="submit" value="Submit">
  
  - radio input
  
```html
<input type="radio" name="hotornot" value="hot">
<input type="radio" name="hotornot" value="not">
```

<input type="radio" name="hotornot" value="hot"> hot

<input type="radio" name="hotornot" value="not"> not

  - checkbox input
  
```html
<input type="checkbox" name="spice" value="Salt">
<input type="checkbox" name="spice" value="Pepper">
<input type="checkbox" name="spice" value="Garlic">
```

<input type="checkbox" name="spice" value="Salt"> Salt

<input type="checkbox" name="spice" value="Pepper"> Pepper

<input type="checkbox" name="spice" value="Garlic"> Garlic

  - textarea
  
```html
<textarea name="comments" rows="10" cols="48"></textarea>
```
Customer feedback:

<textarea name="comments" rows="10" cols="48"></textarea>

  - select&option
  
```html
<select name="characters">
 <option value="Buckaroo">Buckaroo Banzai</option>
 <option value="Tommy">Perfect Tommy</option>
 <option value="Penny">Penny Priddy</option>
 <option value="Jersey">New Jersey</option>
 <option value="John">John Parker</option>
</select>
```

<select name="characters">
 <option value="Buckaroo">Buckaroo Banzai</option>
 <option value="Tommy">Perfect Tommy</option>
 <option value="Penny">Penny Priddy</option>
 <option value="Jersey">New Jersey</option>
 <option value="John">John Parker</option>
</select>

  - number input
  
```html
<input type="number" min="0" max="20">
```

<input type="number" min="0" max="20">

  - range input
  
```html
<input type="range" min="0" max="20" step="5">
```

<input type="range" min="0" max="20" step="5">

  - color input
  
```html
<input type="color">
```

<input type="color">

  - date input
  
```html
<input type="date">
```

Date: <input type="date">

  - email input
  
```html
<input type="email">
```

Email: <input type="email">

  - tel input
  
```html
<input type="tel">
```

Tel: <input type="tel">

  - url input
  
```html
<input type="url">
```

URL: <input type="url">

  - reset
  
```html
<input type="reset" name="submit2" value="重置">
```

<input type="reset" name="submit2" value="重置">

  - file
  
  - image
  
  - hidden

## integrate

```html
<form action="http://starbuzzcoffee.com/processorder.php" method="post">
 <div class="tableRow">
 <p>
 Choose your beans:
 </p>
 <p>
 <select name="beans">
 <option value="House Blend">House Blend</option>
 <option value="Bolivia">Shade Grown Bolivia Supremo</option>
 <option value="Guatemala">Organic Guatemala</option>
 <option value="Kenya">Kenya</option>
 </select>
 </p>
 </div>
 <div class="tableRow">
 <p> Type: </p>
 <p>
 <input type="radio" name="beantype" value="whole"> Whole bean<br>
 <input type="radio" name="beantype" value="ground" checked> Ground
 </p>
 </div>
 <div class="tableRow">
 <p> Number of bags: </p>
 <p> <input type="number" name="bags" min="1" max="10"> </p>
 </div>
 <div class="tableRow label">
 <p> Must arrive by date: </p>
 <p> <input type="date" name="date"> </p>
 </div>
 <div class="tableRow">
 <p> Extras:  </p>
 
 <p> PAY ATTENTION TO extras[]!</p>
 <p>
 <input type="checkbox" name="extras[]" value="giftwrap"> Gift wrap<br>
 <input type="checkbox" name="extras[]" value="catalog" checked>
 Include catalog with order
 </p>
 </div>
 <div class="tableRow">
 <p class="heading"> Ship to </p>
 <p></p>
 </div>
 <div class="tableRow">
 <p> Name: </p>
 <p> <input type="text" name="name" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Address: </p>
 <p> <input type="text" name="address" value=""> </p>
 </div>
 <div class="tableRow">
 <p> City: </p>
 <p> <input type="text" name="city" value=""> </p>
 </div>
 <div class="tableRow">
 <p> State: </p>
 <p> <input type="text" name="state" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Zip: </p>
 <p> <input type="text" name="zip" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Phone: </p>
 <p> <input type="tel" name="phone" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Customer Comments: </p>
 <p>
 <textarea name="comments" rows="10" cols="48"></textarea>
 </p>
 </div>
 <div class="tableRow">
 <p></p>
 <p> <input type="submit" value="Order Now"> </p>
 </div>
</form>
```

<form action="http://starbuzzcoffee.com/processorder.php" method="post">
 <div class="tableRow">
 <p>
 Choose your beans:
 </p>
 <p>
 <select name="beans">
 <option value="House Blend">House Blend</option>
 <option value="Bolivia">Shade Grown Bolivia Supremo</option>
 <option value="Guatemala">Organic Guatemala</option>
 <option value="Kenya">Kenya</option>
 </select>
 </p>
 </div>
 <div class="tableRow">
 <p> Type: </p>
 <p>
 <input type="radio" name="beantype" value="whole"> Whole bean<br>
 <input type="radio" name="beantype" value="ground" checked> Ground
 </p>
 </div>
 <div class="tableRow">
 <p> Number of bags: </p>
 <p> <input type="number" name="bags" min="1" max="10"> </p>
 </div>
 <div class="tableRow label">
 <p> Must arrive by date: </p>
 <p> <input type="date" name="date"> </p>
 </div>
 <div class="tableRow">
 <p> Extras:  </p>
 
 <p> PAY ATTENTION TO `extras[]`!</p>
 <p>
 <input type="checkbox" name="extras[]" value="giftwrap"> Gift wrap<br>
 <input type="checkbox" name="extras[]" value="catalog" checked>
 Include catalog with order
 </p>
 </div>
 <div class="tableRow">
 <p class="heading"> Ship to </p>
 <p></p>
 </div>
 <div class="tableRow">
 <p> Name: </p>
 <p> <input type="text" name="name" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Address: </p>
 <p> <input type="text" name="address" value=""> </p>
 </div>
 <div class="tableRow">
 <p> City: </p>
 <p> <input type="text" name="city" value=""> </p>
 </div>
 <div class="tableRow">
 <p> State: </p>
 <p> <input type="text" name="state" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Zip: </p>
 <p> <input type="text" name="zip" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Phone: </p>
 <p> <input type="tel" name="phone" value=""> </p>
 </div>
 <div class="tableRow">
 <p> Customer Comments: </p>
 <p>
 <textarea name="comments" rows="10" cols="48"></textarea>
 </p>
 </div>
 <div class="tableRow">
 <p></p>
 <p> <input type="submit" value="Order Now"> </p>
 </div>
</form>

  Reload the page, fill in the text inputs, and submit the form. When you do that, the browser will package up the data and send it to the URL in the action attribute, which is at starbuzzcoffee.com. And if you want your customers to get their form, you can set `method` to `GET`.
  
## extra elements

  - fieldsheet

```html
<fieldset>
 <legend>Condiments</legend>
 <input type="checkbox" name="spice" value="salt">
 Salt <br>
 <input type="checkbox" name="spice" value="pepper">
 Pepper <br>
 <input type="checkbox" name="spice" value="garlic">
 Garlic
</fieldset>
```

<fieldset>
 <legend>Condiments</legend>
 <input type="checkbox" name="spice" value="salt">
 Salt <br>
 <input type="checkbox" name="spice" value="pepper">
 Pepper <br>
 <input type="checkbox" name="spice" value="garlic">
 Garlic
</fieldset>

  - passwords
  
```html
<input type="password" name="secret">
```

<input type="password" name="secret">

<center>
# Tabulate
</center>

```html
 <table border="5" bordercolor="#66CCFF" cellspacing="6" cellpadding="5" bgcolor="#FFCCFF">
  <caption>The cities I visited on my Segway'n USA travels</caption>
 <thead bgcolor="#FF33FF">
 <tr>
 <th>City</th>
 <th>Date</th>
 <th>Temperature</th>
 <th>Altitude</th>
 <th>Population</th>
 <th>Diner Rating</th>
 </tr>
 </thead>
 <tbody bgcolor="#CC99FF">
 <tr>
 <td class="right">Walla Walla, WA</td>
 <td>June 15th</td>
 <td>75</td>
 <td>1,204 ft</td>
 <td>29,686</td>
 <td>4/5</td>
 </tr>
 <tr>
 <td>Magic City, ID</td>
 <td>June 25th</td>
 <td>74</td>
 <td>5,312 ft</td>
 <td>50</td>
 <td>3/5</td>
 </tr>
 <tr>
 <td>Bountiful, UT</td>
 <td>July 10th</td>
 <td>91</td>
 <td>4,226 ft</td>
 <td>41,173</td>
 <td>4/5</td>
 </tr>
 <tr>
 <td>Last Chance, CO</td>
 <td>July 23rd</td>
 <td class="right">102</td>
 <td>4,780 ft</td>
 <td>265</td>
 <td>3/5</td>
 </tr>
 <tr>
 <td>Truth or Consequences, NM</td>
 <td>August 9th</td>
 <td>93</td>
 <td>4,242 ft</td>
 <td>7,289</td>
 <td>5/5</td>
 </tr>
 <tr>
 <td>Why, AZ</td>
 <td>August 18th</td>
 <td>104</td>
 <td>860 ft</td>
 <td>480</td>
 <td>3/5</td>
 </tr>
 </tbody>
 <tfoot bgcolor="#FFCCFF">
 <tr>
 <td colspan="6" align="center">biubiubiu</td>
 </tr>
 </tfoot>
 </table>
```

 <table border="5" bordercolor="#66CCFF" cellspacing="6" cellpadding="5" bgcolor="#FFCCFF">
  <caption>The cities I visited on my Segway'n USA travels</caption>
 <thead bgcolor="#FF33FF">
 <tr>
 <th>City</th>
 <th>Date</th>
 <th>Temperature</th>
 <th>Altitude</th>
 <th>Population</th>
 <th>Diner Rating</th>
 </tr>
 </thead>
 <tbody bgcolor="#CC99FF">
 <tr>
 <td class="right">Walla Walla, WA</td>
 <td>June 15th</td>
 <td>75</td>
 <td>1,204 ft</td>
 <td>29,686</td>
 <td>4/5</td>
 </tr>
 <tr>
 <td>Magic City, ID</td>
 <td>June 25th</td>
 <td>74</td>
 <td>5,312 ft</td>
 <td>50</td>
 <td>3/5</td>
 </tr>
 <tr>
 <td>Bountiful, UT</td>
 <td>July 10th</td>
 <td>91</td>
 <td>4,226 ft</td>
 <td>41,173</td>
 <td>4/5</td>
 </tr>
 <tr>
 <td>Last Chance, CO</td>
 <td>July 23rd</td>
 <td class="right">102</td>
 <td>4,780 ft</td>
 <td>265</td>
 <td>3/5</td>
 </tr>
 <tr>
 <td>Truth or Consequences, NM</td>
 <td>August 9th</td>
 <td>93</td>
 <td>4,242 ft</td>
 <td>7,289</td>
 <td>5/5</td>
 </tr>
 <tr>
 <td>Why, AZ</td>
 <td>August 18th</td>
 <td>104</td>
 <td>860 ft</td>
 <td>480</td>
 <td>3/5</td>
 </tr>
 </tbody>
 <tfoot bgcolor="#FFCCFF">
 <tr>
 <td colspan="6" align="center">biubiubiu</td>
 </tr>
 </tfoot>
 </table>
 