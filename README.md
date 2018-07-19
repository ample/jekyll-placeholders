# jekyll-placeholders

[![Build Status](https://travis-ci.org/ample/jekyll-placeholder.svg?branch=master)](https://travis-ci.org/ample/jekyll-placeholder)

This gem makes Jekyll a little more self-aware. By default, Jekyll's support for defining collection permalinks is limited to [a few placeholder values](https://jekyllrb.com/docs/permalinks/#template-variables). When building complex layouts with nested URLs, this gem exposes any key/value pair defined in document frontmatter such that you can use them when defining your collection permalinks.

## Installation

Add the following to your `Gemfile` and bundle...

```ruby
gem "jekyll-placeholders", "~> 0.0.1", git: 'https://github.com/ample/jekyll-placeholders.git'
```

## Usage

Let's assume we have the following document frontmatter within our collections directory...

```
---
title: Some Article
slug: some-article
category_slug: some-category
layout: default
---
```

Our collections configuration looks like this...

```
collections:
  articles:
    output: true
    permalink: /articles/:category_slug/:slug
```

When the project is built, the document referenced above will be rendered to the following path...

[http://localhost:4000/articles/some-category/some-article](#)

### Deeply Nested Frontmatter

This gem even supports deeply nested references, where needed. Imagine the following frontmatter where `categories` is an array of objects...

```
---
title: Some Article
slug: some-article
categories:
  - title: Some Category
    slug: some-category
layout: default
---
```

You can achieve the same result by configuring your collection permalink, like this...

```
collections:
  articles:
    output: true
    permalink: /articles/(:categories/:0/:slug)/:slug
```

When the project is built, the document referenced above will be rendered to the following path...

[http://localhost:4000/articles/some-category/some-article](#)

## License

This project is licensed under the [3-Clause BSD License](https://opensource.org/licenses/BSD-3-Clause).
