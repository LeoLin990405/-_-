# **《Scikit-Learn 回归：完整详细学习笔记》**

---

## **1. 回归分析概述**

回归分析是一种**统计方法**，用于研究**自变量（输入特征）与因变量（目标值）之间的关系**，并通过模型对未来或未知数据进行**连续值预测**。它是**监督学习**的一种，广泛用于经济、金融、工程等领域。

---

### **1.1 回归分析的数学表达式**

在一元线性回归模型中，我们试图拟合一条直线，使预测值尽可能接近真实值。其公式如下：

$$
y = \beta_0 + \beta_1 x + \varepsilon
$$

- $y$：预测的目标值  
- $x$：输入特征  
- $\beta_0$：截距项（线与 $y$ 轴的交点）  
- $\beta_1$：回归系数（表示 $x$ 对 $y$ 的影响程度）  
- $\varepsilon$：误差项（表示模型的预测误差）

---

### **1.2 回归分析的类型**

1. **简单线性回归**：只有一个自变量的线性模型。
2. **多元线性回归**：多个自变量的线性模型。
3. **多项式回归**：用于拟合非线性数据，通过扩展自变量的多项式项实现。
4. **正则化回归**：通过引入惩罚项控制模型复杂度，防止过拟合（如岭回归、Lasso 回归）。

---

## **2. 使用 Scikit-Learn 实现一元线性回归**

### **2.1 数据准备与模型训练**

```python
import numpy as np
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

# 生成模拟数据
np.random.seed(42)
X = np.random.uniform(0, 10, 50).reshape(-1, 1)  # 自变量
y = 2.5 * X + np.random.normal(0, 2, 50)  # 因变量

# 创建线性回归模型并拟合数据
model = LinearRegression()
model.fit(X, y)

# 获取模型的参数
slope = model.coef_[0]  # 斜率
intercept = model.intercept_  # 截距

# 生成预测值
X_pred = np.linspace(0, 10, 100).reshape(-1, 1)
y_pred = model.predict(X_pred)

# 可视化回归结果
plt.scatter(X, y, label='数据点')
plt.plot(X_pred, y_pred, color='r', label=f'回归线: $y = {intercept:.2f} + {slope:.2f}x$')
plt.xlabel('X')
plt.ylabel('Y')
plt.legend()
plt.show()
```

---

## **3. 多元线性回归**

多元线性回归用于分析**多个自变量**与因变量之间的关系。其数学表达式为：

$$
y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + \ldots + \beta_p x_p + \varepsilon
$$

- $x_1, x_2, \ldots, x_p$：多个自变量

---

### **3.1 多元线性回归示例**

```python
from sklearn.datasets import make_regression
from sklearn.model_selection import train_test_split

# 生成模拟数据
X, y = make_regression(n_samples=100, n_features=2, noise=10, random_state=42)

# 创建并训练线性回归模型
model = LinearRegression()
model.fit(X, y)

# 输出模型参数
print(f'截距: {model.intercept_}')
print(f'回归系数: {model.coef_}')

# 划分训练集和测试集
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
score = model.score(X_test, y_test)
print(f'R² 分数: {score}')
```

---

## **4. 多项式回归**

多项式回归用于捕捉**非线性关系**，通过将特征进行**多项式扩展**来拟合复杂的数据模式。

---

### **4.1 多项式回归的数学表达**

$$
y = \beta_0 + \beta_1 x + \beta_2 x^2 + \ldots + \beta_p x^p + \varepsilon
$$

---

### **4.2 多项式回归示例**

```python
from sklearn.preprocessing import PolynomialFeatures

# 生成非线性数据
np.random.seed(42)
X = np.linspace(0, 4, 20).reshape(-1, 1)
y = 2 * X**2 + 3 * X + np.random.normal(0, 2, 20)

# 创建多项式特征（degree=2）
poly = PolynomialFeatures(degree=2)
X_poly = poly.fit_transform(X)

# 创建并训练线性回归模型
model = LinearRegression()
model.fit(X_poly, y)

# 生成预测值
X_pred = np.linspace(0, 4, 100).reshape(-1, 1)
y_pred = model.predict(poly.transform(X_pred))

# 可视化结果
plt.scatter(X, y, label='数据点')
plt.plot(X_pred, y_pred, color='r', label='多项式回归曲线')
plt.xlabel('X')
plt.ylabel('Y')
plt.legend()
plt.show()
```

---

## **5. 正则化回归**

### **5.1 岭回归（Ridge Regression）**

**岭回归**引入了**L2 正则化项**，用于抑制模型的复杂性：

$$
\text{损失函数} = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \alpha \sum_{j=1}^{p} \beta_j^2
$$

### **5.2 Lasso 回归（Lasso Regression）**

**Lasso 回归**采用**L1 正则化**，可以将一些特征的系数缩小为 0，从而实现特征选择：

$$
\text{损失函数} = \sum_{i=1}^{n} (y_i - \hat{y}_i)^2 + \alpha \sum_{j=1}^{p} |\beta_j|
$$

---

### **5.3 岭回归示例**

```python
from sklearn.linear_model import Ridge

# 创建并训练岭回归模型
ridge = Ridge(alpha=1.0)
ridge.fit(X_poly, y)

# 生成预测值
y_pred = ridge.predict(poly.transform(X_pred))

# 可视化结果
plt.scatter(X, y, label='数据点')
plt.plot(X_pred, y_pred, color='r', label='岭回归曲线')
plt.xlabel('X')
plt.ylabel('Y')
plt.legend()
plt.show()
```

---

## **6. 模型评估指标**

1. **R² 分数**：表示模型对数据方差的解释能力：

$$
R^2 = 1 - \frac{\sum (y_i - \hat{y}_i)^2}{\sum (y_i - \bar{y})^2}
$$

2. **均方误差（MSE）**：

$$
MSE = \frac{1}{n} \sum_{i=1}^{n} (y_i - \hat{y}_i)^2
$$

---

### **6.1 模型评估示例**

```python
from sklearn.metrics import mean_squared_error, r2_score

# 预测测试集结果
y_test_pred = ridge.predict(poly.transform(X_test))

# 计算均方误差和 R² 分数
mse = mean_squared_error(y_test, y_test_pred)
r2 = r2_score(y_test, y_test_pred)

print(f'均方误差: {mse}')
print(f'R² 分数: {r2}')
```

---

## **7. 总结与展望**

### **7.1 本章重点回顾**

1. **线性回归模型**：适合简单的线性关系。  
2. **多项式回归**：用于拟合复杂的非线性关系。  
3. **正则化回归（岭回归与 Lasso 回归）**：通过惩罚项控制模型复杂度，防止过拟合。  
4. **模型评估**：使用均方误差和 R² 分数衡量模型性能。

### **7.2 实际应用展望**

在实际项目中：
- **简单线性回归**适用于单一特征的分析和预测。  
- **多元回归**适用于多个特征共同影响目标变量的情况。  
- **多项式回归**用于处理非线性关系的场景。  
- **正则化回归**在高维数据和多特征情况下防止模型过拟合。  

