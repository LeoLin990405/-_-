# **Scikit-Learn 聚类：极致详细学习笔记**

---

## **1. 什么是聚类？**

**聚类（Clustering）** 是**无监督学习（Unsupervised Learning）**中的一种任务。它的目标是将数据集中**相似的样本**聚集在同一簇（Cluster），而不同簇之间的样本差异较大。聚类没有预定义标签，是一种通过特征间的相似性或距离进行自动分类的任务。

---

### **1.1 聚类的应用场景**

- **客户分群**：根据消费行为将客户分组，用于个性化营销。  
- **图像处理**：进行像素分类，提高图像分割效果。  
- **文本分析**：将新闻或文档聚类为不同主题。  
- **生物信息学**：对基因进行聚类，识别相似基因群。

---

## **2. K 均值聚类（K-Means Clustering）**

### **2.1 K 均值算法的核心思想**

K 均值是一种**迭代优化算法**，将数据划分为 $K$ 个簇，目的是**最小化簇内平方误差（SSE）**。算法会反复调整质心位置，直到质心不再发生变化。

---

### **2.2 K 均值算法的数学表达**

1. **初始化质心**：从数据集中随机选择 $K$ 个样本作为初始质心 $\mu_1, \mu_2, \ldots, \mu_K$。

2. **分配簇标签**：对于每个样本 $x_i$，计算其与所有质心的距离，并将其分配到最近的质心所在簇：

   $$
   C_j = \{x_i \mid \|x_i - \mu_j\|^2 \leq \|x_i - \mu_k\|^2, \forall k\}
   $$

3. **更新质心**：对每个簇 $C_j$ 计算新的质心：

   $$
   \mu_j = \frac{1}{|C_j|} \sum_{x_i \in C_j} x_i
   $$

4. **迭代停止条件**：当质心不再变化或达到最大迭代次数时，停止迭代。

---

### **2.3 使用 Scikit-Learn 实现 K 均值聚类**

```python
from sklearn import datasets
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt
import numpy as np

# 加载鸢尾花数据集，并提取前两个特征
iris = datasets.load_iris()
X = iris.data[:, :2]

# 创建 KMeans 模型，设置簇数量为 3
kmeans = KMeans(n_clusters=3, random_state=42)
cluster_labels = kmeans.fit_predict(X)

# 获取质心位置
centroids = kmeans.cluster_centers_

# 可视化聚类结果
plt.scatter(X[:, 0], X[:, 1], c=cluster_labels, cmap='viridis', edgecolor='k')
plt.scatter(centroids[:, 0], centroids[:, 1], marker='x', s=100, linewidths=2, color='r')
plt.xlabel('花萼长度 (Sepal Length)')
plt.ylabel('花萼宽度 (Sepal Width)')
plt.title('K 均值聚类 (K=3)')
plt.show()
```

---

## **3. 高斯混合模型（Gaussian Mixture Model, GMM）**

### **3.1 GMM 的基本思想**

**GMM（Gaussian Mixture Model）** 假设数据集由多个**高斯分布**的混合组成。与 K 均值的硬分配不同，GMM 为每个样本计算其属于每个簇的**概率**，从而实现**软分配（Soft Clustering）**。

---

### **3.2 GMM 数学表达**

1. **GMM 模型的概率密度函数**：

   $$
   P(x) = \sum_{j=1}^{K} \pi_j \cdot \mathcal{N}(x \mid \mu_j, \Sigma_j)
   $$

   - $\pi_j$：第 $j$ 个簇的权重，满足 $\sum_{j=1}^{K} \pi_j = 1$  
   - $\mathcal{N}(x \mid \mu_j, \Sigma_j)$：均值为 $\mu_j$，协方差矩阵为 $\Sigma_j$ 的多元高斯分布。

2. **EM 算法**用于求解 GMM，包括以下步骤：
   - **E 步**：计算每个样本属于每个簇的后验概率。  
   - **M 步**：最大化似然函数，更新模型参数 $\pi_j, \mu_j, \Sigma_j$。

---

### **3.3 使用 Scikit-Learn 实现 GMM 聚类**

```python
from sklearn.mixture import GaussianMixture

# 创建 GMM 模型，设置簇数量为 3
gmm = GaussianMixture(n_components=3, covariance_type='full', random_state=42)
gmm.fit(X)

# 预测簇标签
cluster_labels = gmm.predict(X)

# 获取簇的均值（质心）
centroids = gmm.means_

# 可视化结果
plt.scatter(X[:, 0], X[:, 1], c=cluster_labels, cmap='viridis', edgecolor='k')
plt.scatter(centroids[:, 0], centroids[:, 1], marker='x', s=100, linewidths=2, color='r')
plt.xlabel('花萼长度 (Sepal Length)')
plt.ylabel('花萼宽度 (Sepal Width)')
plt.title('GMM 聚类')
plt.show()
```

---

## **4. 如何选择最佳簇的数量？**

选择适当的簇数量是聚类分析中的一个关键问题。常见的方法有：

### **4.1 肘部法（Elbow Method）**

1. 计算不同簇数 $K$ 下的**簇内平方误差和（SSE）**：

   $$
   SSE = \sum_{j=1}^{K} \sum_{x_i \in C_j} \|x_i - \mu_j\|^2
   $$

2. 绘制 SSE 随簇数变化的折线图，当曲线出现明显的拐点时，即为最佳簇数。

```python
sse = []
for k in range(1, 11):
    kmeans = KMeans(n_clusters=k, random_state=42)
    kmeans.fit(X)
    sse.append(kmeans.inertia_)

# 绘制肘部法图形
plt.plot(range(1, 11), sse, marker='o')
plt.xlabel('簇的数量')
plt.ylabel('簇内平方误差和 (SSE)')
plt.title('肘部法则')
plt.show()
```

---

### **4.2 轮廓系数（Silhouette Coefficient）**

轮廓系数衡量**簇内紧密性**和**簇间分离度**，其取值范围为 $[-1, 1]$。轮廓系数越接近 1，表示聚类效果越好：

$$
s = \frac{b - a}{\max(a, b)}
$$

- $a$：样本与同簇其他样本的平均距离  
- $b$：样本与最近簇内样本的平均距离

```python
from sklearn.metrics import silhouette_score

# 计算轮廓系数
sil_score = silhouette_score(X, cluster_labels)
print(f'轮廓系数: {sil_score:.2f}')
```

---

## **5. 聚类算法的优缺点比较**

| **算法**       | **优点**                           | **缺点**                               |
| -------------- | ---------------------------------- | -------------------------------------- |
| **K 均值聚类** | 简单高效，适用于大数据集           | 对初始质心敏感，易陷入局部最优         |
| **GMM 聚类**   | 能处理复杂形状的簇，并提供概率输出 | 计算复杂度高，需要选择适当的协方差类型 |

---

## **6. 总结与实践建议**

### **6.1 关键点总结**

1. **K 均值聚类**：适用于大规模数据，但只能发现球状簇，对初始质心敏感。  
2. **GMM 聚类**：适合复杂数据，能处理不同形状的簇，并提供概率输出。  
3. **肘部法和轮廓系数**：帮助选择最佳簇数。

### **6.2 实际应用建议**

- **K 均值聚类**：适合大规模数据，如客户分群和推荐系统。  
- **GMM 聚类**：适用于需要概率输出的场景，如基因分析。

