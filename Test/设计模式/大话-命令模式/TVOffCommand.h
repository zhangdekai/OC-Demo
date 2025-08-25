#import <Foundation/Foundation.h>
#import "CommandProtocol.h"
#import "FamilyTV.h"

// 具体命令：关闭电视
@interface TVOffCommand : NSObject <CommandProtocol>

- (instancetype)initWithTV:(FamilyTV *)tv;

@end
