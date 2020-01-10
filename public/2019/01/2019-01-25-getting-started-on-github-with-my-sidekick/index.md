# Getting Started on GitHub with My Sidekick


终于，我还是来到了全球最大的[~~同性~~交友网站](https://github.com/)，下次李老师可以问我有没有交到蓝朋友了……
<img src="https://github.githubassets.com/images/modules/explore/social.jpg">
<!--more-->

<center>
# Getting Started with GitHub
</center>

## what is github?

* At its heart, GitHub is a collaboration platform.

* GitHub is a powerful version control tool.

* GitHub is also a same-sex dating platform...

## issues

  Issues are used to discuss ideas, enhancements, tasks, and bugs. They make collaboration easier by:

* Providing everyone (even future team members) with the complete story in one place

* Allowing you to cross-link to other issues and pull requests

* Creating a single, comprehensive record of how and why you made certain decisions

* Allowing you to easily pull the right people and teams into a conversation with `@-mentions`

## branch

  A branch is a parallel version of a repository. It is contained within the repository, but does not affect the primary or `master` branch allowing you to work freely without disrupting the "live" version. When you've made the changes you want to make, you can merge your branch back into the master branch to publish your changes. For more information, see ["About branches."](https://help.github.com/articles/about-branches)
  
<img src="https://backlog.com/git-tutorial/cn/img/post/stepup/capture_stepup1_1_1.png" width="100%">

  Branches are an important part of the GitHub flow because they allow us to separate our work from the master branch. In other words.

<img src="https://backlog.com/git-tutorial/cn/img/post/stepup/capture_stepup1_1_2.png" width="100%">

  Creating a branch allows you to make modifications to your project without changing the deployed master branch. Now that you have a branch, it’s time to create a file and make your first commit!
  
  And in github, this may generate a simple tabulate, see:https://github.com/hoasxyz/github-slideshow/blob/hello-world/_posts/0000-01-02-hoasxyz.md:
```
---
layout: slide
title: "Welcome to our second slide!"
---
```

  More information about branch:https://backlog.com/git-tutorial/cn/stepup/stepup1_1.html.
  
## pull request

  Where issues encourage discussion with other contributors and collaborators on a project, pull requests help you share your changes, receive feedback on them, and iterate on them until they’re perfect! This pull request is going to keep the changes you just made on your branch and propose applying them to the `master` branch.
  
  To create a pull request:
  
1. From the `Pull requests` tab, click `New pull request`

2. In the `base:` drop-down menu, make sure the `master` branch is selected

3. In the `compare:` drop-down menu, select `hello-world`(this is what you defined)

4. Click `Create pull request`

5. When you’ve selected your branch, enter a title for your pull request. For example `Add hoasxyz's file`(this is what you defined)

6. The next field helps you provide a description of the changes you made. Feel free to add a description of what you’ve accomplished so far. As a reminder, you have: created a branch, created a file and made a commit, and opened a pull request

7. Click `Create pull request`

  After this operation, you can respond to a review by changing your file.

<center>
# Communicating Using Markdown
</center>

## emoji

  For more information about available emoji, see [this handy cheat sheet](https://www.webfx.com/tools/emoji-cheat-sheet/). In most text fields on GitHub, you can type `:` and then begin to type the name of an emoji. A fuzzy search will bring up the 5 best guesses and let you select one.

```markdown
 what you see  | what you type   
 :-------------: |:---------------:
  :heart:       | :heart\:       
  :heavy_exclamation_mark:          | :heavy_exclamation_mark\:        
  :smile:       | :smile\:    
  :sparkles:    | :sparkles\:  
```

 what you see  | what you type   
 :-------------: |:---------------:
  :heart:       | :heart\:       
  :heavy_exclamation_mark:          | :heavy_exclamation_mark\:        
  :smile:       | :smile\:    
  :sparkles:    | :sparkles\: 

## tables

```markdown
| _Colors_      | Fruits          | Vegetable         |
| ------------- |:---------------:| -----------------:|
| Red           | *Apple*         | [Pepper](#Tables) |
| ~~Orange~~    | Oranges         | **Carrot**        |
| Green         | ~~***Pears***~~ | Spinach           |
```

| _Colors_      | Fruits          | Vegetable         |
| ------------- |:---------------:| -----------------:|
| Red           | *Apple*         | [Pepper](#Tables) |
| ~~Orange~~    | Oranges         | **Carrot**        |
| Green         | ~~***Pears***~~ | Spinach           |

  For more detail on formatting with tables, see "[Organizing information with tables](https://github.github.com/gfm/#tables-extension-)" in the GitHub Help.

## summary dropdown

  Most of the text in this issue is formatted in collapsible summary blocks. Here's how to make them with Markdown:

```markdown
<details>
  <summary>Title</summary>

  Content here

</details>
```

<details>
  <summary>Title</summary>

  Content here

</details>

## more links in github

  See: https://help.github.com/articles/autolinked-references-and-urls/.

<center>
# More
</center>
  For more courses in github, see:https://lab.github.com/courses.
  
![Congratulation!](https://camo.githubusercontent.com/2ca441ac2f206f16916ab83262ae9e74d5461931/68747470733a2f2f6f63746f6465782e6769746875622e636f6d2f696d616765732f77656c636f6d65746f6361742e706e67)