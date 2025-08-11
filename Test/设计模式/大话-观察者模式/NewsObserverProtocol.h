#import <Foundation/Foundation.h>

@protocol NewsObserverProtocol <NSObject>
/**
 接收新闻更新通知
 
 @param news 最新新闻内容
 @param category 新闻分类
 */
- (void)onNewsUpdate:(NSString *)news category:(NSString *)category;
@end
