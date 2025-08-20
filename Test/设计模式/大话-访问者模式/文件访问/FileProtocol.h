// File.h
#import <Foundation/Foundation.h>
@protocol VisitorFileProtocol;

// 文件元素接口协议
@protocol FileProtocol <NSObject>

- (void)accept:(id<VisitorFileProtocol>)visitor;

- (NSString *)name;

- (NSInteger)size;

@end
