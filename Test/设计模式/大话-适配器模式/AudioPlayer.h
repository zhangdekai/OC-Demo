#import <Foundation/Foundation.h>

// 目标接口：音频播放器协议
@protocol AudioPlayer <NSObject>
- (void)playAudioWithFileName:(NSString *)fileName;
@end
