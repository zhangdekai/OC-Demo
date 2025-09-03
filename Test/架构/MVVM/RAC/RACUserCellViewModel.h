#import <Foundation/Foundation.h>
#import <ReactiveObjC/ReactiveObjC.h>
#import "RACUserModel.h"

@interface RACUserCellViewModel : NSObject

/// 姓名文本
@property (nonatomic, copy, readonly) NSString *nameText;
/// 年龄文本
@property (nonatomic, copy, readonly) NSString *ageText;
/// 地址文本
@property (nonatomic, copy, readonly) NSString *addressText;
/// 爱好文本
@property (nonatomic, copy, readonly) NSString *hobbiesText;

/// 从用户模型初始化
- (instancetype)initWithUserModel:(RACUserModel *)userModel;

@end
