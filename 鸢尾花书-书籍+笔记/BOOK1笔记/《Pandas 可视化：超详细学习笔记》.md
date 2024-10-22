## **《Pandas 可视化：超详细学习笔记》**

---

## **1. Pandas 可视化概述**

### **1.1 什么是 Pandas 可视化？**
- **Pandas** 是一个数据分析库，虽然它主要用于数据处理，但也集成了**Matplotlib**，可以方便地进行数据可视化。
- 使用 **`DataFrame.plot()`** 系列方法，Pandas 可以绘制各种常见的图表，包括**线图、柱状图、散点图、直方图、箱型图、KDE 曲线**等。

---

## **2. 基础设置**

### **2.1 导入库与数据**
```python
import pandas as pd
import matplotlib.pyplot as plt

# 创建数据集示例
df = pd.DataFrame({
    'A': [3, 4, 7, 6],
    'B': [1, 2, 5, 8],
    'C': [2, 3, 6, 9]
}, index=['Q1', 'Q2', 'Q3', 'Q4'])
```

- **Matplotlib** 用于控制 Pandas 图表的样式和显示。

### **2.2 基本绘图方法**
- **`DataFrame.plot()`** 可以自动选择图表类型，并绘制所有列的曲线：
```python
df.plot()
plt.show()
```

---

## **3. 线图**

### **3.1 基础线图**
```python
df.plot(kind='line', xlabel='Quarter', ylabel='Value', title='Quarterly Data', marker='o')
plt.show()
```

- **解释**：
  - `kind='line'`：设置图表为线图（默认类型）。
  - `marker='o'`：标记每个数据点的位置。

### **3.2 多条线图**
```python
df.plot.line(subplots=True, layout=(2, 2), sharex=True, sharey=True, legend=True)
plt.show()
```
- **解释**：
  - `subplots=True`：每列绘制在一个独立的子图中。
  - `layout=(2, 2)`：将子图布局为 2 行 2 列。

---

## **4. 面积图**

### **4.1 绘制堆积面积图**
```python
df.plot.area(stacked=True, alpha=0.5)
plt.show()
```

- **解释**：
  - **堆积面积图**展示各数据的累积效果，`alpha=0.5` 设置透明度。

---

## **5. 柱状图**

### **5.1 垂直柱状图**
```python
df.plot(kind='bar', ylabel='Value', title='Bar Chart Example')
plt.show()
```

### **5.2 水平柱状图**
```python
df.plot(kind='barh', title='Horizontal Bar Chart Example')
plt.show()
```

---

## **6. 直方图**

### **6.1 基础直方图**
```python
df.plot(kind='hist', bins=5, alpha=0.7)
plt.show()
```
- **解释**：
  - `bins=5`：将数据分为 5 个区间。
  - `alpha=0.7`：设置透明度。

---

## **7. 散点图**

### **7.1 基础散点图**
```python
df.plot.scatter(x='A', y='B', color='red', marker='x')
plt.show()
```

- **解释**：
  - `x='A', y='B'`：指定要展示的列。
  - `color='red'`：设置点的颜色。

---

## **8. 六边形图**

### **8.1 绘制六边形图（Hexbin）**
```python
df.plot.hexbin(x='A', y='B', gridsize=15, cmap='Blues')
plt.show()
```
- **解释**：
  - **六边形图**适用于数据密集区域的展示，`gridsize` 控制六边形的大小。

---

## **9. KDE 曲线（核密度估计）**

### **9.1 绘制 KDE 曲线**
```python
df.plot.kde()
plt.show()
```
- **解释**：
  - KDE 曲线用于展示数据的概率密度。

---

## **10. 箱型图**

### **10.1 绘制箱型图**
```python
df.plot.box()
plt.show()
```

- **解释**：
  - **箱型图**展示数据的四分位数和离群值，用于检测数据的分布。

---

## **11. 图表美化与布局调整**

### **11.1 自定义图表标题与标签**
```python
fig, ax = plt.subplots()
df.plot(ax=ax, title='Customized Plot', xlabel='X Label', ylabel='Y Label')
plt.show()
```

---

## **12. 多变量可视化：成对特征矩阵**

### **12.1 使用 scatter_matrix()**
```python
from pandas.plotting import scatter_matrix

scatter_matrix(df, alpha=0.2, figsize=(6, 6), diagonal='kde')
plt.show()
```
- **解释**：
  - `diagonal='kde'`：在对角线上绘制 KDE 曲线。
  - **成对特征矩阵**展示多列数据的两两关系。

---

## **13. 图表保存**

### **13.1 保存为 PNG 或 SVG 文件**
```python
df.plot()
plt.savefig('plot_example.png', dpi=300)
plt.savefig('plot_example.svg')
```

---

## **14. 综合练习**

1. **创建一个包含 3 个产品季度销售数据的 DataFrame**，绘制柱状图展示它们的销售情况。
2. **使用散点图展示两列数据之间的关系**，并尝试添加不同颜色的标记。
3. **绘制 KDE 曲线和直方图的叠加图**，观察数据的分布情况。

---

## **15. 总结**

- **Pandas 可视化**为数据分析提供了简洁且强大的绘图接口，特别适合**初步数据探索**。
- **通过与 Matplotlib 集成**，可以实现复杂的定制化图表。
- 如果需要更高级的可视化效果，可以结合 **Seaborn** 或 **Plotly**。

---

这份详细的 Pandas 可视化笔记涵盖了所有常见的图表类型及其代码示例。你可以根据分析需求灵活选择图表类型，快速绘制出所需的图形展示数据趋势和关系。