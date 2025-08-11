#import <Foundation/Foundation.h>
#import "Publisher.h"
#import "Subscriber.h"

int testPublishSubscribeModeMain(void) {
    @autoreleasepool {
        // 创建发布者
        Publisher *techCompany = [[Publisher alloc] initWithName:@"科技公司"];
        Publisher *newsAgency = [[Publisher alloc] initWithName:@"新闻社"];
        
        // 创建订阅者
        Subscriber *user1 = [[Subscriber alloc] initWithName:@"用户A"];
        Subscriber *user2 = [[Subscriber alloc] initWithName:@"用户B"];
        Subscriber *user3 = [[Subscriber alloc] initWithName:@"用户C"];
        
        // 用户订阅主题
        [user1 subscribeToTopic:@"科技新闻"];
        [user1 subscribeToTopic:@"体育新闻"];
        [user2 subscribeToTopic:@"科技新闻"];
        [user3 subscribeToTopic:@"体育新闻"];
        
        NSLog(@"\n--- 发布第一条消息 ---");
        [techCompany publishMessage:@"新一代AI芯片发布，性能提升300%" toTopic:@"科技新闻"];
        
        NSLog(@"\n--- 发布第二条消息 ---");
        [newsAgency publishMessage:@"全国运动会明日开幕" toTopic:@"体育新闻"];
        
        // 用户2取消订阅科技新闻
        [user2 unsubscribeFromTopic:@"科技新闻"];
        
        NSLog(@"\n--- 发布第三条消息 ---");
        [techCompany publishMessage:@"首款折叠屏手机将于下月上市" toTopic:@"科技新闻"];
        
        // 用户1取消所有订阅
        [user1 unsubscribeAll];
        
        NSLog(@"\n--- 发布第四条消息 ---");
        [newsAgency publishMessage:@"足球联赛：北京队大胜上海队" toTopic:@"体育新闻"];
    }
    return 0;
}
    
