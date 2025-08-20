// SizeVisitor.h
#import <Foundation/Foundation.h>
#import "VisitorFileProtocol.h"

@interface SizeVisitor : NSObject <VisitorFileProtocol>
@property (nonatomic, assign, readonly) NSInteger totalSize;
@end
