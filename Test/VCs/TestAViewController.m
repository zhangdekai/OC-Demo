//
//  TestAViewController.m
//  Test
//
//  Created by zhang dekai on 2020/7/3.
//  Copyright © 2020 张德凯. All rights reserved.
//

#import "TestAViewController.h"

@interface TestAViewController ()

@end

@implementation TestAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //    NSDateFormatter
    
    //    NSCalendar
    
    //
    
    
    [self performSelector:nil withObject:nil afterDelay:3 inModes:@[]];
    
    

    NSRunLoopMode
    
    /*
    UIKIT_EXTERN NSRunLoopMode const NSRunLoopMode
    
    UITrackingRunLoopMode
    NSDefaultRunLoopMode
    NSRunLoopCommonModes
    
    
    CF_EXPORT const CFRunLoopMode kCFRunLoopDefaultMode;
    CF_EXPORT const CFRunLoopMode kCFRunLoopCommonModes;

    */
}

- (void)dealloc
{
    NSLog(@"A VC dealloc");
}

//
//- (UIImage *)yy_imageByRoundCornerRadius:(CGFloat)radius
//                                 corners:(UIRectCorner)corners
//                             borderWidth:(CGFloat)borderWidth
//                             borderColor:(UIColor *)borderColor
//                          borderLineJoin:(CGLineJoin)borderLineJoin {
//    if (corners != UIRectCornerAllCorners) {
//        UIRectCorner tmp = 0;
//        if (corners & UIRectCornerTopLeft) tmp |= UIRectCornerBottomLeft;
//        if (corners & UIRectCornerTopRight) tmp |= UIRectCornerBottomRight;
//        if (corners & UIRectCornerBottomLeft) tmp |= UIRectCornerTopLeft;
//        if (corners & UIRectCornerBottomRight) tmp |= UIRectCornerTopRight;
//        corners = tmp;
//    }
//
//    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
//    CGContextScaleCTM(context, 1, -1);
//    CGContextTranslateCTM(context, 0, -rect.size.height);
//    CGFloat minSize = MIN(self.size.width, self.size.height);
//
//    if (borderWidth < minSize / 2) {
//        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners
//                                                         cornerRadii:CGSizeMake(radius, borderWidth)];
//        [path closePath];
//        CGContextSaveGState(context);
//        [path addClip];
//        CGContextDrawImage(context, rect, self.CGImage);
//        CGContextRestoreGState(context);
//    }
//    if (borderColor && borderWidth < minSize / 2 && borderWidth > 0) {
//        CGFloat strokeInset = (floor(borderWidth * self.scale) + 0.5) / self.scale;
//        CGRect strokeRect = CGRectInset(rect, strokeInset, strokeInset);
//        CGFloat strokeRadius = radius > self.scale / 2 ? radius - self.scale / 2 : 0;
//        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:strokeRect byRoundingCorners:corners cornerRadii:CGSizeMake(strokeRadius,
//                                                                                                                                 borderWidth)];
//        [path closePath];
//        path.lineWidth = borderWidth;
//        path.lineJoinStyle = borderLineJoin;
//        [borderColor setStroke];
//    }
//
//
//    @end
