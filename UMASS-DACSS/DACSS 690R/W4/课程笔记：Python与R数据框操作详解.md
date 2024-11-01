### 课程笔记：Python与R数据框操作详解

---

### 1. 数据框的概念与创建

数据框（DataFrame）是数据分析和机器学习中使用最广泛的数据结构之一。它以二维表格的形式存储数据，并包含**行（记录）**和**列（属性）**，非常适合处理结构化数据。

#### 1.1 数据框的概念

- **数据框**：类似于数据库表格或Excel工作表，由多个相同长度的列组成，每列代表一个变量（属性），每行代表一个观测（样本）。
- **适用场景**：数据框结构化地组织数据，适合描述、分析和模型训练，能够快速查询、筛选、聚合和变换数据。

#### 1.2 数据框的创建（Python）

- **Python中的`pandas`库**：
  - `pandas`是Python中用于数据分析的核心库之一，`DataFrame`是`pandas`的一个类，专门用于创建和管理数据框。
  - `pandas.DataFrame()`的输入可以是**字典、列表、NumPy数组**等。

- **通过字典创建数据框**：
  - 字典的**键**作为列名，**值**作为列数据。
  - 示例代码：
    ```python
    import pandas as pd  # 导入pandas库
    
    data = {
        "student": ["Alice", "Bob", "Charlie"],
        "age": [20, 21, 22],
        "education": ["BA", "MA", "PhD"]
    }
    
    df = pd.DataFrame(data)  # 使用DataFrame()将字典转换为数据框
    ```
  - 以上代码会生成一个3行3列的数据框，列名分别为`student`、`age`和`education`。

- **从文件创建数据框**：
  - `pd.read_csv()`：读取CSV文件并转换为数据框。
  - `pd.read_excel()`：读取Excel文件中的数据。
  - 示例：
    ```python
    df = pd.read_csv("data.csv")  # 读取CSV文件
    ```

#### 1.3 数据框的创建（R）

- **R中的`data.frame()`函数**：
  - R语言自带的`data.frame()`函数用于创建数据框。每列是一个向量，代表一个变量；多个向量合并形成数据框。
  - 示例代码：
    ```R
    student <- c("Alice", "Bob", "Charlie")  # 创建向量
    age <- c(20, 21, 22)
    education <- c("BA", "MA", "PhD")
    
    df <- data.frame(student, age, education)  # 创建数据框
    ```
  - R的数据框类似于Python的数据框，差异在于**R的行列索引从1开始**（Python从0开始）。

- **从文件创建数据框**：
  - `read.csv()`：读取CSV文件。
  - `read_excel()`：读取Excel文件。
  - 示例：
    ```R
    df <- read.csv("data.csv")  # 读取CSV文件
    ```

---

### 2. 数据框的访问

访问数据框时，可以按**行列索引**或**标签**访问具体的行、列或单元格。

#### 2.1 Python中的数据框访问

- **按索引访问**：
  - 使用`iloc`按行列位置（从0开始）访问数据。
  - 示例代码：
    ```python
    df.iloc[:, 0]     # 获取第一列的所有行
    df.iloc[0, :]     # 获取第一行的所有列
    df.iloc[1, 2]     # 获取第二行、第三列的值
    ```
  - `iloc`中，冒号`:`表示选择全部行或列。

- **按标签访问**：
  - 使用`loc`按行列标签（列名）访问数据，代码可读性较高。
  - 示例代码：
    ```python
    df.loc[:, 'student']  # 获取"student"列
    df.loc[0, 'age']      # 获取第一行"age"列的值
    ```

#### 2.2 R中的数据框访问

- R通过方括号`[]`指定行列，第一参数为行，第二参数为列，逗号`，`分隔。
  - 示例代码：
    ```R
    df[ , "student"]  # 获取"student"列
    df[1, ]           # 获取第一行
    df[1, "age"]      # 获取第一行"age"列的值
    ```
  - R的索引从1开始，因此`df[1, 1]`表示第一行、第一列。

---

### 3. 列表与向量的区别

- **列表（List）**：
  - **Python**和**R**的列表都可以容纳多种数据类型，适合存储异构数据。
  - Python的列表通过`list`对象创建，R的列表通过`list()`函数创建。

- **向量（Vector）**：
  - **Python**没有内置的向量类型，`numpy`的`ndarray`常用于数值向量。
  - **R**的向量是最基本的数据类型，所有元素类型需一致。在数学运算中，向量更适合用于数值计算和数据分析。

---

### 4. 数据框中的替换操作

替换操作用于更改数据框中特定位置的数据，在数据清理中尤为常见。

#### 4.1 Python中的替换操作

- 使用`loc`或`iloc`替换数据框中的值：
  ```python
  df.loc[2, 'student'] = "Dan"   # 将第三行"student"列的值替换为"Dan"
  df.iloc[1, 1] = 25             # 将第二行、第二列的值替换为25
  ```

#### 4.2 R中的替换操作

- 在R中直接用`[行, 列]`指定位置替换值：
  ```R
  df[2, "student"] <- "Dan"  # 替换第二行"student"列的值为"Dan"
  df[1, 2] <- 25             # 将第一行、第二列的值替换为25
  ```

---

### 5. 数据框的删除操作

可以删除数据框中的行或列。

#### 5.1 Python中的删除操作

- **删除列**：
  - 使用`drop`方法删除指定列。
  - 示例：
    ```python
    df.drop(['education'], axis=1, inplace=True)  # 删除"education"列
    ```

- **删除行**：
  - 使用`drop`方法，传入行索引列表（如`[2, 3]`）来删除指定行。
  - 示例：
    ```python
    df.drop([2, 3], axis=0, inplace=True)  # 删除索引为2和3的行
    ```

#### 5.2 R中的删除操作

- **删除列**：通过集合差选取保留的列。
  ```R
  df <- df[ , !(names(df) %in% c("education"))]  # 删除"education"列
  ```
- **删除行**：通过负数索引指定要删除的行。
  ```R
  df <- df[-c(2, 3), ]  # 删除第二和第三行
  ```

---

### 6. 重置索引

删除行后，索引可能不连续。重置索引可以确保索引的连续性。

#### 6.1 Python中的重置索引

- 使用`reset_index()`方法生成新的连续索引。
  ```python
  df.reset_index(drop=True, inplace=True)  # 删除旧索引
  ```
  - `drop=True`表示不保留旧索引列。

#### 6.2 R中的重置索引

- 通过重新分配行名实现索引重置。
  ```R
  rownames(df) <- NULL  # 清除旧索引，生成新索引
  ```

---

### 7. 处理空值

空值代表缺失数据，可用NA来标识。

#### 7.1 Python中的空值处理

- 使用`pd.NA`表示空值。
  ```python
  df.loc[2, 'country'] = pd.NA  # 将第三行"country"列设置为空值
  ```

#### 7.2 R中的空值处理

- 使用`NA`表示缺失值。
  ```R
  df[2, "country"] <- NA  # 将第三行"country"列设置为空值
  ```

---

### 8. 插入新列和合并数据框

数据框可以在列或行方向上扩展。

#### 8.1 插入新列

- **Python**：直接赋值新列。
  ```python
  df["gender"] = ["F", "M", "F"]  # 添加"gender"列
  ```
- **R**：使用

`cbind()`添加列。
  ```R
  df <- cbind(df, gender = c("F", "M", "F"))
  ```

#### 8.2 合并数据框

- **Python**：使用`pd.concat()`按行合并。
  ```python
  df_combined = pd.concat([df1, df2], ignore_index=True)  # 合并数据框
  ```
- **R**：使用`rbind()`按行合并。
  ```R
  df_combined <- rbind(df1, df2)
  ```

---

### 9. 数据框常用操作总结

| 操作           | Python语法                  | R语法                  |
| -------------- | --------------------------- | ---------------------- |
| 查看数据框类型 | `type(df)`                  | `class(df)`            |
| 查看行列数     | `df.shape`                  | `dim(df)`              |
| 列名           | `df.columns`                | `names(df)`            |
| 行索引         | `df.index`                  | `rownames(df)`         |
| 预览前几行     | `df.head(n)`                | `head(df, n)`          |
| 预览后几行     | `df.tail(n)`                | `tail(df, n)`          |
| 清除数据框索引 | `df.reset_index(drop=True)` | `rownames(df) <- NULL` |

---

### 10. 总结与学习路径

- **推荐步骤**：
  1. 熟练掌握数据框的创建与基本操作。
  2. 学习数据筛选、聚合和变换等高级数据清理操作。
  3. 逐步尝试在实际项目中使用数据框，熟悉分析流程。

- **工具**：
  - Python推荐使用**Jupyter Notebook**或**Google Colab**，方便代码运行和实时结果展示。
  - R可以使用**RStudio**，集成环境便于脚本管理和调试。

通过反复练习和对比操作，可以深入掌握Python和R的数据框使用方法，理解两者的操作逻辑和函数差异。