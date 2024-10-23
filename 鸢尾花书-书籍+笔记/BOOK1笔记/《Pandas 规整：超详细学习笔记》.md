## **《Pandas 规整：超详细学习笔记》**

---

## **1. 什么是 Pandas 规整？**

Pandas **数据规整**是指对 **DataFrame** 和 **Series** 进行结构化调整，包括**数据拼接与合并、格式转换、分组聚合、数据映射与变换**。通过这些操作，可以使数据更易于分析和展示。

---

## **2. 数据拼接与合并**

### **2.1 使用 `concat()` 进行数据拼接**

- **`pandas.concat()`** 用于沿行（`axis=0`）或列（`axis=1`）方向将多个 DataFrame 拼接起来。

#### **示例：按列拼接多个 DataFrame**
```python
import pandas as pd

df1 = pd.DataFrame({'Name': ['Alice', 'Bob'], 'Score': [85, 90]})
df2 = pd.DataFrame({'Age': [24, 30], 'City': ['NY', 'LA']})

result = pd.concat([df1, df2], axis=1)
print(result)
```

#### **结果：**
```
    Name  Score  Age City
0  Alice     85   24   NY
1    Bob     90   30   LA
```

- **参数详解：**
  - `axis=0`：沿行方向拼接（上下合并）。
  - `axis=1`：沿列方向拼接（左右合并）。
  - `join='outer'`：取并集，缺失值补 NaN。

---

### **2.2 使用 `merge()` 进行数据库风格的合并**

- **`merge()`** 类似 SQL 的 join 操作，用于通过一个或多个键合并 DataFrame。

#### **示例：按键合并**
```python
df1 = pd.DataFrame({'ID': [1, 2], 'Name': ['Alice', 'Bob']})
df2 = pd.DataFrame({'ID': [2, 3], 'Score': [95, 80]})

result = pd.merge(df1, df2, on='ID', how='inner')
print(result)
```

#### **结果：**
```
   ID  Name  Score
0   2   Bob     95
```

- **参数详解：**
  - `on='ID'`：指定用于匹配的列名。
  - `how='inner'`：执行内连接，仅保留匹配到的行。

---

### **2.3 使用 `join()` 根据索引合并**

- **`join()`** 根据索引合并多个 DataFrame。

#### **示例：索引合并**
```python
df1 = pd.DataFrame({'Score': [85, 90]}, index=['Alice', 'Bob'])
df2 = pd.DataFrame({'City': ['NY', 'LA']}, index=['Alice', 'Charlie'])

result = df1.join(df2, how='outer')
print(result)
```

#### **结果：**
```
        Score City
Alice    85.0   NY
Bob      90.0  NaN
Charlie   NaN   LA
```

---

## **3. 数据格式转换**

### **3.1 使用 `pivot()` 转换数据格式**

- **`pivot()`** 将长格式转换为宽格式。

#### **示例：使用 `pivot()`**
```python
data = {
    'Student': ['Alice', 'Alice', 'Bob', 'Bob'],
    'Subject': ['Math', 'Science', 'Math', 'Science'],
    'Score': [85, 90, 80, 75]
}
df = pd.DataFrame(data)

pivoted = df.pivot(index='Student', columns='Subject', values='Score')
print(pivoted)
```

#### **结果：**
```
Subject  Math  Science
Student                
Alice      85       90
Bob        80       75
```

---

### **3.2 使用 `melt()` 将宽格式转换为长格式**

- **`melt()`** 将宽格式数据“融化”为长格式。

#### **示例：使用 `melt()`**
```python
pivoted = pd.DataFrame({
    'Student': ['Alice', 'Bob'],
    'Math': [85, 80],
    'Science': [90, 75]
})

melted = pd.melt(pivoted, id_vars='Student', var_name='Subject', value_name='Score')
print(melted)
```

#### **结果：**
```
  Student  Subject  Score
0  Alice     Math     85
1  Bob       Math     80
2  Alice  Science     90
3  Bob    Science     75
```

---

### **3.3 使用 `stack()` 和 `unstack()`**

- **`stack()`** 将列转换为行（变为多级索引）。
- **`unstack()`** 将多级索引的行转换为列。

#### **示例：使用 `stack()` 和 `unstack()`**
```python
df = pd.DataFrame({
    'A': [1, 2],
    'B': [3, 4]
}, index=['row1', 'row2'])

stacked = df.stack()
print(stacked)

unstacked = stacked.unstack()
print(unstacked)
```

#### **结果：**
```
row1  A    1
      B    3
row2  A    2
      B    4
dtype: int64
```

---

## **4. 分组与聚合：`groupby()`**

### **4.1 基于列分组并聚合**

- **`groupby()`** 可以按列对数据进行分组，并进行聚合计算。

#### **示例：按班级分组求平均分**
```python
data = {
    'Class': ['A', 'A', 'B', 'B'],
    'Student': ['Alice', 'Bob', 'Charlie', 'David'],
    'Score': [85, 90, 80, 95]
}
df = pd.DataFrame(data)

grouped = df.groupby('Class')['Score'].mean()
print(grouped)
```

#### **结果：**
```
Class
A    87.5
B    87.5
Name: Score, dtype: float64
```

---

## **5. 自定义数据处理：`apply()` 与 `map()`**

### **5.1 使用 `apply()` 处理列或行**

- **`apply()`** 可对 DataFrame 的每列或每行应用自定义函数。

#### **示例：映射分数为等级**
```python
def score_to_grade(score):
    if score >= 90:
        return 'A'
    elif score >= 80:
        return 'B'
    else:
        return 'C'

df['Grade'] = df['Score'].apply(score_to_grade)
print(df)
```

#### **结果：**
```
    Class  Student  Score Grade
0      A    Alice     85     B
1      A      Bob     90     A
2      B  Charlie     80     B
3      B    David     95     A
```

---

### **5.2 使用 `map()` 对 Series 进行映射**

- **`map()`** 是 **Series** 对象的方法，用于逐元素操作。

#### **示例：使用 `map()` 增加分数**
```python
df['Adjusted Score'] = df['Score'].map(lambda x: x + 5)
print(df)
```

#### **结果：**
```
    Class  Student  Score Grade  Adjusted Score
0      A    Alice     85     B              90
1      A      Bob     90     A              95
2      B  Charlie     80     B              85
3      B    David     95     A             100
```

---

## **6. 时间序列数据规整**

Pandas 提供了强大的时间序列处理功能。

### **6.1 创建时间序列 DataFrame**
```python
date_range = pd.date_range(start='2023-01-01', periods=4, freq='D')
df_time = pd.DataFrame({'Value': [10, 20, 30, 40]}, index=date_range)
print(df_time)
```

#### **结果：**
```
            Value
2023-01-01     10
2023-01-02     20
2023-01-03     30
2023-01-04     40
```

---

## **7. 实战练习**

1. **创建两个 DataFrame，使用 `merge()` 合并数据**。
2. **使用 `groupby()` 对数据进行分组求和**。
3. **创建时间序列数据，并按日期范围进行筛选**。
4. **使用 `pivot()` 和 `melt()` 进行格式转换**。

---

## **8. 总结**

- **Pandas 规整工具**包括拼接、合并、格式转换、分组与聚合等操作，是数据处理的重要组成部分。
- 通过掌握 **`merge()`**、**`groupby()`**、**`pivot()`** 和 **`apply()`** 等函数，可以高效完成数据整理与分析任务。
- **实践练习**是熟



练掌握 Pandas 数据规整的关键。

---

这份超详细的 Pandas 数据规整笔记涵盖了所有常用的数据操作及其示例，帮助你在数据分析和清洗过程中轻松处理各种复杂数据。