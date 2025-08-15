#import "TeamLeader.h"

@implementation TeamLeader

- (void)approve:(CGFloat)amount {
    if (amount <= 1000) {
        NSLog(@"[%@] 审批通过：%.2f元（≤1000元）", self.name, amount);
    } else {
        if (self.nextApprover) {
            NSLog(@"[%@] 无法审批（＞1000元），传递给%@", self.name, self.nextApprover.name);
            [self.nextApprover approve:amount];
        } else {
            NSLog(@"[%@] 无后续审批者，请求丢失", self.name);
        }
    }
}

@end
