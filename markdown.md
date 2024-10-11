---
layout: default
title: Markdown
---

# Markdown

markdown is a lightweight markup language for text formatting.

## Headers (atx style)

```text
# h1
## h2
### h3
#### h4
##### h5
###### h6
```

## Headers (setext style)

```text
Header 1
========
```

```text
Header 2
--------
```

## Blockquotes

```text
> This is
> a blockquote
>
> > Nested
> > Blockquote
```

## Unordered List

```text
* Item 1
* Item 2
    * item 3a
    * item 3b
```

or

```text
- Item 1
- Item 2
```

or

```text
+ Item 1
+ Item 2
```

or

```text
- [ ] Checkbox off
- [x] Checkbox on
```

## Ordered List

```text
1. Item 1
2. Item 2
    a. item 3a
    b. item 3b
```

## Links

```text
[link](http://google.com)
```

```text
[link][google]
```

```text
<http://google.com>
```

## Emphasis

```text
*italic*
_italic_
```

```text
**bold**
__bold__
```

```text
`inline code`
~~struck out~~
```

## Horizontal line

Hyphens

```text
---
```

Asterisks

```text
***
```

Underscores

```text
___
```

## Code


    ```javascript
    console.log("This is a block code")
    ```


```
4 space indent makes a ...

    console.log("This is a block code")

code block
```

### inline code

```text
`Inline code` has back-ticks around it
```

## Tables

```text
| Left column | Center column | Right column |
|:------------|:-------------:|-------------:|
| Cell 1      | Centered      | $1600        |
| Cell 2      | Cell 3        | $12          |
```

Simple style

```text
Left column | Center column | Right column 
:---:|:---:|:---:
Cell 1 | Centered | $1600 
Cell 2 | Cell 3 | $12
```

A markdown table generator: [tableconvert.com](https://tableconvert.com/)

## Images

```text
![GitHub Logo](/images/logo.png)

![Alt Text](url)
```

### Image with link

```text
[![GitHub Logo](/images/logo.png)](https://github.com/)

[![Alt Text](image_url)](link_url)
```

### Reference style

```text
![alt text][/images/logo.png]
```

## Backslash escapes

| Characters | Escape | Description |
| :--- | :--- | :--- |
| \ | \ | backslash |
| \` | \\` | backtick |
| \* | \\* | asterisk |
| \_ | \\_ | underscore |
| {} | {} | curly braces |
| \[\] | \\[\] | square brackets |
| () | \() | parentheses |
| \# | \\# | hash mark |
| + | + | plus sign |
| - | - | minus sign \(hyphen\) |
| . | . | dot |
| ! | ! | exclamation mark |
