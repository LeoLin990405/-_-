### **ST346 第3章：泊松回归模型 (Poisson Regression Models) 详解与公式推导**  

---

## **3.1 矩 (Moments) 与累积量 (Cumulants)**  

### 3.1.1 矩的定义与推导  
- **矩 (Moment)** 是描述分布形状的统计量，用于衡量数据的集中趋势、离散程度及非对称性。随机变量 \(Y\) 的第 \(r\) 阶矩定义为：  
  $m_r = E(Y^r)$

- **一阶矩 (Mean)**：
  $m_1 = E(Y)$  
  表示随机变量的均值，是数据的中心位置。

- **二阶矩与方差 (Variance)**：
  方差衡量数据相对于均值的离散程度，其定义为：
  $$\text{Var}(Y) = E\left((Y - E(Y))^2\right) = E(Y^2) - (E(Y))^2 = m_2 - m_1^2$$

#### **矩生成函数 (Moment Generating Function, MGF)** 推导  
矩生成函数 \(M(t)\) 的定义为：  
$$M(t) = E\left[\exp(tY)\right]$$  
利用泰勒展开公式，我们可以将指数函数展开为：  
$$\exp(tY) = \sum_{r=0}^{\infty} \frac{(tY)^r}{r!}$$  
将此代入 \(M(t)\) 的定义：  
$$M(t) = E\left[\sum_{r=0}^{\infty} \frac{(tY)^r}{r!}\right] = \sum_{r=0}^{\infty} \frac{t^r E(Y^r)}{r!} = \sum_{r=0}^{\infty} \frac{t^r m_r}{r!}$$  
由此可见，矩生成函数是一个幂级数，其系数为各阶矩。

- 在 \(t = 0\) 处，  
  $M(0) = E[\exp(0)] = E[1] = 1$

- **矩与导数的关系**：  
  $m_r = \frac{d^r M(t)}{dt^r} \Big|_{t=0}$  
  通过对 \(M(t)\) 在 \(t = 0\) 处求导，可以得到各阶矩。

---

### 3.1.2 累积量 (Cumulants) 与累积量生成函数  
- **累积量生成函数 (Cumulant Generating Function, CGF)** 是矩生成函数的对数：  
  $K(t) = \log M(t)$  

- **第 \(r\) 阶累积量**的计算公式：  
  $ \kappa_r = \frac{d^r K(t)}{dt^r} \Big|_{t=0}$

#### **前几阶累积量与矩的关系**  
- **一阶累积量**：均值  
  $ \kappa_1 = m_1 = E(Y)$

- **二阶累积量**：方差  
  $ \kappa_2 = m_2 - m_1^2 = \text{Var}(Y)$

- **三阶累积量**：用于衡量**偏度 (Skewness)**：  
  $\text{Skewness} = \frac{\kappa_3}{\kappa_2^{3/2}}$

#### **累积量的可加性**  
若$ (Y_1, Y_2, \dots, Y_n)$ 是相互独立的随机变量，则它们的和 $(S = \sum_{i=1}^n Y_i)$ 的累积量为：  
$ K_S(t) = \sum_{i=1}^n K_{Y_i}(t)$

---

## **3.2 泊松分布 (Poisson Distribution)**  

### 3.2.1 泊松分布的定义与性质  
- **泊松分布**描述**单位时间或空间内事件发生次数**，其**概率质量函数 (PMF)** 为：  
  $$P(Y = r) = \frac{\mu^r}{r!} \exp(-\mu), \quad r = 0, 1, 2, \dots$$  
  其中，$(\mu)$ 是均值，也是事件的平均发生次数。

#### **泊松分布的性质**  
- **均值与方差**：  
  $E(Y) = \text{Var}(Y) = \mu$  
  这表明泊松分布的均值和方差相等。

- **泊松分布的渐近性质**：当 \(\mu\) 较大时，泊松分布趋近于正态分布。

---

### 3.2.2 矩生成函数与累积量生成函数的推导  
1. **矩生成函数 (MGF)**：  
   $$M(t) = \exp\left(\mu \left(\exp(t) - 1\right)\right)$$  
   **推导过程**：  
   根据泊松分布的定义，我们有：  
   $$E[\exp(tY)] = \sum_{r=0}^{\infty} \exp(tr) \frac{\mu^r}{r!} \exp(-\mu)$$  
   将其重写为：  
   $$\exp(-\mu) \sum_{r=0}^{\infty} \frac{(\mu \exp(t))^r}{r!} = \exp(-\mu) \cdot \exp(\mu \exp(t))$$  
   最终得到：  
   $$M(t) = \exp\left(\mu \left(\exp(t) - 1\right)\right)$$

2. **累积量生成函数 (CGF)**：  
   $K(t) = \log M(t) = \mu \left(\exp(t) - 1\right)$

3. **均值与方差的推导**：  
   - **均值**：  
     $E(Y) = K'(0) = \mu$  
   - **方差**：  
     $\text{Var}(Y) = K''(0) = \mu$

---

## **3.3 泊松回归模型 (Poisson Regression Models)**  

### 3.3.1 泊松回归模型的数学形式  
泊松回归模型用于分析**计数数据**与预测变量之间的关系。其模型形式为：  
$\log(\mu_i) = \mathbf{x}_i^T \boldsymbol{\beta}$  
其中：  
- $(\mu_i = E(Y_i)) $表示响应变量的期望值。
- $(\mathbf{x}_i) $是包含预测变量的向量。
- $(\boldsymbol{\beta}) $是待估参数。

#### **连接函数的作用**  
对数连接函数的作用是确保预测的期望值为正数：  
$\mu_i = \exp(\mathbf{x}_i^T \boldsymbol{\beta})$

---

## **3.4 泊松回归模型用于比率 (Rates)**  

### 3.4.1 偏置项 (Offset) 的引入  
当观测窗口（如时间或空间区域）不同时，需要通过引入**偏置项**进行标准化：  
$\log(\mu_i) = \mathbf{x}_i^T \boldsymbol{\beta} + \log(C_i)$  
其中 \($C_i$) 是观测窗口的大小。

---

## **3.5 案例分析：船舶数据 (Ships Data)**  

### **数据说明与R代码实现**  
- **数据集**：`ships` 数据来自 R 包 `MASS`，记录了不同类型船舶的事故次数与服务时间。

- **代码实现**：
  ```r
  library(MASS)
  data(ships)
  ships <- subset(ships, service > 0)
  glm.out <- glm(incidents ~ offset(log(service)), 
                 family = poisson(link = "log"), data = ships)
  ```

- **模型输出**：
  ```r
  round(exp(coef(glm.out)), 5)
  # 输出: 0.00218
  ```
  表明每个月的事故发生率为 0.00218。

---

## **总结与思考**  
- 泊松回归模型是一种用于**计数数据**的常用工具，广泛应用于医疗、交通等领域。
- 如果数据出现**超泊松现象**（即方差大于均值），可以考虑使用**负二项回归**模型进行替代。

