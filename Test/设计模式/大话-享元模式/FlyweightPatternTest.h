#import <Foundation/Foundation.h>
#import "CharacterFlyweightFactory.h"
#import "CharacterFlyweight.h"

int testFlyweightPatternMain(void) {
    @autoreleasepool {
        // 创建享元工厂
        CharacterFlyweightFactory *factory = [[CharacterFlyweightFactory alloc] init];
        
        // 获取字符享元并显示，相同样式的字符会被复用
        CharacterFlyweight *a1 = [factory getFlyweightWithSymbol:@"A" font:@"Arial" size:12];
        [a1 displayAtX:10 y:20];
        
        CharacterFlyweight *a2 = [factory getFlyweightWithSymbol:@"A" font:@"Arial" size:12];
        [a2 displayAtX:30 y:20];
        
        CharacterFlyweight *b1 = [factory getFlyweightWithSymbol:@"B" font:@"Arial" size:12];
        [b1 displayAtX:50 y:20];
        
        CharacterFlyweight *a3 = [factory getFlyweightWithSymbol:@"A" font:@"Times" size:14];
        [a3 displayAtX:10 y:50];
        
        // 输出已创建的享元数量
        NSLog(@"总共创建了 %ld 个享元对象", (long)[factory flyweightCount]);
    }
    return 0;
}
