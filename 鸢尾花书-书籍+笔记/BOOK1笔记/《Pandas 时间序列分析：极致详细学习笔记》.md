# **《Pandas 时间序列分析：极致详细学习笔记》**

---

## **1. 什么是时间序列？**

**时间序列（Timeseries）** 是指按时间顺序排列的一组数据点。它描述了某个现象在不同时间上的变化，广泛应用于金融、经济、市场销售、气象等领域。时间序列分析的目的是识别趋势、季节性、周期性，并对未来进行预测。

---

## **2. Pandas 时间序列分析的核心概念**

1. **时间索引（DatetimeIndex）**：将日期或时间作为 DataFrame 的索引，方便进行切片和时间操作。
2. **频率（Frequency）**：描述数据点之间的时间间隔（如每日、每周、每月等）。
3. **重采样（Resampling）**：将时间序列数据转换为不同的时间频率（如按周、按月聚合）。
4. **移动平均与滑动窗口（Rolling Window）**：平滑数据，消除短期波动，分析趋势。
5. **自相关与相关性分析**：了解时间序列中变量之间的关系。
6. **缺失值处理**：填充或插值，确保数据完整性。

---

## **3. 准备工作：安装与导入必要的库**

确保你安装了 **Pandas** 和 **Plotly** 库：
```bash
pip install pandas plotly seaborn
```

### **3.1 导入库**
```python
import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
import seaborn as sns
```

---

## **4. 创建时间序列数据**

### **4.1 使用 `pd.date_range()` 创建时间索引**
```python
# 创建一个 10 天的时间范围
date_range = pd.date_range(start='2023-01-01', periods=10, freq='D')
print(date_range)
```

**结果：**
```
DatetimeIndex(['2023-01-01', '2023-01-02', ..., '2023-01-10'], dtype='datetime64[ns]', freq='D')
```

### **4.2 使用时间索引创建 DataFrame**
```python
# 创建时间序列 DataFrame
df = pd.DataFrame({'value': range(10)}, index=date_range)
print(df)
```

**结果：**
```
            value
2023-01-01      0
2023-01-02      1
2023-01-03      2
2023-01-04      3
2023-01-05      4
2023-01-06      5
...
```

---

## **5. 时间索引与数据切片**

### **5.1 按单个日期索引**
```python
# 获取 2023-01-03 的数据
print(df.loc['2023-01-03'])
```

**结果：**
```
value    2
Name: 2023-01-03, dtype: int64
```

### **5.2 日期范围切片**
```python
# 获取从 2023-01-02 到 2023-01-05 的数据
print(df['2023-01-02':'2023-01-05'])
```

**结果：**
```
            value
2023-01-02      1
2023-01-03      2
2023-01-04      3
2023-01-05      4
```

---

## **6. 重采样与频率转换**

### **6.1 重采样为月度数据**
```python
# 按月重采样，计算均值
df_resampled = df.resample('M').mean()
print(df_resampled)
```

**结果：**
```
            value
2023-01-31    4.5
```

### **6.2 使用前向填充法填充缺失值**
```python
# 使用前向填充处理重采样后的缺失值
df_filled = df.resample('D').ffill()
print(df_filled)
```

---

## **7. 移动平均与滑动窗口分析**

### **7.1 计算 3 天窗口的简单移动平均**
```python
# 添加 3 天滑动窗口的移动平均
df['MA3'] = df['value'].rolling(window=3).mean()
print(df)
```

**结果：**
```
            value   MA3
2023-01-01      0   NaN
2023-01-02      1   NaN
2023-01-03      2   1.0
2023-01-04      3   2.0
2023-01-05      4   3.0
```

### **7.2 绘制移动平均线**
```python
fig = px.line(df, y=['value', 'MA3'], title='3-Day Moving Average')
fig.show()
```

---

## **8. 缺失值处理**

### **8.1 检查缺失值**
```python
# 检查每列中的缺失值数量
print(df.isnull().sum())
```

### **8.2 使用插值法填充缺失值**
```python
# 使用线性插值填补缺失值
df_interpolated = df.interpolate(method='linear')
print(df_interpolated)
```

---

## **9. 计算每日收益率**

### **9.1 使用 `pct_change()` 计算每日收益率**
```python
df['daily_return'] = df['value'].pct_change() * 100
print(df)
```

### **9.2 绘制每日收益率趋势**
```python
fig = px.line(df, y='daily_return', title='Daily Return Trend')
fig.show()
```

---

## **10. 自相关与相关性分析**

### **10.1 计算自相关系数**
```python
# 计算滞后 1 天的自相关系数
autocorr = df['value'].autocorr(lag=1)
print(f'Lag-1 Autocorrelation: {autocorr}')
```

### **10.2 相关性矩阵与热力图**
```python
# 计算相关性矩阵
corr_matrix = df.corr()

# 绘制相关性矩阵热力图
fig = px.imshow(corr_matrix, text_auto=True, title='Correlation Matrix Heatmap')
fig.show()
```

---

## **11. 高级可视化：平行坐标图与树形图**

### **11.1 平行坐标图展示多变量关系**
```python
fig = px.parallel_coordinates(df, dimensions=['value', 'MA3', 'daily_return'],
                              color='value', title='Parallel Coordinates Plot')
fig.show()
```

### **11.2 使用树形图展示分类结构**
```python
fig = px.treemap(df, path=['value'], values='daily_return', 
                 title='Treemap Example')
fig.show()
```

---

## **12. 实战练习：完整时间序列分析流程**

1. **生成模拟销售数据**：创建一个 30 天的销售数据集。
2. **计算每日销售的变化率**：使用 `pct_change()` 计算变化率，并绘制趋势图。
3. **使用滑动窗口计算标准差**：分析销售波动性。
4. **按周重采样**：将数据按周重采样，并计算每周平均销售额。
5. **绘制热力图与平行坐标图**：探索变量之间的关系。

---

## **13. 总结**

在这份极致详细的笔记中，我们深入讲解了如何使用 **Pandas** 进行时间序列分析，并结合 **Plotly** 进行可视化。  
你掌握了以下核心技能：
- **时间索引与切片**：高效筛选时间段内的数据。
- **重采样与频率转换**：按不同时间频率聚合数据。
- **滑动窗口与移动平均**：平滑数据，揭示趋势。
- **缺失值处理与插值**：确保数据完整性。
- **收益率与自相关分析**：评估数据变化与相关性。

通过这些知识，你可以在金融、销售预测、市场分析等领域中灵活应用时间序列分析方法。不断练习这些操作，将帮助你成为时间序列分析的高手！