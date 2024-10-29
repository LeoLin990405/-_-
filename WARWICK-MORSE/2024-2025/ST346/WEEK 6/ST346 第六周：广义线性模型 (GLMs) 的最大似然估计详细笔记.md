## **ST346 第六周：广义线性模型 (GLMs) 的最大似然估计详细笔记**

---

### **目录**
1. **最大似然估计 (MLE) 回顾**  
   1.1 似然函数与对数似然的推导  
   1.2 评分函数与 Fisher 信息矩阵的推导  
   1.3 最大似然估计量的性质  

2. **广义线性模型 (GLM) 的最大似然估计**  
   2.1 GLM 的定义与结构  
   2.2 GLM 的对数似然函数推导  
   2.3 GLM 的评分方程与 Fisher 信息矩阵  

3. **GLM 的数值求解方法**  
   3.1 Newton-Raphson 迭代算法  
   3.2 Fisher Scoring 方法  
   3.3 迭代加权最小二乘法 (IWLS) 算法  

4. **离散参数 \($\phi$) 的估计**  
   4.1 Pearson 残差和离散参数的估计  

5. **总结与练习**

---

## **1. 最大似然估计 (MLE) 回顾**

### **1.1 似然函数与对数似然的推导**
**最大似然估计 (MLE)** 旨在通过给定的数据找到一组参数，使得这些参数下数据出现的概率最大。  
假设我们观察到 \($n$) 个独立随机变量 \($Y_1, Y_2, \ldots, Y_n$)，其联合分布的**似然函数**为：
$$
L(\beta) = \prod_{i=1}^{n} p_i(y_i \mid \beta)
$$

其中 \($p_i(y_i \mid \beta)$) 是第 \(i\) 个观测值的概率密度函数 (pdf) 或概率质量函数 (pmf)。

为简化计算，我们取对数，得到**对数似然函数**：

$$
l(\beta \mid y) = \log L(\beta) = \sum_{i=1}^{n} \log p_i(y_i \mid \beta)
$$

对数似然函数使得乘积运算转化为求和运算，更易于处理。

---

### **1.2 评分函数与 Fisher 信息矩阵的推导**
1. **评分函数 (Score Function)** 是对数似然函数关于参数 \($\beta$) 的一阶导数：

$$
U(\beta) = \frac{\partial l(\beta \mid y)}{\partial \beta} = \sum_{i=1}^{n} \frac{\partial \log p_i(y_i \mid \beta)}{\partial \beta}
$$

MLE 的解 \($\hat{\beta}$) 满足评分方程：

$$
U(\hat{\beta}) = 0
$$

2. **Fisher 信息矩阵**用于度量参数估计的精度。它是评分函数的方差：

$$
I(\beta) = E \left[ \left( \frac{\partial l(\beta \mid Y)}{\partial \beta} \right) \left( \frac{\partial l(\beta \mid Y)}{\partial \beta} \right)^T \right]
$$

Fisher 信息矩阵也可以通过对数似然函数的二阶导数计算：

$$
I(\beta) = -E \left[ \frac{\partial^2 l(\beta \mid Y)}{\partial \beta \partial \beta^T} \right]
$$

---

### **1.3 最大似然估计量的性质**
1. **一致性**：当样本量 \($n \to \infty$) 时，最大似然估计量 \($\hat{\beta}$) 收敛于真实参数 \($\beta$)：

$$
\hat{\beta} \xrightarrow{p} \beta
$$

2. **渐进正态性**：当样本量足够大时，MLE 近似服从正态分布：

$$
\hat{\beta} \sim N(\beta, I(\beta)^{-1})
$$

3. **渐进有效性**：在大样本条件下，MLE 是无偏估计中方差最小的估计量。

---

## **2. 广义线性模型 (GLM) 的最大似然估计**

### **2.1 GLM 的定义与结构**
**广义线性模型 (GLM)** 是经典线性回归的推广，适用于非正态分布的数据。它包括以下部分：

1. **随机部分**：响应变量 \($Y_i$) 来自**指数分布族 (Exponential Family)**，其概率密度函数为：

$$
p(y_i \mid \theta_i, \phi) = a(y_i, \phi) \exp \left( \frac{y_i \theta_i - b(\theta_i)}{\phi} \right)
$$

其中 \($\theta_i$\) 是正则参数，\($\phi$) 是离散参数。

2. **系统部分**：预测变量 \($x_i$) 与线性预测器 \($x_i^T \beta$) 相关。

3. **连接函数**：将响应变量的期望值 \(\mu_i\) 与线性预测器连接：

$$
g(\mu_i) = x_i^T \beta
$$

---

### **2.2 GLM 的对数似然函数推导**
GLM 的对数似然函数形式为：

$$
l(\beta, \phi) = \sum_{i=1}^{n} \left( \frac{w_i (y_i \theta_i - b(\theta_i))}{\phi} + \log a(y_i, \frac{\phi}{w_i}) \right)
$$

---

### **2.3 GLM 的评分方程与 Fisher 信息矩阵**
1. **评分函数**的表达式为：

$$
U(\beta) = \sum_{i=1}^{n} \frac{w_i (y_i - \mu_i)}{\phi} \frac{\partial \theta_i}{\partial \beta}
$$

对于正则连接函数 \(g(\mu_i) = \theta_i\)，有：

$$
U(\beta) = \sum_{i=1}^{n} \frac{w_i (y_i - \mu_i)}{\phi} x_i
$$

2. **Fisher 信息矩阵**：

$$
I(\beta) = \sum_{i=1}^{n} \frac{w_i V(\mu_i)}{\phi} x_i x_i^T
$$

其中 \(V(\mu_i)\) 是方差函数。

---

## **3. GLM 的数值求解方法**

### **3.1 Newton-Raphson 迭代算法**
使用泰勒展开近似评分方程：

$$
\beta^{(k+1)} = \beta^{(k)} + \left[ J(\beta^{(k)}) \right]^{-1} U(\beta^{(k)})
$$

其中 \($J(\beta^{(k)})$) 是观测信息矩阵。

---

### **3.2 Fisher Scoring 方法**
Fisher Scoring 是 Newton-Raphson 方法的特例，将观测信息矩阵 \($J(\beta)$) 替换为 Fisher 信息矩阵 \(I(\beta)\)：

$$
\beta^{(k+1)} = \beta^{(k)} + I(\beta^{(k)})^{-1} U(\beta^{(k)})
$$

---

### **3.3 迭代加权最小二乘法 (IWLS)**  
1. 初始化参数 \($\beta^{(0)}$)。  
2. 更新工作变量：

$$
Z_i = g'(\mu_i) (y_i - \mu_i) + x_i^T \beta^{(k)}
$$

3. 更新参数：

$$
\beta^{(k+1)} = (X^T W X)^{-1} X^T W Z
$$

4. 重复迭代，直到收敛。

---

## **4. 离散参数 \(\phi\) 的估计**

### **4.1 Pearson 残差和离散参数的估计**
1. **Pearson 残差**：

$$
r_i^{(p)} = \sqrt{\frac{w_i}{V(\mu_i)}} (y_i - \mu_i)
$$

2. **离散参数的估计**：

$$
\hat{\phi} = \frac{1}{n - p} \sum_{i=1}^{n} \left( r_i^{(p)} \right)^2
$$

---

## **5. 总结与练习**
本章详细介绍了 GLM 的数学基础和数值求解方法。通过 Newton-Raphson、Fisher Scoring 和 IWLS 算法，可以有效地求解模型参数，并基于 Pearson 残差估计离散参数 \($\phi$)。