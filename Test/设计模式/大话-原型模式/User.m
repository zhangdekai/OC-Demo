#import "User.h"

@implementation ProtoTypeUser

// 初始化方法
- (instancetype)initWithName:(NSString *)name age:(NSInteger)age {
    if (self = [super init]) {
        _name = [name copy];
        _age = age;
    }
    return self;
}

// 实现 NSCopying 协议的方法，定义复制规则
- (id)copyWithZone:(NSZone *)zone {
    // 创建新对象（使用 zone 分配内存，通常传 nil 即可）
    ProtoTypeUser *copyUser = [[[self class] allocWithZone:zone] init];
    // 复制原有对象的属性（此处为浅复制，因 name 是不可变字符串，age 是基本类型）
    copyUser.name = self.name;
    copyUser.age = self.age;
    return copyUser;
}

// 重写 description 方便打印
- (NSString *)description {
    return [NSString stringWithFormat:@"User{name: %@, age: %ld}", self.name, (long)self.age];
}

@end
