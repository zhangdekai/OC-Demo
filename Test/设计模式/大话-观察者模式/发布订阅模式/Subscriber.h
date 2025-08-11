#import <Foundation/Foundation.h>

@interface Subscriber : NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

/// 订阅指定主题
- (void)subscribeToTopic:(NSString *)topic;

/// 取消订阅指定主题
- (void)unsubscribeFromTopic:(NSString *)topic;

/// 取消所有订阅
- (void)unsubscribeAll;

@end
    