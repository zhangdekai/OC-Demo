//
//  NSObject+tools.h
//  Test
//
//  Created by zhang dekai on 2020/6/26.
//  Copyright © 2020 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (tools)

//对这个文件设置-fno-objc-arc,函数:  开启MRC模式
- (NSUInteger)retainCount1;

@end

NS_ASSUME_NONNULL_END
