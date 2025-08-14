#import <Foundation/Foundation.h>
#import "SMSMessageSender.h"
#import "EmailMessageSender.h"
#import "NormalMessage.h"
#import "UrgentMessage.h"

int testBridgePatternMain(void) {
    @autoreleasepool {
        // 创建不同的发送方式（实现化对象）
//        id<MessageSender> smsSender = [[SMSMessageSender alloc] init];
//        id<MessageSender> emailSender = [[EmailMessageSender alloc] init];
        
        id<MessageSenderProtocol> smsSender = [[SMSMessageSender alloc] init];
        id<MessageSenderProtocol> emailSender = [[EmailMessageSender alloc] init];

        // 创建不同的消息类型（抽象化对象），并通过桥接关联发送方式
        Message *normalSMSMessage = [[NormalMessage alloc] initWithSender:smsSender];
        Message *urgentEmailMessage = [[UrgentMessage alloc] initWithSender:emailSender];
        
        // 发送消息
        [normalSMSMessage send:@"明天上午9点开会" to:@"张三"];
        [urgentEmailMessage send:@"系统将在10分钟后重启" to:@"全体员工"];
        
        // 动态切换发送方式
        urgentEmailMessage.sender = smsSender;
        [urgentEmailMessage send:@"项目截止日期提前到周五" to:@"李四"];
    }
    return 0;
}
