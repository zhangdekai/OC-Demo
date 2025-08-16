#import <Foundation/Foundation.h>
#import "ChatRoomMediator.h"
#import "ChatUser.h"

int testMediatorPatternMain(void) {
    @autoreleasepool {
        // 创建中介者（聊天室）
        ChatRoomMediator *chatRoom = [[ChatRoomMediator alloc] init];
        
        // 创建同事（用户）
        ChatUser *user1 = [[ChatUser alloc] initWithName:@"张三"];
        ChatUser *user2 = [[ChatUser alloc] initWithName:@"李四"];
        ChatUser *user3 = [[ChatUser alloc] initWithName:@"王五"];
        
        // 注册用户到聊天室
        [chatRoom registerColleague:user1];
        [chatRoom registerColleague:user2];
        [chatRoom registerColleague:user3];
        
        // 发送消息
        [user1 sendMessage:@"大家好，我是张三！"];
        [user2 sendMessage:@"你好张三，我是李四~"];
        [user3 sendMessage:@"欢迎加入聊天室！"];
    }
    return 0;
}
