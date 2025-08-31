//
//  TextureGridCell.h
//  Test
//
//  Created by zhang dekai on 2025/8/31.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Texture/AsyncDisplayKit/AsyncDisplayKit.h>

NS_ASSUME_NONNULL_BEGIN

// 自定义单元格
@interface TextureGridCell : ASCellNode

@property (nonatomic, strong) ASNetworkImageNode *imageNode;
@property (nonatomic, strong) ASTextNode *textNode;

- (void)configureWithImageURL:(NSURL *)url title:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
