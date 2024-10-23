# **《Scikit-Learn 数据：极致详细学习笔记》**

---

## **1. Scikit-Learn 数据集工具概述**

**Scikit-Learn** 是 Python 中强大的机器学习库，除了提供多种机器学习算法，还包含了丰富的**内置数据集和模拟数据生成工具**。这些数据集和工具为机器学习模型的构建、调试和测试提供了重要支持。

- **经典数据集**：用于快速实验和算法验证，如鸢尾花、手写数字数据集。  
- **数据生成函数**：创建自定义的回归、分类和聚类数据集，方便模拟测试。

---

## **2. 常见内置数据集**

以下是 Scikit-Learn 中一些常见的内置数据集及其应用：

| **数据集名称**         | **描述**                                 | **应用场景** |
| ---------------------- | ---------------------------------------- | ------------ |
| `load_iris()`          | 鸢尾花分类数据集，150 个样本，4 个特征   | 分类任务     |
| `load_boston()`        | 波士顿房价数据集，506 个样本，13 个特征  | 回归任务     |
| `load_digits()`        | 手写数字识别数据集，1797 个 8x8 像素图像 | 多分类任务   |
| `load_wine()`          | 葡萄酒分类数据集，13 个特征，178 个样本  | 分类任务     |
| `load_breast_cancer()` | 乳腺癌诊断数据集，30 个特征，569 个样本  | 分类任务     |

---

## **3. 使用鸢尾花数据集进行分类分析**

### **3.1 加载和查看鸢尾花数据集**

```python
from sklearn.datasets import load_iris
import pandas as pd

# 加载鸢尾花数据集
iris = load_iris()

# 将数据转换为 Pandas DataFrame
df = pd.DataFrame(data=iris.data, columns=iris.feature_names)
df['target'] = iris.target

# 打印前 5 行数据
print(df.head())
```

### **3.2 数据集结构**

- **特征（Feature）**：花萼长度、花萼宽度、花瓣长度、花瓣宽度。  
- **目标（Target）**：0 表示 Setosa，1 表示 Versicolor，2 表示 Virginica。

---

## **4. 数据生成函数**

Scikit-Learn 提供了多种**生成虚拟数据集**的函数，适用于测试算法和模拟真实场景中的数据。

### **4.1 分类数据集生成：`make_classification()`**

```python
from sklearn.datasets import make_classification
import matplotlib.pyplot as plt

# 生成分类数据集
X, y = make_classification(n_samples=500, n_features=2, n_redundant=0, 
                           n_informative=2, n_clusters_per_class=1, random_state=42)

# 可视化数据
plt.scatter(X[:, 0], X[:, 1], c=y, cmap='viridis', edgecolors='k')
plt.title('分类数据集示例')
plt.show()
```

---

### **4.2 回归数据集生成：`make_regression()`**

```python
from sklearn.datasets import make_regression

# 生成回归数据集
X, y = make_regression(n_samples=100, n_features=1, noise=10, random_state=42)

# 可视化回归数据
plt.scatter(X, y, edgecolor='k')
plt.title('回归数据集示例')
plt.show()
```

---

### **4.3 聚类数据集生成：`make_blobs()`**

```python
from sklearn.datasets import make_blobs

# 生成聚类数据集
X, y = make_blobs(n_samples=300, centers=3, n_features=2, random_state=42)

# 可视化聚类数据
plt.scatter(X[:, 0], X[:, 1], c=y, cmap='coolwarm', edgecolor='k')
plt.title('聚类数据集示例')
plt.show()
```

---

## **5. 数据预处理**

在机器学习工作流中，**数据预处理**是必不可少的步骤。Scikit-Learn 提供了强大的工具用于**特征缩放、缺失值处理、编码**等。

### **5.1 特征缩放：标准化**

```python
from sklearn.preprocessing import StandardScaler

# 初始化标准化器
scaler = StandardScaler()

# 对鸢尾花数据进行标准化
X_scaled = scaler.fit_transform(iris.data)

print('标准化后的数据（前 5 行）：\n', X_scaled[:5])
```

### **5.2 处理缺失值：均值填充**

```python
from sklearn.impute import SimpleImputer
import numpy as np

# 创建含有缺失值的数据
X_with_nan = np.array([[np.nan, 2], [6, np.nan], [7, 6]])

# 使用均值填充缺失值
imputer = SimpleImputer(strategy='mean')
X_filled = imputer.fit_transform(X_with_nan)

print('填补后的数据：\n', X_filled)
```

---

## **6. 数据集划分：训练集与测试集**

将数据集划分为**训练集和测试集**，是保证模型泛化能力的重要步骤。常用的划分比例为**80% 训练集，20% 测试集**。

### **6.1 使用 `train_test_split()` 进行划分**

```python
from sklearn.model_selection import train_test_split

# 划分鸢尾花数据集
X_train, X_test, y_train, y_test = train_test_split(iris.data, iris.target, 
                                                    test_size=0.2, random_state=42)

print(f'训练集大小: {X_train.shape}')
print(f'测试集大小: {X_test.shape}')
```

---

## **7. 检测离群值**

**离群值**会干扰模型的训练过程，影响模型性能。我们可以使用 **Isolation Forest** 来检测并处理离群值。

### **7.1 使用 Isolation Forest 检测离群值**

```python
from sklearn.ensemble import IsolationForest

# 初始化 Isolation Forest
iso = IsolationForest(contamination=0.1, random_state=42)

# 检测离群值
y_pred = iso.fit_predict(iris.data)

# 打印前 10 个预测标签 (-1 表示离群值)
print('前 10 个样本的预测结果：\n', y_pred[:10])
```

---

## **8. 构建完整的机器学习管道**

Scikit-Learn 的 **Pipeline** 工具允许我们将**数据预处理和模型训练**整合为一个工作流，简化模型的构建过程。

### **8.1 使用管道进行分类**

```python
from sklearn.pipeline import Pipeline
from sklearn.svm import SVC
from sklearn.metrics import classification_report

# 创建分类管道：标准化 + 支持向量机
pipeline = Pipeline([
    ('scaler', StandardScaler()),
    ('svc', SVC(kernel='linear'))
])

# 在训练集上训练管道
pipeline.fit(X_train, y_train)

# 预测测试集并输出评估结果
y_pred = pipeline.predict(X_test)
print(classification_report(y_test, y_pred))
```

---

## **9. 总结**

### **9.1 本章重点回顾**

1. **经典数据集**：鸢尾花、手写数字、波士顿房价等数据集的加载和使用。  
2. **数据生成函数**：生成回归、分类和聚类数据集，支持模拟测试。  
3. **数据预处理**：使用 **StandardScaler** 进行特征缩放，处理缺失值。  
4. **数据集划分**：将数据集划分为训练集和测试集。  
5. **离群值检测**：使用 **Isolation Forest** 检测和处理离群值。  
6. **管道构建**：将数据预处理与模型训练整合为一个完整的工作流。

### **9.2 实际应用展望**

通过本章的学习，你已经掌握了如何使用 Scikit-Learn 的数据集工具和数据预处理技术。在实际项目中，你可以：
- 使用经典数据集快速测试算法。
- 使用模拟数据生成函数构建和验证模型原型。
- 通过管道简化复杂工作流。

不断练习这些工具和方法，将帮助你在实际数据分析和机器学习项目中更加高效地构建模型。