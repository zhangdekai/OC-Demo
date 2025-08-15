#import "CEO.h"

@implementation CEO

- (void)approve:(CGFloat)amount {
    if (amount > 5000 && amount <= 20000) {
        NSLog(@"[%@] 审批通过：%.2f元（5001-20000元）", self.name, amount);
    } else {
        if (self.nextApprover) {
            [self.nextApprover approve:amount];
        } else {
            NSLog(@"[%@] 无法审批（＞20000元），请求超出限额！", self.name);
        }
    }
}

@end
