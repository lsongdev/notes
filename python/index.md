---
layout: default
title: Python
has_children: true
---

# Python

Python is a programming language created by Guido van Rossum.

## Getting Started

```shell
apt install python-is-python3
```

```shell
sudo apt update
sudo apt-get update
sudo apt-get install -y \
  build-essential \
  libsqlite3-dev \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libncursesw5-dev \
  libgdbm-dev \
  libnss3-dev \
  libffi-dev \
  liblzma-dev \
  libbluetooth-dev \
  uuid-dev \
  g++

# 下载源码
cd /usr/src
sudo wget https://www.python.org/ftp/python/3.13.0/Python-3.13.0a5.tgz
sudo tar xzf Python-3.13.0a5.tgz
cd Python-3.13.0a5

# 编译安装
sudo ./configure --enable-optimizations
sudo make -j$(nproc)
sudo make install
```

### Introduction

* [Python](https://www.python.org/)  _\(python.org\)_
* [Learn X in Y minutes](https://learnxinyminutes.com/docs/python/) _\(learnxinyminutes.com\)_
* [Regex in python](./regex#regex-in-python)

### Hello World

```python
>>> print("Hello, World")
Hello, World
```

The famous "Hello World" program in Python

### Variables

```python
x = 4        # x is of type int
x = "Sally"  # x is now of type str
print(x)
```

Python has no command for declaring a variable.

### Data Types

|  |  |
| :--- | :--- |
| `str` | Text |
| `int`, `float`, `complex` | Numeric |
| `list`, `tuple`, `range` | Sequence |
| `dict` | Mapping |
| `set`, `frozenset` | Set |
| `bool` | Boolean |
| `bytes`, `bytearray`, `memoryview` | Binary |

See: [Data Types](python.md#data-types-2)

### Slicing String

```python
>>> b = "Hello, World!"
>>> print(b[2:5])
llo
```

See: [Strings](python.md#strings-3)

### Lists

```python
mylist = []
mylist.append(1)
mylist.append(2)
for x in mylist:
    print(x) # prints out 1,2
```

See: [Lists](python.md#lists-3)

### If Else

```python
a = 200
if a > 0:
    print("a is greater than 0")
else:
    print("a is not greater than 0")
```

See: [Flow control](python.md#flow-control)

### Loops

```python
for x in range(6):
    if x == 3: break
    print(x)
else:
    print("Finally finished!")
```

See: [Loops](python.md#loops-2)

### Functions

```python
>>> def my_function():
...     print("Hello from a function")
...
>>> my_function()
Hello from a function
```

See: [Functions](python.md#functions-2)

### File Handling

```python
with open("myfile.txt", "r", encoding='utf8') as file:
    for x in file:
        print(x)
```

See: [File Handling](python.md#file-handling-2)

### Arithmetic

```python
result = 10 + 30  # =>  40
result = 40 - 10  # =>  30
result = 50 * 5   # =>  250
result = 16 / 4   # =>  4
result = 25 % 2   # =>  1
result = 5 ** 3   # =>  125
```

### Plus-Equals

```python
counter = 0
counter += 10           # => 10
counter = 0
counter = counter + 10  # => 10

message = "Part 1."
# => Part 1.Part 2.
message += "Part 2."
```

## Data Types

### Strings

```python
s = "Hello World"
s = 'Hello World'

a = """Multiline Strings
Lorem ipsum dolor sit amet,
consectetur adipiscing elit """
```

See: [Strings](python.md#strings-2)

### Numbers

```
x = 1    # int
y = 2.8  # float
z = 1j   # complex

>>> print(type(x))
<class 'int'>
```

### Booleans

```python
a = True 
b = False

bool(0)     # => False
bool(1)     # => True
```

### Lists

```python
list1 = ["apple", "banana", "cherry"]
list2 = [True, False, False]
list3 = [1, 5, 7, 9, 3]
list4 = list((1, 5, 7, 9, 3))
```

See: [Lists](python.md#lists-3)

### Tuple

```python
a = (1, 2, 3)
a = tuple((1, 2, 3))
```

Similar to List but immutable

### Set

```python
set1 = {"a", "b", "c"}   
set2 = set(("a", "b", "c"))
```

Set of unique items/objects

### Dictionary

```python
>>> empty_dict = {}
>>> a = {"one": 1, "two": 2, "three": 3}
>>> a["one"]
1
>>> a.keys()
dict_keys(['one', 'two', 'three'])
>>> a.values()
dict_values([1, 2, 3])
>>> a.update({"four": 4})
>>> a.keys()
dict_keys(['one', 'two', 'three', 'four'])
>>> a['four']
4
```

### Casting

#### Integers

```python
x = int(1)   # x will be 1
y = int(2.8) # y will be 2
z = int("3") # z will be 3
```

#### Floats

```python
x = float(1)     # x will be 1.0
y = float(2.8)   # y will be 2.8
z = float("3")   # z will be 3.0
w = float("4.2") # w will be 4.2
```

#### Strings

```python
x = str("s1") # x will be 's1'
y = str(2)    # y will be '2'
z = str(3.0)  # z will be '3.0'
```

## Strings

### Array-like

```python
>>> a = "Hello, World"
>>> print(a[1])
e
>>> print(a[len(a)-1])
d
```

Get the character at position 1

### Looping

```python
>>> for x in "abc":
...     print(x)
a
b
c
```

Loop through the letters in the word "banana"

### Slicing string

```text
 ┌───┬───┬───┬───┬───┬───┬───┐
 | m | y | b | a | c | o | n |
 └───┴───┴───┴───┴───┴───┴───┘
 0   1   2   3   4   5   6   7
-7  -6  -5  -4  -3  -2  -1
```

```python
>>> s = 'mybacon'
>>> s[2:5]
'bac'
>>> s[0:2]
'my'
```

```python
>>> s = 'mybacon'
>>> s[:2]
'my'
>>> s[2:]
'bacon'
>>> s[:2] + s[2:]
'mybacon'
>>> s[:]
'mybacon'
```

```python
>>> s = 'mybacon'
>>> s[-5:-1]
'baco'
>>> s[2:6]
'baco'
```

#### With a stride

```python
>>> s = '12345' * 5
>>> s
'1234512345123451234512345'
>>> s[::5]
'11111'
>>> s[4::5]
'55555'
>>> s[::-5]
'55555'
>>> s[::-1]
'5432154321543215432154321'
```

### String Length

```python
>>> a = "Hello, World!"
>>> print(len(a))
13
```

The len() function returns the length of a string

### Multiple copies

```python
>>> s = '===+'
>>> n = 8
>>> s * n
'===+===+===+===+===+===+===+===+'
```

### Check String

```python
>>> s = 'spam'
>>> s in 'I saw spamalot!'
True
>>> s not in 'I saw The Holy Grail!'
True
```

### Concatenates

```python
>>> s = 'spam'
>>> t = 'egg'
>>> s + t
'spamegg'
>>> 'spam' 'egg'
'spamegg'
```

### Formatting 

```python
name = "John"
print("Hello, %s!" % name)
```

```python
name = "John"
age = 23
print("%s is %d years old." % (name, age))
```

#### format() Method

```python
txt1 = "My name is {fname}, I'm {age}".format(fname = "John", age = 36)
txt2 = "My name is {0}, I'm {1}".format("John",36)
txt3 = "My name is {}, I'm {}".format("John",36)
```

### Input

```python
>>> name = input("Enter your name: ")
Enter your name: Tom
>>> name
'Tom'
```

Get input data from console

### Join

```python
>>> "#".join(["John", "Peter", "Vicky"])
'John#Peter#Vicky'
```

### Endswith

```python
>>> "Hello, world!".endswith("!")
True
```

## Lists

### Defining

```python
>>> li1 = []
>>> li1
[]
>>> li2 = [4, 5, 6]
>>> li2
[4, 5, 6]
>>> li3 = list((1, 2, 3))
>>> li3
[1, 2, 3]
>>> li4 = list(range(1, 11))
>>> li4
[1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

### Generate

```python
>>> list(filter(lambda x : x % 2 == 1, range(1, 20)))
[1, 3, 5, 7, 9, 11, 13, 15, 17, 19]

>>> [x ** 2 for x in range (1, 11) if  x % 2 == 1]
[1, 9, 25, 49, 81]

>>> [x for x in [3, 4, 5, 6, 7] if x > 5]
[6, 7]

>>> list(filter(lambda x: x > 5, [3, 4, 5, 6, 7]))
[6, 7]
```

### Append

```python
>>> li = []
>>> li.append(1)
>>> li
[1]
>>> li.append(2)
>>> li
[1, 2]
>>> li.append(4)
>>> li
[1, 2, 4]
>>> li.append(3)
>>> li
[1, 2, 4, 3]
```

### List Slicing

Syntax of list slicing:

```python
a_list[start:end]
a_list[start:end:step]
```

#### Slicing

```python
>>> a = ['spam', 'egg', 'bacon', 'tomato', 'ham', 'lobster']
>>> a[2:5]
['bacon', 'tomato', 'ham']
>>> a[-5:-2]
['egg', 'bacon', 'tomato']
>>> a[1:4]
['egg', 'bacon', 'tomato']
```

#### Omitting index

```python
>>> a[:4]
['spam', 'egg', 'bacon', 'tomato']
>>> a[0:4]
['spam', 'egg', 'bacon', 'tomato']
>>> a[2:]
['bacon', 'tomato', 'ham', 'lobster']
>>> a[2:len(a)]
['bacon', 'tomato', 'ham', 'lobster']
>>> a
['spam', 'egg', 'bacon', 'tomato', 'ham', 'lobster']
>>> a[:]
['spam', 'egg', 'bacon', 'tomato', 'ham', 'lobster']
```

#### With a stride

```python
['spam', 'egg', 'bacon', 'tomato', 'ham', 'lobster']
>>> a[0:6:2]
['spam', 'bacon', 'ham']
>>> a[1:6:2]
['egg', 'tomato', 'lobster']
>>> a[6:0:-2]
['lobster', 'tomato', 'egg']
>>> a
['spam', 'egg', 'bacon', 'tomato', 'ham', 'lobster']
>>> a[::-1]
['lobster', 'ham', 'tomato', 'bacon', 'egg', 'spam']
```

### Remove

```python
>>> li = ['bread', 'butter', 'milk']
>>> li.pop()
'milk'
>>> li
['bread', 'butter']
>>> del li[0]
>>> li
['butter']
```

### Access

```python
>>> li = ['a', 'b', 'c', 'd']
>>> li[0]
'a'
>>> li[-1]
'd'
>>> li[4]
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
IndexError: list index out of range
```

### Concatenating

```python
>>> odd = [1, 3, 5]
>>> odd.extend([9, 11, 13])
>>> odd
[1, 3, 5, 9, 11, 13]
>>> odd = [1, 3, 5]
>>> odd + [9, 11, 13]
[1, 3, 5, 9, 11, 13]
```

### Sort & Reverse

```python
>>> li = [3, 1, 3, 2, 5]
>>> li.sort()
>>> li
[1, 2, 3, 3, 5]
>>> li.reverse()
>>> li
[5, 3, 3, 2, 1]
```

### Count

```python
>>> li = [3, 1, 3, 2, 5]
>>> li.count(3)
2
```

### Repeating

```python
>>> li = ["re"] * 3
>>> li
['re', 're', 're']
```

## Flow control

### Basic

```python
a = 5
if a > 10:
    print("a is totally bigger than 10.")
elif a < 10:
    print("a is smaller than 10.")
else:
    print("a is indeed 10.")
```

### One line

```python
>>> a = 330
>>> b = 200
>>> r = "a" if a > b else "b"
>>> print(r)
a
```

### else if

```python
value = True
if not value:
    print("Value is False")
elif value is None:
    print("Value is None")
else:
    print("Value is True")
```

## Loops

### Basic

```python
primes = [2, 3, 5, 7]
for prime in primes:
    print(prime)
```

### With index

```python
animals = ["dog", "cat", "mouse"]
for i, value in enumerate(animals):
    print(i, value)
```

### While

```python
x = 0
while x < 4:
    print(x)
    x += 1  # Shorthand for x = x + 1
```

### Break

```python
x = 0
for index in range(10):
    x = index * 10
    if index == 5:
        break
    print(x)
```

### Continue

```python
for index in range(3, 8): 
    x = index * 10
    if index == 5:
        continue
    print(x)
```

### Range

```python
for i in range(4):
    print(i) # Prints: 0 1 2 3

for i in range(4, 8):
    print(i) # Prints: 4 5 6 7

for i in range(4, 10, 2):
    print(i) # Prints: 4 6 8
```

### With zip()

```python
name = ['Pete', 'John', 'Elizabeth']
age = [6, 23, 44]
for n, a in zip(name, age):
    print('%s is %d years old' %(n, a))
```

### List Comprehension

```python
result = [x**2 for x in range(10) if x % 2 == 0]

print(result)
# [0, 4, 16, 36, 64]
```

## Functions

### Basic

```python
def hello_world():  
    print('Hello, World!')
```

### Return

```python
def add(x, y):
    print("x is %s, y is %s" %(x, y))
    return x + y

add(5, 6)    # => 11
```

### Positional arguments

```python
def varargs(*args):
    return args

varargs(1, 2, 3)  # => (1, 2, 3)
```

### Keyword arguments

```python
def keyword_args(**kwargs):
    return kwargs

# => {"big": "foot", "loch": "ness"}
keyword_args(big="foot", loch="ness")
```

### Returning multiple

```python
def swap(x, y):
    return y, x

x = 1
y = 2
x, y = swap(x, y)  # => x = 2, y = 1
```

### Default Value

```python
def add(x, y=10):
    return x + y

add(5)      # => 15
add(5, 20)  # => 25
```

### Anonymous functions

```python
# => True
(lambda x: x > 2)(3)

# => 5
(lambda x, y: x ** 2 + y ** 2)(2, 1)
```

## Modules

### Import modules

```python
import math
print(math.sqrt(16))  # => 4.0
```

### From a module

```python
from math import ceil, floor
print(ceil(3.7))   # => 4.0
print(floor(3.7))  # => 3.0
```

### Import all

```python
from math import *
```

### Shorten module

```python
import math as m

# => True
math.sqrt(16) == m.sqrt(16)
```

### Functions and attributes

```python
import math
dir(math)
```

## File Handling

### Read file

#### Line by line

```python
with open("myfile.txt") as file:
    for line in file:
        print(line)
```

#### With line number

```python
input = open('myfile.txt', 'r')
for i,line in enumerate(input, start=1):
    print("Number %s: %s" % (i, line))
```

### String

#### Write a string

```python
contents = {"aa": 12, "bb": 21}
with open("myfile1.txt", "w+") as file:
    file.write(str(contents))
```

#### Read a string

```python
with open('myfile1.txt', "r+") as file:
    contents = file.read()
print(contents)
```

### Object

#### Write an object

```python
contents = {"aa": 12, "bb": 21}
with open("myfile2.txt", "w+") as file:
    file.write(json.dumps(contents))
```

#### Read an object

```python
with open('myfile2.txt', "r+") as file:
    contents = json.load(file)
print(contents)
```

### Delete a File

```python
import os
os.remove("myfile.txt")
```

### Check and Delete

```python
import os
if os.path.exists("myfile.txt"):
    os.remove("myfile.txt")
else:
    print("The file does not exist")
```

### Delete Folder

```python
import os
os.rmdir("myfolder")
```

## Classes & Inheritance

### Defining

```python
class MyNewClass:
    '''This is a docstring.'''
    pass

# Class Instantiation
my = MyNewClass()
```

### Constructors

```python
class Animal:
    def __init__(self, voice):
    self.voice = voice

cat = Animal('Meow')
print(cat.voice)    # => Meow

dog = Animal('Woof') 
print(dog.voice)    # => Woof
```

### Method

```python
class Dog:

    # Method of the class
    def bark(self):
    print("Ham-Ham")

charlie = Dog()
charlie.bark()   # => "Ham-Ham"
```

### Class Variables

```python
class my_class:
    class_variable = "A class variable!"

x = my_class()
y = my_class()

# => A class variable!
print(x.class_variable)

# => A class variable!
print(y.class_variable)
```

### Super() Function

```python
class ParentClass:
    def print_test(self):
        print("Parent Method")

class ChildClass(ParentClass):
    def print_test(self):
        print("Child Method")
        # Calls the parent's print_test()
        super().print_test()
```

```python
>>> child_instance = ChildClass()
>>> child_instance.print_test()
Child Method
Parent Method
```

### repr() method

```python
class Employee:
    def __init__(self, name):
        self.name = name

    def __repr__(self):
        return self.name

john = Employee('John')
print(john)  # => John
```

### User-defined exceptions

```python
class CustomError(Exception):
    pass
```

### Polymorphism

```python
class ParentClass:
    def print_self(self):
        print('A')

class ChildClass(ParentClass):
    def print_self(self):
        print('B')

obj_A = ParentClass()
obj_B = ChildClass()

obj_A.print_self() # => A
obj_B.print_self() # => B
```

### Overriding

```python
class ParentClass:
    def print_self(self):
        print("Parent")

class ChildClass(ParentClass):
    def print_self(self):
        print("Child")

child_instance = ChildClass()
child_instance.print_self() # => Child
```

### Inheritance

```python
class Animal: 
    def __init__(self, name, legs):
        self.name = name
        self.legs = legs

class Dog(Animal):
    def sound(self):
        print("Woof!")

Yoki = Dog("Yoki", 4)
print(Yoki.name) # => YOKI
print(Yoki.legs) # => 4
Yoki.sound()     # => Woof!
```

## Miscellaneous

### Comments

```python
# This is a single line comments.
```

```python
""" Multiline strings can be written
    using three "s, and are often used
    as documentation.
"""
```

```python
''' Multiline strings can be written
    using three 's, and are often used
    as documentation.
'''
```

### Generators

```python
def double_numbers(iterable):
    for i in iterable:
        yield i + i
```

Generators help you make lazy code.

### Generator to list

```python
values = (-x for x in [1,2,3,4,5])
gen_to_list = list(values)

# => [-1, -2, -3, -4, -5]
print(gen_to_list)
```

### Handle exceptions

```python
try:
    # Use "raise" to raise an error
    raise IndexError("This is an index error")
except IndexError as e:
    pass                 # Pass is just a no-op. Usually you would do recovery here.
except (TypeError, NameError):
    pass                 # Multiple exceptions can be handled together, if required.
else:                    # Optional clause to the try/except block. Must follow all except blocks
    print("All good!")   # Runs only if the code in try raises no exceptions
finally:                 # Execute under all circumstances
    print("We can clean up resources here")
```

### FAQ
