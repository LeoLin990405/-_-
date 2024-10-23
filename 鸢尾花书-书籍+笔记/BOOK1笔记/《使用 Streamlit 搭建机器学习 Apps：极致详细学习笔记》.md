# **《使用 Streamlit 搭建机器学习 Apps：极致详细学习笔记》**

---

## **1. 什么是 Streamlit？**

**Streamlit** 是一个**开源的 Python Web 应用框架**，专为**数据科学家和机器学习工程师**设计。它能通过简洁的 Python 代码快速搭建**交互式 Web 应用**，并且无需前端开发知识。

### **1.1 Streamlit 的核心特点**

- **简单易用**：以 Python 为基础，无需 HTML/CSS/JavaScript。
- **实时更新**：每次修改代码，页面会自动刷新并显示结果。
- **数据可视化支持**：与 **Matplotlib**、**Seaborn**、**Plotly** 等库无缝集成。
- **支持机器学习模型展示**：可展示 Scikit-learn、TensorFlow 等库的模型效果。

---

## **2. 环境配置与安装**

1. **安装 Streamlit**：
   ```bash
   pip install streamlit
   ```

2. **运行 Streamlit 应用**：
   在终端中输入：
   ```bash
   streamlit run your_app.py
   ```
   该命令会在默认浏览器中打开应用程序。

---

## **3. 一元高斯分布 App**

### **3.1 一元高斯分布的定义**

**一元高斯分布**的概率密度函数（PDF）为：

$$
f(x) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp\left(-\frac{(x - \mu)^2}{2\sigma^2}\right)
$$

- $\mu$：均值，决定分布的中心位置  
- $\sigma$：标准差，决定分布的宽度

---

### **3.2 实现代码**

```python
import streamlit as st
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# 用户输入
mu = st.slider('均值 $\mu$', -10.0, 10.0, 0.0)
sigma = st.slider('标准差 $\sigma$', 0.1, 5.0, 1.0)

# 生成数据
x = np.linspace(mu - 4 * sigma, mu + 4 * sigma, 100)
pdf = norm.pdf(x, mu, sigma)
cdf = norm.cdf(x, mu, sigma)

# 绘图
fig, ax = plt.subplots()
ax.plot(x, pdf, label='PDF')
ax.plot(x, cdf, label='CDF')
ax.legend()
st.pyplot(fig)
```

---

## **4. 多项式回归 App**

### **4.1 多项式回归的数学表达**

多项式回归模型的形式为：

$$
y = \beta_0 + \beta_1 x + \beta_2 x^2 + \ldots + \beta_n x^n + \varepsilon
$$

- $\beta_i$：回归系数  
- $x$：自变量  
- $\varepsilon$：误差项

---

### **4.2 实现代码**

```python
import streamlit as st
import numpy as np
import matplotlib.pyplot as plt
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression

# 用户输入
degree = st.slider('多项式阶数', 1, 10, 2)

# 生成数据
X = np.linspace(-3, 3, 100).reshape(-1, 1)
y = X ** 3 + np.random.normal(0, 1, X.shape)

# 多项式回归
poly = PolynomialFeatures(degree)
X_poly = poly.fit_transform(X)
model = LinearRegression()
model.fit(X_poly, y)

# 预测
y_pred = model.predict(X_poly)

# 绘图
fig, ax = plt.subplots()
ax.scatter(X, y, label='数据')
ax.plot(X, y_pred, color='red', label='回归曲线')
ax.legend()
st.pyplot(fig)
```

---

## **5. 主成分分析 (PCA) App**

### **5.1 主成分分析的数学表达**

主成分分析（PCA）用于将数据从高维空间映射到低维空间：

$$
Z = X W
$$

- $X$：原始数据矩阵  
- $W$：主成分矩阵

---

### **5.2 实现代码**

```python
import streamlit as st
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd

# 加载数据
iris = sns.load_dataset('iris')
X = iris.iloc[:, :-1]

# 用户输入：选择主成分数量
n_components = st.slider('主成分数量', 1, 4, 2)

# 执行 PCA
pca = PCA(n_components=n_components)
X_pca = pca.fit_transform(X)

# 可视化
fig, ax = plt.subplots()
sns.scatterplot(x=X_pca[:, 0], y=X_pca[:, 1], hue=iris['species'], ax=ax)
ax.set_xlabel('PC 1')
ax.set_ylabel('PC 2')
st.pyplot(fig)
```

---

## **6. 支持向量机 (SVM) 分类 App**

### **6.1 SVM 的数学表达**

支持向量机使用如下公式确定分类的决策边界：

$$
f(x) = w \cdot x + b
$$

- $w$：权重向量  
- $b$：偏置项

---

### **6.2 实现代码**

```python
import streamlit as st
from sklearn import datasets
from sklearn.svm import SVC
import matplotlib.pyplot as plt
import numpy as np

# 加载数据
iris = datasets.load_iris()
X = iris.data[:, :2]
y = iris.target

# 用户输入
kernel = st.selectbox('选择核函数', ['linear', 'rbf', 'poly'])
gamma = st.slider('Gamma 参数', 0.1, 1.0, 0.5)

# 训练模型
svm = SVC(kernel=kernel, gamma=gamma)
svm.fit(X, y)

# 绘制决策边界
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
xx, yy = np.meshgrid(np.linspace(x_min, x_max, 100),
                     np.linspace(y_min, y_max, 100))
Z = svm.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)

fig, ax = plt.subplots()
ax.contourf(xx, yy, Z, alpha=0.5)
ax.scatter(X[:, 0], X[:, 1], c=y, edgecolor='k')
st.pyplot(fig)
```

---

## **7. 高斯混合模型 (GMM) 聚类 App**

### **7.1 GMM 的数学表达**

高斯混合模型（GMM）假设数据由多个高斯分布组成：

$$
p(x) = \sum_{k=1}^{K} \pi_k \mathcal{N}(x \mid \mu_k, \Sigma_k)
$$

- $\pi_k$：第 $k$ 个分布的权重  
- $\mu_k$：均值向量  
- $\Sigma_k$：协方差矩阵

---

### **7.2 实现代码**

```python
from sklearn.mixture import GaussianMixture

# 用户输入：选择簇的数量
n_components = st.slider('簇数量', 1, 5, 2)

# 创建 GMM 模型
gmm = GaussianMixture(n_components=n_components)
gmm.fit(X)

# 预测
labels = gmm.predict(X)

# 可视化
fig, ax = plt.subplots()
ax.scatter(X[:, 0], X[:, 1], c=labels, cmap='viridis')
st.pyplot(fig)
```

---

## **8. 总结**

### **8.1 学习收获**

- 掌握了如何使用 **Streamlit** 搭建多种机器学习应用。  
- 学会了结合 **Python** 科学计算库和机器学习模型进行可视化展示。

### **8.2 实践建议**

- **快速原型开发**：Streamlit 适用于快速验证想法，并进行模型展示。  
- **与机器学习结合**：通过 Streamlit 演示机器学习模型的效果，更好地与团队和客户沟通。

Streamlit 提供了一种**简单、高效**的开发方式，适用于**数据科学家、研究人员和开发者**进行交互式应用的开发与展示。