---
# This top area is to give jekyll informations about the page.
title: Welcome to Sherlock
layout: default
nav_order: 1
---
# Welcome To Sherlock

#### Example
{: .no_toc }

<button class="btn js-toggle-dark-mode">Preview dark color scheme</button>

<script>
const toggleDarkMode = document.querySelector('.js-toggle-dark-mode');

jtd.addEvent(toggleDarkMode, 'click', function(){
  if (jtd.getTheme() === 'dark') {
    jtd.setTheme('light');
    toggleDarkMode.textContent = 'Preview dark color scheme';
  } else {
    jtd.setTheme('dark');
    toggleDarkMode.textContent = 'Return to the light side';
  }
});
</script>

ergdrgddgrg site is a simple example for a markdown page.  
All important informations for markdown can be found in the official [documentations](https://docs.github.com/en/github/writing-on-github/basic-writing-and-formatting-syntax).  
Here are just some fundamental things.wdwdwd

## Headlines
In Markdown Headings are created with # and the number of # represent the size of the heaading.
### A smaller headline
Some content
#### An even smaller Headline
Some content

## Structurize content
### List can be created with - or *
- A list
- With Items
* different Item with *, the spacing shows that it is a new list
### Ordered list
1. First Item
1. Second Item
### Nested list
1. Some content
    - Nested Item
        - Nested Item 2

## Styling text
- **Bold** is created with "**" at the beginning and end
- *Italic* is created with "*" at the beginning and end
- ~~Strikethrough~~ is created with "~~" at the beginning and end
- ***All bold and italic*** is created with "***" at the beginning and end
- **Some bold and _italic_** is created with "**" and "_" at the beginning and end
- > Quoting something is done with ">"
- `Code` ist highlighted with "`" 
### Code block
```python
num = int(input("Enter a number: "))
if (num % 2) == 0:
   print("{0} is Even".format(num))
else:
   print("{0} is Odd".format(num))
```

## Links
- A permantent link -> [about](/about)
- A relative link in the mainfolder -> [content](./simple-site.md)
- A relative link in a subfolder -> [content2](./pages/examplesite.md)