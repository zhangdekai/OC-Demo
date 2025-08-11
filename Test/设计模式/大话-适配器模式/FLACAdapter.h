#import <Foundation/Foundation.h>
#import "AudioPlayer.h"
#import "FLACPlayer.h"

// 适配器：将FLACPlayer适配到AudioPlayer接口
@interface FLACAdapter : NSObject <AudioPlayer>
- (instancetype)initWithFLACPlayer:(FLACPlayer *)player;
@end
