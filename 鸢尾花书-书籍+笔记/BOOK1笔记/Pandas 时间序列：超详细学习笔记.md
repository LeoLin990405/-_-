# **Pandas 时间序列：超详细学习笔记**

---

## **1. 什么是时间序列数据？**

**时间序列（Time Series）** 是一系列按时间顺序排列的数据点，每个数据点都与特定时间关联。时间序列的主要目的是分析**趋势、周期性、季节性**及其他变化，并进行预测。  

### **常见时间序列应用：**
- **金融市场**：股票价格、汇率、利率等
- **经济指标**：GDP、通胀率
- **气象数据**：温度、降雨量
- **销售分析**：月度或季度销售额趋势

---

## **2. Pandas 时间序列基础**

### **2.1 创建时间索引**

使用 `pandas.date_range()` 生成一段时间范围：
```python
import pandas as pd

# 创建从2023-01-01开始的10天时间范围
date_range = pd.date_range(start='2023-01-01', periods=10, freq='D')
print(date_range)
```

**结果：**
```
DatetimeIndex(['2023-01-01', '2023-01-02', ..., '2023-01-10'], dtype='datetime64[ns]', freq='D')
```

- **`start`**：指定起始日期  
- **`periods`**：生成的日期数量  
- **`freq`**：时间频率，`D` 代表天频率（可选项：`H` 小时、`M` 月、`Y` 年）

---

### **2.2 创建时间序列 DataFrame**

```python
df = pd.DataFrame({'value': range(10)}, index=date_range)
print(df)
```

**结果：**
```
            value
2023-01-01      0
2023-01-02      1
2023-01-03      2
...
2023-01-10      9
```

---

## **3. 时间索引与数据切片**

### **3.1 单个日期索引**
```python
# 获取某个日期的数据
print(df.loc['2023-01-03'])
```
**结果：**
```
value    2
Name: 2023-01-03, dtype: int64
```

### **3.2 日期范围切片**
```python
# 获取2023-01-02到2023-01-05之间的数据
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

## **4. 时间序列重采样**

### **4.1 将数据按月重采样**
```python
# 重采样为月频率，并计算均值
df_resampled = df.resample('M').mean()
print(df_resampled)
```
**结果：**
```
            value
2023-01-31    4.5
```

### **4.2 重采样后的前向填充**
```python
# 重采样并使用前向填充填补缺失值
df_filled = df.resample('D').ffill()
print(df_filled)
```

---

## **5. 移动平均与滑动窗口计算**

### **5.1 计算简单移动平均**
```python
# 计算3天窗口的简单移动平均
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
...
```

---

### **5.2 绘制移动平均线**
```python
import plotly.express as px

fig = px.line(df, y=['value', 'MA3'], title='3-Day Moving Average')
fig.show()
```

---

## **6. 计算每日收益率**

### **6.1 使用 `pct_change()` 计算每日收益率**
```python
df['daily_return'] = df['value'].pct_change() * 100
print(df)
```

**结果：**
```
            value   MA3  daily_return
2023-01-01      0   NaN           NaN
2023-01-02      1   NaN           inf
2023-01-03      2   1.0         100.0
...
```

### **6.2 绘制收益率趋势**
```python
fig = px.line(df, y='daily_return', title='Daily Return Trend')
fig.show()
```

---

## **7. 缺失值处理**

### **7.1 检查缺失值**
```python
print(df.isnull().sum())
```

### **7.2 删除缺失值**
```python
df_cleaned = df.dropna()
print(df_cleaned)
```

### **7.3 使用插值填充缺失值**
```python
df_interpolated = df.interpolate(method='linear')
print(df_interpolated)
```

---

## **8. 时间序列的相关性分析**

### **8.1 计算自相关系数**
```python
autocorr = df['value'].autocorr(lag=1)
print(f'Lag-1 Autocorrelation: {autocorr}')
```

### **8.2 移动相关性计算**
```python
df['corr'] = df['value'].rolling(window=5).corr(df['MA3'])
print(df)
```

---

## **9. 可视化缺失值与相关性**

### **9.1 使用 Seaborn 绘制缺失值热图**
```python
import seaborn as sns
import matplotlib.pyplot as plt

sns.heatmap(df.isnull(), cmap='YlGnBu', cbar=False)
plt.title('Missing Values Heatmap')
plt.show()
```

### **9.2 绘制相关性矩阵热力图**
```python
corr_matrix = df.corr()

fig = px.imshow(corr_matrix, text_auto=True, title='Correlation Matrix')
fig.show()
```

---

## **10. 滚动标准差分析**

### **10.1 计算滚动标准差**
```python
df['rolling_std'] = df['value'].rolling(window=3).std()
print(df)
```

### **10.2 绘制滚动标准差趋势**
```python
fig = px.line(df, y='rolling_std', title='Rolling Standard Deviation')
fig.show()
```

---

## **11. 实战练习：完整时间序列分析流程**

1. **生成30天的模拟数据**：创建模拟销售数据，并按天记录。
2. **计算每日变化率**：使用 `pct_change()` 计算销售的每日变化。
3. **按周重采样**：将数据按周重采样，并计算周均值。
4. **计算7天窗口的移动平均**：分析趋势变化。
5. **绘制趋势图与滚动标准差图**：可视化销售波动。

---

## **12. 总结**

- **Pandas 时间序列分析工具**支持灵活的数据处理、重采样、滑动窗口计算与自相关分析。
- **Plotly** 提供了强大的可视化支持，使分析结果更加直观。
- 掌握时间序列分析的基础技能，可以应用于金融、销售、气象等领域，预测未来趋势。

通过这份超详细笔记，你将能够在项目中自如运用 Pandas 时间序列分析，实现高效数据处理与预测！