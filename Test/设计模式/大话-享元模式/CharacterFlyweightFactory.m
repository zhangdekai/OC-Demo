#import "CharacterFlyweightFactory.h"
#import <pthread.h>

/// 由于多个线程可能同时访问或修改共享资源（如享元对象缓存、外部状态数据），
/// 需要通过同步机制确保操作的原子性。

@implementation CharacterFlyweightFactory {
    NSMutableDictionary *_flyweights; // 存储享元对象的缓存
    dispatch_queue_t _cacheQueue;// 串行队列
    pthread_rwlock_t rwLock; // 读写锁
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _flyweights = [NSMutableDictionary dictionary];
        
        /// 1. 创建 _cacheQueue 用来解决，多线程访问 _flyweights 时的线程安全问题，数据竞态
        /// 将缓存的所有操作（读 / 写） dispatch 到同一个串行队列，确保操作串行执行
        _cacheQueue = dispatch_queue_create("com.example.flyweight.data", DISPATCH_QUEUE_SERIAL);
        
        /// 2. 读写锁（pthread_rwlock）：读操作并发执行，写操作互斥，
        /// 适合读多写少的场景（性能优于串行队列）
        pthread_rwlock_init(&rwLock, NULL); // 初始化读写锁
        
    }
    return self;
}

- (CharacterFlyweight *)getFlyweightWithSymbol:(NSString *)symbol 
                                          font:(NSString *)font
                                          size:(NSInteger)size {
    // 创建唯一键，用于标识相同内部状态的享元
    NSString *key = [NSString stringWithFormat:@"%@-%@-%ld", symbol, font, (long)size];
    
    // 检查缓存中是否已有该享元
    CharacterFlyweight *flyweight = _flyweights[key];
    
    return [self flyweightWithKey:key];
    
}

// 获取享元对象（线程安全 串行队）: 同步的方式解决安全问题
- (CharacterFlyweight *)flyweightWithKey:(NSString *)key {
    __block CharacterFlyweight *temp;
    // 同步读取缓存
    dispatch_sync(_cacheQueue, ^{
        temp = _flyweights[key];
        if (!temp) {
            // 如果没有，则创建新的享元并加入缓存
            // 缓存未命中时创建对象（写操作）
            temp = [[CharacterFlyweight alloc] init];
            _flyweights[key] = temp;
            NSLog(@"创建新的享元: %@", key);
        } else {
            NSLog(@"复用已有享元: %@", key);
        }
    });
    return temp;
}
// 获取享元对象（线程安全 读写锁）
- (CharacterFlyweight *)flyweightWithKey1:(NSString *)key {
    CharacterFlyweight *temp;
    
    // 加读锁（允许多线程同时读）
    pthread_rwlock_rdlock(&rwLock);
    temp = _flyweights[key];
    pthread_rwlock_unlock(&rwLock);// 释放读锁
    
    if (!temp) {
        // 如果没有，则创建新的享元并加入缓存
        // 缓存未命中时创建对象（写操作）
        // 加写锁（仅允许单线程写）
        pthread_rwlock_wrlock(&rwLock);
        
        if(!_flyweights[key]){
            // 二次检查（避免多线程同时通过首次检查后重复创建）
            temp = [[CharacterFlyweight alloc] init];
            _flyweights[key] = temp;
            NSLog(@"创建新的享元: %@", key);
        } else {
            temp = _flyweights[key];
        }
        pthread_rwlock_unlock(&rwLock); // 释放写锁
        
    } else {
        NSLog(@"复用已有享元: %@", key);
    }
    return temp;
}

- (NSInteger)flyweightCount {
    return _flyweights.count;
}

- (void)dealloc {
    pthread_rwlock_destroy(&rwLock); // 销毁锁
}

@end
