#import "Newspaper.h"

@implementation Newspaper

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = [name copy];
    }
    return self;
}

- (void)onNewsUpdate:(NSString *)news category:(NSString *)category {
    NSLog(@"报纸《%@》收到%@新闻: %@，准备排版印刷", self.name, category, news);
}

@end
