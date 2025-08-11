#import <Foundation/Foundation.h>
#import "MP3Player.h"
#import "FLACPlayer.h"
#import "FLACAdapter.h"

int testAdapterModeMain(void) {
    @autoreleasepool {
        // 使用原生支持的MP3播放器
        id<AudioPlayer> mp3Player = [[MP3Player alloc] init];
        [mp3Player playAudioWithFileName:@"song.mp3"];
        
        // 通过适配器使用FLAC播放器
        FLACPlayer *flacPlayer = [[FLACPlayer alloc] init];
        id<AudioPlayer> flacAdapter = [[FLACAdapter alloc] initWithFLACPlayer:flacPlayer];
        [flacAdapter playAudioWithFileName:@"music.flac"];
        
        // 客户端可以统一使用AudioPlayer接口，无需关心具体实现
        NSArray<id<AudioPlayer>> *players = @[mp3Player, flacAdapter];
        for (id<AudioPlayer> player in players) {
            // 统一调用方式
        }
    }
    return 0;
}
