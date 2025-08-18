// Agent.h
#import <Foundation/Foundation.h>
#import "StarProtocol.h"
#import "MovieStar.h"

// 代理对象：经纪人（控制对明星的访问，添加额外逻辑）
@interface Agent : NSObject <StarProtocol>

// 持有目标对象（明星）的引用
@property (nonatomic, strong) MovieStar *star;

- (instancetype)initWithStar:(MovieStar *)star;

@end

// Agent.m
#import "Agent.h"

@implementation Agent

- (instancetype)initWithStar:(MovieStar *)star {
    if (self = [super init]) {
        _star = star;
    }
    return self;
}

// 代理商演：添加前期沟通和后期收款逻辑
- (void)commercialPerformance {
    NSLog(@"经纪人：与主办方沟通商演细节，确认流程和费用...");
    
    // 调用目标对象的实际业务
    [self.star commercialPerformance];
    NSLog(@"经纪人：商演结束，与主办方结算费用...\n");
}

// 代理拍广告：添加筛选品牌和合同签订逻辑
- (void)shootAdvertisement {
    NSLog(@"经纪人：筛选合适的品牌，洽谈广告合作细节...");
    
    // 调用目标对象的实际业务
    [self.star shootAdvertisement];
    NSLog(@"经纪人：广告拍摄完成，跟进尾款支付...\n");
}
@end
