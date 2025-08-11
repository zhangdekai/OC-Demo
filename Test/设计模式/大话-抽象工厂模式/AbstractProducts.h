#import <Foundation/Foundation.h>

// 手机抽象产品协议
@protocol Phone <NSObject>
- (void)makeCall;
- (void)takePhoto;
@end

// 电脑抽象产品协议
@protocol Computer <NSObject>
- (void)surfInternet;
- (void)editDocument;
@end
