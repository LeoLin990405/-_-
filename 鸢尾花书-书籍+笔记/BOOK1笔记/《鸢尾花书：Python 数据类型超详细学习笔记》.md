## **《鸢尾花书：Python 数据类型超详细学习笔记》**

---

## **第一部分：Python 数据类型概述**

### **1.1 为什么数据类型重要？**
- **数据类型**定义了数据的存储方式和可进行的操作。  
- 在 Python 中，**动态类型系统**允许变量的类型在运行时决定，避免了编译前的类型声明，但要求开发者熟悉数据类型和其特性。

### **1.2 Python 数据类型的分类**
- **数字类型**：整数（int）、浮点数（float）、复数（complex）  
- **布尔类型**：`True` 和 `False`  
- **序列类型**：字符串（str）、列表（list）、元组（tuple）  
- **集合类型**：集合（set）、冻结集合（frozenset）  
- **映射类型**：字典（dict）  
- **None 类型**：表示空值

---

## **第二部分：数字类型（int、float、complex）**

### **2.1 整数类型 (int)**  
- **整数**类型存储不带小数点的数，**支持无限长度**：
  ```python
  a = 42
  b = -3
  print(type(a))  # 输出：<class 'int'>
  ```

### **2.2 浮点数类型 (float)**
- **浮点数**存储有小数部分的数：
  ```python
  pi = 3.14159
  e = -2.718
  print(type(pi))  # 输出：<class 'float'>
  ```

### **2.3 复数类型 (complex)**
- 复数由**实部**和**虚部**组成，虚部以 `j` 表示：
  ```python
  z = 4 + 3j
  print(z.real)  # 输出：4.0
  print(z.imag)  # 输出：3.0
  ```

### **2.4 数学运算与内置函数**
```python
a = 10
b = 3

# 常见数学运算
print(a + b)   # 加法：13
print(a - b)   # 减法：7
print(a * b)   # 乘法：30
print(a / b)   # 浮点除法：3.333...
print(a // b)  # 整除：3
print(a % b)   # 取余：1
print(a ** b)  # 幂运算：1000

# 数学函数
print(abs(-5))     # 绝对值：5
print(pow(2, 3))   # 幂：2^3 = 8
print(round(3.14159, 2))  # 四舍五入：3.14
```

---

## **第三部分：字符串类型（str）**

### **3.1 字符串创建**
- Python 的字符串可以用**单引号**、**双引号**或**三引号**定义：
  ```python
  str1 = 'Hello'
  str2 = "Python"
  str3 = '''This is
  a multi-line string.'''
  ```

### **3.2 字符串操作**
```python
text = "Hello, Python!"

# 拼接字符串
print(text + " Let's learn!")  # 输出：Hello, Python! Let's learn!

# 重复字符串
print(text * 2)  # 输出：Hello, Python!Hello, Python!

# 检查子串
print("Python" in text)  # 输出：True
```

### **3.3 字符串索引与切片**
```python
text = "Hello, Python!"

# 索引
print(text[0])  # 输出：H
print(text[-1])  # 输出：!

# 切片
print(text[:5])  # 输出：Hello
print(text[7:])  # 输出：Python!
```

### **3.4 字符串方法**
```python
text = "  Hello, Python!  "

print(text.lower())  # 转为小写：hello, python!
print(text.upper())  # 转为大写：HELLO, PYTHON!
print(text.strip())  # 去除空格：Hello, Python!
print(text.replace("Python", "World"))  # 替换子串：Hello, World!
print(text.split(","))  # 按逗号分割：['  Hello', ' Python!  ']
```

---

## **第四部分：列表类型（list）**

### **4.1 列表的创建与访问**
```python
fruits = ["apple", "banana", "cherry"]

# 访问元素
print(fruits[0])  # 输出：apple
print(fruits[-1])  # 输出：cherry
```

### **4.2 列表的常用操作**
```python
# 添加元素
fruits.append("orange")
print(fruits)  # 输出：['apple', 'banana', 'cherry', 'orange']

# 插入元素
fruits.insert(1, "blueberry")

# 删除元素
fruits.remove("banana")

# 列表长度
print(len(fruits))  # 输出：4
```

---

## **第五部分：元组类型（tuple）**

### **5.1 元组的创建与操作**
- **元组**是不可变的有序集合：
  ```python
  coordinates = (10, 20, 30)
  print(coordinates[0])  # 输出：10
  ```

- **不可变**意味着元组中的元素不能被修改：
  ```python
  # coordinates[0] = 100  # 报错：TypeError
  ```

---

## **第六部分：集合类型（set）**

### **6.1 集合的创建与基本操作**
```python
numbers = {1, 2, 3, 3}  # 重复元素会被去除
print(numbers)  # 输出：{1, 2, 3}

# 添加元素
numbers.add(4)

# 删除元素
numbers.remove(3)

# 集合运算
A = {1, 2, 3}
B = {3, 4, 5}

print(A | B)  # 并集：{1, 2, 3, 4, 5}
print(A & B)  # 交集：{3}
print(A - B)  # 差集：{1, 2}
```

---

## **第七部分：字典类型（dict）**

### **7.1 字典的创建与访问**
- **字典**使用键值对存储数据：
  ```python
  person = {"name": "Alice", "age": 25}
  print(person["name"])  # 输出：Alice
  ```

### **7.2 字典的常见操作**
```python
# 添加键值对
person["city"] = "New York"

# 修改值
person["age"] = 26

# 删除键值对
del person["city"]

# 遍历字典
for key, value in person.items():
    print(f"{key}: {value}")
```

---

## **第八部分：数据类型之间的转换**

### **8.1 转换示例**
```python
# 列表转元组
lst = [1, 2, 3]
tpl = tuple(lst)

# 字符串转整数
num = int("42")

# 集合转列表
s = {1, 2, 3}
lst = list(s)
```

---

## **第九部分：浅复制与深复制**

### **9.1 浅复制与深复制的区别**
```python
import copy

list1 = [1, 2, [3, 4]]
list2 = list1.copy()  # 浅复制
list3 = copy.deepcopy(list1)  # 深复制

list2[2][0] = 100
print(list1)  # 输出：[1, 2, [100, 4]]  # 浅复制会影响原列表

list3[2][0] = 200
print(list1)  # 输出：[1, 2, [3, 4]]  # 深复制不影响原列表
```

---

## **第十部分：总结与练习**

### **10.1 练习任务**
1. 创建一个字典，存储学生的成绩，并计算平均分。
2. 使用集合找出两个班级的共同兴趣爱好。

### **10.2 总结**
- 熟悉 Python 的数据类型和其操作，是编写高效代码的基础。
- 理解类型之间的转换和集合、字典的使用方法，将提高你在数据处理中的能力。
- 掌握深浅复制的区别，有助于避免潜在的编程错误。

---

这份超详细笔记涵盖了 **Python 数据类型的核心知识与操作技巧**，并通过丰富的示例帮助你更深入理解。如果你在学习过程中有任何问题，请随时联系我，我将竭诚为你提供帮助！