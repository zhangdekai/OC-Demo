//
//  OCLockTestViewController.m
//  Test
//
//  Created by zhang dekai on 2021/3/5.
//  Copyright © 2021 张德凯. All rights reserved.
//

#import "OCLockTestViewController.h"

#import <pthread/pthread.h>


@interface OCLockTestViewController ()

@property(nonatomic, strong)dispatch_queue_t concurrentQueue;
@property(nonatomic, strong)NSMutableArray *testArray;

@end

@implementation OCLockTestViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.concurrentQueue = dispatch_queue_create("com.rwlock.test", 0);

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}
/*
 
 读写锁实际是一种特殊的自旋锁，它把对共享资源的访问者划分成读者和写者，读者只对共享资源进行读访问，写者则需要对共享资源进行写操作。这种锁相对于自旋锁而言，能提高并发性，因为在多处理器系统中，它允许同时有多个读者来访问共享资源，最大可能的读者数为实际的CPU数

 写者是排他性的，⼀个读写锁同时只能有⼀个写者或多个读者（与CPU数相关），但不能同时既有读者⼜有写者。在读写锁保持期间也是抢占失效的
 如果读写锁当前没有读者，也没有写者，那么写者可以⽴刻获得读写锁，否则它必须⾃旋在那⾥，直到没有任何写者或读者。如果读写锁没有写者，那么读者可以⽴即获得该读写锁，否则读者必须⾃旋在那⾥，直到写者释放该读写锁

 */

//MARK: - 读写锁
- (void)readWriteLock {
    
    // 全局声明读写锁
    pthread_rwlock_t lock;
    // 初始化读写锁
    pthread_rwlock_init(&lock, NULL);
    // 读操作-加锁
    pthread_rwlock_rdlock(&lock);
    // 读操作-尝试加锁
    pthread_rwlock_tryrdlock(&lock);
    // 写操作-加锁
    pthread_rwlock_wrlock(&lock);
    // 写操作-尝试加锁
    pthread_rwlock_trywrlock(&lock);
    // 解锁
    pthread_rwlock_unlock(&lock);
    // 释放锁
    pthread_rwlock_destroy(&lock);
}

//MARK: - 栅栏函数实现 读写锁
- (id)readDataForKey:(NSString*)key {
    __block id result;
    dispatch_sync(_concurrentQueue, ^{ // 并发同步
        result = [self valueForKey:key];
    });
    return result;
}


- (void)writeData:(id)data forKey:(NSString*)key {
    dispatch_barrier_async(_concurrentQueue, ^{
        [self setValue:data forKey:key]; // 写
    });
}

//MARK: - 互斥锁
//YYKit的YYMemoryCach有使用到pthread_mutex

- (void)testMutexLock {
    // 全局声明互斥锁
    pthread_mutex_t _lock;
    // 初始化互斥锁
    pthread_mutex_init(&_lock, NULL);
    // 加锁
    pthread_mutex_lock(&_lock);
    // 这里做需要线程安全操作
    // ...
    // 解锁
    pthread_mutex_unlock(&_lock);
    // 释放锁
    pthread_mutex_destroy(&_lock);

}

//MARK: - NSLock
//NSLock是对互斥锁的简单封装。

- (void)testNSLock {
    self.testArray = [NSMutableArray array];
    NSLock *lock = [[NSLock alloc] init];
    for (int i = 0; i < 200000; i++) {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            [lock lock];
            self.testArray = [NSMutableArray array];
            [lock unlock];
        });
    }
}

//MARK: - NSRecursiveLock 递归锁

- (void)test {
    NSRecursiveLock *lock = [[NSRecursiveLock alloc] init];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        static void (^block)(int);
        
        block = ^(int value) {
            [lock lock];
            if (value > 0) {
                NSLog(@"value——%d", value);
                block(value - 1);
            }
            [lock unlock];
        };
        block(10);
    });
    
}


@end
