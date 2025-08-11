#import "NewsSubject.h"

@implementation NewsSubject {
    NSMutableArray<id<NewsObserverProtocol>> *_observers;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _observers = [NSMutableArray array];
    }
    return self;
}

- (void)addObserver:(id<NewsObserverProtocol>)observer {
    if (observer && ![_observers containsObject:observer]) {
        [_observers addObject:observer];
        NSLog(@"添加新的观察者: %@", observer.class);
    }
}

- (void)removeObserver:(id<NewsObserverProtocol>)observer {
    if (observer && [_observers containsObject:observer]) {
        [_observers removeObject:observer];
        NSLog(@"移除观察者: %@", observer.class);
    }
}

- (void)notifyObserversWithNews:(NSString *)news category:(NSString *)category {
    if (!news || !category) return;
    
    NSLog(@"开始通知所有观察者，新闻分类: %@", category);
    // 遍历所有观察者并发送通知
    for (id<NewsObserverProtocol> observer in _observers) {
        if ([observer respondsToSelector:@selector(onNewsUpdate:category:)]) {
            [observer onNewsUpdate:news category:category];
        }
    }
}

@end
