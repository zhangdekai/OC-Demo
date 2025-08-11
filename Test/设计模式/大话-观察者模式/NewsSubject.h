#import <Foundation/Foundation.h>
#import "NewsObserverProtocol.h"

@interface NewsSubject : NSObject

/**
 添加观察者
 
 @param observer 要添加的观察者
 */
- (void)addObserver:(id<NewsObserverProtocol>)observer;

/**
 移除观察者
 
 @param observer 要移除的观察者
 */
- (void)removeObserver:(id<NewsObserverProtocol>)observer;

/**
 通知所有观察者有新闻更新
 
 @param news 新闻内容
 @param category 新闻分类
 */
- (void)notifyObserversWithNews:(NSString *)news category:(NSString *)category;

@end
