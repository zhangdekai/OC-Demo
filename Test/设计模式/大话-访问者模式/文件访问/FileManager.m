// FileManager.m
#import "FileManager.h"

@implementation FileManager {
    NSMutableArray<id<FileProtocol>> *_files;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _files = [NSMutableArray array];
    }
    return self;
}

- (void)addFile:(id<FileProtocol>)file {
    if (file) {
        [_files addObject:file];
    }
}

- (void)accept:(id<VisitorFileProtocol>)visitor {
    for (id<FileProtocol> file in _files) {
        [file accept:visitor];
    }
}

@end
