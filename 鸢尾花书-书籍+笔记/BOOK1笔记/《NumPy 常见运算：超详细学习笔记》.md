## **《NumPy 常见运算：超详细学习笔记》**

---

## **1. 基本算术运算**

### **1.1 什么是逐元素运算？**
- **逐元素运算**是指在两个数组中，按元素位置一一对应地进行运算。NumPy 支持加法、减法、乘法、除法和幂运算等逐元素操作。

| 运算   | 操作符 | NumPy 函数      | 示例                          |
| ------ | ------ | --------------- | ----------------------------- |
| 加法   | `+`    | `np.add()`      | `np.add([1, 2], [3, 4])`      |
| 减法   | `-`    | `np.subtract()` | `np.subtract([5, 7], [2, 4])` |
| 乘法   | `*`    | `np.multiply()` | `np.multiply([2, 3], [3, 2])` |
| 除法   | `/`    | `np.divide()`   | `np.divide([6, 8], [2, 4])`   |
| 幂运算 | `**`   | `np.power()`    | `np.power([2, 3], [3, 2])`    |

#### **示例：数组的逐元素运算**
```python
import numpy as np

a = np.array([1, 2, 3])
b = np.array([4, 5, 6])

print(np.add(a, b))      # 输出：[5 7 9]
print(np.subtract(a, b)) # 输出：[-3 -3 -3]
print(np.multiply(a, b)) # 输出：[4 10 18]
print(np.divide(a, b))   # 输出：[0.25 0.4  0.5]
print(np.power(a, 2))    # 输出：[1 4 9]
```

### **1.2 注意事项：维度对齐**
- 数组的逐元素运算要求**数组维度一致**，或者通过广播机制扩展后进行。

---

## **2. 广播机制**

### **2.1 什么是广播机制？**
- 广播是一种**扩展机制**，允许不同形状的数组进行运算。NumPy 会根据以下规则扩展数组：
  1. 如果两个数组的维度不同，将较小数组扩展至与较大数组一致。
  2. 如果某一维度的大小不一致，但其中一个数组的该维度大小为 1，则沿该维度进行**重复扩展**。

#### **示例：广播机制**
```python
a = np.array([1, 2, 3])
b = np.array([[1], [2], [3]])

print(a + b)  
# 输出：
# [[2 3 4]
#  [3 4 5]
#  [4 5 6]]
```

---

## **3. 统计运算**

NumPy 提供了一系列统计运算函数，包括求和、均值、方差和标准差等。

| 函数        | 说明   | 示例                 |
| ----------- | ------ | -------------------- |
| `np.sum()`  | 求和   | `np.sum([1, 2, 3])`  |
| `np.mean()` | 均值   | `np.mean([1, 2, 3])` |
| `np.var()`  | 方差   | `np.var([1, 2, 3])`  |
| `np.std()`  | 标准差 | `np.std([1, 2, 3])`  |
| `np.max()`  | 最大值 | `np.max([1, 2, 3])`  |
| `np.min()`  | 最小值 | `np.min([1, 2, 3])`  |

#### **示例：统计运算**
```python
A = np.array([[1, 2, 3], [4, 5, 6]])

print(np.sum(A, axis=0))  # 每列求和：[5 7 9]
print(np.mean(A, axis=1)) # 每行求均值：[2. 5.]
print(np.var(A))           # 求方差：2.9166666666666665
print(np.std(A))           # 求标准差：1.707825127659933
```

---

## **4. 线性代数运算**

### **4.1 矩阵乘法**

```python
A = np.array([[1, 2], [3, 4]])
B = np.array([[5, 6], [7, 8]])

print(np.matmul(A, B))
# 输出：
# [[19 22]
#  [43 50]]
```

- **`matmul()`** 或 **`@`** 操作符用于矩阵乘法。

---

### **4.2 矩阵转置**

```python
A = np.array([[1, 2, 3], [4, 5, 6]])
print(A.T)  # 输出：[[1 4] [2 5] [3 6]]
```

---

### **4.3 矩阵求逆**

```python
A = np.array([[1, 2], [3, 4]])
inv_A = np.linalg.inv(A)
print(inv_A)  
# 输出：[[-2.   1. ] [ 1.5 -0.5]]
```

---

### **4.4 特征值和特征向量**

```python
values, vectors = np.linalg.eig(A)
print("特征值:", values)
print("特征向量:", vectors)
```

---

## **5. 随机数生成**

| 函数                  | 描述                      | 示例                               |
| --------------------- | ------------------------- | ---------------------------------- |
| `np.random.rand()`    | 生成 0~1 之间的随机数矩阵 | `np.random.rand(2, 3)`             |
| `np.random.randn()`   | 生成正态分布的随机数      | `np.random.randn(3, 3)`            |
| `np.random.randint()` | 生成随机整数              | `np.random.randint(1, 10, (2, 3))` |
| `np.random.uniform()` | 生成均匀分布随机数        | `np.random.uniform(0, 1, (2, 2))`  |

#### **示例：生成 3x3 的正态分布随机数矩阵**
```python
rand_matrix = np.random.randn(3, 3)
print(rand_matrix)
```

---

## **6. 协方差与相关性系数**

### **6.1 协方差矩阵**

```python
data = np.array([[1, 2], [3, 4], [5, 6]])
cov_matrix = np.cov(data.T)
print(cov_matrix)
```

### **6.2 相关性系数矩阵**

```python
corr_matrix = np.corrcoef(data.T)
print(corr_matrix)
```

---

## **7. 常用数学函数**

| 函数       | 描述         |
| ---------- | ------------ |
| `np.abs()` | 计算绝对值   |
| `np.sin()` | 计算正弦值   |
| `np.cos()` | 计算余弦值   |
| `np.exp()` | 计算指数值   |
| `np.log()` | 计算自然对数 |

#### **示例：计算数组元素的正弦值**

```python
x = np.array([0, np.pi / 2, np.pi])
print(np.sin(x))  # 输出：[0. 1. 0.]
```

---

## **8. 文件读写**

### **8.1 保存数组到文件**

```python
data = np.array([[1, 2, 3], [4, 5, 6]])
np.savetxt('data.csv', data, delimiter=',')
```

### **8.2 从文件读取数组**

```python
loaded_data = np.genfromtxt('data.csv', delimiter=',')
print(loaded_data)
```

---

## **9. NumPy 与 Matplotlib 集成**

```python
import matplotlib.pyplot as plt

x = np.linspace(0, 2 * np.pi, 100)
y = np.sin(x)

plt.plot(x, y)
plt.title("Sine Wave")
plt.show()
```

---

## **10. 综合练习**

1. **生成随机矩阵**，计算其均值和标准差。
2. **实现矩阵与向量的广播运算**。
3. **绘制随机数的直方图**，可视化其分布。

---

## **11. 总结**

- **NumPy** 的常见运算涵盖了**逐元素运算、广播机制、线性代数和统计运算**等多个方面。
- 掌握这些功能，将帮助你在数据分析、科学计算和机器学习中更加高效地处理数据。

通过这些详细的示例与笔记，你将能够熟练使用 NumPy 处理复杂的数学和数据