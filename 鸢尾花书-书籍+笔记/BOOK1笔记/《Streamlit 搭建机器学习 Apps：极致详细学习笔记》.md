# **《Streamlit 搭建机器学习 Apps：极致详细学习笔记》**

---

## **1. 什么是 Streamlit？**

**Streamlit** 是一个用于快速开发**数据应用程序**的 Python 框架，旨在让**数据科学家和开发人员**通过简洁的代码构建交互式 Web 应用程序，而不需要 HTML 或 JavaScript 等前端开发技能。

---

### **1.1 Streamlit 的主要特点**

- **实时更新**：每次修改代码后，应用会自动刷新。  
- **支持数据可视化**：与 Matplotlib、Seaborn、Plotly 等可视化库无缝集成。  
- **模型交互**：适用于展示机器学习模型结果，并支持用户输入。  
- **开源和免费**：安装方便，兼容各种操作系统。  
- **适合快速原型开发**：用于测试和演示机器学习模型效果。

---

## **2. 安装与环境配置**

1. **安装 Streamlit**：
   ```bash
   pip install streamlit
   ```

2. **运行应用**：
   在终端中运行以下命令，启动应用：
   ```bash
   streamlit run your_app.py
   ```
   浏览器会自动打开运行中的 Web 应用页面。

---

## **3. 一元高斯分布 App**

### **3.1 一元高斯分布的数学公式**

一元高斯分布（Univariate Gaussian Distribution）是常见的概率分布，其概率密度函数（PDF）为：

$$
f(x) = \frac{1}{\sqrt{2\pi\sigma^2}} \exp\left(-\frac{(x - \mu)^2}{2\sigma^2}\right)
$$

- $\mu$：均值，决定分布的中心位置  
- $\sigma$：标准差，决定分布的宽度  

---

### **3.2 应用代码实现**

```python
import streamlit as st
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import norm

# 用户输入：选择均值和标准差
mu = st.slider('均值 μ', -10.0, 10.0, 0.0)
sigma = st.slider('标准差 σ', 0.1, 5.0, 1.0)

# 生成数据
x = np.linspace(mu - 4 * sigma, mu + 4 * sigma, 100)
pdf = norm.pdf(x, mu, sigma)  # PDF 曲线
cdf = norm.cdf(x, mu, sigma)  # CDF 曲线

# 绘制 PDF 和 CDF
fig, ax = plt.subplots()
ax.plot(x, pdf, label='PDF')
ax.plot(x, cdf, label='CDF')
ax.set_title('一元高斯分布')
ax.legend()

# 将图像嵌入 Streamlit 页面
st.pyplot(fig)
```

---

## **4. 二元高斯分布 App**

### **4.1 二元高斯分布的协方差矩阵公式**

二元高斯分布用于描述二维变量的联合分布，其协方差矩阵为：

$$
\Sigma = 
\begin{bmatrix}
\sigma_1^2 & \rho \sigma_1 \sigma_2 \\
\rho \sigma_1 \sigma_2 & \sigma_2^2
\end{bmatrix}
$$

- $\sigma_1$ 和 $\sigma_2$：两个变量的标准差  
- $\rho$：相关系数，表示两个变量之间的线性关系  

---

### **4.2 应用代码实现**

```python
import numpy as np
import seaborn as sns

# 生成二元高斯分布数据
mean = [0, 0]  # 均值向量
cov = [[1, 0.5], [0.5, 1]]  # 协方差矩阵
data = np.random.multivariate_normal(mean, cov, 500)

# 使用 Seaborn 可视化联合分布
fig = sns.jointplot(x=data[:, 0], y=data[:, 1], kind='scatter')

# 将图像嵌入 Streamlit 页面
st.pyplot(fig)
```

---

## **5. 多项式回归 App**

### **5.1 多项式回归模型的数学公式**

多项式回归是线性回归的扩展，其公式为：

$$
y = \beta_0 + \beta_1 x + \beta_2 x^2 + \ldots + \beta_n x^n + \varepsilon
$$

- $\beta_i$：回归系数  
- $\varepsilon$：误差项  

---

### **5.2 应用代码实现**

```python
from sklearn.preprocessing import PolynomialFeatures
from sklearn.linear_model import LinearRegression

# 用户选择多项式的阶数
degree = st.slider('多项式阶数', 1, 10, 2)

# 生成数据并训练模型
X = np.linspace(-3, 3, 100).reshape(-1, 1)
y = X**3 + np.random.normal(0, 1, X.shape)
poly = PolynomialFeatures(degree)
X_poly = poly.fit_transform(X)
model = LinearRegression().fit(X_poly, y)

# 绘制回归结果
y_pred = model.predict(X_poly)
fig, ax = plt.subplots()
ax.scatter(X, y, label='原始数据')
ax.plot(X, y_pred, color='red', label='回归曲线')
ax.legend()

# 嵌入 Streamlit 页面
st.pyplot(fig)
```

---

## **6. 支持向量机 (SVM) 分类 App**

### **6.1 SVM 的数学公式**

支持向量机通过最大化分类间隔来找到最佳超平面，其公式为：

$$
f(x) = w \cdot x + b
$$

- $w$：权重向量  
- $b$：偏置项  

---

### **6.2 应用代码实现**

```python
from sklearn.svm import SVC
from sklearn.datasets import load_iris

# 加载数据并训练 SVM 模型
iris = load_iris()
X = iris.data[:, :2]  # 使用前两个特征
y = iris.target

kernel = st.selectbox('选择核函数', ['linear', 'rbf', 'poly'])
svm = SVC(kernel=kernel).fit(X, y)

# 绘制分类结果
x_min, x_max = X[:, 0].min() - 1, X[:, 0].max() + 1
y_min, y_max = X[:, 1].min() - 1, X[:, 1].max() + 1
xx, yy = np.meshgrid(np.linspace(x_min, x_max, 100),
                     np.linspace(y_min, y_max, 100))
Z = svm.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)

fig, ax = plt.subplots()
ax.contourf(xx, yy, Z, alpha=0.5)
ax.scatter(X[:, 0], X[:, 1], c=y, edgecolor='k')
ax.set_title('SVM 分类结果')

# 嵌入 Streamlit 页面
st.pyplot(fig)
```

---

## **7. 高斯混合模型 (GMM) 聚类 App**

### **7.1 GMM 的数学公式**

高斯混合模型（GMM）的概率密度函数为：

$$
p(x) = \sum_{k=1}^{K} \pi_k \mathcal{N}(x \mid \mu_k, \Sigma_k)
$$

- $\pi_k$：第 $k$ 个簇的权重  
- $\mu_k$：均值向量  
- $\Sigma_k$：协方差矩阵  

---

### **7.2 应用代码实现**

```python
from sklearn.mixture import GaussianMixture

# 用户选择簇的数量
n_components = st.slider('簇数量', 1, 5, 2)

# 创建并训练 GMM 模型
gmm = GaussianMixture(n_components=n_components).fit(X)
labels = gmm.predict(X)

# 可视化聚类结果
fig, ax = plt.subplots()
ax.scatter(X[:, 0], X[:, 1], c=labels, cmap='viridis')
ax.set_title('GMM 聚类结果')

# 嵌入 Streamlit 页面
st.pyplot(fig)
```

---

## **8. 总结与应用建议**

### **8.1 学习收获**

- **快速搭建交互式应用**：Streamlit 使开发者能够高效展示数据分析结果和机器学习模型。  
- **无缝集成 Python 库**：支持与 **Matplotlib**、**Seaborn**、**Scikit-Learn** 等库的集成。

### **8.2 实践建议**

- **原型开发**：Streamlit 非常适合用于快速验证和展示项目想法。  
- **模型展示与部署**：在开发机器学习模型时，可以通过 Streamlit 进行效果展示。

