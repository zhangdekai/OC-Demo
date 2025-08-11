#import "FLACAdapter.h"

@implementation FLACAdapter {
    FLACPlayer *_flacPlayer;
}

- (instancetype)initWithFLACPlayer:(FLACPlayer *)player {
    self = [super init];
    if (self) {
        _flacPlayer = player;
    }
    return self;
}

// 实现目标接口，内部调用适配者的方法
- (void)playAudioWithFileName:(NSString *)fileName {
    // 可以在这里进行一些格式转换或路径处理
    [_flacPlayer startFLACPlaybackWithFile:fileName];
}

@end
