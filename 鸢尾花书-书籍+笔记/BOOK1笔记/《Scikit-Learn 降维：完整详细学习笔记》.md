# **《Scikit-Learn 降维：完整详细学习笔记》**

---

## **1. 什么是降维？**

**降维（Dimensionality Reduction）** 是将高维数据映射到低维空间的过程，在此过程中尽可能保留原始数据的结构和信息。降维不仅能提高计算效率，还能降低模型的复杂度，减少过拟合，并在二维或三维空间中进行可视化。

---

### **1.1 为什么需要降维？**

1. **计算效率**：减少特征数量，提高算法的训练和预测速度。
2. **避免维度诅咒**：随着维度的增加，数据在空间中变得稀疏，影响模型性能。
3. **减少噪声**：去除冗余特征，减少数据噪声，提高模型的泛化能力。
4. **可视化**：降维后的数据可以在二维或三维空间中进行可视化，帮助理解数据结构。

---

### **1.2 常见的降维方法**

1. **线性降维**：如**主成分分析（PCA）**，通过线性组合寻找数据的最大方差方向。
2. **非线性降维**：如**核 PCA** 和 **流形学习**，适用于非线性结构的数据。
3. **特征选择**：仅保留对模型效果显著的特征，如 **Lasso 回归** 中的特征选择。

---

## **2. 主成分分析（PCA）**

**PCA（Principal Component Analysis）** 是一种线性降维技术，通过寻找数据的**最大方差方向**，将数据映射到新的坐标系中。每个新的坐标轴称为**主成分**。

---

### **2.1 PCA 的数学推导**

#### **1. 数据中心化（去均值）**

$$
X_{\text{centered}} = X - \mu
$$

其中 $\mu$ 是每个特征的均值向量。

---

#### **2. 计算协方差矩阵**

$$
\Sigma = \frac{1}{n} X_{\text{centered}}^T X_{\text{centered}}
$$

---

#### **3. 特征值分解**

协方差矩阵 $\Sigma$ 的特征值分解：

$$
\Sigma v_i = \lambda_i v_i
$$

- $\lambda_i$：特征值，表示该主成分捕捉的方差。
- $v_i$：特征向量，表示主成分的方向。

---

#### **4. 数据映射到主成分空间**

通过选择前 $k$ 个最大特征值对应的特征向量，将原始数据映射到新的 $k$ 维空间，实现降维。

$$
Z = X_{\text{centered}} \cdot V_k
$$

---

## **3. 使用 Scikit-Learn 实现 PCA**

### **3.1 数据标准化**

在 PCA 中，标准化非常重要，以确保不同量纲的特征在同一尺度上进行比较。

```python
import numpy as np
import pandas as pd
from sklearn.preprocessing import StandardScaler

# 生成模拟数据
np.random.seed(42)
data = np.random.randn(100, 3)  # 100 个样本，3 个特征

# 数据标准化
scaler = StandardScaler()
data_scaled = scaler.fit_transform(data)
```

---

### **3.2 执行 PCA**

```python
from sklearn.decomposition import PCA

# 创建 PCA 对象并设置降维后的维度为 2
pca = PCA(n_components=2)

# 拟合并转换数据
data_pca = pca.fit_transform(data_scaled)

# 打印主成分向量和解释方差比例
print(f'主成分向量:\n{pca.components_}')
print(f'解释方差比例: {pca.explained_variance_ratio_}')
```

---

### **3.3 PCA 可视化**

```python
import matplotlib.pyplot as plt

# 可视化降维后的数据
plt.scatter(data_pca[:, 0], data_pca[:, 1], alpha=0.7)
plt.xlabel('主成分 1')
plt.ylabel('主成分 2')
plt.title('PCA 降维结果')
plt.show()
```

---

## **4. 核 PCA（Kernel PCA）**

当数据具有非线性结构时，普通 PCA 无法有效捕捉数据的特征。**Kernel PCA** 通过核函数将数据映射到高维空间，在高维空间中进行线性降维。

---

### **4.1 常见核函数**

1. **径向基核（RBF Kernel）**：

   $$
   K(x, x') = \exp\left(-\gamma \|x - x'\|^2\right)
   $$

2. **多项式核（Polynomial Kernel）**：

   $$
   K(x, x') = (\alpha \cdot x^T x' + c)^d
   $$

---

### **4.2 使用 Scikit-Learn 实现 Kernel PCA**

```python
from sklearn.decomposition import KernelPCA

# 使用 RBF 核的 Kernel PCA
kpca = KernelPCA(n_components=2, kernel='rbf', gamma=15)
data_kpca = kpca.fit_transform(data_scaled)

# 可视化 Kernel PCA 结果
plt.scatter(data_kpca[:, 0], data_kpca[:, 1], alpha=0.7)
plt.xlabel('主成分 1')
plt.ylabel('主成分 2')
plt.title('Kernel PCA 降维结果')
plt.show()
```

---

## **5. 累积解释方差与维度选择**

PCA 的一个重要问题是如何选择合适的降维维度。我们可以通过**累积解释方差**来确定需要保留的主成分数量。

---

### **5.1 计算累积解释方差**

```python
import numpy as np

# 计算累积解释方差
cumulative_variance = np.cumsum(pca.explained_variance_ratio_)
print(f'累积解释方差: {cumulative_variance}')
```

---

### **5.2 可视化累积解释方差**

```python
plt.plot(np.arange(1, len(cumulative_variance) + 1), cumulative_variance, marker='o')
plt.xlabel('主成分数量')
plt.ylabel('累积解释方差')
plt.title('累积解释方差曲线')
plt.show()
```

---

## **6. 应用实例：利率数据分析**

### **6.1 数据导入与标准化**

```python
import pandas_datareader as pdr

# 导入利率数据
df = pdr.data.DataReader(['DGS6MO', 'DGS1'], data_source='fred', 
                         start='2022-01-01', end='2022-12-31').dropna()

# 计算收益率并标准化数据
returns = df.pct_change().dropna()
scaler = StandardScaler()
returns_scaled = scaler.fit_transform(returns)
```

---

### **6.2 利用 PCA 降维**

```python
# 执行 PCA
pca = PCA(n_components=2)
pca.fit(returns_scaled)

# 打印主成分向量和解释方差比例
print(f'主成分向量:\n{pca.components_}')
print(f'解释方差比例: {pca.explained_variance_ratio_}')
```

---

## **7. 总结与展望**

### **7.1 关键总结**

1. **PCA** 是一种线性降维方法，通过寻找数据的最大方差方向，将数据投影到低维空间。
2. **Kernel PCA** 通过核函数处理非线性结构的数据，实现更有效的降维。
3. **累积解释方差** 可以帮助我们选择适当的主成分数量，以平衡信息保留与降维效果。

### **7.2 实际应用**

- **数据可视化**：在低维空间中展示高维数据，便于理解数据结构。
- **特征选择**：通过去除冗余特征，提高模型的泛化能力。
- **加速训练**：减少特征数量，提高模型的训练速度。

通过本章的学习，我们掌握了 **PCA** 和 **Kernel PCA** 的实现方法及其在降维中的应用。在实际项目中，合理使用降维技术，可以提高模型的性能和效率。