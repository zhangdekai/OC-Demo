#import <Foundation/Foundation.h>
#import "MMVMKVOUserModel.h"

@interface MMVMKVOUserCellViewModel : NSObject
@property (nonatomic, copy, readonly) NSString *nameText;
@property (nonatomic, copy, readonly) NSString *ageText;
@property (nonatomic, copy, readonly) NSString *addressText;
@property (nonatomic, copy, readonly) NSString *hobbiesText;

- (instancetype)initWithUserModel:(MMVMKVOUserModel *)userModel;

@end
    