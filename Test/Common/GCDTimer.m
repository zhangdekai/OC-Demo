#import "GCDTimer.h"

@interface GCDTimer ()
@property (nonatomic, strong) dispatch_source_t timerSource;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, assign) BOOL repeats;
@property (nonatomic, strong) dispatch_queue_t queue;
@property (nonatomic, copy) void(^handler)(void);
@end

@implementation GCDTimer

+ (instancetype)initWithInterval:(NSTimeInterval)interval repeats:(BOOL)repeats handler:(void (^)(void))handler{
    
    return [[GCDTimer alloc]initWithInterval:interval repeats:repeats queue:nil handler:handler];
}

- (instancetype)initWithInterval:(NSTimeInterval)interval
                         repeats:(BOOL)repeats
                           queue:(dispatch_queue_t)queue
                         handler:(void(^)(void))handler {
    self = [super init];
    if (self) {
        _interval = interval;
        _repeats = repeats;
        _queue = queue ?: dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        _handler = [handler copy];
        
        // 创建定时器源
        _timerSource = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, _queue);
        
        // 设置定时器参数（精度为0.1秒，避免过度消耗CPU）
        uint64_t intervalNanoseconds = (uint64_t)(_interval * NSEC_PER_SEC);
        dispatch_source_set_timer(_timerSource,
                                  dispatch_time(DISPATCH_TIME_NOW, 0),
                                  intervalNanoseconds,
                                  100 * NSEC_PER_MSEC); // 允许的误差范围
        
        // 设置定时器触发事件
        __weak typeof(self) weakSelf = self;
        dispatch_source_set_event_handler(_timerSource, ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf && strongSelf->_handler) {
                strongSelf->_handler();
            }
            
            // 如果不重复，执行一次后自动销毁
            if (!strongSelf->_repeats) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [strongSelf invalidate];
                });
            }
        });
    }
    return self;
}

- (void)start {
    if (self.timerSource) {
        dispatch_resume(self.timerSource);
    }
}

- (void)pause {
    if (self.timerSource) {
        dispatch_suspend(self.timerSource);
    }
}

- (void)reset {
    [self pause];
    [self start];
}

- (void)invalidate {
    if (self.timerSource) {
        dispatch_source_cancel(self.timerSource);
        self.timerSource = nil;
        self.handler = nil;
    }
}

- (void)dealloc {
    [self invalidate];
}

#pragma Test

- (void)testTimer{
    // 创建并启动一个每秒执行一次的定时器
    GCDTimer *timer = [[GCDTimer alloc] initWithInterval:1.0
                                                 repeats:YES
                                                   queue:dispatch_get_main_queue()
                                                 handler:^{
        
        NSLog(@"定时器触发 %@", [NSDate date]);
        // 在这里执行定时任务，如更新UI、数据刷新等
    }];
    
    
    [timer start];
    
    // 暂停定时器（例如在页面消失时）
    // [timer pause];
    
    // 重置定时器（重新开始计时）
    // [timer reset];
    
    // 销毁定时器（例如在页面销毁时）
    // [timer invalidate];
}

//MARK: - 使用GCD也可是创建计时器，而且更为精确
/// GCD定时器
- (void)aGCDTimer {
    //创建队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    //1.创建一个GCD定时器
    /*
     第一个参数:表明创建的是一个定时器
     第四个参数:队列
     */
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 需要对timer进行强引用，保证其不会被释放掉，才会按时调用block块
    // 局部变量，让指针强引用
    self.timerSource = timer;
    //2.设置定时器的开始时间,间隔时间,精准度
    /*
     第1个参数:要给哪个定时器设置
     第2个参数:开始时间
     第3个参数:间隔时间
     第4个参数:精准度 一般为0 在允许范围内增加误差可提高程序的性能
     GCD的单位是纳秒 所以要*NSEC_PER_SEC
     */
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 2.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    //3.设置定时器要执行的事情
    dispatch_source_set_event_handler(timer, ^{
        NSLog(@"---%@--",[NSThread currentThread]);
    });
    // 启动
    dispatch_resume(timer);
    
}


@end
