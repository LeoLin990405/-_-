# **《Statsmodels 统计模型：超详细学习笔记》**

---

## **1. 什么是 Statsmodels？**

**Statsmodels** 是一个专为**统计建模、假设检验、时间序列分析**等设计的 Python 库。它提供类似 R 的统计功能，支持**回归分析、多元分析、非参数估计**等，为研究和数据分析提供了详尽的统计报告。

---

## **2. Statsmodels 常用模块与功能**

| **模块**                    | **功能描述**     | **示例函数**                      |
| --------------------------- | ---------------- | --------------------------------- |
| `statsmodels.regression`    | **回归分析**     | `OLS()`、`GLM()`                  |
| `statsmodels.tsa`           | **时间序列分析** | `ARIMA()`、`AutoReg()`            |
| `statsmodels.graphics`      | **统计图表**     | `qqplot()`、`plot_regress_exog()` |
| `statsmodels.nonparametric` | **非参数估计**   | `KDEUnivariate()`                 |
| `statsmodels.multivariate`  | **多元统计分析** | `PCA()`、`Factor()`               |

---

## **3. OLS 一元线性回归**

### **3.1 OLS 回归模型的数学表示**

回归方程：

$$
y = \beta_0 + \beta_1 x + \varepsilon
$$

- $y$：因变量  
- $x$：自变量  
- $\beta_0$：截距  
- $\beta_1$：回归系数  
- $\varepsilon$：误差项  

---

### **3.2 使用 Statsmodels 构建 OLS 模型**

```python
import numpy as np
import statsmodels.api as sm
import matplotlib.pyplot as plt

# 生成模拟数据
np.random.seed(42)
x_data = np.random.uniform(0, 10, 100)
y_data = 3.5 * x_data + 5 + np.random.normal(0, 2, 100)

# 添加常数列用于截距
X = sm.add_constant(x_data)

# 构建 OLS 模型并拟合
model = sm.OLS(y_data, X)
results = model.fit()

# 打印回归结果摘要
print(results.summary())
```

---

### **3.3 OLS 回归结果的解释**

1. **R-squared (R²)**：衡量模型的拟合优度，即自变量解释的因变量的方差比例。R² 越接近 1，模型的解释力越强。
2. **coef（系数）**：截距和斜率的估计值，如 $3.5$ 表示 $x$ 每增加 1 个单位，$y$ 平均增加 3.5 个单位。
3. **P>|t|**：p 值，用于检验系数的显著性。p 值小于 0.05 时，系数显著。
4. **Durbin-Watson**：检验残差的自相关性。接近 2 表示没有自相关性。

---

### **3.4 OLS 回归的可视化**

```python
# 生成拟合值
x_range = np.linspace(0, 10, 100)
y_pred = results.params[1] * x_range + results.params[0]

# 绘制散点图与拟合线
plt.scatter(x_data, y_data, alpha=0.6, label='样本数据')
plt.plot(x_range, y_pred, 'r', label='拟合线')
plt.xlabel('X')
plt.ylabel('Y')
plt.legend()
plt.show()
```

---

## **4. 时间序列分析：ARIMA 模型**

### **4.1 ARIMA 模型结构**

ARIMA（Auto-Regressive Integrated Moving Average）模型的数学表达：

$$
y_t = c + \phi_1 y_{t-1} + \theta_1 \varepsilon_{t-1} + \varepsilon_t
$$

其中：
- $y_t$：当前时间的观测值  
- $c$：常数项  
- $\phi_1$：自回归系数  
- $\theta_1$：移动平均系数  
- $\varepsilon_t$：误差项  

---

### **4.2 使用 ARIMA 预测时间序列**

```python
import pandas as pd
from statsmodels.tsa.arima.model import ARIMA

# 生成模拟时间序列数据
np.random.seed(1)
data = pd.Series(np.random.normal(0, 1, 100))

# 构建 ARIMA 模型并拟合
model = ARIMA(data, order=(1, 1, 1))
results = model.fit()

# 打印模型摘要
print(results.summary())

# 预测未来 10 步的数据
forecast = results.get_forecast(steps=10)
forecast_ci = forecast.conf_int()

print('预测区间:\n', forecast_ci)
```

---

### **4.3 可视化时间序列预测结果**

```python
# 绘制预测结果及置信区间
forecast_values = forecast.predicted_mean
lower_bound, upper_bound = forecast_ci.iloc[:, 0], forecast_ci.iloc[:, 1]

plt.plot(data, label='历史数据')
plt.plot(forecast_values, label='预测值', color='red')
plt.fill_between(forecast_values.index, lower_bound, upper_bound, color='pink', alpha=0.3)
plt.legend()
plt.show()
```

---

## **5. 主成分分析（PCA）**

### **5.1 PCA 的数学原理**

PCA 的目标是将高维数据降维，寻找数据的主要方差方向。数据的协方差矩阵：

$$
\Sigma = \frac{1}{n} \sum_{i=1}^{n} (x_i - \bar{x})(x_i - \bar{x})^T
$$

---

### **5.2 使用 Statsmodels 进行 PCA**

```python
import pandas as pd
from statsmodels.multivariate.pca import PCA

# 生成模拟数据
data = pd.DataFrame(np.random.normal(size=(100, 5)), 
                    columns=['Feature1', 'Feature2', 'Feature3', 'Feature4', 'Feature5'])

# 执行 PCA
pca_model = PCA(data, standardize=True)

# 打印解释方差比例
explained_var_ratio = pca_model.eigenvals / pca_model.eigenvals.sum()
print('解释方差比例:\n', explained_var_ratio)
```

---

### **5.3 绘制主成分陡坡图（Scree Plot）**

```python
plt.plot(np.arange(1, len(explained_var_ratio) + 1), explained_var_ratio, 'o-', label='解释方差比例')
plt.xlabel('主成分序号')
plt.ylabel('解释方差比例')
plt.title('Scree Plot')
plt.show()
```

---

## **6. 核密度估计（KDE）**

### **6.1 核密度估计的公式**

核密度估计（KDE）计算公式：

$$
\hat{f}(x) = \frac{1}{nh} \sum_{i=1}^n K\left(\frac{x - x_i}{h}\right)
$$

其中：
- $K(\cdot)$：核函数  
- $h$：带宽  
- $n$：样本数量  

---

### **6.2 使用 Statsmodels 进行 KDE**

```python
from statsmodels.nonparametric.kde import KDEUnivariate

# 生成随机数据
data = np.random.normal(0, 1, 100)

# 创建 KDE 对象并拟合数据
kde = KDEUnivariate(data)
kde.fit(bw=0.3)

# 绘制密度估计结果
x_vals = np.linspace(-3, 3, 100)
y_vals = kde.evaluate(x_vals)

plt.plot(x_vals, y_vals, label='KDE')
plt.fill_between(x_vals, y_vals, alpha=0.3)
plt.title('KDE 密度估计')
plt.show()
```

---

## **7. 总结与展望**

在本章中，我们深入学习了 **Statsmodels** 的关键功能：

1. **OLS 回归**：通过最小二乘法拟合回归模型，并解释系数和拟合优度。
2. **ARIMA 时间序列分析**：用于非平稳时间序列的建模与预测。
3. **PCA 主成分分析**：将高维数据降维，提取数据的主要信息。
4. **KDE 核密度估计**：估计数据的概率密度函数。

Statsmodels 提供了丰富的统计分析工具，并生成详细的模型报告。在实际项目中，掌握这些模型的使用和结果解释，将极大提高数据分析和科学计算的能力。