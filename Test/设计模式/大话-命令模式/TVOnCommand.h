#import <Foundation/Foundation.h>
#import "Command.h"
#import "FamilyTV.h"

// 具体命令：打开电视
@interface TVOnCommand : NSObject <Command>

- (instancetype)initWithTV:(FamilyTV *)tv;

@end
