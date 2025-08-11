#import <Foundation/Foundation.h>
#import "NewsObserverProtocol.h"

@interface NewsApp : NSObject <NewsObserverProtocol>

@property (nonatomic, copy) NSString *appID;

- (instancetype)initWithAppID:(NSString *)appID;

@end
