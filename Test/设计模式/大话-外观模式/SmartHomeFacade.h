#import <Foundation/Foundation.h>
#import "AirConditioner.h"
#import "TV.h"
#import "Curtain.h"

@interface SmartHomeFacade : NSObject

- (instancetype)initWithAirConditioner:(AirConditioner *)ac
                                    tv:(TV *)tv
                               curtain:(Curtain *)curtain;

// 回家模式
- (void)homeMode;

// 离家模式
- (void)awayMode;

// 观影模式
- (void)movieMode;

@end
