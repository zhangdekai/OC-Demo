#import <Foundation/Foundation.h>

@interface Publisher : NSObject

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

/// 发布消息到指定主题
- (void)publishMessage:(id)message toTopic:(NSString *)topic;

@end
    