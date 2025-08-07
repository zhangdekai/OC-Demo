#import <Foundation/Foundation.h>
#import "User.h"

int testPrototypeMain(void) {
    @autoreleasepool {
        // 1. 创建原始对象（原型）
        ProtoTypeUser *originalUser = [[ProtoTypeUser alloc] initWithName:@"张三" age:25];
        NSLog(@"原始对象: %@", originalUser);
        
        // 2. 通过复制原型创建新对象（无需再次调用复杂的初始化方法）
        ProtoTypeUser *copiedUser = [originalUser copy];
        NSLog(@"复制对象: %@", copiedUser);
        
        // 3. 修改复制对象的属性（不影响原始对象）
        copiedUser.name = @"李四";
        copiedUser.age = 30;
        NSLog(@"修改后的复制对象: %@", copiedUser);
        NSLog(@"原始对象（未受影响）: %@", originalUser);
    }
    return 0;
}
