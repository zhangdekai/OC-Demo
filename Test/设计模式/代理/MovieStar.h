// MovieStar.h
#import <Foundation/Foundation.h>
#import "StarProtocol.h"

// 目标对象：电影明星（真正执行业务的对象）
@interface MovieStar : NSObject <StarProtocol>

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

@end

// MovieStar.m
#import "MovieStar.h"

@implementation MovieStar
- (instancetype)initWithName:(NSString *)name {
    if (self = [super init]) {
        _name = name;
    }
    return self;
}

// 实现商演业务
- (void)commercialPerformance {
    NSLog(@"%@ 正在进行商演，演唱热门歌曲...", self.name);
}

// 实现拍广告业务
- (void)shootAdvertisement {
    NSLog(@"%@ 正在拍摄品牌广告，展示产品...", self.name);
}
@end
