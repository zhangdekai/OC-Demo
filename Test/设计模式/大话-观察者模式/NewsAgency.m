#import "NewsAgency.h"

@implementation NewsAgency

- (void)publishNews:(NSString *)news category:(NSString *)category {
    if (!news || !category) return;
    
    NSLog(@"新闻机构发布了新新闻: %@", news);
    // 发布新闻后通知所有观察者
    [self notifyObserversWithNews:news category:category];
}

@end
