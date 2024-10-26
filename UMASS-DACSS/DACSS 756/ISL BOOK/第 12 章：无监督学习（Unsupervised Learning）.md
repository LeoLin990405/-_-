# 第 12 章：无监督学习（Unsupervised Learning）

## 12.1 无监督学习的挑战

### 12.1.1 什么是无监督学习？
- **无监督学习**指在没有响应变量 Y 的情况下，使用一组特征 $X_1, X_2, \dots, X_p$ 探索数据的内在结构。
- **目标**：识别数据中的模式或子群体，进行可视化或降维，而不是预测特定的结果。

### 12.1.2 为什么无监督学习具有挑战性？
- **主观性强**：没有明确的目标（如预测），分析结果的解读往往依赖于经验和判断。
- **验证困难**：缺乏类似于监督学习中的交叉验证机制来评估结果的好坏，因为**真值**未知。

## 12.2 主成分分析（Principal Component Analysis, PCA）

### 12.2.1 主成分的数学定义
第m个主成分是特征的线性组合：

$$Z_{im} = \phi_{1m}X_{i1} + \phi_{2m}X_{i2} + \cdots + \phi_{pm}X_{ip}$$

约束条件：

$$\sum_{j=1}^p \phi_{jm}^2 = 1$$

### 12.2.2 第一主成分的优化问题

$$\text{maximize}_{\phi_{11},\dots,\phi_{p1}} \{\frac{1}{n}\sum_{i=1}^n(\sum_{j=1}^p \phi_{j1}x_{ij})^2\}$$

$$\text{subject to } \sum_{j=1}^p \phi_{j1}^2 = 1$$

### 12.2.3 方差解释比例（PVE）

$$PVE_m = \frac{\sum_{i=1}^n z_{im}^2}{\sum_{j=1}^p \sum_{i=1}^n x_{ij}^2}$$

### 12.2.4 总方差解释比例
前M个主成分的累积方差解释比例：

$$\text{Cumulative PVE}(M) = \sum_{m=1}^M PVE_m$$

## 12.3 聚类分析

### 12.3.1 K-means聚类
目标函数：

$$\text{minimize}_{C_1,\dots,C_K} \sum_{k=1}^K \sum_{i \in C_k} \|x_i - \mu_k\|^2$$

其中：
- $C_k$ 是第k个簇
- $\mu_k$ 是第k个簇的质心
- $\|x_i - \mu_k\|^2$ 是欧氏距离平方

### 12.3.2 层次聚类
两个簇间的距离度量：

1. **单连接**：
   $$d(C_r, C_s) = \min_{i \in C_r, j \in C_s} d(x_i, x_j)$$

2. **完全连接**：
   $$d(C_r, C_s) = \max_{i \in C_r, j \in C_s} d(x_i, x_j)$$

3. **平均连接**：
   $$d(C_r, C_s) = \frac{1}{|C_r||C_s|}\sum_{i \in C_r}\sum_{j \in C_s} d(x_i, x_j)$$

## 12.4 高维数据的降维

### 12.4.1 t-SNE（t-distributed Stochastic Neighbor Embedding）
相似度计算：

$$p_{j|i} = \frac{\exp(-\|x_i-x_j\|^2/2\sigma_i^2)}{\sum_{k \neq i}\exp(-\|x_i-x_k\|^2/2\sigma_i^2)}$$

低维空间相似度：

$$q_{ij} = \frac{(1 + \|y_i-y_j\|^2)^{-1}}{\sum_{k \neq l}(1 + \|y_k-y_l\|^2)^{-1}}$$

### 12.4.2 UMAP（Uniform Manifold Approximation and Projection）
局部距离：

$$\rho_i = \min\{\|x_i-x_j\| : j \in N_i\}$$

局部连接的概率：

$$p_{ij} = \exp(-\frac{\|x_i-x_j\|-\rho_i}{\sigma_i})$$

## 12.5 模型评估

### 12.5.1 轮廓系数（Silhouette Coefficient）

$$s(i) = \frac{b(i) - a(i)}{\max\{a(i), b(i)\}}$$

其中：
- $a(i)$ 是样本i与同簇其他样本的平均距离
- $b(i)$ 是样本i与最近邻簇中样本的平均距离

## 12.6 模型选择与评估方法

### 12.6.1 聚类个数的选择

1. **肘部法则（Elbow Method）**：
总平方和误差（Total Within-cluster Sum of Squares）：

$$WSS = \sum_{k=1}^K \sum_{i \in C_k} \|x_i - \mu_k\|^2$$

2. **间隙统计量（Gap Statistic）**：

$$Gap_n(k) = E_n^*[\log(W_k)] - \log(W_k)$$

其中 $W_k$ 是类内离散度：

$$W_k = \sum_{r=1}^k \frac{1}{2n_r} \sum_{i,j \in C_r} d_{ij}$$

### 12.6.2 稳定性评估
Bootstrap方法评估聚类稳定性：

$$Stability(k) = \frac{1}{B}\sum_{b=1}^B \text{sim}(C^{(b)}, C^*)$$

## 12.7 降维方法的扩展

### 12.7.1 稀疏主成分分析
带L1正则化的优化目标：

$$\text{maximize}_{\phi} \{\phi^T\Sigma\phi - \lambda\|\phi\|_1\}$$

$$\text{subject to } \|\phi\|_2 = 1$$

### 12.7.2 核主成分分析
核函数映射：

$$K(x_i, x_j) = \langle\Phi(x_i), \Phi(x_j)\rangle$$

主成分计算：

$$a_k = \text{argmax}_{a^T Ka = 1} a^TKKa$$

## 12.8 高维数据的聚类

### 12.8.1 子空间聚类
目标函数：

$$\min_{U,V,\{S_l\}} \sum_{l=1}^k \sum_{j \in C_l} \|x_j - U_lV_l^Tx_j\|^2$$

其中：
- $U_l$ 是子空间基向量
- $V_l$ 是投影矩阵
- $C_l$ 是第l个簇

### 12.8.2 谱聚类
相似度矩阵：

$$W_{ij} = \exp(-\frac{\|x_i - x_j\|^2}{2\sigma^2})$$

拉普拉斯矩阵：

$$L = D - W$$

其中 $D$ 是度矩阵：$D_{ii} = \sum_j W_{ij}$

## 12.9 混合模型

### 12.9.1 高斯混合模型
概率密度函数：

$$p(x) = \sum_{k=1}^K \pi_k \mathcal{N}(x|\mu_k, \Sigma_k)$$

对数似然：

$$\ell(\theta) = \sum_{i=1}^n \log \sum_{k=1}^K \pi_k \mathcal{N}(x_i|\mu_k, \Sigma_k)$$

### 12.9.2 EM算法
E步：计算后验概率

$$\gamma_{ik} = \frac{\pi_k \mathcal{N}(x_i|\mu_k, \Sigma_k)}{\sum_{j=1}^K \pi_j \mathcal{N}(x_i|\mu_j, \Sigma_j)}$$

M步：更新参数

$$\mu_k^{new} = \frac{\sum_{i=1}^n \gamma_{ik} x_i}{\sum_{i=1}^n \gamma_{ik}}$$

$$\Sigma_k^{new} = \frac{\sum_{i=1}^n \gamma_{ik} (x_i-\mu_k^{new})(x_i-\mu_k^{new})^T}{\sum_{i=1}^n \gamma_{ik}}$$

$$\pi_k^{new} = \frac{1}{n}\sum_{i=1}^n \gamma_{ik}$$

## 12.10 总结与应用

### 12.10.1 方法比较
| 方法     | 优点         | 局限性       | 适用场景   |
| -------- | ------------ | ------------ | ---------- |
| PCA      | 简单直观     | 线性假设     | 数据降维   |
| K-means  | 高效         | 需要预设K    | 球形簇     |
| 层次聚类 | 不需预设K    | 计算复杂度高 | 探索性分析 |
| t-SNE    | 保持局部结构 | 计算慢       | 可视化     |

### 12.10.2 实践建议
1. 数据预处理的重要性
2. 特征选择与降维的结合
3. 多种方法的综合使用
4. 结果验证与解释

### 12.10.3 应用领域
1. 基因表达分析
2. 客户细分
3. 图像处理
4. 文本挖掘
5. 社交网络分析