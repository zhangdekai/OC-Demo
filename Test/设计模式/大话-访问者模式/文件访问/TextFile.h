// TextFile.h
#import <Foundation/Foundation.h>
#import "FileProtocol.h"
#import "VisitorFileProtocol.h"

@interface TextFile : NSObject <FileProtocol>
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, assign, readonly) NSInteger size;
@property (nonatomic, copy, readonly) NSString *content;

- (instancetype)initWithName:(NSString *)name 
                        size:(NSInteger)size 
                     content:(NSString *)content;
@end
