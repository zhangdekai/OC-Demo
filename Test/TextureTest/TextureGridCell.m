//
//  TextureGridCell.m
//  Test
//
//  Created by zhang dekai on 2025/8/31.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "TextureGridCell.h"
#import <Texture/AsyncDisplayKit/AsyncDisplayKit.h>

@implementation TextureGridCell

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        // 初始化图片节点
        _imageNode = [[ASNetworkImageNode alloc] init];
        _imageNode.contentMode = UIViewContentModeScaleAspectFill;
        _imageNode.clipsToBounds = YES;
        _imageNode.backgroundColor = [UIColor lightGrayColor];
        
        // 初始化文本节点
        _textNode = [[ASTextNode alloc] init];
        _textNode.maximumNumberOfLines = 1;
        
        // 添加子节点
        [self addSubnode:_imageNode];
        [self addSubnode:_textNode];
    }
    return self;
}

- (void)configureWithImageURL:(NSURL *)url title:(NSString *)title {
    _imageNode.URL = url;
    
    // 设置文本样式
    NSDictionary *textStyle = @{
        NSFontAttributeName: [UIFont systemFontOfSize:14],
        NSForegroundColorAttributeName: [UIColor whiteColor]
    };
    _textNode.attributedText = [[NSAttributedString alloc] initWithString:title attributes:textStyle];
}

- (ASLayoutSpec *)layoutSpecThatFits:(ASSizeRange)constrainedSize {
    // 图片尺寸
    _imageNode.style.preferredSize = CGSizeMake(constrainedSize.max.width, constrainedSize.max.width);
    
    // 文本背景
    ASDisplayNode *textBackground = [[ASDisplayNode alloc] init];
    textBackground.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    textBackground.style.flexGrow = 1;
    
    // 文本布局
    ASInsetLayoutSpec *textInset = [ASInsetLayoutSpec insetLayoutSpecWithInsets:UIEdgeInsetsMake(4, 8, 4, 8) child:_textNode];
    ASOverlayLayoutSpec *textOverlay = [ASOverlayLayoutSpec overlayLayoutSpecWithChild:textBackground overlay:textInset];
    textOverlay.style.height = ASDimensionMake(30);
    
    // 垂直堆叠
    ASStackLayoutSpec *stack = [ASStackLayoutSpec stackLayoutSpecWithDirection:ASStackLayoutDirectionVertical
                                                                       spacing:0
                                                                justifyContent:ASStackLayoutJustifyContentStart
                                                                    alignItems:ASStackLayoutAlignItemsStretch
                                                                      children:@[_imageNode, textOverlay]];
    
    return stack;
}

@end
