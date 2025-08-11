#import <Foundation/Foundation.h>
#import "AudioPlayer.h"

// 适配者：现有的MP3播放器
@interface MP3Player : NSObject <AudioPlayer>
@end
