//
//  ShadowCornerMask.h
//  Test
//
//  Created by zhang dekai on 2025/8/31.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/*
 总结

 1. 优先选择 双层视图方案，平衡性能和可维护性。
 2. 若追求极简结构且视图静态，可使用 单层路径统一方案，但需注意布局变化时同步更新路径。
 3. 避免使用 drawRect: 方案，除非视图完全静态且面积极小。

 核心原则：让阴影在 “不被裁剪的图层” 上，让圆角和遮罩在 “内容图层” 上，无论单层还是双层，都需遵守这一逻辑。
 
 */

@interface ShadowCornerMask : NSObject

+ (UIView *)createViewWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
