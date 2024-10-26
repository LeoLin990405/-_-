# 第三章：线性回归（Linear Regression）——详细完整笔记

## 1. 简单线性回归（Simple Linear Regression）

### 1.1 模型定义与结构
**简单线性回归**用于研究**一个输入变量** $X$ 和**一个响应变量** $Y$ 之间的线性关系：

$$Y = \beta_0 + \beta_1 X + \varepsilon$$

其中：
- $Y$：响应变量（dependent variable），如产品销量
- $X$：输入变量（independent variable），如广告支出
- $\beta_0$：截距，表示当 $X = 0$ 时的响应值
- $\beta_1$：斜率系数，表示 $X$ 增加1单位时 $Y$ 的预期变化量
- $\varepsilon$：误差项，表示无法通过 $X$ 解释的随机性和噪声

### 1.2 模型的核心假设

1. **线性关系假设**：
   $$\mathbb{E}[Y | X] = \beta_0 + \beta_1 X$$

2. **误差项的独立性**：各个样本的误差项彼此独立

3. **误差项的正态分布**：
   $$\varepsilon_i \sim N(0, \sigma^2)$$

4. **方差齐性（Homoscedasticity）**：误差项在所有 $X$ 的取值范围内具有相同的方差

### 1.3 参数估计：最小二乘法 (OLS)

目标是最小化残差平方和（RSS）：

$$RSS = \sum_{i=1}^{n} (Y_i - (\beta_0 + \beta_1 X_i))^2$$

推导得到参数估计值：

$$\hat{\beta}_1 = \frac{\sum_{i=1}^{n} (X_i - \bar{X})(Y_i - \bar{Y})}{\sum_{i=1}^{n} (X_i - \bar{X})^2}$$

$$\hat{\beta}_0 = \bar{Y} - \hat{\beta}_1 \bar{X}$$

## 2. 多元线性回归（Multiple Linear Regression）

### 2.1 模型结构与定义
多元线性回归拓展了简单线性回归，允许使用多个输入变量：

$$Y = \beta_0 + \beta_1 X_1 + \beta_2 X_2 + \cdots + \beta_p X_p + \varepsilon$$

### 2.2 参数估计：矩阵形式

#### 矩阵表示：
$$\mathbf{Y} = \mathbf{X}\boldsymbol{\beta} + \boldsymbol{\varepsilon}$$

其中：
- $\mathbf{Y}$ 是 $n \times 1$ 的响应向量
- $\mathbf{X}$ 是 $n \times (p+1)$ 的设计矩阵
- $\boldsymbol{\beta}$ 是 $(p+1) \times 1$ 的参数向量
- $\boldsymbol{\varepsilon}$ 是 $n \times 1$ 的误差向量

#### OLS估计：
$$\hat{\boldsymbol{\beta}} = (\mathbf{X}^T \mathbf{X})^{-1} \mathbf{X}^T \mathbf{Y}$$

### 2.3 标准误差估计
对于回归系数的标准误差：

$$SE(\hat{\beta}_j) = \sqrt{\hat{\sigma}^2 [(\mathbf{X}^T \mathbf{X})^{-1}]_{jj}}$$

其中 $\hat{\sigma}^2$ 是误差方差的估计：

$$\hat{\sigma}^2 = \frac{RSS}{n-p-1}$$

## 3. 模型评估指标

### 3.1 残差标准误（RSE）
残差标准误衡量了预测的平均误差：

$$RSE = \sqrt{\frac{RSS}{n-p-1}} = \sqrt{\frac{\sum_{i=1}^{n} (y_i - \hat{y}_i)^2}{n-p-1}}$$

### 3.2 决定系数（$R^2$）
$$R^2 = 1 - \frac{RSS}{TSS} = 1 - \frac{\sum_{i=1}^{n} (y_i - \hat{y}_i)^2}{\sum_{i=1}^{n} (y_i - \bar{y})^2}$$

其中：
- RSS：残差平方和
- TSS：总平方和
- $R^2$ 的范围是 [0,1]，越接近1表示模型解释力越强

### 3.3 调整后的 $R^2$
考虑模型复杂度的修正版本：

$$R^2_{adj} = 1 - \frac{RSS/(n-p-1)}{TSS/(n-1)}$$

## 4. 假设检验与推断

### 4.1 单个系数的t检验
假设检验：
$$H_0: \beta_j = 0 \text{ vs } H_1: \beta_j \neq 0$$

检验统计量：
$$t = \frac{\hat{\beta}_j}{SE(\hat{\beta}_j)}$$

### 4.2 F检验（整体显著性检验）
检验所有系数是否同时为0：
$$H_0: \beta_1 = \beta_2 = \cdots = \beta_p = 0$$

F统计量：
$$F = \frac{(TSS-RSS)/p}{RSS/(n-p-1)}$$

## 5. 多重共线性与诊断

### 5.1 多重共线性问题
多重共线性指预测变量之间存在高度相关性，可能导致：
- 参数估计不稳定
- 标准误显著增大
- 系数符号与预期相反

### 5.2 诊断工具

#### 5.2.1 方差膨胀因子 (VIF)
$$VIF_j = \frac{1}{1-R^2_j}$$

其中 $R^2_j$ 是用其他所有预测变量对 $X_j$ 进行回归的 $R^2$。

判断标准：
- VIF > 5 或 10：表示存在较严重的多重共线性
- VIF > 30：表示存在严重的多重共线性

#### 5.2.2 相关系数矩阵
检查预测变量间的相关性：
$$r_{jk} = \frac{\sum_{i=1}^n (x_{ij} - \bar{x}_j)(x_{ik} - \bar{x}_k)}{\sqrt{\sum_{i=1}^n (x_{ij} - \bar{x}_j)^2 \sum_{i=1}^n (x_{ik} - \bar{x}_k)^2}}$$

### 5.3 处理多重共线性的方法

1. **变量选择**：
   - 逐步回归（向前、向后、双向）
   - 剔除高度相关的变量

2. **正则化方法**：
   - 岭回归（Ridge）：
     $$\min_{\beta} \sum_{i=1}^n (y_i - \beta_0 - \sum_{j=1}^p \beta_j x_{ij})^2 + \lambda \sum_{j=1}^p \beta_j^2$$
   
   - Lasso：
     $$\min_{\beta} \sum_{i=1}^n (y_i - \beta_0 - \sum_{j=1}^p \beta_j x_{ij})^2 + \lambda \sum_{j=1}^p |\beta_j|$$

## 6. 模型诊断与改进

### 6.1 残差分析

1. **残差图**：检查以下假设
   - 线性关系
   - 方差齐性
   - 异常值

2. **Q-Q图**：检查正态性假设
   - 若点落在45度线附近，表明残差近似正态分布

### 6.2 异常值诊断

1. **杠杆值（Leverage）**：
   $$h_{ii} = \mathbf{x}_i^T(\mathbf{X}^T\mathbf{X})^{-1}\mathbf{x}_i$$

2. **库克距离（Cook's Distance）**：
   $$D_i = \frac{(\hat{y}_j - \hat{y}_{j(i)})^T(\hat{y}_j - \hat{y}_{j(i)})}{(p+1)\hat{\sigma}^2}$$

3. **DFBETAS**：衡量单个观测值对回归系数的影响

## 7. 模型选择

### 7.1 变量选择方法

1. **向前选择**：
   - 从空模型开始
   - 每次添加最显著的变量

2. **向后选择**：
   - 从全模型开始
   - 每次删除最不显著的变量

3. **逐步回归**：
   - 结合向前和向后选择
   - 每步都考虑添加或删除变量

### 7.2 选择标准

1. **AIC（赤池信息准则）**：
   $$AIC = 2k - 2\ln(L)$$

2. **BIC（贝叶斯信息准则）**：
   $$BIC = \ln(n)k - 2\ln(L)$$

其中：
- $k$ 是参数个数
- $L$ 是似然函数的最大值
- $n$ 是样本量

## 8. 总结

线性回归是统计学习中最基础且重要的方法之一，它：
1. 提供了清晰的数学框架
2. 易于解释和实现
3. 为更复杂的模型提供了基础
4. 在实践中仍然广泛应用

主要局限性：
1. 假设变量间存在线性关系
2. 对异常值敏感
3. 要求预测变量相互独立