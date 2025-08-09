#import "TV.h"

@implementation TV

- (void)turnOn {
    NSLog(@"电视已开启");
}

- (void)turnOff {
    NSLog(@"电视已关闭");
}

- (void)setChannel:(NSInteger)channel {
    NSLog(@"电视频道切换到: %ld", (long)channel);
}

@end
