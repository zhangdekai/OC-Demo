//
//  NameVisitor.m
//  Test
//
//  Created by zhang dekai on 2025/8/20.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "NameVisitor.h"
#import "TextFile.h"
#import "ImageFile.h"

@implementation NameVisitor

- (void)visitTextFile:(TextFile *)textFile{
    
    NSLog(@"访问到文本文件 name: %@ (%ldKB)", textFile.name, (long)textFile.size);
    
}

- (void)visitImageFile:(ImageFile *)imageFile{
    NSLog(@"访问到Image文件 name: %@ (%ldKB)", imageFile.name, (long)imageFile.size);
    
}

@end
