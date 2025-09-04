#import <Foundation/Foundation.h>

@interface GCDTimer : NSObject

/// 创建定时器
/// @param interval 时间间隔（秒）
/// @param repeats 是否重复
/// @param queue 执行队列（nil则默认在全局队列）
/// @param handler 定时器触发回调
- (instancetype)initWithInterval:(NSTimeInterval)interval
                         repeats:(BOOL)repeats
                           queue:(dispatch_queue_t)queue
                         handler:(void(^)(void))handler;


+ (instancetype)initWithInterval:(NSTimeInterval)interval
                         repeats:(BOOL)repeats
                         handler:(void(^)(void))handler;

/// 启动定时器
- (void)start;

/// 暂停定时器
- (void)pause;

/// 重置定时器（重新开始计时）
- (void)reset;

/// 销毁定时器
- (void)invalidate;

@end
