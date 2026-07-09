---
layout: default
title: Mathematics
---

# 数学

### Basic Math Symbols

| Symbol | Name | Description |
|--------|------|-------------|
| $+$ | Plus | 加法 |
| $-$ | Minus | 减法 |
| $\times$ | Times | 乘法 |
| $\div$ | Division | 除法 |
| $=$ | Equals | 等于 |
| $\neq$ | Not equal | 不等于 |
| $<$ | Less than | 小于 |
| $>$ | Greater than | 大于 |
| $\leq$ | Less than or equal | 小于等于 |
| $\geq$ | Greater than or equal | 大于等于 |
| $\pm$ | Plus-minus | 正负号 |
| $\sqrt{}$ | Square root | 平方根 |

### Comparison Operators

Comparison operators are used to compare two values and express relationships between them.

比较运算符用于比较两个值并表示它们之间的关系。

#### Basic Comparisons

| Symbol | LaTeX | Name | Description |
|--------|-------|------|-------------|
| $<$ | $<$ | Less than | $a$ is less than $b$ / $a$ 小于 $b$ |
| $>$ | $>$ | Greater than | $a$ is greater than $b$ / $a$ 大于 $b$ |
| $=$ | $=$ | Equals | $a$ equals $b$ / $a$ 等于 $b$ |
| $\neq$ | $\neq$ | Not equal | $a$ is not equal to $b$ / $a$ 不等于 $b$ |

#### Combined Comparisons

| Symbol | LaTeX | Name | Description |
|--------|-------|------|-------------|
| $\leq$ | $\leq$ | Less than or equal | $a$ is less than or equal to $b$ / $a$ 小于等于 $b$ |
| $\geq$ | $\geq$ | Greater than or equal | $a$ is greater than or equal to $b$ / $a$ 大于等于 $b$ |

#### Formal Definitions (for Real Numbers)

For $a, b \in \mathbb{R}$:

对于 $a, b \in \mathbb{R}$：

- $a < b$ iff $b - a > 0$ / 当且仅当 $b - a > 0$
- $a \leq b$ iff $a < b$ or $a = b$ / 当且仅当 $a < b$ 或 $a = b$
- $a > b$ iff $a - b > 0$ / 当且仅当 $a - b > 0$

#### Properties

- **Transitivity**: If $a < b$ and $b < c$, then $a < c$
- **传递性**：如果 $a < b$ 且 $b < c$，则 $a < c$
- **Trichotomy**: Exactly one holds: $a < b$, $a = b$, or $a > b$
- **三歧性**：以下三种情况恰有一个成立：$a < b$、$a = b$、$a > b$

### Successor

The **successor** function $S(n)$ returns the next natural number after $n$.

$$S(n) = n + 1$$

In Peano arithmetic, successor is a primitive operation used to define all other arithmetic operations:

- $S(0) = 1$
- $S(1) = 2$
- $S(2) = 3$

### Gödel Numbers

**Gödel numbering** assigns a unique natural number to each symbol, formula, and sequence of symbols in a formal language.

**哥德尔编码**将形式语言中的每个符号、公式和符号序列分配一个唯一的自然数。

#### Symbol Encoding

Each basic symbol is assigned a number:

每个基本符号被分配一个数字：

| Symbol | Gödel Number | Description |
|--------|--------------|-------------|
| $0$ | 1 | Zero / 零 |
| $S$ | 2 | Successor / 后继 |
| $=$ | 3 | Equals / 等于 |
| $+$ | 4 | Plus / 加 |
| $\times$ | 5 | Times / 乘 |
| $($ | 6 | Left parenthesis / 左括号 |
| $)$ | 7 | Right parenthesis / 右括号 |
| $\neg$ | 8 | Negation / 否定 |
| $\lor$ | 9 | Or / 析取（或） |
| $\exists$ | 10 | Existential quantifier / 存在量词 |

#### Sequence Encoding

A sequence of $n$ symbols $(a_1, a_2, \ldots, a_n)$ is encoded as a single number:

$n$ 个符号的序列 $(a_1, a_2, \ldots, a_n)$ 被编码为一个单一的数字：

$$\text{Gödel number} = p_1^{a_1} \cdot p_2^{a_2} \cdot p_3^{a_3} \cdots p_n^{a_n}$$

where $p_i$ is the $i$-th prime number ($2, 3, 5, 7, 11, \ldots$).

其中 $p_i$ 是第 $i$ 个素数（$2, 3, 5, 7, 11, \ldots$）。

#### Example

The formula $S(0) = 0$ consists of symbols $(S, (, 0, ), =, 0)$ with Gödel numbers $(2, 6, 1, 7, 3, 1)$:

公式 $S(0) = 0$ 由符号 $(S, (, 0, ), =, 0)$ 组成，对应的哥德尔数为 $(2, 6, 1, 7, 3, 1)$：

$$\text{Gödel number} = 2^2 \cdot 3^6 \cdot 5^1 \cdot 7^7 \cdot 11^3 \cdot 13^1 = 18,343,129,497,024$$

#### Properties

- **Injective**: Different sequences produce different numbers
- **单射性**：不同的序列产生不同的数字

- **Effective**: Computation of Gödel numbers is computable
- **可计算性**：哥德尔数的计算是可计算的

- **Invertible**: Any Gödel number can be uniquely decoded back to its original sequence
- **可逆性**：任何哥德尔数都可以唯一地解码回其原始序列

### Prime Numbers

A **prime number** is a natural number greater than 1 that has no positive divisors other than 1 and itself.

**质数**（素数）是大于1的自然数，除了1和它自身外没有其他正因数。

#### Notation

| Symbol | Name | Description |
|--------|------|-------------|
| $p$ | Prime | A prime number / 一个质数 |
| $\pi(x)$ | Prime counting function | Number of primes $\leq x$ / 不超过 $x$ 的质数个数 |
| $p_n$ | $n$-th prime | The $n$-th prime number / 第 $n$ 个质数 |

#### Formal Definition

$n$ is prime if and only if:

$n$ 是质数当且仅当：

$$(\forall d \in \mathbb{N}) \, (d \mid n \Rightarrow d = 1 \lor d = n)$$

where $d \mid n$ means "$d$ divides $n$".

其中 $d \mid n$ 表示 "$d$ 整除 $n$"。

#### First Few Primes

| $p_1$ | $p_2$ | $p_3$ | $p_4$ | $p_5$ | $p_6$ | $p_7$ | $p_8$ | $p_9$ | $p_{10}$ |
|-------|-------|-------|-------|-------|-------|-------|-------|-------|----------|
| $2$ | $3$ | $5$ | $7$ | $11$ | $13$ | $17$ | $19$ | $23$ | $29$ |

#### Properties

- 2 is the only even prime / 2 是唯一的偶数质数
- There are infinitely many primes / 质数有无穷多个
- Prime gaps can be arbitrarily large / 质数间隙可以任意大

### Fundamental Theorem of Arithmetic

Every integer greater than 1 can be uniquely represented as a product of prime numbers, up to the order of the factors.

每个大于1的整数都可以唯一地表示为素数的乘积，不考虑因子的顺序。

$$n = p_1^{a_1} \cdot p_2^{a_2} \cdots p_k^{a_k}$$

where $p_1 < p_2 < \cdots < p_k$ are prime numbers and $a_i \geq 1$ are positive integers.

其中 $p_1 < p_2 < \cdots < p_k$ 是素数，$a_i \geq 1$ 是正整数。

#### Examples

| Number | Prime Factorization |
|--------|---------------------|
| $12$ | $2^2 \cdot 3^1$ |
| $60$ | $2^2 \cdot 3^1 \cdot 5^1$ |
| $100$ | $2^2 \cdot 5^2$ |
| $101$ | $101^1$ |

#### Significance

- Provides a unique "fingerprint" for each number
- Foundation for number theory and cryptography
- Basis for computing GCD and LCM

**意义**

- 为每个数提供了唯一的"指纹"
- 是数论和密码学的基础
- 是计算最大公约数和最小公倍数的基础

### Existence of 1

How do we prove that $1$ exists? The answer depends on your foundational system.

我们如何证明 $1$ 存在？答案取决于你选择的基础系统。

#### Peano Axioms

$1$ is defined as the successor of $0$:

$1$ 被定义为 $0$ 的后继：

$$1 \stackrel{\text{def}}{=} S(0)$$

It exists by the very definition of the successor function.

它根据后继函数的定义而存在。

#### Set Theory (ZFC)

$1$ is defined as the set containing only the empty set:

$1$ 被定义为仅包含空集的集合：

$$1 \stackrel{\text{def}}{=} \{\emptyset\}$$

The empty set $\emptyset$ exists by the Axiom of Empty Set, so $1$ exists.

空集 $\emptyset$ 根据空集公理而存在，因此 $1$ 也存在。

#### Conclusion

In mathematics, $1$ is not "discovered" but "defined" within a formal system. Its existence is guaranteed by the axioms we accept.

在数学中，$1$ 不是被"发现"的，而是在形式系统内被"定义"的。它的存在由我们接受的公理来保证。

### EMC

$E = mc^2$

### Fibonacci

$F_n = F_{n-1} + F_{n-2}$

```
fn = n => n < 2 ? n : fn(n-1) + fn(n-2)
```

### Golden ratio

$\phi = \frac{1 + \sqrt{5}}{2}$


### Euler's formula

$e^{i\pi} + 1 = 0$

### Fourier series

$ f(t) = a_0 + \sum_{n=1}^{\infty} (a_n \cos(nt) + b_n \sin(nt))$

### Fast Fourier Transform

$X_k = \sum_{n=0}^{N-1} x_n e^{-i 2 \pi k n / N}$

### [Metric prefixes](https://en.wikipedia.org/wiki/Metric_prefix)

| Name | Symbol | Base 10 | Decimal |
|------|--------|---------|---------|
| quetta | Q | $10^{30}$  | 1000000000000000000000000000000 |
| ronna | R | $10^{27}$   | 1000000000000000000000000000 |
| yotta | Y | $10^{24}$   | 1000000000000000000000000 |
| zetta | Z | $10^{21}$   | 1000000000000000000000 |
| exa | E | $10^{18}$     | 1000000000000000000 |
| peta | P | $10^{15}$    | 1000000000000000 |
| tera | T | $10^{12}$    | 1000000000000 |
| giga | G | $10^9$       | 1000000000 |
| mega | M | $10^6$       | 1000000 |
| kilo | k | $10^3$       | 1000 |
| hecto | h | $10^2$      | 100 |
| deca | da | $10^1$      | 10 |
|      |    | $10^0$      | 1 |
| deci | d | $10^{−1}$    | 0.1 |
| centi | c | $10^{−2}$   | 0.01 |
| milli | m | $10^{−3}$   | 0.001 |
| micro | $\mu$ | $10^{−6}$ | 0.000001 |
| nano | n | $10^{−9}$    | 0.000000001 |
| pico | p | $10^{−12}$   | 0.000000000001 |
| femto | f | $10^{−15}$  | 0.000000000000001 |
| atto | a | $10^{−18}$   | 0.000000000000000001 |
| zepto | z | $10^{−21}$  | 0.000000000000000000001 |
| yocto | y | $10^{−24}$  | 0.000000000000000000000001 |
| ronto | r | $10^{−27}$  | 0.000000000000000000000000001 |
| quecto| q | $10^{−30}$  | 0.000000000000000000000000000001 |