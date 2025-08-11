#import "NewsApp.h"

@implementation NewsApp

- (instancetype)initWithAppID:(NSString *)appID {
    self = [super init];
    if (self) {
        _appID = [appID copy];
    }
    return self;
}

- (void)onNewsUpdate:(NSString *)news category:(NSString *)category {
    NSLog(@"新闻应用《%@》收到%@新闻: %@，推送通知给用户", self.appID, category, news);
}

@end
