#import "RACUserCellViewModel.h"
#import "RACUserModel.h"

@implementation RACUserCellViewModel

- (instancetype)initWithUserModel:(RACUserModel *)userModel {
    if (self = [super init]) {
        // 数据转换：将模型数据转换为UI可用的文本格式
        _nameText = userModel.name;
        _ageText = [NSString stringWithFormat:@"年龄：%ld岁", (long)userModel.age];
        _addressText = [NSString stringWithFormat:@"地址：%@", userModel.address];
        
        // 将爱好数组转换为字符串
        NSString *hobbiesStr = [userModel.hobbies componentsJoinedByString:@"、"];
        _hobbiesText = [NSString stringWithFormat:@"爱好：%@", hobbiesStr];
    }
    return self;
}

@end
