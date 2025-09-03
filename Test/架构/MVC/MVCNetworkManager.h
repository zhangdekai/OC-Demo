#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseObject);
typedef void(^FailureBlock)(NSError *error);

@interface MVCNetworkManager : NSObject

+ (instancetype)sharedManager;

// GET请求
- (void)GET:(NSString *)url 
 parameters:(NSDictionary *)parameters 
    success:(SuccessBlock)success 
    failure:(FailureBlock)failure;

// POST请求
- (void)POST:(NSString *)url 
  parameters:(NSDictionary *)parameters 
     success:(SuccessBlock)success 
     failure:(FailureBlock)failure;

@end
    