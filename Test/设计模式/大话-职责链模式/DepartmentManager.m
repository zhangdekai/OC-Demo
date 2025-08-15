#import "DepartmentManager.h"

@implementation DepartmentManager

- (void)approve:(CGFloat)amount {
    if (amount > 1000 && amount <= 5000) {
        NSLog(@"[%@] 审批通过：%.2f元（1001-5000元）", self.name, amount);
    } else {
        if (self.nextApprover) {
            NSLog(@"[%@] 无法审批（＞5000元），传递给%@", self.name, self.nextApprover.name);
            [self.nextApprover approve:amount];
        } else {
            NSLog(@"[%@] 无后续审批者，请求丢失", self.name);
        }
    }
}

@end
