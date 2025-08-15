#import <Foundation/Foundation.h>
#import "Command.h"
#import "FamilyTV.h"

// 具体命令：关闭电视
@interface TVOffCommand : NSObject <Command>

- (instancetype)initWithTV:(FamilyTV *)tv;

@end
