#import <Foundation/Foundation.h>
#import "MVVMUserModel.h"

@interface MVVMUserCellViewModel : NSObject
/// 用于UI展示的姓名
@property (nonatomic, copy, readonly) NSString *nameText;
/// 用于UI展示的年龄（格式："年龄：25岁"）
@property (nonatomic, copy, readonly) NSString *ageText;
/// 用于UI展示的地址（格式："地址：北京市海淀区"）
@property (nonatomic, copy, readonly) NSString *addressText;
/// 用于UI展示的爱好（格式："爱好：篮球, 编程"）
@property (nonatomic, copy, readonly) NSString *hobbiesText;

/// 从UserModel初始化CellViewModel（核心：数据转换）
- (instancetype)initWithUserModel:(MVVMUserModel *)userModel;

@end
