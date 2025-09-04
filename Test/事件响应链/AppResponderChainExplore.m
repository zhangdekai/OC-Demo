//
//  AppResponderChainExplore.m
//  Test
//
//  Created by zhang dekai on 2025/9/4.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "AppResponderChainExplore.h"

@implementation AppResponderChainExplore

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma 事件响应

/// 核心逻辑： hitTest （点击命中）
/// Returns the farthest descendant of the receiver in the view hierarchy (including itself) that contains a specified point.
/// 返回接收者在视图层次结构（包括自身在内）中距离指定点最远的子元素。（自顶向下查找响应的 view）
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    /// 该方法
    /// recursively calls -pointInside:withEvent:. point is in the receiver's coordinate system
    /// 递归调用 -pointInside:withEvent： 。该点位于接收者的坐标系内。
    
    /*
     伪代码： 基本逻辑
     // 1. 基本条件过滤：不满足则无法响应
         if (!self.userInteractionEnabled || self.hidden || self.alpha <= 0.01) {
             return nil;
         }
         
         // 2. 判断触摸点是否在当前视图范围内
         if (![self pointInside:point withEvent:event]) {
             return nil;
         }
         
         // 3. 从后往前检查所有子视图（优先响应层级更高的子视图）
         for (UIView *subview in [self.subviews reverseObjectEnumerator]) {
     
             // 转换触摸点坐标到子视图坐标系
             CGPoint convertedPoint = [subview convertPoint:point fromView:self];
             
             // 递归测试子视图
             UIView *hitSubview = [subview hitTest:convertedPoint withEvent:event];
             
             // 如果子视图中找到合适的响应者，直接返回
             if (hitSubview) {
                 return hitSubview;
             }
         }
         
         // 4. 没有子视图符合条件，则自身作为响应者
         return self;
     */
    
    
    return [super hitTest: point withEvent:event];
    
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    return  [super pointInside:point withEvent:event];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UIView *view = [[UIView alloc]init];
    
    UIButton *btn = [[UIButton alloc]init];
    btn.userInteractionEnabled = YES;
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc]init];
    label.userInteractionEnabled = NO;
//    [label addTarget:]  do not have
    
    UIWindow *window = [[UIWindow alloc]init];
    
    UIImageView *imgView = [[UIImageView alloc]init];
    
    [super touchesBegan:touches withEvent:event];
}

- (void)btnAction{
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
