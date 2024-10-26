# 第10章：深度学习（Deep Learning）

## 10.1 简单神经网络

### 10.1.1 基本结构
单层神经网络的数学表达：

$$f(X) = \beta_0 + \sum_{k=1}^K \beta_k g\left(w_{k0} + \sum_{j=1}^p w_{kj} X_j\right)$$

其中：
- $w_{kj}$ 是权重
- $g(\cdot)$ 是激活函数
- $K$ 是隐藏单元数
- $p$ 是输入特征数

### 10.1.2 激活函数

1. **Sigmoid**：
   $$g(z) = \frac{1}{1 + e^{-z}}$$

2. **ReLU**：
   $$g(z) = \max(0, z)$$

3. **Tanh**：
   $$g(z) = \frac{e^z - e^{-z}}{e^z + e^{-z}}$$

### 10.1.3 损失函数

1. **均方误差(MSE)**：
   $$MSE = \frac{1}{n}\sum_{i=1}^n (y_i - \hat{y}_i)^2$$

2. **交叉熵损失**：
   $$L = -\sum_{i=1}^n \sum_{k=1}^K y_{ik}\log(\hat{y}_{ik})$$

## 10.2 多层神经网络

### 10.2.1 前向传播
第$l$层的输出：

$$a^{(l)} = g(W^{(l)}a^{(l-1)} + b^{(l)})$$

其中：
- $a^{(l)}$ 是第$l$层的激活值
- $W^{(l)}$ 是权重矩阵
- $b^{(l)}$ 是偏置向量

### 10.2.2 反向传播
损失函数关于权重的梯度：

$$\frac{\partial L}{\partial W^{(l)}} = \delta^{(l)}(a^{(l-1)})^T$$

其中 $\delta^{(l)}$ 是第$l$层的误差项

## 10.3 卷积神经网络（CNNs）

### 10.3.1 卷积操作

卷积层的输出计算：

$$h_{i,j} = g\left(\sum_{m=0}^{f_h-1}\sum_{n=0}^{f_w-1} w_{m,n}x_{i+m,j+n} + b\right)$$

其中：
- $(f_h, f_w)$ 是卷积核大小
- $w_{m,n}$ 是卷积核权重
- $b$ 是偏置项

### 10.3.2 池化操作

最大池化：

$$p_{i,j} = \max_{0\leq m<s, 0\leq n<s} x_{i\cdot s+m,j\cdot s+n}$$

其中 $s$ 是池化窗口大小

## 10.4 循环神经网络（RNNs）

### 10.4.1 基本RNN

时间步$t$的隐藏状态：

$$h_t = g(W_{hh}h_{t-1} + W_{xh}x_t + b_h)$$

输出计算：

$$y_t = W_{hy}h_t + b_y$$

### 10.4.2 LSTM结构

遗忘门：

$$f_t = \sigma(W_f[h_{t-1}, x_t] + b_f)$$

输入门：

$$i_t = \sigma(W_i[h_{t-1}, x_t] + b_i)$$

输出门：

$$o_t = \sigma(W_o[h_{t-1}, x_t] + b_o)$$

单元状态更新：

$$c_t = f_t \odot c_{t-1} + i_t \odot \tanh(W_c[h_{t-1}, x_t] + b_c)$$

## 10.5 深度学习优化与正则化

### 10.5.1 优化器

#### 1. SGD with Momentum：

$$\begin{aligned}
v_t &= \gamma v_{t-1} + \eta\nabla_\theta J(\theta) \\
\theta &= \theta - v_t
\end{aligned}$$

#### 2. Adam优化器：

$$\begin{aligned}
m_t &= \beta_1 m_{t-1} + (1-\beta_1)\nabla_\theta J(\theta) \\
v_t &= \beta_2 v_{t-1} + (1-\beta_2)(\nabla_\theta J(\theta))^2
\end{aligned}$$

### 10.5.2 正则化

#### 1. L2正则化：

$$L_{reg} = L + \lambda\sum_w w^2$$

#### 2. Dropout
训练时随机丢弃概率：

$$P(h_i = 0) = p$$

## 10.6 模型训练与评估

### 10.6.1 批量归一化
对每个mini-batch计算：

$$\begin{aligned}
\mu_B &= \frac{1}{m}\sum_{i=1}^m x_i \\
\sigma_B^2 &= \frac{1}{m}\sum_{i=1}^m (x_i - \mu_B)^2 \\
\hat{x}_i &= \frac{x_i - \mu_B}{\sqrt{\sigma_B^2 + \epsilon}}
\end{aligned}$$

### 10.6.2 早停法
验证集损失函数：

$$L_{val}(t) = \frac{1}{n_{val}}\sum_{i=1}^{n_{val}}L(y_i, f(x_i; \theta_t))$$

## 10.7 实践考虑

### 10.7.1 超参数选择
- 学习率
- 批量大小
- 网络深度与宽度
- 正则化参数

### 10.7.2 模型评估指标

1. 分类任务：
   $$Accuracy = \frac{TP + TN}{TP + TN + FP + FN}$$

2. 回归任务：
   $$R^2 = 1 - \frac{\sum_i(y_i - \hat{y}_i)^2}{\sum_i(y_i - \bar{y})^2}$$

## 10.8 总结

### 优势
1. 强大的特征学习能力
2. 适应复杂非线性关系
3. 端到端学习

### 局限性
1. 需要大量数据
2. 计算资源要求高
3. 模型可解释性差

### 应用场景
1. 图像识别
2. 自然语言处理
3. 语音识别
4. 推荐系统

这个版本的笔记包含了深度学习的核心概念、数学推导和实践考虑，保持了公式的正确性和清晰的结构。