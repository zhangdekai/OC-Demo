// ImageFile.h
#import <Foundation/Foundation.h>
#import "FileProtocol.h"
#import "VisitorFileProtocol.h"

@interface ImageFile : NSObject <FileProtocol>

@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSInteger size;
@property (nonatomic, copy, readonly) NSString *resolution;

- (instancetype)initWithName:(NSString *)name 
                        size:(NSInteger)size 
                  resolution:(NSString *)resolution;
@end
