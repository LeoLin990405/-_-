---

# 第4章 分类 (Classification)——超详细解析与代码复现

---

## 4.3 逻辑回归（Logistic Regression）

### 4.3.1 **逻辑回归的概率模型**

逻辑回归用于解决**二分类问题**。假设响应变量 $Y \in \{0, 1\}$，即 $Y$ 表示两个类别（如：违约与不违约）。逻辑回归的目标是计算给定特征向量 $X$ 时，$Y = 1$ 的**概率**：

$$
p(Y = 1 \mid X) = \frac{e^{\beta_0 + \beta_1 X}}{1 + e^{\beta_0 + \beta_1 X}}
$$

#### **公式解读**
- **指数项**：$e^{\beta_0 + \beta_1 X}$ 将线性模型的输出转换为正数，避免概率为负。
- **Sigmoid函数**：将模型输出映射到 $(0, 1)$ 范围内，符合概率的定义。

当 $X$ 增大时，$e^{\beta_0 + \beta_1 X}$ 也会增加，因此违约概率 $p(Y = 1 \mid X)$ 会趋近于 1；反之，当 $X$ 变小时，违约概率趋向于 0。

---

### 4.3.2 **对数几率 (Logit) 转换**

为了将非线性的 Sigmoid 函数转化为线性形式，我们对概率 $p(X)$ 进行**logit转换**：

$$
\text{logit}(p(X)) = \log \left( \frac{p(X)}{1 - p(X)} \right) = \beta_0 + \beta_1 X
$$

#### **公式解读**
- **对数几率（log odds）**：$\log \left( \frac{p(X)}{1 - p(X)} \right)$ 表示发生和不发生事件的相对可能性。
  - 当 $p(X) = 0.5$ 时，对数几率为 0，即事件发生和不发生的概率相等。
  - 当 $p(X) > 0.5$ 时，对数几率为正，表示事件更有可能发生。
  - 当 $p(X) < 0.5$ 时，对数几率为负，表示事件不太可能发生。

#### **优点**：
- **线性模型**：logit转换使得逻辑回归的参数 $\beta_0, \beta_1$ 可以像线性回归中的参数一样，用常规方法估计。

---

### 4.3.3 **最大似然估计（MLE）**

在逻辑回归中，我们使用**最大似然估计**（MLE）来确定参数 $\beta_0$ 和 $\beta_1$，以使模型预测的概率尽可能符合实际数据。

给定 $n$ 个观测 $(x_i, y_i)$，其中 $y_i \in \{0, 1\}$，似然函数定义如下：

$$
\ell(\beta_0, \beta_1) = \prod_{i=1}^n p(x_i)^{y_i} (1 - p(x_i))^{1 - y_i}
$$

#### **公式推导**
- 当 $y_i = 1$ 时，似然函数中的 $p(x_i)$ 部分会被保留，表示希望该样本的预测概率接近 1。
- 当 $y_i = 0$ 时，似然函数中的 $(1 - p(x_i))$ 部分会被保留，表示希望模型能预测为 0。

为了简化优化，我们取似然函数的对数，得到**对数似然函数**：

$$
\log \ell(\beta_0, \beta_1) = \sum_{i=1}^n \left[ y_i \log p(x_i) + (1 - y_i) \log (1 - p(x_i)) \right]
$$

通过**梯度下降法**或其他优化算法，我们可以找到使对数似然最大化的参数 $\hat{\beta}_0$ 和 $\hat{\beta}_1$。

---

## 4.4 线性判别分析 (LDA) 详细推导

### 4.4.1 **LDA模型的基本假设**

- 假设在每个类别 $k$ 中，特征 $X$ 服从**多元正态分布**：
  
$$
X \mid Y = k \sim N(\mu_k, \Sigma)
$$

- $\mu_k$：类别 $k$ 的均值向量。  
- $\Sigma$：所有类别共享的协方差矩阵。

---

### 4.4.2 **LDA判别函数的推导**

我们的目标是找到最大化后验概率 $P(Y = k \mid X)$ 的类别 $k$。根据贝叶斯定理：

$$
P(Y = k \mid X) \propto \pi_k f_k(X)
$$

其中 $\pi_k$ 是类别 $k$ 的先验概率，$f_k(X)$ 是类别 $k$ 的条件密度。

根据多元正态分布的概率密度函数：

$$
f_k(X) = \frac{1}{(2\pi)^{p/2} |\Sigma|^{1/2}} \exp \left( -\frac{1}{2} (X - \mu_k)^T \Sigma^{-1} (X - \mu_k) \right)
$$

将其代入贝叶斯定理，并取对数，我们得到**LDA判别函数**：

$$
\delta_k(X) = X^T \Sigma^{-1} \mu_k - \frac{1}{2} \mu_k^T \Sigma^{-1} \mu_k + \log(\pi_k)
$$

#### **公式解读**
- **线性结构**：$\delta_k(X)$ 是 $X$ 的线性函数，因此 LDA 的决策边界是**线性边界**。
- **分类规则**：对于每个观测 $X$，我们选择使 $\delta_k(X)$ 最大的类别 $k$。

---

## 4.5 二次判别分析 (QDA) 详细推导

### 4.5.1 **QDA的基本假设**

与 LDA 的区别在于，QDA 假设**每个类别有不同的协方差矩阵** $\Sigma_k$。因此，类别 $k$ 中数据的概率密度为：

$$
f_k(X) = \frac{1}{(2\pi)^{p/2} |\Sigma_k|^{1/2}} \exp \left( -\frac{1}{2} (X - \mu_k)^T \Sigma_k^{-1} (X - \mu_k) \right)
$$

---

### 4.5.2 **QDA判别函数**

取对数并整理，我们得到**QDA判别函数**：

$$
\delta_k(X) = -\frac{1}{2} (X - \mu_k)^T \Sigma_k^{-1} (X - \mu_k) - \frac{1}{2} \log |\Sigma_k| + \log(\pi_k)
$$

#### **公式解读**
- **二次结构**：由于包含二次项 $(X - \mu_k)^T \Sigma_k^{-1} (X - \mu_k)$，QDA 的决策边界是**二次曲面**。

---

## 4.6 LDA 与 QDA 的比较

| **模型** | **假设**             | **决策边界** | **适用场景**   |
| -------- | -------------------- | ------------ | -------------- |
| LDA      | 各类别协方差矩阵相同 | 线性         | 数据线性可分时 |
| QDA      | 各类别协方差矩阵不同 | 二次曲面     | 数据非线性时   |

---

## 4.7 Python 代码复现 LDA 和 QDA

### 4.7.1 LDA 实现

```python
from sklearn.discriminant_analysis import LinearDiscriminantAnalysis as LDA

lda = LDA()
lda.fit(X, y)
y_pred_lda = lda.predict(X)

print("LDA 混淆矩阵：")
print(confusion_matrix(y, y_pred_lda))
```

### 4.7.2 QDA 实现

```python
from sklearn.discriminant_analysis import QuadraticDiscriminantAnalysis as QDA

qda = QDA()
qda.fit(X, y)
y_pred_qda = qda.predict(X)

print("QDA 混淆矩阵：")
print(confusion_matrix(y, y_pred_qda))
```

---

## 总结



通过以上详细解析和公式推导，我们深入理解了**逻辑回归、LDA 和 QDA**的数学原理及其适用场景：
1. **逻辑回归**：适用于解释二分类问题的概率。
2. **LDA**：适合线性数据和协方差相同的情况。
3. **QDA**：适用于非线性数据，但需要更多样本估计协方差矩阵。

如果你还有其他问题或需要更深入的推导，请告诉我！