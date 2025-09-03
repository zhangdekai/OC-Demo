#import "MMVMKVOUserCellViewModel.h"

@implementation MMVMKVOUserCellViewModel

- (instancetype)initWithUserModel:(MMVMKVOUserModel *)userModel {
    if (self = [super init]) {
        // 数据转换：将模型数据转换为UI展示数据
        _nameText = userModel.name;
        _ageText = [NSString stringWithFormat:@"年龄：%ld岁", (long)userModel.age];
        _addressText = [NSString stringWithFormat:@"地址：%@", userModel.address];
        
        NSString *hobbiesStr = [userModel.hobbies componentsJoinedByString:@", "];
        _hobbiesText = [NSString stringWithFormat:@"爱好：%@", hobbiesStr];
    }
    return self;
}

@end
    