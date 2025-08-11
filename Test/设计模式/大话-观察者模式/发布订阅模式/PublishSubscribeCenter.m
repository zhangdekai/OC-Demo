#import "PublishSubscribeCenter.h"

@interface Subscription : NSObject

@property (nonatomic, weak) id subscriber;
@property (nonatomic, copy) SubscriptionBlock block;

- (instancetype)initWithSubscriber:(id)subscriber block:(SubscriptionBlock)block;

@end

@implementation Subscription

- (instancetype)initWithSubscriber:(id)subscriber block:(SubscriptionBlock)block {
    self = [super init];
    if (self) {
        _subscriber = subscriber;
        _block = block;
    }
    return self;
}

@end

@interface PublishSubscribeCenter ()

/// 存储主题与订阅者的映射关系
/// key: 主题名称(NSString)
/// value: 订阅数组(NSArray<Subscription *>)
@property (nonatomic, strong) NSMutableDictionary<NSString *, NSMutableArray<Subscription *> *> *topics;

@end

@implementation PublishSubscribeCenter

+ (instancetype)sharedCenter {
    static PublishSubscribeCenter *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[PublishSubscribeCenter alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _topics = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)subscribeToTopic:(NSString *)topic
              subscriber:(id)subscriber
                   block:(SubscriptionBlock)block {
    if (!topic || !subscriber || !block) {
        return;
    }
    
    // 确保主题对应的数组存在
    if (!self.topics[topic]) {
        self.topics[topic] = [NSMutableArray array];
    }
    
    // 检查是否已经订阅，避免重复订阅
    NSMutableArray<Subscription *> *subscriptions = self.topics[topic];
    for (Subscription *sub in subscriptions) {
        if (sub.subscriber == subscriber) {
            return;
        }
    }
    
    // 添加新的订阅
    Subscription *newSubscription = [[Subscription alloc] initWithSubscriber:subscriber block:block];
    [subscriptions addObject:newSubscription];
}

- (void)unsubscribeFromTopic:(NSString *)topic
                  subscriber:(id)subscriber {
    if (!topic || !subscriber) {
        return;
    }
    
    NSMutableArray<Subscription *> *subscriptions = self.topics[topic];
    if (subscriptions) {
        // 遍历移除指定订阅者的订阅
        for (NSInteger i = subscriptions.count - 1; i >= 0; i--) {
            Subscription *sub = subscriptions[i];
            if (sub.subscriber == subscriber || sub.subscriber == nil) {
                [subscriptions removeObjectAtIndex:i];
            }
        }
        
        // 如果主题下已没有订阅者，移除该主题
        if (subscriptions.count == 0) {
            [self.topics removeObjectForKey:topic];
        }
    }
}

- (void)unsubscribeAllForSubscriber:(id)subscriber {
    if (!subscriber) {
        return;
    }
    
    // 遍历所有主题，移除该订阅者的所有订阅
    NSArray *topics = [self.topics allKeys];
    for (NSString *topic in topics) {
        [self unsubscribeFromTopic:topic subscriber:subscriber];
    }
}

- (void)publishToTopic:(NSString *)topic
               message:(id)message {
    if (!topic) {
        return;
    }
    
    NSMutableArray<Subscription *> *subscriptions = self.topics[topic];
    if (subscriptions && subscriptions.count > 0) {
        // 复制一份避免在遍历中修改数组
        NSArray *copiedSubscriptions = [subscriptions copy];
        
        for (Subscription *sub in copiedSubscriptions) {
            // 检查订阅者是否还存在（避免野指针）
            if (sub.subscriber && sub.block) {
                // 在主线程执行回调，确保UI操作安全
                dispatch_async(dispatch_get_main_queue(), ^{
                    sub.block(message);
                });
            } else if (!sub.subscriber) {
                // 移除已释放的订阅者
                [subscriptions removeObject:sub];
            }
        }
    }
}

@end

