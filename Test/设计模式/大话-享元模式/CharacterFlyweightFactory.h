#import <Foundation/Foundation.h>
#import "CharacterFlyweight.h"

// 享元工厂：负责创建和管理享元对象
@interface CharacterFlyweightFactory : NSObject

// 获取或创建字符享元
- (CharacterFlyweight *)getFlyweightWithSymbol:(NSString *)symbol 
                                          font:(NSString *)font 
                                          size:(NSInteger)size;

// 获取已创建的享元数量
- (NSInteger)flyweightCount;

@end
