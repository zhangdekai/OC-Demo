#import <Foundation/Foundation.h>
#import "CommandProtocol.h"
#import "FamilyTV.h"

// 具体命令：打开电视
@interface TVOnCommand : NSObject <CommandProtocol>

- (instancetype)initWithTV:(FamilyTV *)tv;

@end
