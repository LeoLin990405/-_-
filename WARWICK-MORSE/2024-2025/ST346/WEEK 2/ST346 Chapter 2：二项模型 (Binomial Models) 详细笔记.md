# **ST346 Chapter 2：二项模型 (Binomial Models) 详细笔记**

---

## **目录**  
1. **伯努利分布 (Bernoulli Distribution)**  
2. **潜在线性模型 (Latent Linear Model)**  
3. **二项分布及二项结果 (Binomial Outcomes)**  
4. **缩放二项分布 (Scaled Binomial Distribution)**  
5. **R 实现 (Implementation in R)**  
6. **逻辑回归 (Logistic Regression)**  
7. **容忍分布及链接函数 (Tolerance Distributions)**  

---

## **2.1 伯努利分布 (Bernoulli Distribution)**

### **定义与性质**  
**伯努利分布**用于描述**单次试验只有两个可能结果**的情况。例如：
- 硬币的正面/反面；
- 答题正确/错误；
- 产品是否被购买。

设随机变量 $Y \in \{0, 1\}$，则：
- $Y = 1$：事件成功；
- $Y = 0$：事件失败。

**概率定义**：
$$
P(Y = 1) = \mu, \quad P(Y = 0) = 1 - \mu
$$
- 其中 $\mu = E(Y)$ 表示事件 $Y = 1$ 的发生概率。

**概率质量函数 (PMF)**：
$$
p(y) = \mu^y (1 - \mu)^{1 - y}, \quad y \in \{0, 1\}
$$
- 当 $y = 1$ 时，$p(1) = \mu$；当 $y = 0$ 时，$p(0) = 1 - \mu$。

### **期望与方差推导**  
- **期望**：
  $E(Y)$ 的计算如下：
  $$
  E(Y) = \sum_{y \in \{0, 1\}} y \cdot p(y) = 0 \cdot (1 - \mu) + 1 \cdot \mu = \mu
  $$

- **方差**：
  $$
  \text{Var}(Y) = E(Y^2) - E(Y)^2
  $$
  - 由于 $Y \in \{0, 1\}$，所以 $Y^2 = Y$。因此：
    $$
    E(Y^2) = E(Y) = \mu
    $$
  - 方差为：
    $$
    \text{Var}(Y) = \mu - \mu^2 = \mu(1 - \mu)
    $$

**异方差性 (Heteroscedasticity)**：  
伯努利分布的方差依赖于均值 $\mu$。当 $\mu$ 靠近 0 或 1 时，方差接近 0；当 $\mu = 0.5$ 时，方差达到最大值 0.25。这种方差随均值变化的现象称为**异方差性**。

---

## **2.2 潜在线性模型 (Latent Linear Model)**

### **定义与基本思想**  
潜在线性模型通过引入**潜在变量** $Z$ 来解释观测值 $Y$。假设：
- $Z_i \sim N(x_i^T \beta, 1)$，即 $Z_i$ 服从均值为 $x_i^T \beta$、方差为 1 的正态分布；
- $Z_i$ 的值决定了 $Y_i$ 的状态：
  $$
  Y_i =
  \begin{cases}
  1 & \text{若 } Z_i \geq 0 \\
  0 & \text{若 } Z_i < 0
  \end{cases}
  $$

### **概率计算**  
我们希望计算事件 $Y_i = 1$ 的概率：
$$
\mu_i = P(Y_i = 1) = P(Z_i \geq 0)
$$
由于 $Z_i \sim N(x_i^T \beta, 1)$，我们可以对其标准化：
$$
\mu_i = P\left(\frac{Z_i - x_i^T \beta}{1} \geq \frac{0 - x_i^T \beta}{1}\right)
= P(N(0, 1) \geq -x_i^T \beta) = P(N(0, 1) \leq x_i^T \beta)
$$
- 使用标准正态分布的累积分布函数 (CDF) $\Phi$ 表示：
  $$
  \mu_i = \Phi(x_i^T \beta)
  $$

### **线性预测量与链接函数**  
- 定义**线性预测量**：
  $$
  \eta_i = x_i^T \beta
  $$
  - $\eta_i$ 是自变量的线性组合，是模型中的预测值。

- **均值函数**：将线性预测量 $\eta_i$ 映射为概率 $\mu_i$：
  $$
  \mu_i = \Phi(\eta_i)
  $$
- **链接函数 (Link Function)**：将概率 $\mu_i$ 反映射为线性预测量 $\eta_i$：
  $$
  \eta_i = \Phi^{-1}(\mu_i)
  $$
  - 此链接函数称为 **probit 链接函数**。

---

## **2.3 二项分布及二项结果 (Binomial Outcomes)**

### **定义**  
二项分布描述**多次独立重复的伯努利试验的总成功次数**。  
- 若 $Z_1, Z_2, \dots, Z_m \sim \text{Bernoulli}(\mu)$，则：
  $$
  Y = \sum_{i=1}^m Z_i \sim \text{Binomial}(m, \mu)
  $$
  - 其中 $Y$ 表示 $m$ 次试验中的成功次数。

### **概率质量函数 (PMF)**  
$$
p(y) = \binom{m}{y} \mu^y (1 - \mu)^{m - y}, \quad y \in \{0, 1, \dots, m\}
$$
- 其中 $\binom{m}{y}$ 是组合数，表示从 $m$ 次实验中选出 $y$ 次成功的方式数：
  $$
  \binom{m}{y} = \frac{m!}{y! (m - y)!}
  $$

### **期望与方差**  
- **期望**：
  $$
  E(Y) = m \mu
  $$
- **方差**：
  $$
  \text{Var}(Y) = m \mu (1 - \mu)
  $$

---

## **2.4 缩放二项分布 (Scaled Binomial Distribution)**  

在广义线性模型 (GLM) 中，我们常使用缩放二项分布。  
定义比例响应变量：
$$
Y^* = \frac{1}{m} \sum_{i=1}^m Z_i
$$
- **均值**：  
  $$
  E(Y^*) = \mu
  $$
- **方差**：
  $$
  \text{Var}(Y^*) = \frac{1}{m} \mu (1 - \mu)
  $$
  这种处理允许我们使用比例 $Y^* = Y/m$ 作为响应变量，并将样本量 $m$ 作为权重。

---

## **2.5 在 R 中的实现 (Implementation in R)**

以下是在 R 中使用 `glm()` 函数拟合二项 GLM 模型的示例代码：

```R
# 加载数据并拟合模型
glm.out <- glm(Fissures/Turbines ~ Hours, weights = Turbines,
               family = binomial(link = "probit"), data = turbines)

# 查看模型摘要
summary(glm.out)
```

---

## **2.6 逻辑回归 (Logistic Regression)**

### **逻辑函数 (Logistic Function)**  
逻辑回归使用以下均值函数将预测值映射为概率：
$$
h(\eta) = \frac{e^\eta}{1 + e^\eta} = \frac{1}{1 + e^{-\eta}}
$$
- 该函数单调递增，并在 $\eta \to -\infty$ 时趋近于 0，在 $\eta \to \infty$ 时趋近于 1。

### **逻辑链接函数 (Logit Link Function)**  
逻辑链接函数是均值函数的逆函数：
$$
g(\mu) = \log\left(\frac{\mu}{1 - \mu}\right)
$$
- 它将概率 $\mu$ 转换为对数优势比 (log odds)。

---

## **2.7 容忍分布及链接函数 (Tolerance Distributions)**

### **常见容忍分布及链接函数**  

| **分布类型**      | **概率密度函数 (PDF)**                            | **均值函数 (Mean Function)**                                | **链接函数 (Link Function)**                  | **R 中的链接名称** |
| ----------------- | ------------------------------------------------- | ----------------------------------------------------------- | --------------------------------------------- | ------------------ |
| **正态分布**      | $f(x) = \frac{1}{\sqrt{2\pi}} e^{-\frac{x^2}{2}}$ | $\mu = \Phi(\eta)$                                          | $\eta = \Phi^{-1}(\mu)$                       | `"probit"`         |
| **Logistic 分布** | $f(x) = \frac{e^x}{(1 + e^x)^2}$                  | $\mu = \frac{e^\eta}{1 + e^\eta} = \frac{1}{1 + e^{-\eta}}$ | $\eta = \log\left(\frac{\mu}{1 - \mu}\right)$ | `"logit"`          |
| **Gumbel 分布**   | $f(x) = e^{-x - e^{-x}}$                          | $\mu = 1 - e^{-e^\eta}$                                     | $\eta = \log(-\log(1 - \mu))$                 | `"cloglog"`        |
| **Cauchy 分布**   | $f(x) = \frac{1}{\pi (1 + x^2)}$                  | $\mu = \frac{1}{\pi} \arctan(\eta) + \frac{1}{2}$           | $\eta = \tan(\pi (\mu - 0.5))$                | `"cauchit"`        |

---

### **解释与应用**  

1. **正态分布 (Probit 回归)**  
   - 使用标准正态分布的累积分布函数 $\Phi$ 作为均值函数。  
   - 适用于模型中误差服从正态分布的情况。  

2. **Logistic 分布 (Logistic 回归)**  
   - 均值函数为逻辑函数，描述概率 $\mu$ 如何随着线性预测量 $\eta$ 变化。  
   - 常用于分类问题和风险分析，解释为**对数优势比 (log odds)**。

3. **Gumbel 分布 (Complementary Log-Log 回归)**  
   - 常用于建模极端事件或生存分析中的时间数据。  
   - 当感兴趣的事件发生概率较小时，`"cloglog"` 链接函数尤为有用。  

4. **Cauchy 分布 (Cauchit 回归)**  
   - 由于 Cauchy 分布的重尾特性，该模型对离群值不敏感。  
   - 适用于异常值较多的数据分析。  

---

## **总结**  
本章介绍了伯努利和二项分布的数学推导及其在广义线性模型中的应用。通过潜在变量模型和不同链接函数，我们可以灵活处理二元响应数据。逻辑回归和 probit 回归是实际应用中的常用工具，而不同容忍分布的选择使模型更加适应不同场景的数据分析需求。