## **《Python 数据可视化超详细学习笔记》**

---

## **1. 什么是数据可视化？**

### **1.1 数据可视化的定义**
- **数据可视化**是将数据转换为图形或图表，以直观方式展示和传达信息的过程。
- 通过数据可视化，我们可以：
  - 发现数据中的**模式和趋势**。
  - **比较数据集**之间的关系。
  - 快速发现数据中的异常值和重要点。
  - 更有效地与他人分享分析结果。

---

## **2. 常用的 Python 数据可视化库**

1. **Matplotlib**：
   - 基础绘图库，提供灵活的静态图形绘制。
2. **Seaborn**：
   - 基于 Matplotlib，适用于统计数据的可视化。
3. **Plotly**：
   - 支持交互式图表，适合 Web 应用和仪表板。
4. **Pandas**：
   - 数据分析库，自带简单的可视化接口。
5. **Altair**：
   - 基于 Vega-Lite 的声明式可视化工具。

---

## **3. Matplotlib 基础：创建静态图表**

### **3.1 导入库并创建图形对象**
```python
import matplotlib.pyplot as plt
import numpy as np

# 创建数据
x = np.linspace(0, 10, 100)
y = np.sin(x)

# 创建图形和子图
fig, ax = plt.subplots()

# 绘制曲线
ax.plot(x, y)

# 显示图形
plt.show()
```

---

### **3.2 Matplotlib 图形的基本构成**

- **Figure**：整个图形区域，包含一个或多个子图（axes）。
- **Axes**：子图对象，是真正绘制图形的区域。
- **Axis**：坐标轴，展示数据范围和刻度。
- **Legend**：图例，用于标识数据系列。
- **Title**：图表的标题。

---

### **3.3 设置标题、标签与图例**
```python
fig, ax = plt.subplots()

# 绘制多条曲线
ax.plot(x, np.sin(x), label='Sine')
ax.plot(x, np.cos(x), label='Cosine')

# 添加标题和标签
ax.set_title('Sine and Cosine Functions')
ax.set_xlabel('x')
ax.set_ylabel('f(x)')

# 添加图例
ax.legend()

# 显示图表
plt.show()
```

---

## **4. 图表类型与绘制方法**

### **4.1 折线图（Line Plot）**
- **`plot()`** 用于绘制连续数据的折线图。
```python
x = np.linspace(0, 10, 50)
y = np.sin(x)

plt.plot(x, y)
plt.title("Line Plot Example")
plt.show()
```

---

### **4.2 散点图（Scatter Plot）**
- **`scatter()`** 用于展示点状数据的分布。
```python
x = np.random.rand(50)
y = np.random.rand(50)

plt.scatter(x, y, color='r', marker='o')
plt.title("Scatter Plot Example")
plt.show()
```

---

### **4.3 柱状图（Bar Chart）**
- **`bar()`** 和 **`barh()`** 用于绘制垂直和水平柱状图。
```python
categories = ['A', 'B', 'C', 'D']
values = [3, 7, 5, 9]

plt.bar(categories, values, color='b')
plt.title("Bar Chart Example")
plt.show()
```

---

### **4.4 饼图（Pie Chart）**
- **`pie()`** 用于展示各部分占比。
```python
labels = ['A', 'B', 'C', 'D']
sizes = [15, 30, 45, 10]

plt.pie(sizes, labels=labels, autopct='%1.1f%%')
plt.title("Pie Chart Example")
plt.show()
```

---

## **5. 图表美化与高级设置**

### **5.1 调整颜色与线型**
```python
plt.plot(x, y, color='green', linestyle='--', linewidth=2)
plt.show()
```

- **`color`**：设置颜色（如 `'r'` 表示红色）。
- **`linestyle`**：设置线型（如 `'--'` 表示虚线）。
- **`linewidth`**：设置线宽。

---

### **5.2 设置刻度与标签**
```python
fig, ax = plt.subplots()
ax.plot(x, y)

# 设置刻度
ax.set_xticks([0, np.pi, 2 * np.pi])
ax.set_xticklabels(['0', 'π', '2π'])

plt.show()
```

---

### **5.3 添加网格线**
```python
fig, ax = plt.subplots()
ax.plot(x, y)

# 添加网格
ax.grid(True, linestyle='--', alpha=0.7)

plt.show()
```

---

## **6. 子图与布局**

### **6.1 创建多子图**
- 使用 **`plt.subplots()`** 创建多个子图。
```python
fig, (ax1, ax2) = plt.subplots(1, 2, figsize=(10, 4))

ax1.plot(x, np.sin(x))
ax1.set_title("Sine")

ax2.plot(x, np.cos(x))
ax2.set_title("Cosine")

plt.tight_layout()
plt.show()
```

---

### **6.2 共享坐标轴的子图**
```python
fig, (ax1, ax2) = plt.subplots(2, 1, sharex=True)

ax1.plot(x, np.sin(x))
ax2.plot(x, np.cos(x))

plt.show()
```

---

## **7. 使用 Seaborn 创建统计图表**

### **7.1 导入 Seaborn**
```python
import seaborn as sns
import pandas as pd

# 加载示例数据集
df = sns.load_dataset('tips')

# 绘制散点图
sns.scatterplot(data=df, x='total_bill', y='tip', hue='day')
plt.show()
```

---

### **7.2 箱线图（Box Plot）**
- **箱线图**展示数据的分布、四分位数和异常值。
```python
sns.boxplot(data=df, x='day', y='total_bill')
plt.show()
```

---

## **8. 使用 Plotly 创建交互式图表**

### **8.1 绘制交互式线图**
```python
import plotly.express as px

fig = px.line(x=x, y=np.sin(x), title='Interactive Sine Wave')
fig.show()
```

---

### **8.2 使用 Pandas 数据帧创建交互图表**
```python
df = pd.DataFrame({'x': x, 'Sine': np.sin(x), 'Cosine': np.cos(x)})

fig = px.line(df, x='x', y=['Sine', 'Cosine'])
fig.show()
```

---

## **9. 图表保存与导出**

### **9.1 保存为 PNG、SVG、PDF 等格式**
```python
plt.savefig('plot.png', dpi=300, format='png')
plt.savefig('plot.svg', format='svg')
```

- **`dpi`**：设置分辨率（每英寸点数）。
- **`format`**：指定文件格式。

---

## **10. 综合练习：绘制多种图表**

1. **绘制一组正弦曲线和余弦曲线的子图。**
2. **使用 Seaborn 绘制数据集的箱线图和分布图。**
3. **使用 Plotly 创建交互式柱状图，展示不同国家的 GDP。**

---

## **11. 学习总结**

- 掌握 **Matplotlib** 和 **Seaborn** 能满足大部分静态图表的需求。
- **Plotly** 提供了强大的交互式图表能力，适用于 Web 展示。
- 探索更多高级功能，如 **动画图表**、**3D 图表**，将进一步提升数据展示的能力。

---

通过这份超详细学习笔记，你已经掌握了 Python 数据可视化的基本知识和高级技巧。继续实践，将这些知识应用于数据分析和报告展示，你的可视化技能将不断提升！