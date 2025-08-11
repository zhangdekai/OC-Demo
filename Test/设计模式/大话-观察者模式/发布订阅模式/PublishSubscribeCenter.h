#import <Foundation/Foundation.h>

/// 订阅者接收消息的回调block
typedef void(^SubscriptionBlock)(id message);

@interface PublishSubscribeCenter : NSObject

/// 单例方法
+ (instancetype)sharedCenter;

/// 订阅指定主题
/// @param topic 主题名称
/// @param subscriber 订阅者
/// @param block 接收消息的回调
- (void)subscribeToTopic:(NSString *)topic
              subscriber:(id)subscriber
                  block:(SubscriptionBlock)block;

/// 取消订阅指定主题
/// @param topic 主题名称
/// @param subscriber 订阅者
- (void)unsubscribeFromTopic:(NSString *)topic
                  subscriber:(id)subscriber;

/// 取消订阅者的所有订阅
/// @param subscriber 订阅者
- (void)unsubscribeAllForSubscriber:(id)subscriber;

/// 发布消息到指定主题
/// @param topic 主题名称
/// @param message 消息内容
- (void)publishToTopic:(NSString *)topic
               message:(id)message;

@end
    