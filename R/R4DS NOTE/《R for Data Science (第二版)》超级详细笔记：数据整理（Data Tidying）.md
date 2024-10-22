### **《R for Data Science (第二版)》超级详细笔记：数据整理（Data Tidying）**

---

## **1. 数据整理的概念与重要性**

数据整理是将杂乱的数据转化为**结构化的整洁数据（tidy data）**的过程。整洁数据是数据分析和可视化的标准格式。其三大原则为：  
1. **每一列是一个变量（Variable）**。  
2. **每一行是一个观测值（Observation）**。  
3. **每个单元格存储一个单一的值（Value）**。

**示例：**下表展示了2013年1月某公司在多个城市的销售数据：  

| 城市 | 1月销售额 | 2月销售额 | 3月销售额 |
| ---- | --------- | --------- | --------- |
| 上海 | 2000      | 2200      | 2500      |
| 北京 | 1800      | 1900      | 2100      |

- **问题**：在这个表中，月份信息嵌套在列名中，导致结构不符合“整洁数据”的标准。
- **解决方案**：使用`pivot_longer()`将宽表转换为长表。

---

## **2. `tidyr`包：数据整理的核心工具**

### **2.1 安装与加载`tidyr`包**
```R
install.packages("tidyverse")  # 安装tidyverse生态系统
library(tidyverse)  # 加载tidyr、dplyr等包
```

`tidyr`包中的核心工具包括：  
- **`pivot_longer()`**：将宽表（wide format）转换为长表（long format）。  
- **`pivot_wider()`**：将长表（long format）转换为宽表（wide format）。  
- **`separate()`**：分离嵌套信息的列。  
- **`unite()`**：合并多列为一列。

---

## **3. 宽表与长表的转换**

### **3.1 使用`pivot_longer()`：宽表转长表**

当表中的变量被存储为**列名**时，需要使用`pivot_longer()`将这些列名转换为行中的变量。

#### **3.1.1 基本语法**
```R
pivot_longer(
  data,            # 数据框
  cols,            # 要拉长的列
  names_to,        # 新列名，存储原列名
  values_to,       # 新列名，存储原值
  values_drop_na = FALSE  # 是否删除缺失值
)
```

#### **3.1.2 示例：转换月度销售数据**
```R
sales <- tibble(
  city = c("上海", "北京"),
  jan = c(2000, 1800),
  feb = c(2200, 1900),
  mar = c(2500, 2100)
)

sales_long <- sales |> 
  pivot_longer(
    cols = jan:mar, 
    names_to = "month", 
    values_to = "revenue"
  )
```

- **输出结果：**
  ```
  # A tibble: 6 × 3
    city  month revenue
    <chr> <chr>   <dbl>
  1 上海  jan      2000
  2 上海  feb      2200
  3 上海  mar      2500
  4 北京  jan      1800
  5 北京  feb      1900
  6 北京  mar      2100
  ```

- **解释**：
  - 将`jan`、`feb`、`mar`列拉长为一个新列`month`。
  - 每个城市的销售额变为新的行。

---

### **3.2 使用`pivot_wider()`：长表转宽表**

当数据已经是长表形式，但需要将其转为宽表时，可使用`pivot_wider()`。

#### **3.2.1 基本语法**
```R
pivot_wider(
  data, 
  names_from,   # 列名来源
  values_from   # 值来源列
)
```

#### **3.2.2 示例：将测量数据转为宽表**
```R
df <- tibble(
  id = c("A", "B", "A", "B"),
  measurement = c("bp1", "bp1", "bp2", "bp2"),
  value = c(100, 140, 120, 130)
)

df_wide <- df |> 
  pivot_wider(
    names_from = measurement, 
    values_from = value
  )
```

- **输出结果：**
  ```
  # A tibble: 2 × 3
    id    bp1   bp2
    <chr> <dbl> <dbl>
  1 A       100   120
  2 B       140   130
  ```

---

## **4. 列名嵌套信息的处理：`separate()` 和 `unite()`**

### **4.1 使用`separate()`拆分嵌套列名**

有时，列名中可能包含多个变量的信息，需要将其拆分为独立的列。

#### **4.1.1 示例：拆分嵌套列名**
```R
df <- tibble(
  observation = c("A_1", "B_2"),
  value = c(10, 20)
)

df_separated <- df |> 
  separate(
    observation, 
    into = c("group", "id"), 
    sep = "_"
  )
```

- **输出结果：**
  ```
  # A tibble: 2 × 3
    group id    value
    <chr> <chr> <dbl>
  1 A     1        10
  2 B     2        20
  ```

---

### **4.2 使用`unite()`合并列**

如果需要将多列的值合并为一个新列，可以使用`unite()`。

#### **4.2.1 示例：合并多列为一列**
```R
df_united <- df_separated |> 
  unite(
    "observation", 
    group:id, 
    sep = "_"
  )
```

- **输出结果：**
  ```
  # A tibble: 2 × 2
    observation value
    <chr>       <dbl>
  1 A_1            10
  2 B_2            20
  ```

---

## **5. 处理缺失值**

### **5.1 删除缺失值**

```R
df_clean <- df |> 
  drop_na()
```

- **解释**：`drop_na()`会删除包含`NA`值的所有行。

### **5.2 填充缺失值**

```R
df_filled <- df |> 
  fill(value, .direction = "down")
```

- **解释**：`fill()`向下填充缺失值，适合处理时间序列数据。

---

## **6. 数据整理与可视化的结合**

整洁数据让`ggplot2`等可视化工具的使用变得更加方便。

#### **6.1 实例：绘制病例趋势图**

```R
ggplot(table1, aes(x = year, y = cases, color = country)) +
  geom_line() +
  geom_point()
```

- **解释**：通过映射整洁数据中的列，轻松绘制不同国家的病例变化趋势。

---

## **7. 实战练习**

### **练习题：将以下宽表转换为长表**
```R
df <- tibble(
  id = c(1, 2),
  treatment_a = c(3, 4),
  treatment_b = c(5, 6)
)
```

- **答案**：
```R
df_long <- df |> 
  pivot_longer(
    cols = starts_with("treatment"), 
    names_to = "treatment", 
    values_to = "result"
  )
```

---

## **8. 总结**

### **8.1 核心要点**
- **整洁数据**是数据分析的基础，使得操作简洁、逻辑清晰。
- **`pivot_longer()`和`pivot_wider()`** 是进行数据格式转换的关键工具。
- 使用 **`separate()` 和 `unite()`** 可以拆分或合并列中的嵌套信息。

### **8.2 最佳实践**
- 在数据分析的初期确保数据是整洁的，可以大大减少后续操作中的麻烦。
- 善用`tidyr`工具，将数据转换为适合分析和可视化的格式。

---

### **结语**

通过本章的学习，你已经掌握了如何使用`tidyr`包将数据整理为整洁格式，并理解了长表与宽表之间的转换逻辑。整洁数据是数据分析的基础，它让你的分析更加高效、准确。如果你有其他问题或需要更多帮助，请随时告诉我！