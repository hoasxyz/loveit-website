# Learning Regular Expression with Stringr


A copy from _R for data science_.

> Some people, when confronted with a problem, think “I know, I’ll use regular expressions.” Now they have two problems.     ---Jamie Zawinski

<center>
<img src="https://github.com/tidyverse/stringr/raw/master/man/figures/logo.png">
</center>
<!--more-->

# String Basics

You can create strings with either single quotes or double quotes. Unlike other languages, there is no difference in behavior.

To include a literal single or double quote in a string you can use `\` to “escape” it:

```r
double_quote <- "\"" # or '"'
single_quote <- '\'' # or "'"
```

That means if you want to include a literal backslash, you’ll need to double it up: `\\`.

{{% admonition warning warning %}}
Beware that the printed representation of a string is not the same as string itself, because the printed representation shows the escapes(转义). To see the raw contents of the string, use `writeLines()`:
```r
x <- c("\"", "\\")
x
#> [1] "\"" "\\"
writeLines(x)
#> "
#> \
```
{{% /admonition %}}

There are a handful of other special characters. The most common are `\n`, newline, and `\t`, tab, but you can see the complete list by requesting help on `?'"'`, or `?"'"`. You’ll also sometimes see strings like `\u00b5`, which is a way of writing non-English characters that works on all platforms:

```r
x <- "\u00b5"
x
#> [1] "μ"
```

## Basic String Operations

The functions from __stringr__ all start with `str_`:

- String Length

```r
str_length(c("a", "R for data science", NA))
#> [1] 1 18 NA
```
- Combining Strings

```r
str_c("x", "y")
#> [1] "xy"
str_c("x", "y", "z")
#> [1] "xyz"

str_c("x", "y", sep = ", ")
#> [1] "x, y"
```
Like most other functions in R, missing values are contagious. If you want them to print as `NA`, use `str_replace_na()`:

```r
x <- c("abc", NA)
str_c("|-", x, "-|")
#> [1] "|-abc-|" NA
str_c("|-", str_replace_na(x), "-|")
#> [1] "|-abc-|" "|-NA-|"

str_c("prefix-", c("a", "b", "c"), "-suffix")
#> [1] "prefix-a-suffix" "prefix-b-suffix" "prefix-c-suffix"
```

- To collapse a vector of strings into a single string, use `collapse()`:

```r
str_c(c("x", "y", "z"), collapse = ", ")
#> [1] "x, y, z"
```

## Subsetting Strings

```r
x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3)
#> [1] "App" "Ban" "Pea"

# negative numbers count backwards from end
str_sub(x, -3, -1)
#> [1] "ple" "ana" "ear"

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1))
x
#> [1] "apple" "banana" "pear"

# To duplicate individual strings, you can use str_dup():
str_dup(x, c(2, 3))
#> [1] "abXdefabXdef"       "ghXfjkghXfjkghXfjk"
```
## Locales

However, changing case is more complicated than it might at first appear because different languages have different rules for changing case.

Another important operation that’s affected by the locale is sorting. The base R `order()` and `sort()` functions sort strings using the current locale. If you want robust behavior across different computers, you may want to use `str_sort()` and `str_order()`, which take an additional locale argument:

```r
x <- c("apple", "eggplant", "banana")

str_order(x)
#> [1] 1 3 2

str_sort(x, locale = "en") # English
#> [1] "apple" "banana" "eggplant"

str_sort(x, locale = "haw") # Hawaiian
#> [1] "apple" "eggplant" "banana"
```

```r
x <- "I like horses."
str_to_upper(x)
#> [1] "I LIKE HORSES."
str_to_title(x)
#> [1] "I Like Horses."

str_to_lower(x)
#> [1] "i like horses."
# Turkish has two sorts of i: with and without the dot
str_to_lower(x, "tr")
#> [1] "ı like horses."
```

## Whitespace

Three functions add, remove, or modify whitespace:

- `str_pad()` pads a string to a fixed length by adding extra whitespace on the left, right, or both sides.

```r
x <- c("abc", "defghi")

str_pad(x, 10) # default pads on left
#> [1] "       abc" "    defghi"
str_pad(x, 10, "both")
#> [1] "   abc    " "  defghi  "
str_pad(x, 4)
#> [1] " abc"   "defghi"
```

- The opposite of `str_pad()` is `str_trim()`, which removes leading and trailing whitespace:

```r
x <- c("  a   ", "b   ",  "   c")
str_trim(x)
#> [1] "a" "b" "c"
str_trim(x, "left")
#> [1] "a   " "b   " "c"
```
- You can use `str_wrap()` to modify existing whitespace in order to wrap a paragraph of text, such that the length of each line is as similar as possible.

```r
jabberwocky <- str_c(
  "`Twas brillig, and the slithy toves ",
  "did gyre and gimble in the wabe: ",
  "All mimsy were the borogoves, ",
  "and the mome raths outgrabe. "
)
cat(str_wrap(jabberwocky, width = 40))
#> `Twas brillig, and the slithy toves did
#> gyre and gimble in the wabe: All mimsy
#> were the borogoves, and the mome raths
#> outgrabe.
```

# Matching Patterns with Regular Expressions

To learn regular expressions, we’ll use `str_view()` and `str_view_all()`. These functions take a character vector and a regular expression, and show you how they match.

## Basic Matches

```r
x <- c("apple", "banana", "pear")
str_view(x, "an")
# Which extract strings that have 'an'.

The next step up in complexity is `.`, which matches any character (except a newline):
str_view(x, ".a.")
str_view(x, "a..")
```
Escape for `.`:

```r
# To create the regular expression, we need \\
dot <- "\\."

# But the expression itself only contains one: writeLines(dot)
#> \.

# And this tells R to look for an explicit .
str_view(c("abc", "a.c", "bef"), "a\\.c")


x <- c("a\\b","a\\.b")

# Only match `.` .
str_view(x,'\\.')

# Match `\.` and `\b` because of `.`! And `.` is failed to escaped.
str_view(x,'\\\\.')

# Match `\.` .
str_view(x,'\\\\\\.')
```

{{% admonition warning warning %}}
1. `writeLines()`用作将字符串转化为正则表达式

2. `str_view()`显示字符串所要匹配的字符，原字符串和匹配的字符串是通过正则表达式联系的！所以要匹配的字符串中若出现了`.`请注意！见上例。

3. 区别字符串本身和print出来给你看（正则表达式转化）的替身！

4. 抛开第二点，若想逆推出要匹配字符所对应的字符串输入，请将要匹配的字符分开考虑！见上例。
{{% /admonition %}}

| chars to match            | regular expression | chars to input |
| :------------------------ | :----------------- | :------------- |
| `.`                       | `\.`               | `\\.`          |
| `\`                       | `\\`               | `\\\\`         |
| `\.`                      | `\\\.`             | `\\\\\\.`      |
| `\` and one char after it | `\.`[^n]           | `\\\\.`        |

[^n]: I don't know whether this column is right or not.

## Anchors

- `^` to match the start of the string.

- `$` to match the end of the string.

```r
x <- c("apple", "banana", "pear")

str_view(x, "^a")

str_view(x, "a$")
```
## Character Classes and Alternatives

- `\d` matches any digit.

- `\s` matches any whitespace (e.g., space, tab, newline).

- `[abc]` matches a, b, or c.

- `[^abc]` matches anything except a, b, or c.

Remember, to create a regular expression containing `\d` or `\s`, you’ll need to escape the `\` for the string, so you’ll type `\\d` or `\\s`.

You can use alternation to pick between one or more alternative patterns. For example, `abc|d..f` will match either `abc`, or `deaf`. Note that the precedence for `|` is low, so that `abc|xyz` matches `abc` or `xyz` not `abcyz` or `abxyz`. Like with mathematical expressions, if precedence ever gets confusing, use parentheses to make it clear what you want: `str_view(c("grey", "gray"), "gr(e|a)y")`.

## Repetition

The next step up in power involves controlling how many times a pattern matches:

- `?`: 0 or 1

- `+`: 1 or more

- `*`: 0 or more

Note that the precedence of these operators is high, so you can write `colou?r` to match either American or British spellings.

You can also specify the number of matches precisely:

- `{n}`: exactly n

- `{n,}`: n or more

- `{,m}`: at most m

- `{n,m}`: between n and m

```r
x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"

str_view(x, "C{2}")

str_view(x, "C{2,}")

str_view(x, "C{2,3}")
```
By default these matches are “greedy”: they will match the longest string possible. You can make them “lazy,” matching the shortest string possible, by putting a `?` after them.

```r
str_view(x, 'C{2,3}?')


Try more and know more...  :joy:
# > str_view(x, 'LX*')
# > str_view(x, 'CLX*')
# > str_view(x, "C{2}")
# > str_view(x, "C[LX+]?")
# > str_view(x, "C(LX+)?")
# > str_view(x, "C(LX+)")
# > str_view(x, "C(LX)+")
# > str_view(x, "C(LXX)+")
# > str_view(x, "C(LXX+)")
# > str_view(x, "C+(LX)+")
# > str_view(x, "C(LX)+")
# > str_view(x, "C+(LX+)")

# > str_view(x, "(LX)V")
# > str_view(x, "(LX+)V")
# > str_view(x, "(LX)+V")
# > str_view(x, "LX+V")
# > str_view(x, "LXV")
# > str_view(x, "LX+V")
```
{{% admonition warning warning %}}
- `[]`表示或！就是在里面的每个字母每次都可以单独监测！所以顺序不是问题！
```r
> str_view(x, "C[XL]")
> str_view(x, "C[XL]+")
> str_view(x, "C[XLV]+")
```

- `()`表示且！是必须按顺序的！要当做一个整体来看！也就相当于提高到一级表达式。
```r
> str_view(x, "C(XL)")
> str_view(x, "C(LX)")
> str_view(x, "C(LX+)")
> str_view(x, "C(LX)+")
```

{{% /admonition %}}

## Grouping and Backreferences

Earlier, you learned about parentheses as a way to disambiguate complex expressions. They also define “groups” that you can refer to with backreferences, like `\1`, `\2`, etc.

```r
str_view(fruit, "(..)\\1", match = TRUE)
```
# Tools

## Detect matches

```r
x <- c("apple", "banana", "pear")
str_detect(x, "e")
#> [1]  TRUE FALSE  TRUE

# How many common words start with t?
sum(str_detect(words, "^t"))
#> [1] 65
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))
#> [1] 0.277
```

A common use of `str_detect()` is to select the elements that match a pattern. You can do this with logical subsetting, or the convenient `str_subset()` wrapper:

```r
words[str_detect(words, "x$")]
#> [1] "box" "sex" "six" "tax"
str_subset(words, "x$")
#> [1] "box" "sex" "six" "tax"

df <- tibble(
  word = words, 
  i = seq_along(word)
)
df %>% 
  filter(str_detect(word, "x$"))
#> # A tibble: 4 x 2
#>   word      i
#>   <chr> <int>
#> 1 box     108
#> 2 sex     747
#> 3 six     772
#> 4 tax     841
```
A variation on `str_detect()` is `str_count()`: rather than a simple yes or no, it tells you how many matches there are in a string:

```r
x <- c("apple", "banana", "pear")
str_count(x, "a")
#> [1] 1 3 1

# On average, how many vowels per word?
mean(str_count(words, "[aeiou]"))
#> [1] 1.99

df %>% 
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )
#> # A tibble: 980 x 4
#>   word         i vowels consonants
#>   <chr>    <int>  <int>      <int>
#> 1 a            1      1          0
#> 2 able         2      2          2
#> 3 about        3      3          2
#> 4 absolute     4      4          4
#> 5 accept       5      2          4
#> 6 account      6      3          4
#> # … with 974 more rows
```
{{% admonition warning warning %}}
Note that matches never overlap. For example, in "abababa", how many times will the pattern "aba" match? Regular expressions say two, not three:
```r
str_count("abababa", "aba")
#> [1] 2
str_view_all("abababa", "aba")
```
{{% /admonition %}}

## Extract matches 

```r
colours <- c("red", "orange", "yellow", "green", "blue", "purple")
colour_match <- str_c(colours, collapse = "|")
colour_match
#> [1] "red|orange|yellow|green|blue|purple"
has_colour <- str_subset(sentences, colour_match)
matches <- str_extract(has_colour, colour_match)
head(matches)
#> [1] "blue" "blue" "red"  "red"  "red"  "blue"
```
{{% admonition tip tip %}}
- Following can turn it into a single __regular expression__ ?!
```r
colour_match <- str_c(colours, collapse = "|")
colour_match
#> [1] "red|orange|yellow|green|blue|purple"
```

- Note that `str_extract()` only extracts the first match. We can see that most easily by first selecting all the sentences that have more than 1 match:
```r
more <- sentences[str_count(sentences, colour_match) > 1]
str_view_all(more, colour_match)
```
{{% /admonition %}}

This is a common pattern for stringr functions, because working with a single match allows you to use much simpler data structures. To get all matches, use `str_extract_all()`. It returns a list.

If you use `simplify = TRUE`, `str_extract_all()` will return a matrix with short matches expanded to the same length as the longest.

## Grouped matches

```r
noun <- "(a|the) ([^ ]+)"

has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)
has_noun %>% 
  str_extract(noun)
#>  [1] "the smooth" "the sheet"  "the depth"  "a chicken"  "the parked"
#>  [6] "the sun"    "the huge"   "the ball"   "the woman"  "a helps"

# 改进版！去掉第二个单词后面的逗号和句号！
noun <- "(a|the|an) ([^ +(,|.)$]+)"

has_noun <- sentences %>%
    str_subset(noun)
has_noun %>% 
    str_extract(noun)
    
tibble(sentence = sentences) %>% 
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ +(,|.)$]+)", 
    remove = FALSE
  )
# # A tibble: 720 x 3
#    sentence                                    article noun   
#    <chr>                                       <chr>   <chr>  
#  1 The birch canoe slid on the smooth planks.  the     smooth 
#  2 Glue the sheet to the dark blue background. the     sheet  
#  3 It's easy to tell the depth of a well.      the     depth  
#  4 These days a chicken leg is a rare dish.    a       chicken
#  5 Rice is often served in round bowls.        NA      NA     
#  6 The juice of lemons makes fine punch.       NA      NA     
#  7 The box was thrown beside the parked truck. the     parked 
#  8 The hogs were fed chopped corn and garbage. NA      NA     
#  9 Four hours of steady work faced us.         NA      NA     
# 10 Large size in stockings is hard to sell.    NA      NA     
# # ... with 710 more rows
```
## Replacing matches

```r
x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
#> [1] "-pple"  "p-ar"   "b-nana"
str_replace_all(x, "[aeiou]", "-")
#> [1] "-ppl-"  "p--r"   "b-n-n-"

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three"))
#> [1] "one house"    "two cars"     "three people"
```
```r
sentences %>% 
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% 
  head(5)
#> [1] "The canoe birch slid on the smooth planks." 
#> [2] "Glue sheet the to the dark blue background."
#> [3] "It's to easy tell the depth of a well."     
#> [4] "These a days chicken leg is a rare dish."   
#> [5] "Rice often is served in round bowls."
```

## Splitting

```r
> sentences[[1]] %>%
+     head(5) %>% 
+     str_split(" ")
[[1]]
[1] "The"     "birch"   "canoe"   "slid"    "on"      "the"     "smooth"  "planks."
```
Because each component might contain a different number of pieces, this returns a list. If you’re working with a length-1 vector, the easiest thing is to just extract the first element of the list:

```r
"a|b|c|d" %>% 
  str_split("\\|") %>% 
  .[[1]]
#> [1] "a" "b" "c" "d"

sentences %>%
  head(5) %>% 
  str_split(" ", simplify = TRUE)
#>      [,1]    [,2]    [,3]    [,4]      [,5]  [,6]    [,7]    
#> [1,] "The"   "birch" "canoe" "slid"    "on"  "the"   "smooth"
#> [2,] "Glue"  "the"   "sheet" "to"      "the" "dark"  "blue"  
#> [3,] "It's"  "easy"  "to"    "tell"    "the" "depth" "of"    
#> [4,] "These" "days"  "a"     "chicken" "leg" "is"    "a"     
#> [5,] "Rice"  "is"    "often" "served"  "in"  "round" "bowls."
#>      [,8]          [,9]   
#> [1,] "planks."     ""     
#> [2,] "background." ""     
#> [3,] "a"           "well."
#> [4,] "rare"        "dish."
#> [5,] ""            ""

fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE)
#>      [,1]      [,2]    
#> [1,] "Name"    "Hadley"
#> [2,] "Country" "NZ"    
#> [3,] "Age"     "35"
```
Instead of splitting up strings by patterns, you can also split up by character, line, sentence and word `boundary()`s:

```r
x <- "This is a sentence.  This is another sentence."
str_view_all(x, boundary("word"))

str_split(x, " ")[[1]]
#> [1] "This"      "is"        "a"         "sentence." ""          "This"     
#> [7] "is"        "another"   "sentence."
str_split(x, boundary("word"))[[1]]
#> [1] "This"     "is"       "a"        "sentence" "This"     "is"      
#> [7] "another"  "sentence"
```
## Find matches

`str_locate()` and `str_locate_all()` give you the starting and ending positions of each match. These are particularly useful when none of the other functions does exactly what you want. You can use `str_locate()` to find the matching pattern, `str_sub()` to extract and/or modify them.

# Other types of pattern

- `ignore_case = TRUE` allows characters to match either their uppercase or lowercase forms. This always uses the current locale.

```r
bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")

str_view(bananas, regex("banana", ignore_case = TRUE))
```
- `multiline = TRUE` allows `^` and `$` to match the start and end of each line rather than the start and end of the complete string.

```r
x <- "Line 1\nLine 2\nLine 3"
str_extract_all(x, "^Line")[[1]]
#> [1] "Line"
str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]
#> [1] "Line" "Line" "Line"
```
---

- `comments = TRUE` allows you to use comments and white space to make complex regular expressions more understandable. Spaces are ignored, as is everything after `#`. To match a literal space, you’ll need to escape it: `\\ `.

Important!

```r
phone <- regex("
  \\(?     # optional opening parens
  (\\d{3}) # area code
  [) -]?   # optional closing parens, space, or dash
  (\\d{3}) # another three numbers
  [ -]?    # optional space or dash
  (\\d{4}) # three more numbers
  ", comments = TRUE)

str_match("514-791-8141", phone)
#>      [,1]          [,2]  [,3]  [,4] 
#> [1,] "514-791-814" "514" "791" "8141"
```
---

- `dotall = TRUE` allows `.` to match everything, including `\n`.

There are three other functions you can use instead of `regex()`:

- `fixed()`: matches exactly the specified sequence of bytes. It ignores all special regular expressions and operates at a very low level. This allows you to avoid complex escaping and can be much faster than regular expressions. Beware using `fixed()` with non-English data. It is problematic because there are often multiple ways of representing the same character. For example, there are two ways to define “á”: either as a single character or as an “a” plus an accent.

- Omit `coll()`.

- As you saw with `str_split()` you can use `boundary()` to match boundaries. You can also use it with the other functions.

# Other uses of regular expressions

- `apropos()` searches all objects available from the global environment. This is useful if you can’t quite remember the name of the function.

```r
> apropos("tibble")
 [1] "as.tibble"       "as_tibble"       "as_tibble"       "is.tibble"       "is_tibble"       "new_tibble"     
 [7] "tibble"          "tibble"          "tibble_"         "validate_tibble"
```

- `dir()` lists all the files in a directory. The pattern argument takes a regular expression and only returns file names that match the pattern. For example, you can find all the R Markdown files in the current directory with:

```r
# You should pay attention to the path.
> head(dir(pattern = "\\.R$"))
[1] "li.R"    "Rdata.R"
```

# Other functions

- [`str_remove()/str_remove_all()`](https://stringr.tidyverse.org/reference/str_remove.html)

- [`word()`](https://stringr.tidyverse.org/reference/word.html)

# More

- http://yphuang.github.io/blog/2016/03/15/regular-expression-and-strings-processing-in-R/

- https://blog.csdn.net/sinat_26917383/article/details/51122043

## R预定义字符组

| 代码      | 含义说明                                  |
| :--------: | :----------------------------------------: |
| `[:digit:]` | 数字：0-9                                 |
| `[:lower:]` | 小写字母：a-z                             |
| `[:upper:]` | 大写字母：A-Z                             |
| `[:alpha:]` | 字母：a-z 及 A-Z                            |
| `[:alnum:]` | 所有字母及数字                            |
| `[:punct:]` | 标点符号，如`. , ;`等                       |
| `[:graph:]` | Graphical characters,即`[:alnum:]`和`[:punct:]` |
| `[:blank:]` | 空字符，即：Space和Tab                    |
| `[:space:]` | Space，Tab，newline，及其他space characters |
| `[:print:]` | 可打印的字符，即：`[:alnum:]`，`[:punct:]`和`[:space:]` |

## 代表字符组的特殊符号

| 代码 |         含义说明          |
| :--: | :-----------------------: |
| `\w` | 字符串，等价于`[:alnum:]` |
| `\W` | 非字符串，等价于`[^[:alnum:]]` |
| `\s` | 空格字符，等价于`[:blank:]` |
| `\S` | 非空格字符，等价于`[^[:blank:]]` |
| `\d` |  数字，等价于`[:digit:]`  |
| `\D` | 非数字，等价于`[^[:digit:]]` |
| `\b` | Word edge（单词开头或结束的位置） |
| `\B` | No Word edge（非单词开头或结束的位置） |
| `\<` | Word beginning（单词开头的位置） |
| `\>` | Word end（单词结束的位置） |

<center>
<img src="https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/72/samsung/78/smiling-face-with-open-mouth-and-smiling-eyes_1f604.png">

To be continued
</center>