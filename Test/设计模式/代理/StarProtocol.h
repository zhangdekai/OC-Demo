// StarProtocol.h
#import <Foundation/Foundation.h>

// 抽象主题：明星相关业务接口
@protocol StarProtocol <NSObject>
// 商演
- (void)commercialPerformance;
// 拍广告
- (void)shootAdvertisement;
@end
