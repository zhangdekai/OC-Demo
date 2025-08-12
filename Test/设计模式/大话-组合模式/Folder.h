#import "FileSystemComponent.h"

@interface Folder : FileSystemComponent

- (BOOL)addComponent:(FileSystemComponent *)component;
- (BOOL)removeComponent:(FileSystemComponent *)component;

@end
