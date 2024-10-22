### **《R for Data Science (第二版)》超详细笔记：数据转换（Data Transformation）**

---

## **1. 数据转换的概述与重要性**

在实际的数据分析中，**原始数据往往需要清理和转换**，才能进行有意义的分析与建模。数据转换的任务主要包括**筛选、排序、选择列、计算新变量、分组汇总**等操作。R语言中的`dplyr`包提供了一套**直观且高效的语法**来处理这些常见的数据转换任务。

---

## **2. dplyr的核心概念与准备**

### **2.1 安装与加载包**
```R
install.packages("nycflights13")  # 安装航班数据包
install.packages("tidyverse")     # 安装Tidyverse生态系统
library(nycflights13)  
library(tidyverse)  # 加载dplyr和其他Tidyverse包
```

- **`nycflights13` 数据集**：该数据集包含2013年从纽约三大机场起飞的航班详细信息。
- **`dplyr`包**：Tidyverse的一部分，用于数据框的转换和操作。

---

## **3. dplyr的核心动词（verbs）**

`dplyr`提供了**六个核心动词**，它们涵盖了数据转换的主要操作：
1. **`filter()`**：筛选行
2. **`arrange()`**：排序行
3. **`mutate()`**：添加新列
4. **`select()`**：选择列
5. **`rename()`**：重命名列
6. **`group_by()` 与 `summarize()`**：分组与汇总

---

## **4. 筛选行：`filter()`**

### **4.1 基本筛选操作**
`filter()`用于根据条件筛选数据中的特定行。
```R
flights |> 
  filter(dep_delay > 120)  # 筛选出延迟超过120分钟的航班
```

### **4.2 多条件筛选**
```R
flights |> 
  filter(month == 1 & day == 1)  # 筛选2013年1月1日的航班
```
- 使用`&`表示"且"，`|`表示"或"。

### **4.3 使用`%in%`简化筛选多个条件**
```R
flights |> 
  filter(month %in% c(7, 8, 9))  # 筛选7月、8月和9月的航班
```

---

## **5. 排序行：`arrange()`**

`arrange()`用于根据某些列对数据进行排序。

### **5.1 升序排序**
```R
flights |> 
  arrange(dep_delay)  # 按出发延迟时间升序排序
```

### **5.2 降序排序**
```R
flights |> 
  arrange(desc(arr_delay))  # 按到达延迟时间降序排序
```

### **5.3 多列排序**
```R
flights |> 
  arrange(year, month, day)  # 先按年、再按月、最后按日排序
```

---

## **6. 添加新列：`mutate()`**

`mutate()`用于基于现有列创建新的列。

### **6.1 添加计算列**
```R
flights |> 
  mutate(
    gain = dep_delay - arr_delay,  # 计算延迟弥补时间
    speed = distance / air_time * 60  # 计算速度（每小时英里数）
  )
```

### **6.2 只保留使用过的列**
```R
flights |> 
  mutate(hours = air_time / 60, .keep = "used")
```

---

## **7. 选择与重命名列**

### **7.1 使用`select()`选择列**
- **选择特定列**：
```R
flights |> 
  select(year, month, day, dep_time, arr_time)
```

- **按列名模式选择**：
```R
flights |> 
  select(starts_with("arr"))  # 选择所有以“arr”开头的列
```

- **排除某些列**：
```R
flights |> 
  select(-year, -month)  # 排除年份和月份列
```

### **7.2 使用`rename()`重命名列**
```R
flights |> 
  rename(tail_num = tailnum)  # 将tailnum列重命名为tail_num
```

### **7.3 使用`relocate()`移动列**
```R
flights |> 
  relocate(time_hour, .before = dep_time)  # 将time_hour移动到dep_time之前
```

---

## **8. 分组与汇总**

### **8.1 使用`group_by()`按组分析**
- **按目的地分组**：
```R
flights |> 
  group_by(dest)
```

### **8.2 使用`summarize()`进行汇总**
- **计算每个月的平均延迟时间**：
```R
flights |> 
  group_by(month) |> 
  summarize(avg_delay = mean(dep_delay, na.rm = TRUE))
```

- **汇总多个统计量**：
```R
flights |> 
  group_by(month) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE), 
    total_flights = n()
  )
```

---

## **9. 数据完整性检查与去重**

### **9.1 使用`distinct()`删除重复行**
- **按出发地与目的地去重**：
```R
flights |> 
  distinct(origin, dest)
```

---

## **10. 管道符`|>`实现流畅操作**

### **10.1 管道符的使用示例**
```R
flights |> 
  filter(dest == "IAH") |> 
  mutate(speed = distance / air_time * 60) |> 
  select(year:day, dep_time, arr_time, speed) |> 
  arrange(desc(speed))
```
- **解释**：
  1. 筛选飞往IAH机场的航班。
  2. 计算速度。
  3. 选择日期和时间相关列。
  4. 按速度降序排列。

---

## **11. 常见数据转换任务与解决方案**

### **11.1 找到最长飞行时间的航班**
```R
flights |> 
  slice_max(air_time, n = 1)  # 找到飞行时间最长的航班
```

### **11.2 找出每个目的地的总飞行时间**
```R
flights |> 
  group_by(dest) |> 
  summarize(total_air_time = sum(air_time, na.rm = TRUE))
```

---

## **12. 常见错误与调试**

### **12.1 未找到列名的错误**
```R
flights |> 
  select(dep_delay, arr_del)  # 错误：arr_del 列不存在
```
- **解决方法**：确保列名拼写正确。

---

## **13. 总结**

- **核心操作**：
  1. **筛选与排序**：`filter()`、`arrange()`
  2. **选择与重命名列**：`select()`、`rename()`、`relocate()`
  3. **添加新变量**：`mutate()`
  4. **分组与汇总**：`group_by()`、`summarize()`

- **使用管道符`|>`实现高效的数据转换**。

---

## **14. 练习与思考**

### **14.1 练习题**
1. **找出所有延迟超过2小时的航班**：
   ```R
   flights |> filter(arr_delay > 120)
   ```

2. **找出每个航空公司的最长航班**：
   ```R
   flights |> 
     group_by(carrier) |> 
     slice_max(air_time, n = 1)
   ```

---

### **结语**

通过本章的学习，你掌握了如何使用`dplyr`包进行数据转换。这些工具将帮助你快速筛选、计算和汇总数据，并为进一步的分析和可视化奠定基础。如果你有其他问题，请告诉我，我可以提供更多支持。