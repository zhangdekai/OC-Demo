//
//  DispatchGroupViewController.m
//  iOS多线程
//
//  Created by zhang dekai on 2019/11/26.
//  Copyright © 2019 zhang dekai. All rights reserved.
//

#import "DispatchGroupViewController.h"

@interface DispatchGroupViewController ()

@property(nonatomic, strong)NSMutableArray *imagesArray;

@end

@implementation DispatchGroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imagesArray = [NSMutableArray array];
    // Do any additional setup after loading the view.
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 创建队列组
    dispatch_group_t group = dispatch_group_create();
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    
    // 添加异步任务
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务1-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务2-%@", [NSThread currentThread]);
        }
    });
    
    // 等前面的任务执行完毕后，会自动执行这个任务
//    dispatch_group_notify(group, queue, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            for (int i = 0; i < 5; i++) {
//                NSLog(@"任务3-%@", [NSThread currentThread]);
//            }
//        });
//    });
    
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        for (int i = 0; i < 5; i++) {
//            NSLog(@"任务3-%@", [NSThread currentThread]);
//        }
//    });
    
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务3-%@", [NSThread currentThread]);
        }
    });
    
    dispatch_group_notify(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务4-%@", [NSThread currentThread]);
        }
    });
    
    // dispatch_group_wait:同步操作，不推荐使用。
    // dispatch_group_wait(group, DISPATCH_TIME_FOREVER);//一直等待。
    
    
}

- (void)testDispatchGroupEnter {
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t queue = dispatch_queue_create("com.iosMultiThread.groupenter", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(4);
            NSLog(@"模拟请求1-----%@", [NSThread currentThread]);
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_async(group, queue, ^{
        dispatch_group_enter(group);
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            sleep(3);
            NSLog(@"模拟请求2-----%@", [NSThread currentThread]);
            dispatch_group_leave(group);
        });
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"全部结束-----%@", [NSThread currentThread]);
    });
    
    /*
     
     全部开始-----<NSThread: 0x60000007e980>{number = 1, name = main}
     模拟请求2-----<NSThread: 0x604000460840>{number = 3, name = (null)}
     模拟请求1-----<NSThread: 0x6000004676c0>{number = 4, name = (null)}
     全部结束-----<NSThread: 0x60000007e980>{number = 1, name = main}
     
     */
    
    
}

/// GCD 上传20张图片； 伪代码
- (void)testUploadImg{
    // 1. 获取全局并发队列（或创建自定义并发队列）
    // 自定义队列可控制并发数，全局队列并发数由系统管理
    dispatch_queue_t uploadQueue = dispatch_queue_create("com.example.imageUpload", DISPATCH_QUEUE_CONCURRENT);

    // 限制最大并发数（可选，避免同时发起太多网络请求）
    // 最多同时5个上传任务
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(5);

    // 2. 创建分组，监听所有任务完成
    dispatch_group_t group = dispatch_group_create();

    // 3. 遍历20张图片，异步执行上传
    for (int i = 0; i < 20 && [_imagesArray count] >= 20 ; i++) {
        // 进入分组
        dispatch_group_enter(group);
        
        // 异步执行上传任务
        dispatch_async(uploadQueue, ^{
            // 等待信号量（控制并发数）
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
            
            // 获取当前图片（假设图片已提前加载到数组中）
            UIImage *image = [self.imagesArray objectAtIndex:i];
            
            // 执行上传逻辑（模拟网络请求，实际项目中替换为真实上传接口）
            [self uploadImage:image index:i completion:^(BOOL success) {
                if (success) {
                    NSLog(@"第%d张图片上传成功", i);
                } else {
                    NSLog(@"第%d张图片上传失败", i);
                }
                
                // 发送信号量，允许新任务执行
                dispatch_semaphore_signal(semaphore);
                
                // 离开分组（任务完成）
                dispatch_group_leave(group);
            }];
        });
    }

    // 4. 所有任务完成后回调（回到主线程处理结果）
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"20张图片全部上传完成");
        // 这里可以更新UI，如显示上传完成提示
    });
}

// 模拟图片上传（实际项目中替换为AFNetworking等网络库）
- (void)uploadImage:(UIImage *)image index:(NSInteger)index completion:(void(^)(BOOL success))completion {
    // 模拟网络延迟（1-3秒）
    double delay = 1 + (arc4random_uniform(3) * 0.5);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{
        // 模拟上传结果（随机成功/失败）
        BOOL success = arc4random_uniform(10) > 1; // 90%成功率
        completion(success);
    });
}

/// NSOperationQueue 版 伪代码
- (void)testUploadImgByNSOperation{
    // 1. 创建操作队列，设置最大并发数
    NSOperationQueue *uploadQueue = [[NSOperationQueue alloc] init];
    uploadQueue.maxConcurrentOperationCount = 5; // 最多同时5个任务

    // 2. 遍历20张图片，创建上传操作
    for (int i = 0; i < 20; i++) {
        // 创建块操作
        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            // 自动释放池，避免内存占用过高
            @autoreleasepool {
                // 获取当前图片
                UIImage *image = [self.imagesArray objectAtIndex:i];
                
                // 同步执行上传（注意：block内部需同步执行，否则操作会立即完成）
                __block BOOL success = NO;
                dispatch_semaphore_t sem = dispatch_semaphore_create(0);
                
                // 执行上传（模拟网络请求）
                [self uploadImage:image index:i completion:^(BOOL finishSuccess) {
                    success = finishSuccess;
                    dispatch_semaphore_signal(sem);
                }];
                
                // 等待上传完成
                dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
                
                // 输出结果
                if (success) {
                    NSLog(@"第%d张图片上传成功", i);
                } else {
                    NSLog(@"第%d张图片上传失败", i);
                }
            }
        }];
        
        // 3. 设置操作完成回调（可选）
        [operation setCompletionBlock:^{
            // 单个任务完成后的处理（注意：此回调在子线程执行）
        }];
        
        // 4. 添加到队列
        [uploadQueue addOperation:operation];
    }

    // 5. 监听所有任务完成（回到主线程）
    dispatch_async(dispatch_get_main_queue(), ^{
        [uploadQueue addBarrierBlock:^{
            // 所有任务完成后执行（注意：barrierBlock在队列所有任务完成后执行）
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"20张图片全部上传完成");
                // 更新UI
            });
        }];
    });
}

/*
 上传20张图片
 关键注意事项：

 1. 控制并发数：同时上传的任务数不宜过多（建议 3-5 个），否则会导致网络竞争，反而降低效率。
 
 2. 线程安全：如果上传过程中需要修改共享数据（如成功计数），需通过 @synchronized 或 GCD 信号量保证线程安全。
 
 3. 错误处理：实际项目中需处理网络错误、超时等情况，可加入重试机制。
 
 4. UI 更新：所有 UI 操作（如进度条更新）必须在主线程执行，通过 dispatch_async(dispatch_get_main_queue(), ^{}) 切换。
 
 哪种方式更合适？

 1. 优先选 GCD：代码更简洁，性能略优，适合大多数上传场景。
 2. 选 NSOperationQueue：当需要取消任务、设置优先级或依赖关系时（如某张图片必须在另一张之后上传），更具优势。
 */


@end
