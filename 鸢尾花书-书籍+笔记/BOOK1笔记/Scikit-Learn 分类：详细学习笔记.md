# **Scikit-Learn 分类：详细学习笔记**

---

## **1. 分类概述**

**分类（Classification）** 是**监督学习（Supervised Learning）**的一种类型，通过输入的特征向量预测数据所属的**离散类别**。分类任务主要解决的是预测问题，即为新样本分配类别标签。

### **1.1 分类任务的应用场景**

- **金融**：信用评分、欺诈检测  
- **医疗**：癌症检测、疾病诊断  
- **自然语言处理**：垃圾邮件分类、情感分析  
- **计算机视觉**：图像识别、人脸识别  

---

## **2. k-最近邻分类（k-Nearest Neighbors, kNN）**

### **2.1 kNN 的基本思想**

kNN 是一种基于**距离**的分类算法。对于一个测试样本，算法会找到其**最近的 $k$ 个邻居**，并通过投票决定其类别。

### **2.2 数学表达**

给定一个测试样本 $q$，其最近的 $k$ 个邻居的标签分别为 $y_1, y_2, \ldots, y_k$，则预测类别 $\hat{y}$ 为：

$$
\hat{y} = \arg \max_y \sum_{i=1}^{k} \mathbf{1}(y_i = y)
$$

- $\mathbf{1}(\cdot)$ 是指示函数，当括号内的条件成立时取 1，否则取 0。

### **2.3 kNN 实现与可视化**

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn import neighbors, datasets

# 加载鸢尾花数据集
iris = datasets.load_iris()
X = iris.data[:, :2]  # 只使用前两个特征
y = iris.target

# 创建 kNN 分类器
knn = neighbors.KNeighborsClassifier(n_neighbors=5)
knn.fit(X, y)

# 生成网格数据
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
xx, yy = np.meshgrid(np.linspace(x_min, x_max, 100),
                     np.linspace(y_min, y_max, 100))

# 对网格点进行预测
Z = knn.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)

# 可视化结果
plt.contourf(xx, yy, Z, alpha=0.6)
plt.scatter(X[:, 0], X[:, 1], c=y, edgecolors='k')
plt.xlabel('花萼长度')
plt.ylabel('花萼宽度')
plt.title('kNN 分类 (k=5)')
plt.show()
```

---

## **3. 朴素贝叶斯分类（Naive Bayes）**

### **3.1 贝叶斯定理**

朴素贝叶斯基于**贝叶斯定理**，即：

$$
P(C_i \mid X) = \frac{P(X \mid C_i) P(C_i)}{P(X)}
$$

- $P(C_i \mid X)$：样本属于类别 $C_i$ 的后验概率  
- $P(X \mid C_i)$：在类别 $C_i$ 下观察到 $X$ 的概率  
- $P(C_i)$：类别 $C_i$ 的先验概率  
- $P(X)$：特征 $X$ 的证据概率  

---

### **3.2 高斯朴素贝叶斯**

高斯朴素贝叶斯假设**每个特征在类别条件下服从高斯分布**。对于给定类别 $C_i$ 的特征 $X_j$，其概率密度函数为：

$$
P(X_j \mid C_i) = \frac{1}{\sqrt{2 \pi \sigma_i^2}} \exp\left(-\frac{(X_j - \mu_i)^2}{2 \sigma_i^2}\right)
$$

---

### **3.3 朴素贝叶斯实现**

```python
from sklearn.naive_bayes import GaussianNB

# 创建高斯朴素贝叶斯分类器
gnb = GaussianNB()
gnb.fit(X, y)

# 对网格点进行预测
Z = gnb.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)

# 可视化结果
plt.contourf(xx, yy, Z, alpha=0.6)
plt.scatter(X[:, 0], X[:, 1], c=y, edgecolor='k')
plt.xlabel('花萼长度')
plt.ylabel('花萼宽度')
plt.title('朴素贝叶斯分类')
plt.show()
```

---

## **4. 支持向量机分类（Support Vector Machine, SVM）**

### **4.1 支持向量机的核心思想**

SVM 通过寻找**最大间隔（Margin）**的超平面来分类数据。支持向量是离决策面最近的样本点，它们决定了分类边界的位置。

---

### **4.2 数学表达**

假设超平面的方程为：

$$
w \cdot x + b = 0
$$

其中 $w$ 是法向量，$b$ 是偏置。模型的目标是最大化间隔，同时满足以下约束：

$$
y_i (w \cdot x_i + b) \geq 1, \quad \forall i
$$

---

### **4.3 SVM 实现（线性核）**

```python
from sklearn import svm

# 创建线性核 SVM 分类器
svm_linear = svm.SVC(kernel='linear')
svm_linear.fit(X, y)

# 对网格点进行预测
Z = svm_linear.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)

# 可视化结果
plt.contourf(xx, yy, Z, alpha=0.6)
plt.scatter(X[:, 0], X[:, 1], c=y, edgecolor='k')
plt.xlabel('花萼长度')
plt.ylabel('花萼宽度')
plt.title('SVM 决策边界 (线性核)')
plt.show()
```

---

## **5. 核技巧与非线性 SVM**

### **5.1 核技巧的原理**

**核技巧（Kernel Trick）** 将数据映射到高维空间，使得在低维空间中不可分的数据在高维空间中线性可分。

---

### **5.2 常见的核函数**

1. **径向基核（RBF Kernel）**：

   $$
   K(x, x') = \exp\left(-\gamma \|x - x'\|^2\right)
   $$

2. **多项式核（Polynomial Kernel）**：

   $$
   K(x, x') = (\alpha \cdot x^T x' + c)^d
   $$

---

### **5.3 使用 RBF 核的 SVM**

```python
# 创建 RBF 核 SVM 分类器
svm_rbf = svm.SVC(kernel='rbf', gamma='auto')
svm_rbf.fit(X, y)

# 对网格点进行预测
Z = svm_rbf.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)

# 可视化结果
plt.contourf(xx, yy, Z, alpha=0.6)
plt.scatter(X[:, 0], X[:, 1], c=y, edgecolor='k')
plt.xlabel('花萼长度')
plt.ylabel('花萼宽度')
plt.title('SVM 决策边界 (RBF 核)')
plt.show()
```

---

## **6. 分类算法的比较与选择**

| **算法**   | **优点**                     | **缺点**                         |
| ---------- | ---------------------------- | -------------------------------- |
| kNN        | 简单直观，适合小数据集       | 计算复杂度高，对噪声敏感         |
| 朴素贝叶斯 | 适用于高维数据，计算效率高   | 假设特征独立，可能与实际不符     |
| SVM        | 适合高维数据，支持非线性分类 | 对大数据集计算复杂，参数调优困难 |

---

## **7. 总结与展望**

1. **kNN**：适用于小规模数据集和简单分类任务。  
2. **朴素贝叶斯**：适用于高维数据的快速分类，如文本分类。  
3. **SVM**：适合复杂的高维数据，尤其是线性不可分的情况。  

### **实际应用中的选择建议**

- **kNN** 适用于推荐系统和小样本分类。  
- **朴素贝叶斯** 常用于垃圾邮件检测、文本分类等任务。  
- **SVM** 适用于需要精确分类且特征较多的场景，如图像分类。

