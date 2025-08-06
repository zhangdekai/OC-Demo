//
//  Finery.h
//  Test
//
//  Created by zhang dekai on 2025/8/6.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DecortorPerson.h"

NS_ASSUME_NONNULL_BEGIN

/// 服饰
@interface Finery : NSObject<PersonProtocol>

@property (nonatomic, strong) id<PersonProtocol> person;

- (void)decorate:(id<PersonProtocol>)person;
//- (void)show;

@end

/// 帽子

@interface Hat : Finery


@end


/// 裤子
@interface Pants : Finery


@end

/// 鞋子
@interface Shoes : Finery


@end

/// 
@interface TShirt : Finery


@end

NS_ASSUME_NONNULL_END
