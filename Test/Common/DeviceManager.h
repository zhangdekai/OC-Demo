//
//  DeviceManager.h
//  Test
//
//  Created by zhang dekai on 2024/3/11.
//  Copyright © 2024 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DeviceManager : NSObject


+ (instancetype)shareInstance;


- (void) configDevice:(BOOL)hasSafeArea;

@property (nonatomic, assign) BOOL hasSafeArea;

@property (nonatomic, assign) CGFloat navigationBarH;

@property (nonatomic, assign) CGFloat navigationBarStateH;

@property (nonatomic, assign) CGFloat navigationBarTotalH;


@end

NS_ASSUME_NONNULL_END
