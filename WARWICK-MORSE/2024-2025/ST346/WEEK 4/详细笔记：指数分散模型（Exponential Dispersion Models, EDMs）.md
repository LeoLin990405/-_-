### **详细笔记：指数分散模型（Exponential Dispersion Models, EDMs）**

---

## **1. 引言与动机**

在统计学中，我们经常需要估计一组**独立同分布（i.i.d.）随机变量** $Y_1, Y_2, \dots, Y_n$ 的**均值** $\mu$。常见的两种估计方法如下：

1. **样本均值**：
   $$
   \bar{y} = \frac{1}{n} \sum_{i=1}^n y_i
   $$

2. **最大似然估计（MLE）**：
   最大似然估计通过**最大化对数似然函数** $ \sum_{i=1}^n \log(p(y_i | \mu)) $ 得到参数 $\mu$ 的估计值 $\hat{\mu}$。

#### **问题：MLE 和样本均值是否相同？**
- 对于一些分布，如**正态分布**和**Gamma 分布**，MLE $\hat{\mu}$ 与样本均值 $\bar{y}$ 相同。
- 但在其他分布中（如 t 分布），它们不一定相等。

#### **为什么需要 EDM？**
- **EDM 是一类特殊的分布**，它们保证了**样本均值 $\bar{y}$ 等于 MLE**，这使其在广义线性模型（GLM）中有广泛的应用。

---

## **2. EDM 的定义与公式**

### **2.1 EDM 的规范形式**
指数分散模型（EDM）的概率密度函数（pdf）或概率质量函数（pmf）可以写成以下**规范形式**：
$$
p(y | \theta, \phi) = a(y, \phi) \exp\left(\frac{\theta y - b(\theta)}{\phi}\right)
$$

#### **符号解释：**
- $ \theta $：**规范参数**（Canonical Parameter），控制分布的中心位置。
- $ \phi > 0 $：**分散参数**（Dispersion Parameter），控制数据的离散程度（类似于方差）。
- $ b(\theta) $：**累积量函数**（Cumulant Function），与分布的均值和方差相关。
- $ a(y, \phi) $：**归一化函数**（Normalizing Function），用于确保概率分布在其支持域上的积分为 1：
  $$
  \int_{y \in S} p(y | \theta, \phi) \, dy = 1
  $$

---

## **3. EDM 的均值和方差推导**

在 EDM 中，**累积量函数 $b(\theta)$ 的导数**用于描述分布的均值和方差：

1. **均值的推导：**
   $$
   \mu = E(Y) = b'(\theta)
   $$
   解释：$\mu$ 是累积量函数 $b(\theta)$ 对规范参数 $\theta$ 的**一阶导数**。

2. **方差的推导：**
   $$
   \text{Var}(Y) = \phi b''(\theta)
   $$
   解释：方差是累积量函数的**二阶导数**，并与分散参数 $\phi$ 成正比。

---

## **4. 常见 EDM 分布及推导**

### **4.1 正态分布 \(N(\mu, \sigma^2)\)**

- 正态分布的概率密度函数：
  $$
  p(y | \mu, \sigma^2) = \frac{1}{\sqrt{2\pi \sigma^2}} \exp\left(-\frac{(y - \mu)^2}{2\sigma^2}\right)
  $$

- 将其写成 EDM 的规范形式：
  $$
  p(y | \mu, \sigma^2) = \exp\left(-\frac{y^2 - 2\mu y + \mu^2}{2\sigma^2}\right) \cdot \frac{1}{\sqrt{2\pi \sigma^2}}
  $$

- 比较得到：
  $ \theta = \mu, \quad \phi = \sigma^2, \quad b(\theta) = \frac{\theta^2}{2} $

- **均值与方差**：
  $$
  E(Y) = b'(\theta) = \theta = \mu, \quad \text{Var}(Y) = \phi b''(\theta) = \sigma^2
  $$

- **规范链接函数**：恒等链接 $ \theta = \mu $。

---

### **4.2 泊松分布（Poisson Distribution）**

- 泊松分布的概率质量函数：
  $$
  p(y | \mu) = \frac{\mu^y e^{-\mu}}{y!}
  $$

- 写成 EDM 的规范形式：
  $$
  p(y | \mu) = \exp\left(y \log(\mu) - \mu - \log(y!)\right)
  $$

- 比较得到：
  $ \theta = \log(\mu), \quad \phi = 1, \quad b(\theta) = \exp(\theta) $

- **均值与方差**：
  $$
  E(Y) = b'(\theta) = \exp(\theta) = \mu, \quad \text{Var}(Y) = \phi b''(\theta) = \mu
  $$

- **规范链接函数**：对数链接 $ \theta = \log(\mu) $。

---

### **4.3 二项分布（Binomial Distribution）**

- 二项分布的概率质量函数：
  $$
  p(y | n, \mu) = \binom{n}{y} \mu^y (1 - \mu)^{n - y}
  $$

- 写成 EDM 的规范形式：
  $$
  p(y | \mu, n) = \exp\left(y \log\left(\frac{\mu}{1 - \mu}\right) + n \log(1 - \mu)\right)
  $$

- 比较得到：
  $ \theta = \log\left(\frac{\mu}{1 - \mu}\right), \quad \phi = 1, \quad b(\theta) = \log(1 + e^\theta) $

- **均值与方差**：
  $$
  E(Y) = b'(\theta) = \frac{e^\theta}{1 + e^\theta} = \mu, \quad \text{Var}(Y) = n \mu (1 - \mu)
  $$

- **规范链接函数**：logit 链接 $ \theta = \log\left(\frac{\mu}{1 - \mu}\right) $。

---

## **5. 偏差（Deviance）及其推导**

### **5.1 偏差的定义**
- 在 EDM 中，**偏差（Deviance）**用于衡量观测值与模型预测值之间的差异。
- **单位偏差（Unit Deviance）**定义为：
  $$
  d(y, \mu) = 2 \left( t(y, y) - t(y, \mu) \right)
  $$
  其中 $ t(y, \mu) = \theta y - b(\theta) $。

### **5.2 总偏差的计算**
- 如果 $ Y_1, \dots, Y_n $ 是独立的 EDM 观测值，具有均值 $ \mu_i $ 和权重 $ w_i $，则**总偏差（Total Deviance）**为：
  $$
  D(y, \mu) = \sum_{i=1}^n w_i d(y_i, \mu_i)
  $$

- **缩放偏差（Scaled Deviance）**：
  $$
  D^*(y, \mu) = \frac{D(y, \mu)}{\phi}
  $$

### **5.3 正态分布和泊松分布的单位偏差**
1. **正态分布**：
   $$
   d(y, \mu) = (y - \mu)^2
   $$

2. **泊松分布**：
   $$
   d(y, \mu) = 2 \left( y \log\left(\frac{y}{\mu}\right) - (y - \mu) \right)
   $$

---

## **6. 小结**

- **EDM 统一了多种常见的分布**（如正态、泊松、二项分布），并为**广义线性模型（GLM）**提供了理论支持。
- **规范链接函数**将**均值 $\mu$ 和规范参数 $\theta$** 关联起来，在模型参数估计中起到重要作用。
- **偏差**是衡量模型拟合优劣的重要指标，可以用于比较不同模型的性能。


