#import "ConcreteProducts.h"

@implementation IPhone
- (void)makeCall {
    NSLog(@"使用iPhone打电话");
}
- (void)takePhoto {
    NSLog(@"使用iPhone拍照");
}
@end

@implementation Mac
- (void)surfInternet {
    NSLog(@"使用Mac浏览网页");
}
- (void)editDocument {
    NSLog(@"使用Mac编辑文档");
}
@end

@implementation HuaweiPhone
- (void)makeCall {
    NSLog(@"使用华为手机打电话");
}
- (void)takePhoto {
    NSLog(@"使用华为手机拍照");
}
@end

@implementation HuaweiComputer
- (void)surfInternet {
    NSLog(@"使用华为电脑浏览网页");
}
- (void)editDocument {
    NSLog(@"使用华为电脑编辑文档");
}
@end
