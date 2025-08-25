#import <Foundation/Foundation.h>
#import "Light.h"
#import "FamilyTV.h"
#import "LightOnCommand.h"
#import "LightOffCommand.h"
#import "TVOnCommand.h"
#import "TVOffCommand.h"
#import "RemoteControl.h"

int testCommandPatternMain(void) {
    @autoreleasepool {
        // 创建接收者
        Light *light = [[Light alloc] init];
        FamilyTV *tv = [[FamilyTV alloc] init];
        
        // 创建具体命令
        id<CommandProtocol> lightOn = [[LightOnCommand alloc] initWithLight:light];
        id<CommandProtocol> lightOff = [[LightOffCommand alloc] initWithLight:light];
        id<CommandProtocol> tvOn = [[TVOnCommand alloc] initWithTV:tv];
        id<CommandProtocol> tvOff = [[TVOffCommand alloc] initWithTV:tv];
        
        // 创建调用者（遥控器）
        RemoteControl *remote = [[RemoteControl alloc] init];
        
        // 测试电灯操作
        NSLog(@"--- 测试电灯操作 ---");
        [remote setCommand:lightOn];
        [remote pressButton];    // 打开电灯
        [remote pressUndoButton];// 撤销（关闭电灯）
        
        [remote setCommand:lightOff];
        [remote pressButton]; // 关闭电灯
        [remote pressUndoButton];//
        
        // 测试电视操作
        NSLog(@"--- 测试电视操作 ---");
        [remote setCommand:tvOn];
        [remote pressButton];    // 打开电视
        
        [remote setCommand:tvOff];
        [remote pressButton];    // 关闭电视
        [remote pressUndoButton];// 撤销（打开电视）
    }
    return 0;
}

/*
 NSOperation 与 NSOperationQueue

 NSOperation 是 Foundation 中基于命令模式的核心组件：

 NSOperation：抽象的 “命令对象”，封装了需要执行的任务（同步或异步）。
 NSOperationQueue：作为 “调用者”，负责管理命令的执行（如并发控制、依赖管理）。
 使用场景：网络请求、文件 IO 等耗时操作的调度，支持取消、暂停、优先级设置等。
 
 */
int testFoundationCommandClass(void){
    
    NSOperation *op = [[NSOperation alloc]init];
    
    // 自定义命令（任务）
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        // 执行耗时任务（如下载文件）
        NSLog(@"执行任务...");
    }];
    
    // 调用者（队列）管理命令
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [queue addOperation:operation]; // 加入队列执行
    
    return  0;
}

