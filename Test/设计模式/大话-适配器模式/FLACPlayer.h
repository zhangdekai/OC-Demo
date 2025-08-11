#import <Foundation/Foundation.h>

// 需要适配的FLAC播放器（接口与目标接口不兼容）
@interface FLACPlayer : NSObject
- (void)startFLACPlaybackWithFile:(NSString *)filePath;
@end
