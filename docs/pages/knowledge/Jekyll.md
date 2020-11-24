---
layout: default
title: Jekyll
parent: Knowledge
---

<details close markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Jekyll
- Jekyll is most popular framework to work static websites
- Powerfull and extensible
- Has a large community behind it. The community creates themes and templates that you can use for free to add more advanced features
- Jekyll ist built on top of ruby language

## Create a new Jekyll site
After installation, run these commands in a folder to create a new Jekyll static site
- `jekyll new SITENAME` -> This will create a site  with a bunch of files inside the folder named 'SITENAME'
- Then enter in that folder name and run the following command, e.g `on Window OS `:

    - Run `bundle lock -- add-platform ruby`
    - Run `bundle lock --add-platform x86_64-linux`
    - To preview the site run `bundle exec jekyll serve` --> This will output a URL, where the website is hosted on
    - Run `bundle exec jekyll built` to built a website

