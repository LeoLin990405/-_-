# **《Plotly 统计可视化：超详细学习笔记》**

---

## **1. 引言：Plotly 简介**

**Plotly** 是一个强大的交互式数据可视化库，支持多种静态与动态图表类型，包括**散点图、柱状图、热力图、饼图、树形图、平行坐标图**等。  
它适用于构建**数据分析报告、仪表板**，通过丰富的交互功能（如悬停查看、缩放、数据钻取）帮助用户深入分析数据。

---

## **2. 准备工作：安装与导入库**

### **2.1 安装 Plotly 和所需依赖**
```bash
pip install plotly pandas seaborn
```

### **2.2 导入必要库**
```python
import plotly.express as px
import plotly.graph_objects as go
import pandas as pd
import seaborn as sns
```

---

## **3. 加载数据：鸢尾花数据集**

鸢尾花数据集是数据分析中的经典示例，包含 150 个样本的 4 个特征和物种类别：

### **3.1 加载鸢尾花数据集**
```python
# 加载鸢尾花数据集并查看前 5 行数据
df = sns.load_dataset("iris")
print(df.head())
```

**数据结构：**
| sepal_length | sepal_width | petal_length | petal_width | species |
| ------------ | ----------- | ------------ | ----------- | ------- |
| 5.1          | 3.5         | 1.4          | 0.2         | setosa  |

---

## **4. 散点图：变量关系的可视化**

### **4.1 基本散点图**
```python
fig = px.scatter(df, x='sepal_length', y='petal_length',
                 color='species', template='plotly_white',
                 labels={'sepal_length': 'Sepal Length (cm)',
                         'petal_length': 'Petal Length (cm)'},
                 title='Sepal Length vs Petal Length')
fig.show()
```

**解析：**
- **`color='species'`**：物种分类显示不同颜色。
- **`labels`**：为坐标轴添加友好标签。
- **交互功能**：鼠标悬停查看每个点的详细数据。

---

### **4.2 散点图增强版：添加边缘分布**
```python
fig = px.scatter(df, x='sepal_length', y='petal_length',
                 color='species', marginal_x='box', marginal_y='violin',
                 template='plotly_white', 
                 title='Scatter Plot with Marginals')
fig.show()
```

- **`marginal_x='box'`**：添加 X 轴边缘箱型图，展示分布。
- **`marginal_y='violin'`**：添加 Y 轴边缘小提琴图。

---

## **5. 数据聚合与分类分析**

### **5.1 计算花萼面积并创建分类**
```python
# 计算花萼面积并按面积大小进行分类
df['sepal_area'] = df['sepal_length'] * df['sepal_width']
df['area_category'] = pd.qcut(df['sepal_area'], 4, labels=['Small', 'Medium', 'Large', 'X-Large'])
print(df.head())
```

---

### **5.2 绘制按分类的散点图和箱型图**
```python
# 绘制分类散点图
fig = px.scatter(df, x='sepal_area', y='petal_length', 
                 color='area_category', template='plotly_white',
                 title='Sepal Area vs Petal Length')
fig.show()

# 绘制按分类的箱型图
fig = px.box(df, x='area_category', y='sepal_area', 
             color='area_category', points='all', template='plotly_white',
             title='Box Plot: Sepal Area Categories')
fig.show()
```

---

## **6. 热力图与交叉分析**

### **6.1 创建交叉表并绘制热力图**
```python
# 创建交叉表展示物种与面积分类之间的频率
crosstab = pd.crosstab(df['species'], df['area_category'])

# 绘制热力图
fig = px.imshow(crosstab, text_auto=True, title='Heatmap: Species vs Area Category',
                template='plotly_white')
fig.show()
```

---

### **6.2 使用密度热图展示分布**
```python
fig = px.density_heatmap(df, x='species', y='area_category',
                         histfunc='count', template='plotly_white',
                         title='Density Heatmap: Species vs Area Category')
fig.show()
```

---

## **7. 分类数据的比例分析：饼图与柱状图**

### **7.1 计算物种比例并绘制甜甜圈图**
```python
species_percent = df['species'].value_counts(normalize=True).reset_index()
species_percent.columns = ['species', 'percent']

fig = px.pie(species_percent, names='species', values='percent', 
             hole=0.5, title='Donut Chart: Species Distribution',
             template='plotly_white')
fig.show()
```

---

## **8. 层次化可视化：太阳爆炸图与树形图**

### **8.1 太阳爆炸图展示物种与分类层次**
```python
fig = px.sunburst(df, path=['species', 'area_category'], 
                  values='sepal_area', color='sepal_area',
                  title='Sunburst: Species and Sepal Area Categories',
                  template='plotly_white')
fig.show()
```

---

### **8.2 矩形树形图展示分类结构**
```python
fig = px.treemap(df, path=['species', 'area_category'], 
                 values='sepal_area', color='sepal_area',
                 title='Treemap: Sepal Area by Species',
                 template='plotly_white')
fig.show()
```

---

## **9. 平行坐标图与钻取分析**

### **9.1 使用平行坐标图展示多变量关系**
```python
fig = px.parallel_coordinates(df, dimensions=['sepal_length', 'sepal_width', 'petal_length', 'petal_width'],
                              color='species_id', labels={'species_id': 'Species'},
                              template='plotly_white', title='Parallel Coordinates Plot')
fig.show()
```

---

## **10. 相关性分析与可视化**

### **10.1 计算相关性矩阵并绘制热力图**
```python
corr_matrix = df.corr()

fig = px.imshow(corr_matrix, text_auto=True, 
                title='Correlation Matrix Heatmap', 
                template='plotly_white')
fig.show()
```

---

## **11. 图表保存与导出**

### **11.1 将图表保存为 HTML 和 PNG 文件**
```python
fig.write_html('interactive_plot.html')
fig.write_image('plot_image.png')
```

---

## **12. 实战练习：完整案例**

1. **创建新的特征列**：根据花瓣长宽比创建新列，并绘制相关图表。
2. **使用平行坐标图探索数据关系**：比较不同物种的特征分布。
3. **绘制太阳爆炸图**：展示多层次分类结构。
4. **分析物种与分类的交互关系**，并使用钻取图表进行探索。

---

## **13. 总结**

- **Plotly 提供了灵活、强大的交互式图表**，适用于数据分析与展示。
- **结合 Pandas 进行数据处理**，可以轻松实现复杂的数据可视化需求。
- **层次化图表**（如太阳爆炸图和树形图）帮助深入理解数据的多维度结构。
- **平行坐标图** 和 **热力图** 等工具，为数据间的关联分析提供了直观的支持。

通过这些详细的示例和实战练习，你将掌握如何使用 **Plotly** 构建交互式图表，并在项目中灵活应用。希望这份超详细笔记能帮助你在数据可视化领域取得成功！