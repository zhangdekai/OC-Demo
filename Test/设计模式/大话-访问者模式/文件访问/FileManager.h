// FileManager.h
#import <Foundation/Foundation.h>
#import "FileProtocol.h"
#import "VisitorFileProtocol.h"

@interface FileManager : NSObject

- (void)addFile:(id<FileProtocol>)file;

- (void)accept:(id<VisitorFileProtocol>)visitor;

@end
