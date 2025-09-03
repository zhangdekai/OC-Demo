#import "MVVMUserCellViewModel.h"

@implementation MVVMUserCellViewModel

- (instancetype)initWithUserModel:(MVVMUserModel *)userModel {
    if (self = [super init]) {
        // 将Model的原始数据转换为UI直接可用的格式（ViewModel核心职责）
        _nameText = userModel.name;
        _ageText = [NSString stringWithFormat:@"年龄：%ld岁", (long)userModel.age];
        _addressText = [NSString stringWithFormat:@"地址：%@", userModel.address];
        // 将爱好数组转为字符串（格式："爱好：篮球, 编程"）
        NSString *hobbiesStr = [userModel.hobbies componentsJoinedByString:@", "];
        _hobbiesText = [NSString stringWithFormat:@"爱好：%@", hobbiesStr];
    }
    return self;
}

@end
