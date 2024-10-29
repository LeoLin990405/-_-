### **ST346 - Chapter 1: Weighted Linear Regression 详细笔记与完整推导**

---

## **一、普通线性回归（OLS）模型回顾**

### **1.1 模型定义**
对于给定的数据 $(x_1, y_1), (x_2, y_2), \dots, (x_n, y_n)$，线性回归模型定义如下：

$$
Y_i = x_i^T \beta + \epsilon_i, \quad \text{for } i = 1, \dots, n
$$

其中：
- **$Y_i$** 是第 $i$ 个观测的响应变量（也叫目标变量）。
- **$x_i = (x_{i1}, \dots, x_{ip})^T$** 是自变量的向量，含有 $p$ 个特征。
- **$\beta = (\beta_1, \dots, \beta_p)^T$** 是我们要估计的回归系数向量。
- **$\epsilon_i$** 是误差项，用于描述观测值与模型预测之间的偏差。

我们假设误差项 $\epsilon_i$ 满足以下条件：
1. **期望为零**：$E(\epsilon_i) = 0$，说明误差没有系统性偏差。
2. **方差恒定**（齐次方差假设）：$\text{Var}(\epsilon_i) = \sigma^2$，即误差项的方差对所有观测值都相同。
3. **误差独立**：$\text{Cov}(\epsilon_i, \epsilon_j) = 0 \quad (i \neq j)$，误差项之间彼此独立。
4. **误差服从正态分布**：$\epsilon_i \sim N(0, \sigma^2)$，保证我们能够进行统计推断。

---

### **1.2 OLS 的目标**
OLS 方法通过**最小化残差平方和 (RSS, Residual Sum of Squares)** 来估计参数 $\beta$。残差是观测值与模型预测值之间的差异：
$$
r_i = y_i - x_i^T \beta
$$
目标是使所有残差的平方和最小：
$$
S(\beta) = \sum_{i=1}^n (y_i - x_i^T \beta)^2
$$

---

### **1.3 OLS 的矩阵形式推导**

为了简化表示，我们使用矩阵形式来写出上述目标函数。

- **$Y = (y_1, \dots, y_n)^T$** 是 $n \times 1$ 的响应向量。
- **$X$** 是 $n \times p$ 的设计矩阵，其中第 $i$ 行是 $x_i^T$。
- **$\beta = (\beta_1, \dots, \beta_p)^T$** 是 $p \times 1$ 的参数向量。

于是，模型可以写成矩阵形式：

$$
Y = X \beta + \epsilon
$$

其中 $\epsilon = (\epsilon_1, \dots, \epsilon_n)^T$ 是误差向量。

**目标函数的矩阵形式**：
$$
S(\beta) = (Y - X\beta)^T (Y - X\beta)
$$

---

### **1.4 OLS 的推导过程**

对 $S(\beta)$ 对 $\beta$ 求导，并令导数为 0，找到使得 $S(\beta)$ 最小的 $\beta$。

#### **第一步：对 $\beta$ 求导**
$$
\frac{\partial S(\beta)}{\partial \beta} = -2 X^T (Y - X\beta)
$$

#### **第二步：令导数为 0**
$$
X^T (Y - X\beta) = 0
$$

#### **第三步：解出 $\beta$**
$$
X^T Y = X^T X \beta
$$
若 $X^T X$ 可逆，则：
$$
\hat{\beta} = (X^T X)^{-1} X^T Y
$$

---

### **1.5 OLS 的性质**
1. **无偏性**：$E(\hat{\beta}) = \beta$。
2. **方差**：$\text{Var}(\hat{\beta}) = \sigma^2 (X^T X)^{-1}$。
3. **预测值的方差**：$\text{Var}(\hat{Y}) = X (X^T X)^{-1} X^T \sigma^2$。

---

## **二、加权最小二乘法 (WLS) 的推导**

### **2.1 为什么需要 WLS？**
在实际数据中，有时不同观测点的方差并不相同（即数据存在**异方差性**），这种情况下使用 OLS 会导致估计的 $\beta$ 不准确。为了解决这个问题，我们使用**加权最小二乘法 (Weighted Least Squares, WLS)**。

---

### **2.2 WLS 的模型假设**

我们假设不同观测值的误差方差与权重 $w_i$ 相关：
$$
\text{Var}(\epsilon_i) = \frac{\phi}{w_i}, \quad i = 1, \dots, n
$$
- $w_i$ 是已知的非负权重。权重大的观测点表示信息量更大（方差更小）。
- $\phi$ 是未知的离散参数。

**核心思想**：我们希望对每个观测值的残差平方进行加权，使得**权重大**（即方差小）的观测值对模型的贡献更大。

---

### **2.3 WLS 的目标函数**

WLS 的目标是最小化加权后的残差平方和：
$$
S(\beta) = \sum_{i=1}^n w_i \left( y_i - x_i^T \beta \right)^2
$$

写成矩阵形式：
$$
S(\beta) = (Y - X\beta)^T W (Y - X\beta)
$$

其中：
- $W = \text{diag}(w_1, \dots, w_n)$ 是对角矩阵，每个 $w_i$ 是第 $i$ 个观测的权重。

---

### **2.4 WLS 的推导**

对 $S(\beta)$ 对 $\beta$ 求导，并令导数为 0。

#### **第一步：求导**
$$
\frac{\partial S(\beta)}{\partial \beta} = -2 X^T W (Y - X\beta)
$$

#### **第二步：令导数为 0**
$$
X^T W (Y - X\beta) = 0
$$

#### **第三步：解出 $\beta$**
$$
X^T W Y = X^T W X \beta
$$

若 $X^T W X$ 可逆，则：
$$
\hat{\beta} = (X^T W X)^{-1} X^T W Y
$$

---

## **三、WLS 与 OLS 的关系**

- 当所有权重 $w_i = 1$ 时，WLS 退化为 OLS：
$$
\hat{\beta}_{\text{OLS}} = (X^T X)^{-1} X^T Y
$$

---

## **四、模型诊断：帽子矩阵与杠杆值**

### **4.1 帽子矩阵 (Hat Matrix)**

WLS 中的帽子矩阵定义为：
$$
H = X (X^T W X)^{-1} X^T W
$$
帽子矩阵用于将观测值 $Y$ 投影到拟合值 $\hat{Y}$：
$$
\hat{Y} = H Y
$$

### **4.2 杠杆值 (Leverage)**

帽子矩阵的对角元素称为**杠杆值**：
$$
h_i = w_i x_i^T (X^T W X)^{-1} x_i
$$
杠杆值表示第 $i$ 个观测值对模型拟合的影响。

---

## **五、加权残差与标准化**

### **5.1 加权残差**

- **原始残差**：
  $r_i = y_i - x_i^T \hat{\beta}$
  
- **加权残差**：
  $r_i^* = \sqrt{w_i} r_i = \sqrt{w_i} \left( y_i - x_i^T \hat{\beta} \right)$

### **5.2 标准化残差**

标准化残差用于消除不同权重和杠杆值的影响：
$$
r_i^{(s)} = \frac{\sqrt{w_i} \left( y_i - x_i^T \hat{\beta} \right)}{\sqrt{(1 - h_i) \hat{\phi}}}
$$

---

## **六、总结**

1. **WLS** 通过引入权重解决了 OLS 在异方

差情况下的局限性。
2. **WLS 的估计量**为：
   $$
   \hat{\beta}_{\text{WLS}} = (X^T W X)^{-1} X^T W Y
   $$
3. **杠杆值和标准化残差**是重要的模型诊断工具，帮助识别异常值和高杠杆点。

---

