#import <Foundation/Foundation.h>
#import "TeamLeader.h"
#import "DepartmentManager.h"
#import "CEO.h"

int testChainOfResponsibiltyMain(void) {
    @autoreleasepool {
        // 创建具体处理者
        AbstractApprover *teamLeader = [[TeamLeader alloc] initWithName:@"张组长"];
        AbstractApprover *deptManager = [[DepartmentManager alloc] initWithName:@"李经理"];
        AbstractApprover *ceo = [[CEO alloc] initWithName:@"王CEO"];
        
        // 构建职责链
        teamLeader.nextApprover = deptManager;
        deptManager.nextApprover = ceo;
        
        // 提交不同金额的报销请求
        NSLog(@"=== 报销800元 ===");
        [teamLeader approve:800];
        
        NSLog(@"\n=== 报销3000元 ===");
        [teamLeader approve:3000];
        
        NSLog(@"\n=== 报销15000元 ===");
        [teamLeader approve:15000];
        
        NSLog(@"\n=== 报销25000元 ===");
        [teamLeader approve:25000];
        
        // 直接找李经理, 跨越职责找上上层，，，
        [deptManager approve:3000];
    }
    return 0;
}
