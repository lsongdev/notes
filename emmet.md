---
layout: default
title: Emmet
---

# Emmet

## Syntax

### Getting started

Let us start to improve your development to the speed of light.

* [Emmet in Visual Studio Code](https://code.visualstudio.com/docs/editor/emmet) _\(code.visualstudio.com\)_
* [Emmet 2 for Sublime Text](https://github.com/emmetio/sublime-text-plugin) _\(github.com\)_
* [Emmet for Coda](https://emmet.io/download/coda/) _\(emmet.io\)_
* [Emmet for Atom](https://github.com/emmetio/emmet-atom#readme) _\(github.com\)_

### Multiplication: `\*`

`ul>li\*5`

```html
<ul>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
    <li></li>
</ul>
```

### Child: `>`

`nav>ul>li`

```html
<nav>
    <ul>
        <li></li>
    </ul>
</nav>
```

### Custom attributes

`p\[title="Hello world"\]`

```html
<p title="Hello world"></p>
```

`td\[rowspan=2 colspan=3 title\]`

```html
<td rowspan="2" colspan="3" title=""></td>
```

`\[a='value1' b="value2"\]`

```html
<div a="value1" b="value2"></div>
```

### Text: `{}`

`a{Click me}`

```html
<a href="">Click me</a>
```

`p>{Click }+a{here}+{ to continue}`

```html
Click [here](emmet.md) to continue
```

### ID and CLASS attributes

`#header`

```html
<div id="header"></div>
```

`.title`

```html
<div class="title"></div>
```

`form\#search.wide`

```html
<form id="search" class="wide"></form>
```

`p.class1.class2.class3`

```html
<p class="class1 class2 class3"></p>
```

### Implicit tag names

`.class`

```html
<div class="class"></div>
```

`em>.class`

```html
<em><span class="class"></span></em>
```

`ul>.class`

```html
<ul>
    <li class="class"></li>
</ul>
```

`table>.row>.col`

```html
<table>
    <tr class="row">
        <td class="col"></td>
    </tr>
</table>
```

### Sibling: `+`

`div+p+bq`

```html
<div></div>
<p></p>
<blockquote></blockquote>
```

### Climb-up: `^`

`div+div>p>span+em^bq`

```html
<div></div>
<div>
    <p><span></span><em></em></p>
    <blockquote></blockquote>
</div>
```

`div+div>p>span+em^^bq`

```html
<div></div>
<div>
    <p><span></span><em></em></p>
</div>
<blockquote></blockquote>
```

### Grouping: `()`

`div>\(header>ul>li\*2>a\)+footer>p`

```html
<div>
    <header>
        <ul>
            <li><a href=""></a></li>
            <li><a href=""></a></li>
        </ul>
    </header>
    <footer>
        <p></p>
    </footer>
</div>
```

`\(div>dl>\(dt+dd\)\*4\)+footer>p`

```html
<div>
    <dl>
        <dt></dt>
        <dd></dd>
        <dt></dt>
        <dd></dd>
        <dt></dt>
        <dd></dd>
        <dt></dt>
        <dd></dd>
    </dl>
</div>
<footer>
    <p></p>
</footer>
```

### Multiplication and `$`

`ul>li.item$\*3`

```html
<ul>
    <li class="item1"></li>
    <li class="item2"></li>
    <li class="item3"></li>
</ul>
```

`h$\[title=item$\]{Header $}\*3`

```html
<h1 title="item1">Header 1</h1>
<h2 title="item2">Header 2</h2>
<h3 title="item3">Header 3</h3>
```

`ul>li.item$$$\*3`

```html
<ul>
    <li class="item001"></li>
    <li class="item002"></li>
    <li class="item003"></li>
</ul>
```

`ul>li.item$@-\*3`

```html
<ul>
    <li class="item3"></li>
    <li class="item2"></li>
    <li class="item1"></li>
</ul>
```

`ul>li.item$@2\*3`

```html
<ul>
    <li class="item2"></li>
    <li class="item3"></li>
    <li class="item4"></li>
</ul>
```

## Also see

* [Emmet Cheat sheet](https://docs.emmet.io/cheat-sheet/) _\(docs.emmet.io\)_

