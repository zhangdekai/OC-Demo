// Visitor.h
#import <Foundation/Foundation.h>

@class TextFile, ImageFile;

// 访问者接口协议
@protocol VisitorFileProtocol <NSObject>

- (void)visitTextFile:(TextFile *)textFile;

- (void)visitImageFile:(ImageFile *)imageFile;

@end
