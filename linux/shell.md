---
layout: default
title: Shell
parent: Linux
nav_order: 4
---

## Shell

很多同学其实会分不太清楚什么是终端, 什么是 shell
终端这个词最早其实上是指一台电脑或者计算机系统，用来让用户输入数据，及显示其计算结果的机器，简而言之就是人类用户与计算机交互的设备。终端有些是全电子的，也有些是机电的。其又名终端机，它与一部独立的电脑不同，但也是电脑组成的部分。

![Computer terminal](https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/DEC_VT100_terminal_transparent.png/440px-DEC_VT100_terminal_transparent.png)
（Computer terminal, From Wikipedia）

而现代我们日常中使用的 Terminal.app 和 iTerm2 实际上是一种终端模拟器

![iTerm2](https://kitcorpuz.com/storage/img/images_24/iterm2_themes.png)
(iTerm2, 终端模拟器)

简而言之，终端实际上是指可以收集用户输入和显示计算机输出结果的事物(thing)。

## Command-line 命令行 和 Shell 的关系

Shell 实际上是指一类功能的统称， 它的实际作用是通过 TTY 拿到用户的输入，解析输入的字符并根据一定的逻辑找到我们要执行的程序，并把程序的输出结果打印出来。

当我们在聊 Shell 的时候需要知道我们使用的 Shell 具体实现是什么，典型的有 sh bash zsh fish
从发展历史来看，sh 出现的时间最早，zsh 和 fish 出现的时间最晚，不同的 Shell 的实现对用户输入的内容处理方式也会有所不同。

命令行提示符（PS）

```shell
~$
~#
```

当我们使用 Linux 的时候最先接触的是上面的这个命令行提示符，命令行提示符代表着一些意义
1. `~` 表示当前处于 $HOME 目录，比如：/home/lsong
2. `$` 表示当前是以普通用户模式运行的，# 表示当前是以 root 用户运行的

**命令行是一种泛指用户可以输入命令的东西，而 Shell 则是一种处理用户输入的实现。**

好，到目前为止，我们大致了解了命令行和 Shell 的逻辑关系


## Getting started

基本操作

```shell
cd /
ls -la
find . -name ""
```

Go to previous directory

```shell
pwd # /home/user/foo
cd bar/
pwd # /home/user/foo/bar
cd -
pwd # /home/user/foo
```

### 命令的执行过程  / 原理

简单来说当我们输入一个命令的时候比如 `find`  实际上是在 PATH 这个变量中依次查找

```shell
~$ echo $PATH
/usr/sbin:/usr/bin:/sbin:/bin
```

通过 which 这个命令可以让我们了解到程序所在的位置，而不是执行它

```shell
~$ which find
/usr/bin/find

~$ which ls
/bin/ls
```

但是你很快注意到了一些奇怪的事情

```shell
which cd
cd: shell built-in command
```

这就带出了我们接下来要了解到的概念，一些 shell 实现的时候会把一些常用命令作为内部实现，也就是上面输出里提到的 shell built-in command，那么怎么区分某个命令是否是内部实现呢？

可以通过 type 命令

```shell
~$ type cd
cd is a shell builtin
```

如何知道都有哪些是 builtin 呢?

可以通过 man 这个命令查看手册

```shell
man builtin
```

事实上，我们可以通过 man 命令查看很多程序的使用手册（前提是它有提供）。


### Brace expansion

```shell
echo {A,B}.js
```

| Expression | Description |
| :--- | :--- |
| `{A,B}` | Same as `A B` |
| `{A,B}.js` | Same as `A.js B.js` |
| `{1..5}` | Same as `1 2 3 4 5` |

**序列展开**

```shell
~$ echo {1..9}
1 2 3 4 5 6 7 8 9

~$ echo {a..z}
a b c d e f g h i j k l m n o p q r s t u v w x y z

~$ echo {A..Z}
A B C D E F G H I J K L M N O P Q R S T U V W X Y Z

~$ echo A{1..9}
A1 A2 A3 A4 A5 A6 A7 A8 A9
```

**笛卡尔展开**

```shell
~$ echo A{1,3,5}
A1 A3 A5

~$ echo {A,B,C}{1,3,5}
A1 A3 A5 B1 B3 B5 C1 C3 C5
```

例子

```shell
~$ touch /tmp/a.txt
~$ ls /tmp/a.txt
/tmp/a.txt

~$ mv /tmp/{a,b}.txt
~$ ls /tmp/b.txt
/tmp/b.txt


~$ mv /tmp/b.{txt,bak}
~$ ls /tmp/b.bak
/tmp/b.bak

~$ mv /tmp/b{.bak,}
~$ ls /tmp/b
/tmp/b
```

通过上面的例子我们可以看到 shell 变量展开的强大之处。

#### 文件通配符展开

```shell
~$ echo *
Applications Desktop Documents Downloads Library Movies Music Pictures Projects Public

~$ echo D*
Desktop Documents Downloads
```

See: [Brace expansion](http://wiki.bash-hackers.org/syntax/expansion/brace)

### Variables 变量

上面我们了解到了 PATH 这个变量，它存储着 shell 查找命令的路径信息，它在 shell 启动时，在 bashrc -> profile 中被定义。
常用的变量还有 PWD，实际上 cd 命令就是在修改 PWD 这个变量，而 ls 也会使用这个变量来输出文件内容。
定义一个变量在 shell 环境里面很简单。

hello.sh

```shell
#!/bin/bash

A=world
echo "Hello $A!" # => Hello world!
```

有一点需要注意的是，`=` 的前后不能有空格，不然会被认为是在调用 A 这个程序 后面的 `=` 和 `world` 作为参数。

Execute the script 

```shell
$ bash hello.sh
```

```shell
NAME="John"

echo ${NAME}    # => John
echo $NAME      # => John
echo "$NAME"    # => John
echo '$NAME'    # => $NAME
echo "${NAME}!" # => John!

NAME = "John" # => Error (about space)
```

### Comments

```shell
# This is an inline Bash comment.
```

```shell
: '
This is a
very neat comment
in bash
'
```

Multi-line comments use `:'` to open and `'` to close

### Arguments

| Expression | Description |
| :--- | :--- |
| `$1` … `$9` | Parameter 1 ... 9 |
| `$0` | Name of the script itself |
| `$1` | First argument |
| `${10}` | Positional parameter 10 |
| `$#` | Number of arguments |
| `$$` | Process id of the shell |
| `$*` | All arguments |
| `$@` | All arguments, starting from first |
| `$-` | Current options |
| `$_` | Last argument of the previous command |

See: [Special parameters](http://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables).

### Conditionals <a id="conditionals-example"></a>

```shell
if [[ -z "$string" ]]; then
    echo "String is empty"
elif [[ -n "$string" ]]; then
    echo "String is not empty"
fi
```

See: [Conditionals](bash.md#conditionals-2)

## Parameter expansions

### Syntax

| Code | Description |
| :--- | :--- |
| `${FOO%suffix}` | Remove suffix |
| `${FOO#prefix}` | Remove prefix |
| `${FOO%%suffix}` | Remove long suffix |
| `${FOO##prefix}` | Remove long prefix |
| `${FOO/from/to}` | Replace first match |
| `${FOO//from/to}` | Replace all |
| `${FOO/%from/to}` | Replace suffix |
| `${FOO/#from/to}` | Replace prefix |

#### Substrings

| Expression | Description |
| :--- | :--- |
| `${FOO:0:3}` | Substring _\(position, length\)_ |
| `${FOO:(-3):3}` | Substring from the right |

#### Length

| Expression | Description |
| :--- | :--- |
| `${#FOO}` | Length of `$FOO` |

#### Default values

| Expression | Description |
| :--- | :--- |
| `${FOO:-val}` | `$FOO`, or `val` if unset |
| `${FOO:=val}` | Set `$FOO` to `val` if unset |
| `${FOO:+val}` | `val` if `$FOO` is set |
| `${FOO:?message}` | Show message and exit if `$FOO` is unset |

### Substitution

```shell
echo ${food:-Cake}  #=> $food or "Cake"
```

```shell
STR="/path/to/foo.cpp"
echo ${STR%.cpp}    # /path/to/foo
echo ${STR%.cpp}.o  # /path/to/foo.o
echo ${STR%/*}      # /path/to

echo ${STR##*.}     # cpp (extension)
echo ${STR##*/}     # foo.cpp (basepath)

echo ${STR#*/}      # path/to/foo.cpp
echo ${STR##*/}     # foo.cpp

echo ${STR/foo/bar} # /path/to/bar.cpp
```

### Slicing

```shell
name="John"
echo ${name}           # => John
echo ${name:0:2}       # => Jo
echo ${name::2}        # => Jo
echo ${name::-1}       # => Joh
echo ${name:(-1)}      # => n
echo ${name:(-2)}      # => hn
echo ${name:(-2):2}    # => hn

length=2
echo ${name:0:length}  # => Jo
```

See: [Parameter expansion](http://wiki.bash-hackers.org/syntax/pe)

### basepath & dirpath

```shell
SRC="/path/to/foo.cpp"
```

```shell
BASEPATH=${SRC##*/}   
echo $BASEPATH  # => "foo.cpp"


DIRPATH=${SRC%$BASEPATH}
echo $DIRPATH   # => "/path/to/"
```

### Transform

```shell
STR="HELLO WORLD!"
echo ${STR,}   # => hELLO WORLD!
echo ${STR,,}  # => hello world!

STR="hello world!"
echo ${STR^}   # => Hello world!
echo ${STR^^}  # => HELLO WORLD!

ARR=(hello World)
echo "${ARR[@],}" # => hello world
echo "${ARR[@]^}" # => Hello World
```

## Arrays 

### Defining arrays

```shell
Fruits=('Apple' 'Banana' 'Orange')

Fruits[0]="Apple"
Fruits[1]="Banana"
Fruits[2]="Orange"

ARRAY2=(foo{1..2}) # => foo1 foo2
ARRAY3=({A..D})    # => A B C D

# declare construct
declare -a Numbers=(1 2 3 4 5 6)
```

### Indexing

| - | - |
| :--- | :--- |
| `${Fruits[0]}` | First element |
| `${Fruits[-1]}` | Last element |
| `${Fruits[*]}` | All elements |
| `${Fruits[@]}` | All elements |
| `${#Fruits[@]}` | Number of all |
| `${#Fruits}` | Length of 1st |
| `${#Fruits[3]}` | Length of nth |
| `${Fruits[@]:3:2}` | Range |
| `${!Fruits[@]}` | Keys of all |



### Iteration

```shell
Fruits=('Apple' 'Banana' 'Orange')

for e in "${Fruits[@]}"; do
    echo $e
done
```

#### With index

```shell
for i in "${!Fruits[@]}"; do
  printf "%s\t%s\n" "$i" "${Fruits[$i]}"
done
```

### Operations

```shell
Fruits=("${Fruits[@]}" "Watermelon")     # Push
Fruits+=('Watermelon')                   # Also Push
Fruits=( ${Fruits[@]/Ap*/} )             # Remove by regex match
unset Fruits[2]                          # Remove one item
Fruits=("${Fruits[@]}")                  # Duplicate
Fruits=("${Fruits[@]}" "${Veggies[@]}")  # Concatenate
lines=(`cat "logfile"`)                  # Read from file
```

### Arrays as arguments

```shell
function extract()
{
    local -n myarray=$1
    local idx=$2
    echo "${myarray[$idx]}"
}
Fruits=('Apple' 'Banana' 'Orange')
extract Fruits 2     # => Orangle
```

## Dictionaries

### Defining

```shell
declare -A sounds
```

```shell
sounds[dog]="bark"
sounds[cow]="moo"
sounds[bird]="tweet"
sounds[wolf]="howl"
```

### Working with dictionaries

```shell
echo ${sounds[dog]} # Dog's sound
echo ${sounds[@]}   # All values
echo ${!sounds[@]}  # All keys
echo ${#sounds[@]}  # Number of elements
unset sounds[dog]   # Delete dog
```

### Iteration

```shell
for val in "${sounds[@]}"; do
    echo $val
done
```

```shell
for key in "${!sounds[@]}"; do
    echo $key
done
```

## Conditionals 条件判断

在 shell 中判断一个变量是否为某值可以：

```shell
if [ "$filename" = "test.txt" ]; then
  echo "$filename"
fi
```

一个违反常识的事实是，在 shell 中并不存在逻辑表达式，上面的 if 和 `[` 实际上都是程序。
`[` 实际上是 test 的 alias

```shell
~$ which [
/usr/bin/[ -> /usr/bin/test
```

所以，当我们学习 shell 中的 if 时，更多的时候是在了解 test 程序的用法。

### Integer conditions

| Condition | Description |
| :--- | :--- |
| `[[ NUM -eq NUM ]]` | Equal |
| `[[ NUM -ne NUM ]]` | Not equal |
| `[[ NUM -lt NUM ]]` | Less than |
| `[[ NUM -le NUM ]]` | Less than or equal |
| `[[ NUM -gt NUM ]]` | Greater than |
| `[[ NUM -ge NUM ]]` | Greater than or equal |
| `(( NUM < NUM ))` | Less than |
| `(( NUM <= NUM ))` | Less than or equal |
| `(( NUM > NUM ))` | Greater than |
| `(( NUM >= NUM ))` | Greater than or equal |

### String conditions

| Condition | Description |
| :--- | :--- |
| `[[ -z STR ]]` | Empty string |
| `[[ -n STR ]]` | Not empty string |
| `[[ STR == STR ]]` | Equal |
| `[[ STR = STR ]]` | Equal \(Same above\) |
| `[[ STR < STR ]]` | Less than _\(ASCII\)_ |
| `[[ STR > STR ]]` | Greater than _\(ASCII\)_ |
| `[[ STR != STR ]]` | Not Equal |
| `[[ STR =~ STR ]]` | Regexp |

### Example

#### String

```shell
if [[ -z "$string" ]]; then
    echo "String is empty"
elif [[ -n "$string" ]]; then
    echo "String is not empty"
else
    echo "This never happens"
fi
```

#### Combinations

```shell
if [[ X && Y ]]; then
    ...
fi
```

#### Equal

```shell
if [[ "$A" == "$B" ]]; then
    ...
fi
```

#### Regex

```shell
if [[ '1. abc' =~ ([a-z]+) ]]; then
    echo ${BASH_REMATCH[1]}
fi
```

#### Smaller

```shell
if (( $a < $b )); then
   echo "$a is smaller than $b"
fi
```

#### Exists

```shell
if [[ -e "file.txt" ]]; then
    echo "file exists"
fi
```

### File conditions

| Condition | Description |
| :--- | :--- |
| `[[ -e FILE ]]` | Exists |
| `[[ -d FILE ]]` | Directory |
| `[[ -f FILE ]]` | File |
| `[[ -h FILE ]]` | Symlink |
| `[[ -s FILE ]]` | Size is &gt; 0 bytes |
| `[[ -r FILE ]]` | Readable |
| `[[ -w FILE ]]` | Writable |
| `[[ -x FILE ]]` | Executable |
| `[[ f1 -nt f2 ]]` | f1 newer than f2 |
| `[[ f1 -ot f2 ]]` | f2 older than f1 |
| `[[ f1 -ef f2 ]]` | Same files |

### More conditions

| Condition | Description |  |  |
| :--- | :--- | :--- | :--- |
| `[[ -o noclobber ]]` | If OPTION is enabled |  |  |
| `[[ ! EXPR ]]` | Not |  |  |
| `[[ X && Y ]]` | And |  |  |
| \`\[\[ X |  | Y \]\]\` | Or |

### logical and, or

```shell
if [ "$1" = 'y' -a $2 -gt 0 ]; then
    echo "yes"
fi

if [ "$1" = 'n' -o $2 -lt 0 ]; then
    echo "no"
fi
```

#### Grep check 

```shell
if grep -q 'foo' ~/.bash_history; then
    echo "You appear to have typed 'foo' in the past"
fi
```

#### Conditional execution

```shell
git commit && git push
git commit || echo "Commit failed"
```

## Loops 循环

### Basic for loop

```shell
for i in /etc/rc.*; do
    echo $i
done
```

### C-like for loop

```shell
for ((i = 0 ; i < 100 ; i++)); do
    echo $i
done
```

### Ranges

```shell
for i in {1..5}; do
    echo "Welcome $i"
done
```

#### With step size

```shell
for i in {5..50..5}; do
    echo "Welcome $i"
done
```

### Auto increment

```shell
i=1
while [[ $i -lt 4 ]]; do
    echo "Number: $i"
    ((i++))
done
```

### Auto decrement

```shell
i=3
while [[ $i -gt 0 ]]; do
    echo "Number: $i"
    ((i--))
done
```

### Continue


```shell
{data=3,5} for number in $\(seq 1 3\); do if \[\[ $number == 2 \]\]; then continue; fi echo "$number" done

```

### Break

```shell
for number in $(seq 1 3); do
    if [[ $number == 2 ]]; then
        # Skip entire rest of loop.
        break;
    fi
    # This will only print 1
    echo "$number"
done
```

### Until

```shell
count=0
until [ $count -gt 10 ]; do
    echo "$count"
    ((count++))
done
```

### Forever

```shell
while true; do
    # here is some code.
done
```

### Forever \(shorthand\)

```shell
while :; do
    # here is some code.
done
```

### Reading lines

```shell
cat file.txt | while read line; do
    echo $line
done
```

### IO 输入与输出
stdin stdout stderror

我们用到的许多程序都会产生某种输出。这种输出，经常由两种类型组成。 第一，程序运行结果；这是说，程序要完成的功能。第二，我们得到状态和错误信息， 这些告诉我们程序进展。如果我们观察一个命令，例如 ls，会看到它的运行结果和错误信息 显示在屏幕上。

像 ls这样的程序实际上把他们的运行结果 输送到一个叫做标准输出的特殊文件（经常用 stdout 表示），而它们的状态信息则送到另一个 叫做标准错误输出的文件（stderr）。默认情况下，标准输出和标准错误输出都连接到屏幕，而不是 保存到磁盘文件。除此之外，许多程序从一个叫做标准输入（stdin）的设备得到输入，默认情况下， 标准输入连接到键盘。

#### Redirection 重定向运算符

I/O 重定向允许我们更改输出地点和输入来源。一般来说，输入来自键盘，输出送到屏幕， 但是通过 I/O 重定向，我们可以做出改变。

我们可以告诉 shell 把 ls 命令的运行结果输送到文件

```
ls -l /usr/bin > ls-usr-bin-output.txt
ls -l /usr/bin >> ls.txt
```

```shell
python hello.py > output.txt   # stdout to (file)
python hello.py >> output.txt  # stdout to (file), append
python hello.py 2> error.log   # stderr to (file)
python hello.py 2>&1           # stderr to stdout
python hello.py 2>/dev/null    # stderr to (null)
python hello.py &>/dev/null    # stdout and stderr to (null)
```

#### Reading input

```shell
echo -n "Proceed? [y/n]: "
read ans
echo $ans
```

```shell
read -n 1 ans    # Just one character
```

```shell
python hello.py < foo.txt      # feed foo.txt to stdin for python
```

#### 重定向到标准错误

ls -l /bin/usr 2> ls-error.txt
将标准输出和标准错误输出到同一个文件
ls -l /bin/usr > ls-output.txt 2>&1
联合重定向
ls -l /bin/usr &> ls-output.txt
丢弃标准错误
ls -l /bin/usr 2> /dev/null

一个复杂的例子

```shell
echo hello | tee /tmp/a

cat > a.txt <EOF
hello world
EOF
```

##### Heredoc

```shell
cat <<END
hello world
END
```

## Miscellaneous 

### Numeric calculations

```shell
$((a + 200))      # Add 200 to $a
```

```shell
$(($RANDOM%200))  # Random number 0..199
```

### Subshells

```shell
(cd somedir; echo "I'm now in $PWD")
pwd # still in first directory
```

### Inspecting commands

```shell
command -V cd
#=> "cd is a function/alias/whatever"
```


### Source relative

```shell
source "${0%/*}/../share/foo.sh"
```

### Directory of script

```shell
DIR="${0%/*}"
```

### Case/switch

```shell
case "$1" in
    start | up)
    vagrant up
    ;;

    *)
    echo "Usage: $0 {start|stop|ssh}"
    ;;
esac
```

### Trap errors

```shell
trap 'echo Error at about $LINENO' ERR
```

or

```shell
traperr() {
    echo "ERROR: ${BASH_SOURCE[1]} at about ${BASH_LINENO[0]}"
}

set -o errtrace
trap traperr ERR
```

### printf

```shell
printf "Hello %s, I'm %s" Sven Olga
#=> "Hello Sven, I'm Olga

printf "1 + 1 = %d" 2
#=> "1 + 1 = 2"

printf "Print a float: %f" 2
#=> "Print a float: 2.000000"
```

### Getting options

```shell
while [[ "$1" =~ ^- && ! "$1" == "--" ]]; do case $1 in
    -V | --version )
    echo $version
    exit
    ;;
    -s | --string )
    shift; string=$1
    ;;
    -f | --flag )
    flag=1
    ;;
esac; shift; done
if [[ "$1" == '--' ]]; then shift; fi
```

#### Options

```shell
# Avoid overlay files
# (echo "hi" > foo)
set -o noclobber

# Used to exit upon error
# avoiding cascading errors
set -o errexit   

# Unveils hidden failures
set -o pipefail  

# Exposes unset variables
set -o nounset
```

#### Glob options

```shell
# Non-matching globs are removed  
# ('*.foo' => '')
shopt -s nullglob   

# Non-matching globs throw errors
shopt -s failglob  

# Case insensitive globs
shopt -s nocaseglob 

# Wildcards match dotfiles 
# ("*.sh" => ".foo.sh")
shopt -s dotglob    

# Allow ** for recursive matches 
# ('lib/**/*.rb' => 'lib/a/b/c.rb')
shopt -s globstar
```

## Functions

### Defining functions

```shell
myfunc() {
    echo "hello $1"
}
```

```shell
# Same as above (alternate syntax)
function myfunc() {
    echo "hello $1"
}
```

```shell
myfunc "John"
```

### Returning values

```shell
myfunc() {
    local myresult='some value'
    echo $myresult
}
```

```shell
result="$(myfunc)"
```

### Raising errors

```shell
myfunc() {
    return 1
}
```

```shell
if myfunc; then
    echo "success"
else
    echo "failure"
fi
```


```shell
get_name() {
    echo "John"
}

echo "You are $(get_name)"
```

See: [Functions](bash.md#functions-2)


### Shell execution

```shell
echo "I'm in $(PWD)"
# Same
echo "I'm in `pwd`"
```

See: [Command substitution](http://wiki.bash-hackers.org/syntax/expansion/cmdsubst)

### Check for command's result 

```shell
if ping -c 1 google.com; then
    echo "It appears you have a working internet connection"
fi
```

### Special variables 

| Expression | Description |
| :--- | :--- |
| `$?` | Exit status of last task |
| `$!` | PID of last background task |
| `$$` | PID of shell |
| `$0` | Filename of the shell script |

See [Special parameters](http://wiki.bash-hackers.org/syntax/shellvars#special_parameters_and_shell_variables).

## History

### Commands

| Command | Description |
| :--- | :--- |
| `history` | Show history |
| `shopt -s histverify` | Don't execute expanded result immediately |


### Expansions

| Expression | Description |
| :--- | :--- |
| `!$` | Expand last parameter of most recent command |
| `!*` | Expand all parameters of most recent command |
| `!-n` | Expand `n`th most recent command |
| `!n` | Expand `n`th command in history |
| `!<command>` | Expand most recent invocation of command `<command>` |

### Operations

| Code | Description |
| :--- | :--- |
| `!!` | Execute last command again |
| `!!:s/<FROM>/<TO>/` | Replace first occurrence of `<FROM>` to `<TO>` in most recent command |
| `!!:gs/<FROM>/<TO>/` | Replace all occurrences of `<FROM>` to `<TO>` in most recent command |
| `!$:t` | Expand only basename from last parameter of most recent command |
| `!$:h` | Expand only directory from last parameter of most recent command |

`!!` and `!$` can be replaced with any valid expansion.

### Slices

| Code | Description |
| :--- | :--- |
| `!!:n` | Expand only `n`th token from most recent command \(command is `0`; first argument is `1`\) |
| `!^` | Expand first argument from most recent command |
| `!$` | Expand last token from most recent command |
| `!!:n-m` | Expand range of tokens from most recent command |
| `!!:n-$` | Expand `n`th token to last from most recent command |

`!!` can be replaced with any valid expansion i.e. `!cat`, `!-2`, `!42`, etc.


### Strict mode

```shell
set -euo pipefail
IFS=$'\n\t'
```

See: [Unofficial bash strict mode](http://redsymbol.net/articles/unofficial-bash-strict-mode/)

## Also see

* [Devhints](https://devhints.io/bash) _\(devhints.io\)_
* [Bash-hackers wiki](http://wiki.bash-hackers.org/) _\(bash-hackers.org\)_
* [Shell vars](http://wiki.bash-hackers.org/syntax/shellvars) _\(bash-hackers.org\)_
* [Learn bash in y minutes](https://learnxinyminutes.com/docs/bash/) _\(learnxinyminutes.com\)_
* [Bash Guide](http://mywiki.wooledge.org/BashGuide) _\(mywiki.wooledge.org\)_
* [ShellCheck](https://www.shellcheck.net/) _\(shellcheck.net\)_
* [shell - Standard Shell](https://devmanual.gentoo.org/tools-reference/bash/index.html) _\(devmanual.gentoo.org\)_

