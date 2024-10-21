## **《鸢尾花书：Python 基础语法详细学习笔记》**

---

### **第一部分：Python 语言概述**

#### **1.1 什么是 Python？**
- **Python** 是一种高级、解释型、跨平台的编程语言，1989 年由 Guido van Rossum 开发。  
- **特性**：
  - **简单易学**：代码结构清晰，语法接近自然语言。
  - **开源免费**：社区活跃，第三方库资源丰富。
  - **跨平台**：支持 Windows、Linux、Mac OS 等平台。
  - **广泛应用**：包括 **Web 开发、数据分析、人工智能、自动化脚本** 等领域。

---

## **第二部分：Python 程序的基础结构**

#### **2.1 Python 文件结构与运行方式**
- **交互模式**：在终端或 Jupyter Notebook 中直接运行单行或多行代码。
  ```bash
  python  # 进入 Python 交互环境
  >>> print("Hello, World!")
  ```

- **脚本文件模式**：将代码保存为 `.py` 文件并在终端运行。
  ```bash
  python my_script.py  # 运行 my_script.py
  ```

---

## **第三部分：变量与数据类型**

#### **3.1 变量的定义与赋值**
- 在 Python 中，**变量不需要声明类型**，使用 `=` 直接赋值：
  ```python
  name = "Alice"  # 字符串类型
  age = 25  # 整数类型
  height = 1.75  # 浮点数类型
  ```

#### **3.2 Python 数据类型**

| **数据类型**     | **示例**                       | **描述**                      |
| ---------------- | ------------------------------ | ----------------------------- |
| 整数 (`int`)     | `x = 10`                       | 存储整数，如 -3, 0, 42        |
| 浮点数 (`float`) | `y = 3.14`                     | 存储小数，如 3.14, -2.718     |
| 字符串 (`str`)   | `name = "Alice"`               | 存储文本数据                  |
| 布尔值 (`bool`)  | `t = True`                     | 存储逻辑值：`True` 或 `False` |
| 列表 (`list`)    | `fruits = ["apple", "banana"]` | 有序、可变集合                |
| 元组 (`tuple`)   | `tpl = (1, 2, 3)`              | 有序、不可变集合              |
| 字典 (`dict`)    | `d = {"key": "value"}`         | 键值对的集合                  |
| 集合 (`set`)     | `s = {1, 2, 3}`                | 无序、不重复的集合            |

---

## **第四部分：输入与输出**

#### **4.1 获取用户输入**
- 使用 `input()` 函数获取用户输入，并存储为字符串：
  ```python
  name = input("请输入您的姓名：")
  print(f"你好, {name}!")
  ```

#### **4.2 格式化输出**
- **使用 `f-string` 格式化**：
  ```python
  age = 25
  print(f"我今年 {age} 岁")
  ```

- **`format()` 方法**：
  ```python
  print("我叫 {}，今年 {} 岁".format("Alice", 25))
  ```

---

## **第五部分：Python 条件判断**

#### **5.1 if-elif-else 结构**
- **基本语法**：
  ```python
  x = int(input("输入一个整数："))
  if x > 0:
      print("这是正数")
  elif x == 0:
      print("这是零")
  else:
      print("这是负数")
  ```

#### **5.2 嵌套条件**
- 可以在条件语句内嵌套另一层 `if-else` 结构：
  ```python
  if x > 0:
      if x % 2 == 0:
          print("正偶数")
      else:
          print("正奇数")
  ```

---

## **第六部分：循环语句**

#### **6.1 for 循环**
- 遍历序列中的每个元素：
  ```python
  fruits = ["apple", "banana", "cherry"]
  for fruit in fruits:
      print(fruit)
  ```

- **使用 `range()` 生成整数序列**：
  ```python
  for i in range(5):
      print(i)  # 输出 0 到 4
  ```

#### **6.2 while 循环**
- 当条件为真时，反复执行代码块：
  ```python
  x = 0
  while x < 5:
      print(x)
      x += 1
  ```

#### **6.3 break 和 continue**
- **`break`**：提前退出循环。
  ```python
  for i in range(10):
      if i == 5:
          break
      print(i)
  ```

- **`continue`**：跳过当前循环的剩余部分，直接进入下一次循环。
  ```python
  for i in range(5):
      if i == 2:
          continue
      print(i)
  ```

---

## **第七部分：函数定义与调用**

#### **7.1 定义函数**
- 使用 `def` 关键字定义函数：
  ```python
  def greet(name):
      print(f"Hello, {name}!")
  greet("Alice")
  ```

#### **7.2 带返回值的函数**
- 使用 `return` 返回计算结果：
  ```python
  def add(a, b):
      return a + b
  
  result = add(3, 5)
  print(result)  # 输出 8
  ```

---

## **第八部分：Python 的异常处理**

#### **8.1 捕获异常**
- 使用 `try-except` 捕获异常，避免程序崩溃：
  ```python
  try:
      x = int(input("输入一个整数："))
      result = 10 / x
  except ValueError:
      print("请输入有效的整数")
  except ZeroDivisionError:
      print("除数不能为 0")
  ```

#### **8.2 finally 代码块**
- **`finally`** 中的代码无论是否发生异常都会执行：
  ```python
  try:
      f = open("data.txt", "r")
  except FileNotFoundError:
      print("文件未找到")
  finally:
      print("执行结束")
  ```

---

## **第九部分：文件操作**

#### **9.1 读取文件**
```python
with open("example.txt", "r") as f:
    content = f.read()
    print(content)
```

#### **9.2 写入文件**
```python
with open("example.txt", "w") as f:
    f.write("这是新内容")
```

#### **9.3 追加内容**
```python
with open("example.txt", "a") as f:
    f.write("\n追加的内容")
```

---

## **第十部分：Python 模块与包**

#### **10.1 导入模块**
- **导入整个模块**：
  ```python
  import math
  print(math.sqrt(16))
  ```

- **导入特定函数**：
  ```python
  from math import pi
  print(pi)
  ```

#### **10.2 自定义模块**
- 创建一个 `.py` 文件作为模块，并在主程序中导入：
  ```python
  # my_module.py
  def greet(name):
      print(f"Hello, {name}!")
  
  # main.py
  from my_module import greet
  greet("Alice")
  ```

---

## **第十一部分：Python 编程风格与最佳实践**

#### **11.1 遵循 PEP8 代码规范**
- **变量命名**：使用蛇形命名法，如 `my_variable`。
- **类名命名**：使用大驼峰命名法，如 `MyClass`。

#### **11.2 编写清晰的注释**
- 为复杂逻辑添加注释，帮助理解代码。

#### **11.3 避免全局变量**
- 封装变量在函数或类中，减少全局变量的使用。

---

## **第十二部分：完整代码示例**

```python
import math

def calculate_area(radius):
    """计算圆的面积"""
    if radius < 0:
        raise ValueError("半径不能为负")
    return math.pi * radius ** 2

try:
    r = float(input("请输入圆的半径："))
    area = calculate_area(r)
    print(f"圆的面积为：{area:.2f}")
except ValueError as e:
    print(e)
```

---

## **第十三部分：学习建议与总结**

1. **多动手实践**：通过编写和运行代码理解语法和逻辑。
2. **养成良好编码习惯**：遵循 PEP8 编程规范，提高代码可读性