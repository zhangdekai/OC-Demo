#import <Foundation/Foundation.h>

@interface AirConditioner : NSObject

- (void)turnOn;
- (void)turnOff;
- (void)setTemperature:(float)temp;

@end
