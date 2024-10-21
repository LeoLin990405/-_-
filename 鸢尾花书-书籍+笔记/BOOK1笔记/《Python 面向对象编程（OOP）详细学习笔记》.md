## **《Python 面向对象编程（OOP）详细学习笔记》**

---

## **1. 什么是面向对象编程 (OOP)?**

### **1.1 面向对象编程简介**
- **面向对象编程 (Object-Oriented Programming, OOP)** 是一种将**数据（属性）**和**行为（方法）**封装在一起的编程范式。  
- OOP 更符合人类的思维习惯，将现实世界的**实体**抽象为**对象**。每个对象都有**属性**（特征）和**方法**（行为）。

---

### **1.2 OOP 的四大核心概念**
1. **封装 (Encapsulation)**：将数据与操作数据的方法封装在类中，并隐藏内部实现细节。  
2. **继承 (Inheritance)**：子类继承父类的属性和方法，避免代码冗余。  
3. **多态 (Polymorphism)**：同一方法在不同对象上表现出不同行为。  
4. **抽象 (Abstraction)**：将复杂的逻辑隐藏起来，只暴露必要的接口。

---

## **2. 类与对象**

### **2.1 什么是类？**
- **类 (Class)** 是对象的蓝图或模板，定义了一类对象的属性和行为。

### **2.2 什么是对象？**
- **对象 (Object)** 是类的实例。通过类的模板，我们可以创建多个对象，每个对象拥有独立的数据。

---

### **2.3 定义类与创建对象**

#### **示例：定义一个类并创建对象**
```python
class Dog:
    # 构造函数，用于初始化属性
    def __init__(self, name, age):
        self.name = name  # 定义属性 name
        self.age = age    # 定义属性 age

    # 方法：打印狗的介绍
    def introduce(self):
        print(f"我是 {self.name}，今年 {self.age} 岁。")

# 创建对象
dog1 = Dog("小白", 2)
dog1.introduce()  # 输出：我是 小白，今年 2 岁。
```

---

## **3. 构造方法与析构方法**

### **3.1 构造方法 `__init__()`**
- **`__init__()`** 是 Python 的**构造方法**，在创建对象时自动调用，用于初始化属性。

#### **示例：使用构造方法初始化对象**
```python
class Car:
    def __init__(self, brand, model, year):
        self.brand = brand
        self.model = model
        self.year = year

# 创建对象并访问属性
car1 = Car("Toyota", "Camry", 2020)
print(car1.brand)  # 输出：Toyota
```

---

### **3.2 析构方法 `__del__()`**
- **`__del__()`** 是 Python 的**析构方法**，在对象销毁时自动调用，用于释放资源。

#### **示例：使用析构方法**
```python
class Person:
    def __init__(self, name):
        self.name = name
        print(f"{self.name} 已创建")

    def __del__(self):
        print(f"{self.name} 已被销毁")

p = Person("Alice")
del p  # 手动销毁对象
```

---

## **4. 类的属性与实例属性**

### **4.1 实例属性**
- 实例属性属于具体的对象，每个对象的实例属性是独立的。

#### **示例：定义和访问实例属性**
```python
class Student:
    def __init__(self, name, grade):
        self.name = name
        self.grade = grade

student1 = Student("Alice", 90)
print(student1.name)  # 输出：Alice
print(student1.grade)  # 输出：90
```

---

### **4.2 类属性**
- **类属性**属于类本身，所有对象共享同一个类属性。

#### **示例：定义和访问类属性**
```python
class Student:
    school = "Python Academy"  # 类属性

    def __init__(self, name):
        self.name = name  # 实例属性

student1 = Student("Alice")
student2 = Student("Bob")

print(student1.school)  # 输出：Python Academy
print(student2.school)  # 输出：Python Academy

# 修改类属性
Student.school = "New Academy"
print(student1.school)  # 输出：New Academy
```

---

## **5. 类方法与静态方法**

### **5.1 类方法**

- **类方法**使用 `@classmethod` 装饰，第一个参数为 `cls`，用于操作类属性。

#### **示例：定义类方法**
```python
class Animal:
    species = "动物"  # 类属性

    @classmethod
    def get_species(cls):
        return cls.species

print(Animal.get_species())  # 输出：动物
```

---

### **5.2 静态方法**

- **静态方法**使用 `@staticmethod` 装饰，不依赖实例或类。

#### **示例：定义静态方法**
```python
class Math:
    @staticmethod
    def add(a, b):
        return a + b

print(Math.add(3, 5))  # 输出：8
```

---

## **6. 继承与多态**

### **6.1 继承**

- **继承**允许子类复用父类的代码，并可以扩展新的功能。

#### **示例：继承**
```python
class Animal:
    def __init__(self, name):
        self.name = name

    def eat(self):
        print(f"{self.name} is eating.")

class Dog(Animal):
    def bark(self):
        print(f"{self.name} is barking.")

dog = Dog("Buddy")
dog.eat()  # 调用父类方法
dog.bark()  # 调用子类方法
```

---

### **6.2 多态**

- **多态**：子类可以重写父类的方法，调用时根据实际对象执行相应的方法。

#### **示例：多态**
```python
class Animal:
    def sound(self):
        pass

class Dog(Animal):
    def sound(self):
        print("汪汪")

class Cat(Animal):
    def sound(self):
        print("喵喵")

animals = [Dog(), Cat()]
for animal in animals:
    animal.sound()
```

---

## **7. 封装与私有属性**

### **7.1 封装**

- 使用双下划线 (`__`) 将属性设为**私有**，避免直接访问。

#### **示例：封装属性**
```python
class BankAccount:
    def __init__(self, owner, balance):
        self.owner = owner
        self.__balance = balance  # 私有属性

    def get_balance(self):
        return self.__balance

account = BankAccount("Alice", 1000)
print(account.get_balance())  # 输出：1000
# print(account.__balance)  # 报错：无法访问私有属性
```

---

## **8. 属性装饰器：`@property`**

- 使用 `@property` 将方法转换为**只读属性**。

#### **示例：使用 `@property`**
```python
class Circle:
    def __init__(self, radius):
        self._radius = radius

    @property
    def radius(self):
        return self._radius

    @radius.setter
    def radius(self, value):
        if value >= 0:
            self._radius = value
        else:
            print("半径不能为负")

c = Circle(5)
print(c.radius)  # 输出：5
c.radius = 10
print(c.radius)  # 输出：10
```

---

## **9. 抽象类与接口**

- **抽象类**定义接口，但不能实例化，需要子类实现具体方法。

#### **示例：抽象类**
```python
from abc import ABC, abstractmethod

class Shape(ABC):
    @abstractmethod
    def area(self):
        pass

class Circle(Shape):
    def __init__(self, radius):
        self.radius = radius

    def area(self):
        return 3.14 * self.radius ** 2

c = Circle(5)
print(c.area())  # 输出：78.5
```

---

## **10. 总结与练习**

1. **练习题**：创建一个 `Person` 类，并实现年龄计算方法。
2. **练习题**：实现一个 `Vehicle` 类，并通过继承创建 `Car` 和 `Bike`。

---

这份超详细的 Python 面向对象编程笔记涵盖了 OOP 的所有重要概念与应用。通过不断实践，你将能熟练掌握 OOP 的思想，并在项目中灵活应用。如果有疑问，请随时联系我！