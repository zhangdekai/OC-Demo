//
//  Person.h
//  Test
//
//  Created by zhang dekai on 2025/8/6.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol PersonProtocol <NSObject>

- (void)show;

@end



@interface DecortorPerson : NSObject<PersonProtocol>

@property (nonatomic, copy) NSString *name;

- (instancetype)initWithName:(NSString *)name;

//- (void)testDecortorMode;

@end

NS_ASSUME_NONNULL_END
