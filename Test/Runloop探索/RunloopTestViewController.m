//
//  RunloopTestViewController.m
//  Test
//
//  Created by 张德凯 on 2018/8/2.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "RunloopTestViewController.h"
#import "NSObject+addProperty.h"

@interface RunloopTestViewController ()

@property (nonatomic, assign) dispatch_source_t timer;
@property (nonatomic, strong) NSThread *thread;

@end

@implementation RunloopTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*   // Foundation
     [NSRunLoop currentRunLoop]; // 获得当前线程的RunLoop对象
     [NSRunLoop mainRunLoop]; // 获得主线程的RunLoop对象
     
     //Core Foundation
     CFRunLoopGetCurrent(); // 获得当前线程的RunLoop对象
     CFRunLoopGetMain(); // 获得主线程的RunLoop对象
     
     */
    
    UIButton *takePhoto = [[UIButton alloc]initWithFrame:CGRectMake(100, 200, 100, 30)];
    [takePhoto setTitle:@"测试线程常驻" forState:0];
    [takePhoto setTitleColor:[UIColor blackColor] forState:0];
    [self.view addSubview:takePhoto];
    [takePhoto addTarget:self action:@selector(btnClick:) forControlEvents:(UIControlEventTouchUpInside)];
    
    NSObject *testAdditionalProperty = [[NSObject alloc]init];
    testAdditionalProperty.name = @"测试哦";
}

/// 保持线程存活
/// 子线程如果不主动开启 RunLoop，执行完任务就退出。
/// 通过 RunLoop 可以让子线程常驻，随时处理任务。
/// 若需子线程长期处理任务（如后台下载、定时回调）
- (void)startThread {
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"子线程开始");
        
        /// 增加一个 timer 事件
        /// 
        
        // 开启 RunLoop，保持线程存活
        [[NSRunLoop currentRunLoop] run];
    }];
    [thread start];
}

/// 子线程 Runloop 示例：维持线程存活
- (void)dispatchThread {
    // 子线程中启动 Runloop
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        /// 1. 首次获取 Runloop，触发创建（懒加载）
        NSRunLoop *runloop = [NSRunLoop currentRunLoop];
        
        /// 2. 注册事件（必须添加事件，否则 Runloop 会立即退出）
        /// 若 Runloop 未注册任何 Source/Timer，调用 run() 会立即退出（因为无事件可处理）
        NSTimer *timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"子线程 Timer 触发");
        }];
        [runloop addTimer:timer forMode:NSRunLoopCommonModes];
        
        // 3. 启动 Runloop（以特定 Mode 运行，直到超时或被停止）
        // 方式1：无限运行（需手动调用 CFRunLoopStop 停止）
        [runloop run];
        
        // 方式2：有限运行（到指定时间后自动退出）
        [runloop runMode:NSRunLoopCommonModes beforeDate:[NSDate distantFuture]];
    });
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"点击了屏幕");
    
    [self threadKeepByRunloop];
    
}

//线程常驻 （子线程执行完毕就会被销毁，无法常驻）
- (void)threadKeepByRunloop {
    
    NSThread *thread = [[NSThread alloc]initWithTarget:self selector:@selector(keepSubThread) object:nil];
    thread.name = @"这是测试，线程常驻";
    self.thread = thread;
    [thread start];
}

- (CFRunLoopObserverRef)addRunloopObserverTest {
    return CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
            default:
                break;
        }
    });
}

- (void)keepSubThread {
    
    // 注意：打印方法一定要在RunLoop创建开始运行之前，如果在RunLoop跑起来之后打印，RunLoop先运行起来，已经在跑圈了就出不来了，进入死循环也就无法执行后面的操作了。
    // 但是此时点击Button还是有操作的，因为Button是在RunLoop跑起来之后加入到子线程的，当Button加入到子线程RunLoop就会跑起来
    
    NSLog(@"打印方法：%s",__func__);//p:打印方法：-[RunloopTestViewController keepSubThread]
    
    // 1.创建子线程相关的RunLoop，在子线程中创建即可，并且RunLoop中要至少有一个Timer 或 一个Source 保证RunLoop不会因为空转而退出，因此在创建的时候直接加入
    
    // 添加Source [NSMachPort port] 添加一个端口
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    
    // 添加一个Timer
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    //创建监听者
    CFRunLoopObserverRef observer = [self addRunloopObserverTest];
    
    // 给RunLoop添加监听者
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);

    // 2.子线程需要开启RunLoop
    [[NSRunLoop currentRunLoop] run];
    CFRelease(observer);
}

- (void)btnClick:(UIButton *)sender {
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

-(void)test
{
    NSLog(@"%@",[NSThread currentThread]);
}

// performSelector默认是在default模式下运行，因此在滑动ScrollView时，图片不会加载
- (void)imageViewShow {
    
    // [self.imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@"abc"] afterDelay:2.0 ];
    // inModes: 传入Mode数组
    
    UIImageView *imageView = [[UIImageView alloc]init];
    [imageView performSelector:@selector(setImage:) withObject:[UIImage imageNamed:@""] afterDelay:2.0 inModes:@[NSDefaultRunLoopMode,UITrackingRunLoopMode]];
    
}

- (void)setImage:(UIImageView *)imageView {
//    imageView.image =
}


//MARK:- NSTimer 失效原因
- (void)aNormalTimer
{
    NSTimer *timer1 = [NSTimer timerWithTimeInterval:2.0 target:self selector:@selector(show) userInfo:nil repeats:YES];
    
    // 加入到RunLoop中才可以运行
    // 1. 把定时器添加到RunLoop中，并且选择默认运行模式NSDefaultRunLoopMode = kCFRunLoopDefaultMode
    // [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    // 当textFiled滑动的时候，timer失效，停止滑动时，timer恢复
    // 原因：当textFiled滑动的时候，RunLoop的Mode会自动切换成UITrackingRunLoopMode模式，因此timer失效，当停止滑动，RunLoop又会切换回NSDefaultRunLoopMode模式，因此timer又会重新启动了
    
    // 2. 当我们将timer添加到UITrackingRunLoopMode模式中，此时只有我们在滑动textField时timer才会运行
    // [[NSRunLoop mainRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    
    // 3. 那个如何让timer在两个模式下都可以运行呢？
    // 3.1 在两个模式下都添加timer 是可以的，但是timer添加了两次，并不是同一个timer
    // 3.2 使用站位的运行模式 NSRunLoopCommonModes标记，凡是被打上NSRunLoopCommonModes标记的都可以运行，下面两种模式被打上标签
    //0 : <CFString 0x10b7fe210 [0x10a8c7a40]>{contents = "UITrackingRunLoopMode"}
    //2 : <CFString 0x10a8e85e0 [0x10a8c7a40]>{contents = "kCFRunLoopDefaultMode"}
    
    // 因此也就是说如果我们使用NSRunLoopCommonModes，timer可以在UITrackingRunLoopMode，kCFRunLoopDefaultMode两种模式下运行
    
    //NSRunLoopCommonModes :这是一个占位用的Mode，作为标记kCFRunLoopDefaultMode和UITrackingRunLoopMode用，并不是一种真正的Mode
    [[NSRunLoop mainRunLoop] addTimer:timer1 forMode:NSRunLoopCommonModes];
    
    NSLog(@"%@",[NSRunLoop mainRunLoop]);
    
}

- (void)addAObserver {
    //创建监听者
    /*
     第一个参数 CFAllocatorRef allocator：分配存储空间 CFAllocatorGetDefault()默认分配
     第二个参数 CFOptionFlags activities：要监听的状态 kCFRunLoopAllActivities 监听所有状态
     第三个参数 Boolean repeats：YES:持续监听 NO:不持续
     第四个参数 CFIndex order：优先级，一般填0即可
     第五个参数 ：回调 两个参数observer:监听者 activity:监听的事件
     */
    /*
     所有事件
     typedef CF_OPTIONS(CFOptionFlags, CFRunLoopActivity) {
     kCFRunLoopEntry = (1UL << 0),   //   即将进入RunLoop
     kCFRunLoopBeforeTimers = (1UL << 1), // 即将处理Timer
     kCFRunLoopBeforeSources = (1UL << 2), // 即将处理Source
     kCFRunLoopBeforeWaiting = (1UL << 5), //即将进入休眠
     kCFRunLoopAfterWaiting = (1UL << 6),// 刚从休眠中唤醒
     kCFRunLoopExit = (1UL << 7),// 即将退出RunLoop
     kCFRunLoopAllActivities = 0x0FFFFFFFU
     };
     */
    
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"RunLoop进入");
                break;
            case kCFRunLoopBeforeTimers:
                NSLog(@"RunLoop要处理Timers了");
                break;
            case kCFRunLoopBeforeSources:
                NSLog(@"RunLoop要处理Sources了");
                break;
            case kCFRunLoopBeforeWaiting:
                NSLog(@"RunLoop要休息了");
                break;
            case kCFRunLoopAfterWaiting:
                NSLog(@"RunLoop醒来了");
                break;
            case kCFRunLoopExit:
                NSLog(@"RunLoop退出了");
                break;
            default:
                break;
        }
    });
    
    // 给RunLoop添加监听者
    /*
     第一个参数 CFRunLoopRef rl：要监听哪个RunLoop,这里监听的是主线程的RunLoop
     第二个参数 CFRunLoopObserverRef observer 监听者
     第三个参数 CFStringRef mode 要监听RunLoop在哪种运行模式下的状态
     */
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    
    //    CFRunLoopAddTimer(<#CFRunLoopRef rl#>, <#CFRunLoopTimerRef timer#>, <#CFRunLoopMode mode#>)
    //    CFRunLoopAddSource(<#CFRunLoopRef rl#>, <#CFRunLoopSourceRef source#>, <#CFRunLoopMode mode#>)
    
    
    /*
     CF的内存管理（Core Foundation）
     凡是带有Create、Copy、Retain等字眼的函数，创建出来的对象，都需要在最后做一次release
     GCD本来在iOS6.0之前也是需要我们释放的，6.0之后GCD已经纳入到了ARC中，所以我们不需要管了
     */
    CFRelease(observer);
    
}

- (void)stopTheRunloop {
    //
    
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:1000 * 100];
    
    [[NSRunLoop currentRunLoop]runUntilDate:date];//到达指定时间，便会退出
    
    [[NSRunLoop currentRunLoop]runMode:NSDefaultRunLoopMode beforeDate:date];
}

-(void)show {
    NSLog(@"-------");
}

/// NSTimer
/// 定时器依赖 RunLoop，如果 RunLoop 被阻塞或者处于其他 Mode，定时器可能不触发。
///

- (void)testTimer {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                     target:self
                                   selector:@selector(timerAction)
                                   userInfo:nil
                                    repeats:YES];
    /// 如果你希望 Timer 在滚动时也能触发，需要把它加到 NSRunLoopCommonModes：
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    
}

-(void)timerAction {
    NSLog(@"test timer in NSRunLoopCommonModes");
}

@end
