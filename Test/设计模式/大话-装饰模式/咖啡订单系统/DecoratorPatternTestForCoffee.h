#import <Foundation/Foundation.h>
#import "Coffee.h"
#import "ConcreteCondiments.h"

/*
 代码解析

 这个例子完美展示了装饰模式的四个核心角色：

 1. 抽象组件（Component）：Beverage 类
 
 定义了所有饮料的基本接口（描述和价格）
 是被装饰者和装饰者的共同父类
 
 2. 具体组件（ConcreteComponent）：Espresso、Americano、Latte 类
 这些是具体的咖啡种类，是被装饰的对象
 实现了基类的抽象方法，提供了基础价格和描述
 
 3. 抽象装饰器（Decorator）：CondimentDecorator 类
 继承自 Beverage，保证了接口一致性
 持有一个 Beverage 对象的引用，这个对象可以是具体咖啡或其他装饰器
 提供了基础实现，子类可以在此基础上扩展
 
 4. 具体装饰器（ConcreteDecorator）：Milk、Sugar、Chocolate、Foam 类
 每个类代表一种配料，负责给饮料添加特定功能
 在重写的方法中，先调用被装饰对象的方法，再添加自己的功能（价格和描述）

 */

int testDecortorPatternCoffeeMain(void) {
    @autoreleasepool {
        // 1. 点一杯纯的浓缩咖啡
        Beverage *espresso = [[Espresso alloc] init];
        NSLog(@"订单: %@, 价格: ¥%.2f", espresso.description, espresso.cost);
        
        // 2. 点一杯加牛奶和糖的美式咖啡
        Beverage *americano = [[Americano alloc] init];
        americano = [[Milk alloc] initWithBeverage:americano]; // 加牛奶
        americano = [[Sugar alloc] initWithBeverage:americano]; // 加糖
        NSLog(@"订单: %@, 价格: ¥%.2f", americano.description, americano.cost);
        
        // 3. 点一杯加巧克力、牛奶和奶泡的拿铁
        Beverage *latte = [[Latte alloc] init];
        latte = [[Chocolate alloc] initWithBeverage:latte]; // 加巧克力
        latte = [[Milk alloc] initWithBeverage:latte]; // 加牛奶
        latte = [[Foam alloc] initWithBeverage:latte]; // 加奶泡
        NSLog(@"订单: %@, 价格: ¥%.2f", latte.description, latte.cost);
        
        // 4. 动态添加更多配料 - 给上面的拿铁再加一份糖
        latte = [[Sugar alloc] initWithBeverage:latte];
        NSLog(@"订单: %@, 价格: ¥%.2f", latte.description, latte.cost);
    }
    return 0;
}
