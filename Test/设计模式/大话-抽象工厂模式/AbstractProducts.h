#import <Foundation/Foundation.h>

// 手机抽象产品协议
@protocol PhoneProtocol <NSObject>
- (void)makeCall;
- (void)takePhoto;
@end

// 电脑抽象产品协议
@protocol ComputerProtocol <NSObject>
- (void)surfInternet;
- (void)editDocument;
@end
