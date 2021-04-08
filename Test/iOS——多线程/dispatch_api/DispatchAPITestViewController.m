//
//  DispatchBarrierViewController.m
//  iOS多线程
//
//  Created by zhang dekai on 2019/12/1.
//  Copyright © 2019 zhang dekai. All rights reserved.
//

#import "DispatchAPITestViewController.h"

@interface DispatchAPITestViewController ()

@property (nonatomic, copy) NSString *tempS;

@property (nonatomic, strong) dispatch_semaphore_t sem;

@end



@implementation DispatchAPITestViewController



- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self testBarrier];
//    [self testDispatchApply];
//    [self testSignl];
//    [self testNSInvocationOperation];
    [self addButton];
    
    _tempS = @"1111";
    
}

- (void)addButton {
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 30)];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn setTitle:@"设置" forState:UIControlStateNormal];
    
    [btn addTarget:self action:@selector(setNumber) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)setNumber {
    
    _tempS = @"1923";
    
    NSLog(@"setNumber = %@", _tempS);
    
    BOOL a = [self returnResult];
    
    NSLog(@"a = %d", a);
    
}

- (BOOL)returnResult {
    
    
    _sem = dispatch_semaphore_create(0);
    
    __block BOOL a = false;

    NSLog(@"out a = %d",a);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
            
            NSLog(@"3秒后");
            
            a = true;

            dispatch_semaphore_signal(self.sem);

        });
    // 此处需要配合 延迟中 异步线程 dispatch_get_global_queue 来使用，否则，使用 main的话，会阻塞主线程。
    dispatch_semaphore_wait(_sem, DISPATCH_TIME_FOREVER);

    return a;
}

- (void)handleA:(void (^ __nullable)(BOOL finished))completion  {
    
    completion(true);
    
//    [UIView animateWithDuration:(NSTimeInterval) animations:^{
//        <#code#>
//    } completion:^(BOOL finished) {
//        <#code#>
//    }]
}



//MARK: - dispatch_barrier_sync 同步阻塞，先执行前边的任务
- (void)testBarrier {
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        sleep(3);
        NSLog(@"task - A");
    });
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"task - B");
    });
    
    NSLog(@"before barrier");
    
    dispatch_barrier_sync(queue,^{//同步阻塞，先执行前边的任务，也可以通过别的同步手段处理
        NSLog(@"task - new");
    });
    
    NSLog(@"after barrier");
    
    dispatch_async(queue, ^{
        sleep(2);
        NSLog(@"task - C");
    });
    
    dispatch_async(queue, ^{
        sleep(1);
        NSLog(@"task - D");
    });
    
    /*
     before barrier
     task - B
     task - A
     task - new
     after barrier
     task - D
     task - C
     */
}

//MARK: - dispatch_apply:是同步的,可以在主线程走任务,如果想异步可以在外面包一层
- (void)testDispatchApply {
    
    NSLog(@"----1");
    NSArray *array = @[@"1",@"2",@"3",@"4"];
    
    dispatch_apply(array.count, dispatch_get_global_queue(0, 0), ^(size_t index) {
           
           NSLog(@"queue 并行 ——Thread：%@",[NSThread currentThread]);

           NSLog(@"元素：%@----第%ld次", array[index],index);
           
       });
    
    NSLog(@"----2");

    
    dispatch_queue_t queue = dispatch_queue_create("com.iosmuti.serial", DISPATCH_QUEUE_SERIAL);
    
    dispatch_apply(array.count, queue, ^(size_t index) {
        
        NSLog(@"queue 串行——Thread：%@",[NSThread currentThread]);

        
        NSLog(@"元素：%@----第%ld次", array[index],index);

    });
    
    NSLog(@"----3");
    
    dispatch_queue_t main = dispatch_get_main_queue();
    
    dispatch_apply(array.count, main, ^(size_t index) {//ps:同步 阻塞主线程
        
        NSLog(@"queue 串行——Thread：%@",[NSThread currentThread]);

        
        NSLog(@"元素：%@----第%ld次", array[index],index);

    });
    
    NSLog(@"----4");

    
    /*
     queue 并行 ——Thread：<NSThread: 0x600000eb72c0>{number = 6, name = (null)}
     2019-12-10 12:11:34.638541+0800 iOS多线程[4170:118583] queue 并行 ——Thread：<NSThread: 0x600000eb8940>{number = 5, name = (null)}
     2019-12-10 12:11:34.638538+0800 iOS多线程[4170:118579] queue 并行 ——Thread：<NSThread: 0x600000eb2300>{number = 3, name = (null)}
     2019-12-10 12:11:34.638565+0800 iOS多线程[4170:118478] queue 并行 ——Thread：<NSThread: 0x600000ef1cc0>{number = 1, name = main}
     2019-12-10 12:11:34.638668+0800 iOS多线程[4170:118579] 元素：4----第3次
     2019-12-10 12:11:34.638668+0800 iOS多线程[4170:118578] 元素：2----第1次
     2019-12-10 12:11:34.638669+0800 iOS多线程[4170:118583] 元素：3----第2次
     2019-12-10 12:11:34.638758+0800 iOS多线程[4170:118478] 元素：1----第0次
     2019-12-10 12:11:34.639054+0800 iOS多线程[4170:118478] queue 串行——Thread：<NSThread: 0x600000ef1cc0>{number = 1, name = main}
     2019-12-10 12:11:34.639259+0800 iOS多线程[4170:118478] 元素：1----第0次
     2019-12-10 12:11:34.639471+0800 iOS多线程[4170:118478] queue 串行——Thread：<NSThread: 0x600000ef1cc0>{number = 1, name = main}
     2019-12-10 12:11:34.639667+0800 iOS多线程[4170:118478] 元素：2----第1次
     2019-12-10 12:11:34.639881+0800 iOS多线程[4170:118478] queue 串行——Thread：<NSThread: 0x600000ef1cc0>{number = 1, name = main}
     2019-12-10 12:11:34.640097+0800 iOS多线程[4170:118478] 元素：3----第2次
     2019-12-10 12:11:34.640322+0800 iOS多线程[4170:118478] queue 串行——Thread：<NSThread: 0x600000ef1cc0>{number = 1, name = main}
     2019-12-10 12:11:34.640526+0800 iOS多线程[4170:118478] 元素：4----第3次
     */
}

//MARK: - 信号量  //可实现类似 dispatch enter的功能。
- (void)testSignl {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    
    dispatch_group_async(group, queue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(3);
            NSLog(@"完成1");
            dispatch_semaphore_signal(semaphore);
        });
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(2);
            NSLog(@"完成2");
            dispatch_semaphore_signal(semaphore);
        });
    });
    
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"全部完成");
    });
    
    // 完成2  完成1 全部完成
    
}

//MARK: - 信号量dispatch_semaphore_t 实现线程依赖
- (void)testSignalDependence {
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create(NULL, DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_semaphore_t semaphore0 = dispatch_semaphore_create(0);
    dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);
    
    dispatch_group_async(group, queue, ^{
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:3];
            NSLog(@"完成1");
            dispatch_semaphore_signal(semaphore0);
        });
    });
    
    dispatch_group_async(group, queue, ^{
        
        //等待semaphore0的任务先完成，线程依赖（需要创建多个信号量），略有啰嗦。
        dispatch_semaphore_wait(semaphore0, DISPATCH_TIME_FOREVER);
        
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [NSThread sleepForTimeInterval:2];
            NSLog(@"完成2");
            dispatch_semaphore_signal(semaphore1);
        });
    });
    
    
    dispatch_group_notify(group, queue, ^{
        dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
        NSLog(@"全部完成");
    });
    // 完成1 完成2 全部完成
}

- (void)testGCD {
    
    dispatch_block_t block = ^{
        // 任务 打印字符串
        NSLog(@"GCD 的一个简单block，无参 无返回值的");
    };
    dispatch_queue_t queue = dispatch_queue_create("com.film.test", NULL);
    dispatch_async(queue, block);
    
    
    dispatch_async(queue, ^{
        // 任务 打印字符串
        NSLog(@"GCD 的一个简单block，无参 无返回值的");
    });
}

//MARK: - NSInvocationOperation
- (void)testNSInvocationOperation {
    // 处理事务
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self
    selector:@selector(handleInvocation:) object:@"Felix"];
    // 创建队列
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    // 操作加入队列
    [queue addOperation:op];
}

- (void)handleInvocation:(id)operation {
    NSLog(@"%@ --- %@",operation, [NSThread currentThread]);
}

@end
