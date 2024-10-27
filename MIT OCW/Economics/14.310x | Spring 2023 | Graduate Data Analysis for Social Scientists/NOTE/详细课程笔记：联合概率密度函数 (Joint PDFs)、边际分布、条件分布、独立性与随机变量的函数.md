# **详细课程笔记：联合概率密度函数 (Joint PDFs)、边际分布、条件分布、独立性与随机变量的函数**

---

## **1. 课程概述与重点**
本讲详细介绍了**联合概率密度函数 (Joint PDFs)**，探讨如何从联合 PDF 中推导**边际分布 (Marginal Distributions)** 和**条件分布 (Conditional Distributions)**，并分析如何判断**随机变量的独立性 (Independence)**。此外，还介绍了如何处理**随机变量的函数 (Functions of Random Variables)** 及其分布。理解这些内容对于进一步学习统计分析（如假设检验、数据建模等）至关重要。

---

## **2. 联合概率密度函数 (Joint PDFs) 的定义与归一化**

### **2.1. 联合 PDF 的定义**

联合概率密度函数 \(f_{X,Y}(x, y)\) 描述两个连续随机变量 \(X\) 和 \(Y\) 同时取得某些值的概率密度。对于任意区域 \(A \subseteq \mathbb{R}^2\)，该区域上的概率为：

$$
P((X, Y) \in A) = \int_A f_{X,Y}(x, y) \, dx \, dy
$$

联合 PDF 必须满足以下两个条件：  
1. **非负性 (Non-negativity)**：
   $  
   f_{X,Y}(x, y) \geq 0 \quad \forall \, (x, y) \in \mathbb{R}^2  
   $
2. **归一化条件 (Normalization)**：
   联合 PDF 在整个 \(x\)-\(y\) 平面上积分必须为 1：
   $$
   \int_{-\infty}^{\infty} \int_{-\infty}^{\infty} f_{X,Y}(x, y) \, dy \, dx = 1
   $$

---

### **2.2. 示例：联合 PDF 的归一化**

假设联合 PDF 定义为：

\[
f_{X,Y}(x, y) = c \cdot x^2 \cdot y, \quad \text{if } x^2 \leq y \leq 1, \quad \text{else } 0
\]

**目标**：找到常数 \(c\)，使得联合 PDF 满足归一化条件。

#### **(1) 写出积分表达式：**
积分的区域是 \(x \in [-1, 1]\) 且 \(y \in [x^2, 1]\)。因此归一化条件为：

$$
\int_{-1}^{1} \int_{x^2}^{1} c \cdot x^2 \cdot y \, dy \, dx = 1
$$

#### **(2) 先对 \(y\) 积分：**

$  
\int_{x^2}^{1} c \cdot x^2 \cdot y \, dy = c \cdot x^2 \cdot \left[ \frac{y^2}{2} \right]_{x^2}^{1}  
$

将上限和下限代入：

$  
c \cdot x^2 \cdot \left( \frac{1}{2} - \frac{x^4}{2} \right)  
$

#### **(3) 再对 \(x\) 积分：**

$$
\int_{-1}^{1} c \cdot x^2 \cdot \left( \frac{1}{2} - \frac{x^4}{2} \right) \, dx
$$

将积分拆成两部分：

$$
\frac{c}{2} \int_{-1}^{1} x^2 \, dx - \frac{c}{2} \int_{-1}^{1} x^6 \, dx
$$

计算各部分：

- $  
  \int_{-1}^{1} x^2 \, dx = \left[ \frac{x^3}{3} \right]_{-1}^{1} = \frac{2}{3}  
  $

- $  
  \int_{-1}^{1} x^6 \, dx = \left[ \frac{x^7}{7} \right]_{-1}^{1} = \frac{2}{7}  
  $

代入得到：

$$
\frac{c}{2} \cdot \frac{2}{3} - \frac{c}{2} \cdot \frac{2}{7} = \frac{4c}{21}
$$

#### **(4) 求解常数 \(c\)：**

归一化条件要求积分结果为 1：

$  
\frac{4c}{21} = 1 \quad \Rightarrow \quad c = \frac{21}{4}  
$

---

## **3. 边际分布 (Marginal Distribution) 的推导**

### **3.1. 边际 PDF 的定义**

**边际分布**描述了单个随机变量的分布，可以通过对联合 PDF 对另一个变量积分得到：

- \(X\) 的边际 PDF：

$$
f_X(x) = \int_{-\infty}^{\infty} f_{X,Y}(x, y) \, dy
$$

- \(Y\) 的边际 PDF：

$$
f_Y(y) = \int_{-\infty}^{\infty} f_{X,Y}(x, y) \, dx
$$

### **3.2. 示例计算：**

已知联合 PDF 为：

$  
f_{X,Y}(x, y) = \frac{21}{4} \cdot x^2 \cdot y, \quad \text{if } x^2 \leq y \leq 1  
$

#### **(1) 求 \(X\) 的边际分布：**

$$
f_X(x) = \int_{x^2}^{1} \frac{21}{4} \cdot x^2 \cdot y \, dy
$$

积分结果为：

$$
f_X(x) = \frac{21}{4} \cdot x^2 \cdot \left( \frac{1}{2} - \frac{x^4}{2} \right)
$$

---

## **4. 条件分布 (Conditional Distribution) 的推导**

### **4.1. 条件 PDF 的定义**

条件 PDF 描述在已知一个随机变量的值时，另一个随机变量的分布。其公式为：

$$
f_{Y|X}(y | x) = \frac{f_{X,Y}(x, y)}{f_X(x)}
$$

### **4.2. 示例计算：**

已知联合 PDF 为：

$  
f_{X,Y}(x, y) = \frac{21}{4} \cdot x^2 \cdot y  
$

在 \(X = \frac{1}{2}\) 的条件下，\(Y\) 的条件 PDF 为：

$  
f_{Y|X}(y | x = \frac{1}{2}) = \frac{\frac{21}{4} \cdot \left(\frac{1}{2}\right)^2 \cdot y}{f_X\left(\frac{1}{2}\right)}  
$

---

## **5. 随机变量的独立性 (Independence)**

### **5.1. 独立性的定义**

如果两个随机变量 \(X\) 和 \(Y\) 独立，则联合 PDF 可以分解为两个边际 PDF 的乘积：

$$
f_{X,Y}(x, y) = f_X(x) \cdot f_Y(y)
$$

---

## **6. 随机变量的函数 (Functions of Random Variables)**

### **6.1. 问题描述**

给定一个随机变量 \(X\)，我们希望求其某个函数 \(Y = h(X)\) 的分布。

---

## **7. 总结**

1. **联合 PDF 提供完整的概率信息**：不仅描述单个变量的分布，还描述它们之间的关系。
2. **条件 PDF 用于更新概率**：在已知部分信息的情况下，计算另一个变量的分布。
3. **独立性简化计算**：若两个变量独立，则联合分布为边际分布的乘积。

这些概念为统计推断和数据分析奠定了理论基础。