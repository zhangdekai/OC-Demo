//
//  KVCTestClass.m
//  Test
//
//  Created by zhang dekai on 2019/12/15.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KVCTestClass.h"
#import "Person.h"
#import "Book.h"

/*
 键值编码（key value coding）NSObject的扩展方法集
 常用方法：https://www.jianshu.com/p/f70a2d19677d
 */


@implementation KVCTestClass

- (void)testKVC {
    
    [self setValue:@"测试01" forKey:@"key"];
    
    //使用valueForKeyPath:用来访问多层嵌套的字典是比较方便的
    Person *person = [[Person alloc]init];
    person.name = @"你好呀";
    [self setValue:@"person类的属性" forKeyPath:@"person.name"];
    
    
    NSError *error = nil;
    NSString *value = @"value";
    
    BOOL result = [self validateValue:&value forKeyPath:@"person.name" error:&error];
    
    if ( error ) {
        NSLog(@"error = %@", error);
    }
    
    if ( result ) {
        NSLog(@"validate success");
    } else {
        NSLog(@"validate failure");
    }
    
    [self test01];
    [self test02];
    
    
}

#pragma mark - NSkeyValueCoding

#pragma mark - setter  getter
- (void)setValue:(id)value forKey:(NSString *)key {
    
}

- (id)valueForKey:(NSString *)key {
    return @"test";
}

- (void)setValue:(id)value forKeyPath:(NSString *)keyPath {
    
}

- (id)valueForKeyPath:(NSString *)keyPath {
    return @"test";
}

#pragma mark NSMutableArray - NSkeyValueCoding
- (NSMutableArray *)mutableArrayValueForKey:(NSString *)key {
    NSMutableArray *array = [NSMutableArray array];
    return array;
}



#pragma mark - 多值赋值取值
- (NSDictionary<NSString *,id> *)dictionaryWithValuesForKeys:(NSArray<NSString *> *)keys {
    
    NSDictionary *dict = [NSDictionary dictionary];
    
    return dict;
}

- (void)setValuesForKeysWithDictionary:(NSDictionary<NSString *,id> *)keyedValues {
    
}


#pragma mark - 异常处理
- (void)setNilValueForKey:(NSString *)key {
    
    NSLog(@"这里处理当赋值为nil时，出现异常");
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"key没有定义的时候，可以在这里处理");
    
}

- (id)valueForUndefinedKey:(NSString *)key {
    
    NSLog(@"这是未找到定义的key");
    
    return nil;  //注意如果是某个非对象的属性赋值为 nil 时，抛出 NSInvalidArgumentException 的异常并崩溃，重写下面的方法- (void)setNilValueForKey:(NSString *)key;处理
    
}

#pragma mark - 验证属性key对应的Value是否可用。
- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKey:(NSString *)inKey error:(out NSError *__autoreleasing  _Nullable *)outError {
    
    NSString *name = *ioValue;
    
    if ([name isEqualToString:@"value"]) {
        return YES;
    }
    
    return NO;
}

- (BOOL)validateValue:(inout id  _Nullable __autoreleasing *)ioValue forKeyPath:(NSString *)inKeyPath error:(out NSError *__autoreleasing  _Nullable *)outError {
    NSString *name = *ioValue;
    
    if ([name isEqualToString:@"person类的属性"]) {
        return YES;
    }
    return NO;
}

#pragma mark - 消息的多层传递

- (void)test01 {
    NSLog(@"——————消息的多层传递:");
    NSArray *arr = @[@"apple", @"orange", @"pear", @"grape"];
    NSArray *capitalizedStringArr = [arr valueForKey:@"capitalizedString"];
    NSLog(@"capitalizedStringArr = %@", capitalizedStringArr);
    
    //取得了每个字符串的 length
    NSArray *capitalizedStringLengthArr = [arr valueForKeyPath:@"capitalizedString.length"];
    
    NSLog(@"capitalizedStringLengthArr = %@", capitalizedStringLengthArr);
    
    NSArray *arr1 = @[@"10", @"11", @"12", @"13"];
    //NSString 的属性length
    NSArray *capitalizedStringArr1 = [arr1 valueForKey:@"length"];
    NSLog(@"capitalizedStringArr1 = %@", capitalizedStringArr1);
    
    NSArray *capitalizedStringLengthArr1 = [arr1 valueForKeyPath:@"capitalizedString.length"];
    
    NSLog(@"capitalizedStringLengthArr1 = %@", capitalizedStringLengthArr1);
    
    
    //    NSString
    
    
    /*
     ——————消息的多层传递:
     2019-12-16 10:24:03.027195+0800 Test[2390:60263] capitalizedStringArr = (
     Apple,
     Orange,
     Pear,
     Grape
     )
     2019-12-16 10:24:03.027497+0800 Test[2390:60263] capitalizedStringLengthArr = (
     5,
     6,
     4,
     5
     )
     */
}

#pragma mark - 简单集合运算 @avg， @count ， @max ， @min ，@sum5 对象运算符:
- (void)test02 {
    // 简单集合运算符共有@avg， @count ， @max ， @min ，@sum5种
    
    Book *book1 = [Book new];
    book1.name = @"The Great Gastby";
    book1.price = 10;
    Book *book2 = [Book new];
    book2.name = @"Time History";
    book2.price = 20;
    Book *book3 = [Book new];
    book3.name = @"Wrong Hole";
    book3.price = 30;
    
    Book *book4 = [Book new];
    book4.name = @"Wrong Hole";
    book4.price = 40;
    
    NSArray* arrBooks = @[book1,book2,book3,book4];
    NSNumber* sum = [arrBooks valueForKeyPath:@"@sum.price"];
    NSLog(@"sum:%f",sum.floatValue);
    NSNumber* avg = [arrBooks valueForKeyPath:@"@avg.price"];
    NSLog(@"avg:%f",avg.floatValue);
    NSNumber* count = [arrBooks valueForKeyPath:@"@count"];
    NSLog(@"count:%f",count.floatValue);
    NSNumber* min = [arrBooks valueForKeyPath:@"@min.price"];
    NSLog(@"min:%f",min.floatValue);
    NSNumber* max = [arrBooks valueForKeyPath:@"@max.price"];
    NSLog(@"max:%f",max.floatValue);
    /*
     打印结果：
     2018-05-05 17:04:50.674243+0800 KVCKVO[35785:6351239] sum:100.000000
     2018-05-05 17:04:50.675007+0800 KVCKVO[35785:6351239] avg:25.000000
     2018-05-05 17:04:50.675081+0800 KVCKVO[35785:6351239] count:4.000000
     2018-05-05 17:04:50.675146+0800 KVCKVO[35785:6351239] min:10.000000
     2018-05-05 17:04:50.675204+0800 KVCKVO[35785:6351239] max:40.000000
     链接：https://www.jianshu.com/p/b9f020a8b4c9
     */
#pragma mark 对象运算符 distinctUnionOfObjects  unionOfObjects
    
    //它们的返回值都是NSArray，区别是前者返回的元素都是唯一的，是去重以后的结果；后者返回的元素是全集
    
    NSLog(@"distinctUnionOfObjects");
    NSArray* arrDistinct = [arrBooks valueForKeyPath:@"@distinctUnionOfObjects.price"];
    for (NSNumber *price in arrDistinct) {
        NSLog(@"%f",price.floatValue);
    }
    NSLog(@"unionOfObjects");
    NSArray* arrUnion = [arrBooks valueForKeyPath:@"@unionOfObjects.price"];
    for (NSNumber *price in arrUnion) {
        NSLog(@"%f",price.floatValue);
    }
}

@end


