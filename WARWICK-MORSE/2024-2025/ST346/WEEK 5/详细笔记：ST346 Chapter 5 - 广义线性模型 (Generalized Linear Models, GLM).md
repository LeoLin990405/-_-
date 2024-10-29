### **详细笔记：ST346 Chapter 5 - 广义线性模型 (Generalized Linear Models, GLM)**

---

### **目录**  
1. **方差函数 (Variance Function)**  
   - 定义与基本公式  
   - 方差函数的推导与性质  
   - 正态分布的例子：公式推导  
2. **准似然 (Quasi-likelihood)**  
   - 定义与推导  
   - 准似然模型的应用与过度离散的处理  
   - 案例：Noisy miner 数据分析  
3. **伽马分布 (Gamma Distribution)**  
   - 密度函数与数学推导  
   - 方差函数与连接函数的计算  
   - 在 R 中实现伽马 GLM  
4. **逆高斯分布 (Inverse Gaussian Distribution)**  
   - 密度函数与方差的推导  
   - 布朗运动中的 hitting time 问题  
   - 在 R 中实现逆高斯 GLM  
5. **二项分布的泊松极限 (Poisson Limit of Binomial Distribution)**  
   - 理论推导与公式计算  
   - 应用场景分析  
6. **泊松与二项 GLM 的选择 (Choosing Between Poisson and Binomial GLM)**  
   - 模型选择指南与案例分析  

---

## **1. 方差函数 (Variance Function)**

### **1.1 定义与基本公式**
在广义线性模型 (GLM) 中，方差函数 $V(\mu)$ 用于描述响应变量 $Y$ 的**均值与方差的关系**。公式为：
$$
\text{Var}(Y | \mu, \phi) = \phi V(\mu)
$$
其中：  
- $\mu = E(Y)$ 是响应变量的**均值**。  
- $\phi$ 是**离散参数 (dispersion parameter)**，控制数据的变异程度。  
- $V(\mu)$ 是方差函数，表示方差如何随均值变化。

### **1.2 指数分布族的定义**
广义线性模型依赖于**指数分布族 (Exponential Dispersion Model, EDM)**。指数分布族的密度函数表示为：
$$
p(y | \theta, \phi) = \exp\left( \frac{y \theta - b(\theta)}{\phi} + c(y, \phi) \right)
$$
- $\theta$ 是**规范参数 (canonical parameter)**。  
- $b(\theta)$ 是累积量函数 (cumulant function)，控制均值和方差的关系。  
- $c(y, \phi)$ 是与 $y$ 和 $\phi$ 相关的常数项。

通过求 $b(\theta)$ 的一阶和二阶导数，我们可以得到响应变量的**均值和方差**：
$$[
E(Y) = b'(\theta), \quad \text{Var}(Y) = \phi b''(\theta)
$$]
- $b'(\theta)$ 是累积量函数 $b(\theta)$ 的一阶导数，对应于**均值** $\mu$。  
- $b''(\theta)$ 是累积量函数的二阶导数，对应于方差函数。

### **1.3 方差函数的推导**
规范参数 $\theta$ 和均值 $\mu$ 之间存在一一对应关系。我们将方差重写为：
$$
\text{Var}(Y | \mu, \phi) = \phi V(\mu)
$$
其中 $V(\mu) = b''(\theta)$ 是关于均值 $\mu$ 的函数。

### **1.4 例子：正态分布的方差函数完整推导**
对于正态分布 $Y \sim N(\mu, \sigma^2)$，其概率密度函数为：
$$
p(y | \mu, \sigma^2) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left( -\frac{(y - \mu)^2}{2\sigma^2} \right)
$$
将其重写为指数分布族的形式：
$$
p(y | \mu) = \exp\left( -\frac{y^2 - 2y\mu + \mu^2}{2\sigma^2} \right)
$$
对于正态分布，均值 $\mu$ 与规范参数 $\theta$ 相同，即 $\theta = \mu$，因此其方差函数为：
$$[
V(\mu) = 1
$$]
这说明正态分布的方差与均值无关。因此，正态 GLM 等价于经典的线性回归模型。

---

## **2. 准似然 (Quasi-likelihood)**

### **2.1 为什么需要准似然？**
在实际数据分析中，模型的方差可能大于理论预测值，这种现象称为**过度离散 (over-dispersion)**。例如：  
- 泊松分布假设 $\text{Var}(Y) = \mu$，但实际数据可能有 $\text{Var}(Y) > \mu$。  
- 二项分布假设 $\text{Var}(Y) = \mu(1 - \mu)$，但实际数据常常表现出更大的方差。

为了解决这种问题，我们引入了**准似然 (quasi-likelihood)**。准似然允许在没有严格的指数分布族的情况下，使用估计的方法进行统计推断。

### **2.2 准泊松与准二项模型**
- **准泊松模型**：允许离散参数 $\phi$ 为自由变量，方差函数为：
  $$
  \text{Var}(Y) = \phi \mu
  $$
- **准二项模型**：允许 $\phi$ 自由变化，方差函数为：
  $$
  \text{Var}(Y) = \phi \mu(1 - \mu)
  $$

### **2.3 案例分析：Noisy miner 数据中的过度离散**
- 在研究桉树密度对 noisy miner 鸟类数量的影响时，使用泊松模型发现 $\phi > 1$，即数据存在过度离散。  
- 通过使用**准泊松模型**进行分析，我们可以更好地捕捉数据的变异性。

---

## **3. 伽马分布 (Gamma Distribution)**

### **3.1 密度函数推导**
伽马分布 $Y \sim \Gamma(r, s)$ 常用于建模非负连续变量。其概率密度函数为：
$$
p(y | r, s) = \frac{e^{-ry} (ry)^{s-1}}{\Gamma(s)}, \quad y > 0
$$
其中：  
- $r > 0$ 是速率参数，$s > 0$ 是形状参数。

### **3.2 方差函数与连接函数**
伽马分布的方差函数为：
$$
V(\mu) = \mu^2
$$
伽马 GLM 的常用连接函数为对数链接：
$$
g(\mu) = \log(\mu)
$$

### **3.3 在 R 中实现伽马 GLM**
在 R 中，伽马 GLM 可以通过以下代码实现：
```R
glm(y ~ x, family = Gamma(link = "log"), data = mydata)
```

---

## **4. 逆高斯分布 (Inverse Gaussian Distribution)**

### **4.1 密度函数与方差函数**
逆高斯分布的密度函数为：
$$
p(y | \mu, \phi) = \sqrt{\frac{1}{2\pi \phi y^3}} \exp\left( -\frac{(y - \mu)^2}{2\phi \mu^2 y} \right)
$$
其方差函数为：
$$
V(\mu) = \mu^3
$$

### **4.2 布朗运动与 hitting time**
逆高斯分布在**布朗运动**中有重要应用。当布朗运动 $X_t$ 第一次达到某一水平时，所花的时间服从逆高斯分布。

---

## **5. 二项分布的泊松极限 (Poisson Limit of Binomial Distribution)**

### **5.1 理论推导**
设 $Y \sim \text{Binomial}(m, \mu)$ 且 $\mu = \lambda / m$。当 $m \to \infty$ 且 $\lambda$ 固定时，$Y$ 的分布趋于泊松分布：
$$
Y \sim \text{Poisson}(\lambda)
$$

---

## **6. 泊松与二项 GLM 的选择**

### **6.1 模型选择指南**
- **泊松 GLM**：用于建模事件发生的速率。  
- **二项 GLM**：用于建模比例或概率。

### **6.2 案例分析**
- **案例 1**：调查大学入学比例——使用二项 GLM。  
- **案例 2**：分析机器故障次数——使用泊松 GLM。

---

## **总结与思考**

本章详细介绍了广义线性模型中的方差函数、准似然模型及常见分布的应用。理解**均值与方差的关系**对于选择合适的 GLM 模型至关重要。