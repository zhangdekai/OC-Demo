//
//  ShadowCornerMask.m
//  Test
//
//  Created by zhang dekai on 2025/8/31.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "ShadowCornerMask.h"

@implementation ShadowCornerMask

/*
 1. “阴影” 和 “圆角 + 遮罩”
 
 最佳实现方案：双层视图分离责任

 核心思路是 用两个图层分离 “阴影” 和 “圆角 + 遮罩” 的职责：

 外层视图（容器）：仅负责显示阴影（不设置圆角和遮罩，避免裁剪阴影）。
 内层视图（内容）：负责显示圆角和遮罩（设置 masksToBounds = YES，不影响外层阴影）。

 这种方式既能避免属性冲突，又能保证性能（减少离屏渲染）。
 
 */
+ (UIView *)createViewWithFrame:(CGRect)frame {
    // 1. 外层容器视图：负责阴影
    UIView *containerView = [[UIView alloc] initWithFrame:frame];
    containerView.backgroundColor = UIColor.clearColor; // 必须透明，否则会遮挡内层
    
    // 阴影属性设置
    containerView.layer.shadowColor = UIColor.blackColor.CGColor;    // 阴影颜色
    containerView.layer.shadowOpacity = 0.3;                        // 阴影透明度
    containerView.layer.shadowRadius = 8;                           // 阴影模糊半径
    containerView.layer.shadowOffset = CGSizeMake(0, 4);             // 阴影偏移
    // 关键优化：指定阴影路径（避免系统实时计算，提升性能）
    containerView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:containerView.bounds
                                                                   cornerRadius:12].CGPath;
    
    // 2. 内层内容视图：负责圆角和遮罩
    UIView *contentView = [[UIView alloc] initWithFrame:containerView.bounds];
    contentView.backgroundColor = UIColor.whiteColor; // 内容背景色
    [containerView addSubview:contentView];
    
    // 圆角设置
    contentView.layer.cornerRadius = 12;
    contentView.layer.masksToBounds = YES; // 裁剪圆角（仅影响内层，不影响外层阴影）
    
    // 3. 遮罩设置（示例：添加一个圆形遮罩，可根据需求修改）
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = contentView.bounds;
    // 遮罩路径（示例：中间圆形可见，外部透明）
    maskLayer.path = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(contentView.bounds, 20, 20)].CGPath;
    contentView.layer.mask = maskLayer;
    
    return containerView;
    /*
     关键技术点解析

     1. 外层容器视图（shadow 载体）
     * 背景色必须设为透明（clearColor），否则会遮挡内层内容。
     * 必须设置 shadowPath：这是性能优化的关键！系统默认会实时计算阴影形状，指定 shadowPath 后可减少 90% 以上的阴影绘制耗时。
     * 不设置 masksToBounds 和 cornerRadius，确保阴影不被裁剪。
     2. 内层内容视图（圆角 + 遮罩载体）
     * 通过 cornerRadius + masksToBounds = YES 实现圆角（仅对内层生效，不影响外层阴影）。
     * 遮罩（mask）添加到内层视图，仅影响内容显示区域，与外层阴影无冲突。
     3. 遮罩的灵活使用
     * 遮罩通过 CAShapeLayer 的 path 定义，可实现任意形状（圆形、多边形、复杂路径等）。
     * 遮罩的 frame 需与内层视图一致，否则会出现位置偏移。
     
     
     性能优化建议

     避免离屏渲染：外层视图不设置 masksToBounds，内层视图的 cornerRadius 配合 masksToBounds 虽然会触发离屏渲染，但范围仅限于内层视图（面积较小，性能影响可控）。
     动态更新处理：若视图 frame 会动态变化，需在布局更新时同步更新 shadowPath 和遮罩的 path（例如在 layoutSubviews 中重设）。
     简化阴影形状：阴影路径越简单（如矩形、圆角矩形），性能越好，避免使用复杂路径作为阴影形状。
     
     */
}

@end





@interface SingleLayerView : UIView
@end

/*
 通过 单层视图 + CAShapeLayer 手动控制路径 的方式实现，
 核心是利用 UIBezierPath 统一管理 “阴影路径”“圆角路径” 和 “遮罩路径”，
 避免 masksToBounds对阴影的裁剪。
 但这种方式对路径同步要求较高，且性能略逊于双层视图方案，适合简单场景。
 
 */

@implementation SingleLayerView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
    }
    return self;
}
/// 通过 CAShapeLayer 手动定义形状，让阴影、圆角、遮罩共享同一套路径，避免属性冲突。
///
- (void)setupLayer {
    self.backgroundColor = UIColor.whiteColor;
    
    // 1. 定义基础路径（带圆角的矩形，作为统一基准）
    CGFloat cornerRadius = 12;
    UIBezierPath *basePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:cornerRadius];
    
    // 2. 设置阴影（基于基础路径，不依赖masksToBounds）
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 8;
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.shadowPath = basePath.CGPath; // 阴影路径与基础路径一致
    
    // 3. 设置遮罩（在基础路径上叠加额外形状，示例：中间圆形镂空）
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    
    // 遮罩路径：基础路径（圆角矩形）减去中间圆形（形成镂空）
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:cornerRadius];
    UIBezierPath *holePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 30, 30)];
    [maskPath appendPath:holePath];
    maskPath.usesEvenOddFillRule = YES; // 启用奇偶填充规则（实现镂空）
    maskLayer.path = maskPath.CGPath;
    
    self.layer.mask = maskLayer;
}

// 注意：若视图frame变化，需重设路径（在layoutSubviews中更新）
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat cornerRadius = 12;
    UIBezierPath *basePath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                         cornerRadius:cornerRadius];
    self.layer.shadowPath = basePath.CGPath;
    
    // 更新遮罩路径
    CAShapeLayer *maskLayer = (CAShapeLayer *)self.layer.mask;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                          cornerRadius:cornerRadius];
    UIBezierPath *holePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(self.bounds, 30, 30)];
    [maskPath appendPath:holePath];
    maskPath.usesEvenOddFillRule = YES;
    maskLayer.path = maskPath.CGPath;
}

@end

@interface DrawRectView : UIView

@end

/*
 
 利用 drawRect: 手动绘制（不推荐）

 通过重写 drawRect: 手动绘制带圆角的内容，同时设置阴影。但此方法性能较差（CPU 绘制，无法利用 GPU 加速），仅适合静态、小面积视图。
 
 缺点

 性能差：drawRect: 依赖 CPU 绘制，无法利用 GPU 硬件加速，频繁刷新时会卡顿。
 维护复杂：绘制逻辑与视图布局耦合，修改形状需同步更新绘制代码和阴影路径。
 
 */

@implementation DrawRectView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self setupShadow];
    }
    return self;
}

- (void)setupShadow {
    // 设置阴影（与方法一相同）
    self.layer.shadowColor = UIColor.blackColor.CGColor;
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 8;
    self.layer.shadowOffset = CGSizeMake(0, 4);
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12].CGPath;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 1. 绘制带圆角的背景
    CGFloat cornerRadius = 12;
    UIBezierPath *bgPath = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius];
    [UIColor.whiteColor setFill];
    [bgPath fill];
    
    // 2. 绘制遮罩效果（示例：中间圆形镂空）
    UIBezierPath *holePath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset(rect, 30, 30)];
    [UIColor.clearColor setFill];
    holePath.usesEvenOddFillRule = YES;
    [holePath fill];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 更新阴影路径
    self.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:12].CGPath;
    [self setNeedsDisplay]; // 触发重绘
}

@end
