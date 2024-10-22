## **《NumPy 超详细学习笔记》**

---

## **1. NumPy 简介**

### **1.1 什么是 NumPy？**
- **NumPy**（Numerical Python）是一个用于**科学计算**的基础库，支持高效的**多维数组（ndarray）**操作。
- 它的设计使得**矩阵运算**、**线性代数**、**傅里叶变换**和**随机数生成**更加方便，并且与 Python 科学计算生态系统中的其他库（如 Pandas 和 SciPy）无缝集成。

---

## **2. NumPy 数组：核心数据结构**

### **2.1 什么是 `ndarray`？**
- **`ndarray`** 是 NumPy 的多维数组对象，支持高效的存储和运算。
- 数组中的所有元素必须是相同类型。

```python
import numpy as np

# 创建一维数组
arr1 = np.array([1, 2, 3, 4])

# 创建二维数组
arr2 = np.array([[1, 2, 3], [4, 5, 6]])

print(arr1)  # 输出：[1 2 3 4]
print(arr2)  # 输出：[[1 2 3] [4 5 6]]
```

---

### **2.2 数组的属性**

```python
print(arr2.shape)   # 输出：(2, 3) - 数组的形状（行数和列数）
print(arr2.ndim)    # 输出：2 - 数组的维度数
print(arr2.size)    # 输出：6 - 数组的元素总数
print(arr2.dtype)   # 输出：int64 - 数组元素的数据类型
```

---

## **3. 数组创建与生成**

### **3.1 基本数组生成方法**
```python
# 创建全零数组
zeros = np.zeros((3, 4))
print(zeros)

# 创建全一数组
ones = np.ones((2, 3))
print(ones)

# 创建单位矩阵
identity = np.eye(3)
print(identity)

# 创建填充特定数值的数组
filled = np.full((2, 2), 7)
print(filled)
```

---

### **3.2 数列生成**

#### **`arange()`**：生成等差数列
```python
arr = np.arange(0, 10, 2)  # 输出：[0 2 4 6 8]
print(arr)
```

#### **`linspace()`**：生成等间距数列
```python
arr = np.linspace(0, 1, 5)  # 输出：[0.   0.25 0.5  0.75 1.]
print(arr)
```

#### **`logspace()`**：生成对数间距数列
```python
arr = np.logspace(0, 3, 4)  # 输出：[1. 10. 100. 1000.]
print(arr)
```

---

## **4. 数组的索引与切片**

### **4.1 一维数组索引与切片**
```python
arr = np.array([1, 2, 3, 4, 5])

print(arr[0])  # 输出：1
print(arr[1:4])  # 输出：[2 3 4]
```

### **4.2 二维数组索引与切片**
```python
arr2d = np.array([[1, 2, 3], [4, 5, 6], [7, 8, 9]])

# 访问特定元素
print(arr2d[1, 2])  # 输出：6

# 访问特定行的切片
print(arr2d[0:2, 1:3])  # 输出：[[2 3] [5 6]]
```

---

## **5. 数组变形与合并**

### **5.1 数组的重塑（reshape）**
```python
arr = np.array([1, 2, 3, 4, 5, 6])
reshaped = arr.reshape(2, 3)  # 重塑为 2x3 矩阵
print(reshaped)
```

### **5.2 数组的合并**

```python
# 垂直合并
a = np.array([[1, 2], [3, 4]])
b = np.array([[5, 6]])
vstacked = np.vstack((a, b))
print(vstacked)  # 输出：[[1 2] [3 4] [5 6]]

# 水平合并
hstacked = np.hstack((a, a))
print(hstacked)  # 输出：[[1 2 1 2] [3 4 3 4]]
```

---

## **6. 广播机制**

- **广播机制**允许不同形状的数组进行运算。

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

## **7. 数学运算**

### **7.1 基本运算**
```python
a = np.array([1, 2, 3, 4])

print(a + 1)  # 输出：[2 3 4 5]
print(a * 2)  # 输出：[2 4 6 8]
print(np.sum(a))  # 输出：10
print(np.mean(a))  # 输出：2.5
```

---

### **7.2 线性代数运算**

```python
A = np.array([[1, 2], [3, 4]])
B = np.array([[5, 6], [7, 8]])

# 矩阵乘法
print(np.matmul(A, B))

# 求逆矩阵
print(np.linalg.inv(A))

# 求特征值和特征向量
values, vectors = np.linalg.eig(A)
print(values)
print(vectors)
```

---

## **8. 随机数生成**

### **8.1 随机数的生成**
```python
# 生成均匀分布的随机数
rand_arr = np.random.rand(3, 3)
print(rand_arr)

# 生成正态分布的随机数
normal_arr = np.random.randn(3, 3)
print(normal_arr)

# 生成随机整数
int_arr = np.random.randint(1, 10, (2, 3))
print(int_arr)
```

---

## **9. 文件读写**

### **9.1 保存数组到文件**
```python
data = np.array([[1, 2, 3], [4, 5, 6]])
np.savetxt('data.csv', data, delimiter=',')
```

### **9.2 从文件读取数组**
```python
loaded_data = np.genfromtxt('data.csv', delimiter=',')
print(loaded_data)
```

---

## **10. NumPy 与 Matplotlib 集成**

```python
import matplotlib.pyplot as plt

x = np.linspace(0, 2 * np.pi, 100)
y = np.sin(x)

plt.plot(x, y)
plt.title("Sine Wave")
plt.show()
```

---

## **11. 三维数据可视化**

```python
from mpl_toolkits.mplot3d import Axes3D

x = np.linspace(-5, 5, 50)
y = np.linspace(-5, 5, 50)
X, Y = np.meshgrid(x, y)
Z = np.sin(np.sqrt(X**2 + Y**2))

fig = plt.figure()
ax = fig.add_subplot(111, projection='3d')
ax.plot_surface(X, Y, Z, cmap='viridis')
plt.show()
```

---

## **12. 总结**

- **NumPy** 是 Python 科学计算和数据分析的基础库。
- 通过掌握 **数组的创建、索引、变形、数学运算、文件读写和随机数生成**，可以高效处理数据。
- 与 **Matplotlib** 的无缝集成，使得数据可视化更加简单和直观。

---

这份超详细的 NumPy 学习笔记涵盖了 NumPy 的所有关键功能，并附带了完整的代码示例。通过不断实践这些知识，你将能熟练掌握 NumPy 的使用，并在科学计算、数据分析和机器学习中得心应手。