#import "FileSystemComponent.h"

@interface File : FileSystemComponent

@property (nonatomic, assign, readonly) NSUInteger fileSize;

- (instancetype)initWithName:(NSString *)name size:(NSUInteger)size;

@end
