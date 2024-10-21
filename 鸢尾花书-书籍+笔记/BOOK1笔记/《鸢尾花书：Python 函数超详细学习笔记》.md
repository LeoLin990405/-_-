## **《鸢尾花书：Python 函数超详细学习笔记》**

---

## **第一部分：什么是函数？**

### **1.1 函数的概念**
- **函数**是执行特定任务的**代码块**，将一段代码封装起来，通过调用执行任务。
- **模块化思想**：函数将复杂程序划分为小单元，方便复用和维护。

### **1.2 为什么使用函数？**
1. **避免重复代码**：减少冗余，提高代码质量。
2. **提高可读性**：将代码逻辑模块化，便于理解。
3. **易于维护**：将任务分解为独立函数，简化调试。

---

## **第二部分：Python 函数的基本结构**

### **2.1 函数的定义与调用**
#### **定义函数**
```python
def function_name(parameters):
    """这是一个文档字符串，用于描述函数的功能。"""
    # 代码块
    return result  # 可选
```

#### **调用函数**
```python
def greet(name):
    print(f"Hello, {name}!")

greet("Alice")  # 输出：Hello, Alice!
```

### **2.2 函数的组成部分**
1. **`def`**：定义函数的关键字。
2. **函数名**：标识符，遵循变量命名规则。
3. **参数**：输入给函数的变量（可选）。
4. **函数体**：执行的代码块。
5. **`return`**：返回结果（可选）。

---

## **第三部分：参数详解**

### **3.1 位置参数**
- 参数根据顺序传递。
```python
def add(a, b):
    return a + b

print(add(3, 5))  # 输出：8
```

### **3.2 关键字参数**
- 使用参数名进行传递，顺序无关。
```python
def greet(name, message="Hello"):
    print(f"{message}, {name}!")

greet(name="Alice", message="Hi")  # 输出：Hi, Alice!
```

### **3.3 默认参数**
- 给参数提供默认值。
```python
def greet(name="Guest"):
    print(f"Hello, {name}!")

greet()  # 输出：Hello, Guest!
```

### **3.4 可变参数：`*args` 和 `**kwargs`**

#### **`*args`：传递不定数量的位置参数**
```python
def multiply(*args):
    result = 1
    for num in args:
        result *= num
    return result

print(multiply(2, 3, 4))  # 输出：24
```

#### **`**kwargs`：传递不定数量的关键字参数**
```python
def describe_person(**kwargs):
    for key, value in kwargs.items():
        print(f"{key}: {value}")

describe_person(name="Alice", age=25, city="New York")
```

---

## **第四部分：返回值**

### **4.1 返回单个值**
```python
def square(num):
    return num ** 2

print(square(4))  # 输出：16
```

### **4.2 返回多个值**
- 返回多个值作为**元组**。
```python
def arithmetic_operations(a, b):
    return a + b, a - b, a * b, a / b

add, sub, mul, div = arithmetic_operations(10, 2)
print(add, sub, mul, div)  # 输出：12 8 20 5.0
```

---

## **第五部分：变量作用域**

### **5.1 局部变量**
- 在函数内声明，只能在函数内部使用。
```python
def func():
    local_var = 5
    print(local_var)

func()  # 输出：5
```

### **5.2 全局变量**
- 在函数外部声明，可在整个程序中访问。
```python
global_var = 10

def func():
    print(global_var)

func()  # 输出：10
```

### **5.3 使用 `global` 修改全局变量**
```python
count = 0

def increment():
    global count
    count += 1

increment()
print(count)  # 输出：1
```

---

## **第六部分：递归函数**

### **6.1 什么是递归？**
- **递归**是函数**调用自身**，解决分解问题。

#### **示例：阶乘**
```python
def factorial(n):
    if n == 0:
        return 1
    return n * factorial(n - 1)

print(factorial(5))  # 输出：120
```

---

## **第七部分：Lambda 函数**

### **7.1 定义 Lambda 函数**
- **Lambda** 是匿名函数，用于简化代码。
```python
square = lambda x: x ** 2
print(square(5))  # 输出：25
```

### **7.2 Lambda 函数与内置函数结合使用**
- **`map()`**：将函数应用于序列的每个元素。
```python
numbers = [1, 2, 3]
squares = list(map(lambda x: x ** 2, numbers))
print(squares)  # 输出：[1, 4, 9]
```

- **`filter()`**：筛选符合条件的元素。
```python
even_numbers = list(filter(lambda x: x % 2 == 0, numbers))
print(even_numbers)  # 输出：[2]
```

---

## **第八部分：异常处理与函数**

### **8.1 捕获异常**
```python
def divide(a, b):
    try:
        result = a / b
    except ZeroDivisionError:
        print("除数不能为 0")
        return None
    return result

print(divide(10, 2))  # 输出：5.0
```

---

## **第九部分：函数作为参数**

### **9.1 高阶函数**
- 函数可以作为**参数传递**给其他函数。
```python
def apply_function(func, value):
    return func(value)

print(apply_function(lambda x: x ** 2, 5))  # 输出：25
```

---

## **第十部分：模块与包**

### **10.1 创建模块**
- 将函数保存为 `.py` 文件，作为模块导入使用。

#### **示例：模块 math_tools.py**
```python
# 文件：math_tools.py
def add(a, b):
    return a + b
```

#### **使用模块**
```python
import math_tools
print(math_tools.add(3, 5))  # 输出：8
```

---

## **第十一部分：装饰器（Decorator）**

### **11.1 装饰器的概念**
- **装饰器**在函数执行前后执行额外逻辑。

#### **示例：定义装饰器**
```python
def log_decorator(func):
    def wrapper(*args, **kwargs):
        print(f"调用函数：{func.__name__}")
        result = func(*args, **kwargs)
        print("函数调用结束")
        return result
    return wrapper

@log_decorator
def greet(name):
    print(f"Hello, {name}!")

greet("Alice")
```

---

## **第十二部分：练习与总结**

### **12.1 练习**
1. **递归实现斐波那契数列**：
```python
def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n - 1) + fibonacci(n - 2)

for i in range(10):
    print(fibonacci(i), end=" ")
```

2. **创建模块并使用**：实现基本的加减乘除运算，并在主程序中调用模块。

---

## **总结**
- Python 的**函数**是程序设计的重要组成部分，能够提升代码的可读性和可复用性。
- 掌握**参数传递、递归、Lambda、装饰器**等高级技巧，能写出更高效的代码。
- **模块与包**的使用使代码更加模块化和结构化，有利于团队开发。

这份笔记涵盖了 Python 函数的**核心知识和高级技巧**。通过实践这些内容，你将熟练掌握函数在实际项目中的应用。如果你有任何疑问，请随时联系我！