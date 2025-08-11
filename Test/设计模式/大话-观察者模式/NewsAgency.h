#import "NewsSubject.h"

@interface NewsAgency : NewsSubject

/**
 发布新闻
 
 @param news 新闻内容
 @param category 新闻分类
 */
- (void)publishNews:(NSString *)news category:(NSString *)category;

@end
