### **《R for Data Science (第二版)》超级详细笔记：数据导入（Data Import）**

---

## **1. 为什么数据导入是关键？**

数据导入是数据分析的第一步，你需要将外部文件（如CSV、TSV、日志文件或数据库数据）加载到R中进行处理。  
掌握数据导入工具，能让你从**多种格式和来源**导入数据，并确保数据的**准确性和完整性**。  
本章重点介绍`readr`包，它是**Tidyverse**的一部分，为高效导入数据提供了强大支持。

---

## **2. 使用`read_csv()`读取CSV文件**

### **2.1 什么是CSV文件？**

CSV（Comma-Separated Values）是最常见的**矩形数据格式**，各列用**逗号`,`**分隔，每一行代表一个数据记录。

---

### **2.2 基本使用：从本地和网络读取CSV文件**

```R
library(tidyverse)

# 从本地文件读取CSV数据
students <- read_csv("data/students.csv")

# 从网络URL直接读取CSV数据
students <- read_csv("https://example.com/students.csv")
```

**示例输出：**
```
Rows: 6 Columns: 5
── Column specification ──────────────────────────────────────
chr (4): Full Name, favourite.food, mealPlan, AGE
dbl (1): Student ID
```

- **解释**：R会自动推断列类型，并提供详细的列类型信息。

---

### **2.3 指定列类型**

虽然`read_csv()`能自动推断列类型，但在某些情况下，手动指定列类型会更精确。

#### **示例：手动设置列类型**
```R
students <- read_csv("data/students.csv", col_types = cols(
  student_id = col_integer(),
  full_name = col_character(),
  age = col_double(),
  meal_plan = col_factor()
))
```

#### **常见的列类型设置**：
- **`col_character()`**：字符型数据。
- **`col_double()`**：浮点数。
- **`col_integer()`**：整数。
- **`col_factor()`**：因子变量（分类数据）。
- **`col_skip()`**：跳过某一列。

---

## **3. 处理缺失值**

不同数据文件中，缺失值可能被表示为`NA`、`""`或`"N/A"`等。你可以通过`na`参数指定缺失值标记。

#### **示例：指定缺失值标记**
```R
students <- read_csv("data/students.csv", na = c("", "N/A"))
```

---

## **4. 使用其他`readr`函数读取文件**

### **4.1 `read_csv2()`：读取分号分隔文件**

在一些国家（如德国、法国），CSV文件使用**分号`；`**而不是逗号作为分隔符。

```R
sales <- read_csv2("data/sales.csv")
```

---

### **4.2 `read_tsv()`：读取TSV文件**

TSV（Tab-Separated Values）文件使用**制表符`Tab`**作为分隔符。

```R
products <- read_tsv("data/products.tsv")
```

---

### **4.3 `read_fwf()`：读取固定宽度文件**

固定宽度文件（Fixed Width Files, FWF）每一列都有**固定的字符长度**，适合读取没有分隔符的对齐数据。

```R
read_fwf("data/fwf_file.txt", fwf_widths(c(5, 10, 8)))
```

- **`fwf_widths()`**：定义每列的字符宽度。

---

## **5. 读取多个文件并合并**

### **5.1 使用`list.files()`批量读取CSV文件**

如果你的数据分散在多个文件中，可以使用`list.files()`列出所有文件，并用`map_df()`批量读取和合并。

#### **示例：批量读取销售数据文件**
```R
sales_files <- list.files("data", pattern = "sales_.*\\.csv$", full.names = TRUE)

# 使用map_df()批量读取并合并数据
sales_data <- sales_files |> 
  map_df(~ read_csv(.x))
```

---

## **6. 控制列名和跳过不需要的数据**

### **6.1 跳过文件头部的元数据行**

某些文件包含额外的头部信息，需要跳过这些行。

```R
read_csv("data/complex_file.csv", skip = 3)
```

- **解释**：跳过前3行，从第4行开始读取数据。

---

### **6.2 忽略注释行**

某些文件包含注释行（以`#`开头），这些行可以通过`comment`参数忽略。

```R
read_csv("data/log_file.csv", comment = "#")
```

---

## **7. 数据写入：保存数据到文件**

### **7.1 写入CSV文件**

```R
write_csv(students, "data/cleaned_students.csv")
```

---

### **7.2 使用RDS格式保存R对象**

RDS格式不仅能保存数据，还能保留R对象的完整信息，包括**列类型和因子属性**。

```R
write_rds(students, "data/students.rds")
students_loaded <- read_rds("data/students.rds")
```

---

## **8. 创建小型数据集：`tibble()` 和 `tribble()`**

### **8.1 使用`tibble()`按列创建数据**

`tibble()`是`data.frame()`的改进版，能更好地处理列名和类型。

```R
tibble(
  id = 1:3,
  name = c("Alice", "Bob", "Charlie"),
  score = c(90, 85, 88)
)
```

---

### **8.2 使用`tribble()`按行创建数据**

`tribble()`适用于手动创建小型数据集，按**行方式输入**数据。

```R
tribble(
  ~id, ~name, ~score,
  1, "Alice", 90,
  2, "Bob", 85,
  3, "Charlie", 88
)
```

---

## **9. 常见数据导入问题与解决方案**

### **9.1 处理列名缺失**

```R
read_csv("data/no_header.csv", col_names = FALSE)
```

- **解释**：当数据文件没有列名时，R会自动为列生成默认名称`X1`、`X2`等。

---

### **9.2 修复数据类型错误**

某些数值列可能被错误地读取为字符型。你可以使用`parse_number()`进行修复。

```R
students <- students |> 
  mutate(age = parse_number(age))
```

---

### **9.3 清理列名**

使用`janitor::clean_names()`清理包含空格或特殊字符的列名。

```R
library(janitor)
students <- students |> janitor::clean_names()
```

**输出示例：**
```
student_id, full_name, favourite_food, age
```

---

## **10. 数据导入的最佳实践**

1. **使用相对路径加载文件**：避免使用绝对路径，确保代码的**可移植性**。
2. **检查导入数据的类型和结构**：
   ```R
   glimpse(students)
   ```
3. **保存数据分析结果**：避免依赖R环境，确保分析可复现。
4. **定期备份数据**：使用`write_csv()`和`write_rds()`保存重要文件。

---

## **11. 总结与拓展阅读**

### **11.1 核心要点**
- 使用`read_csv()`高效导入CSV文件，并处理缺失值和列类型。
- 使用`tibble()`和`tribble()`快速创建数据。
- 保存数据为RDS格式，确保对象的完整性。

### **11.2 拓展阅读**
- **从Excel文件导入**：`readxl`包支持读取`.xls`和`.xlsx`文件。
- **从数据库导入**：使用`DBI`和`dplyr`访问SQL数据库。
- **从Parquet和JSON读取数据**：使用`arrow`和`jsonlite`包。

---

### **结语**

通过本章的学习，你已经掌握了如何使用`readr`导入和处理多种数据格式，并了解了常见的数据导入问题与解决方案。掌握这些技能，将大大提高你的数据分析效率。如果你有进一步的问题，请随时告诉我！