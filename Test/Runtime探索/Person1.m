//
//  Person1.m
//  Test
//
//  Created by 张德凯 on 2018/8/8.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import "Person1.h"

//按位与可以用来取出特定的位，想取出哪一位就将那一位置为1，其他为都置为0，然后同原数据进行按位与计算，即可取出特定的位。
//#define TallMask        0b00000100 //4
//#define RichMask        0b00000010 //2
//#define HandsomeMask    0b00000001 //1

//掩码 : 上述代码中定义了三个宏，用来分别进行按位与运算而取出相应的值，一般用来按位与（&）运算的值 称之为掩码。

//为了能更清晰的表明掩码是为了取出哪一位的值，上述三个宏的定义可以使用<<（左移）来优化

#define TallMask (1<<2)         // 0b00000100 4
#define RichMask (1<<1)         // 0b00000010 2
#define HandsomeMask (1<<0)     // 0b00000001 1

@interface Person1()


@end

@implementation Person1


- (instancetype)init
{
    self = [super init];
    if (self) {
        //method_t 包含SEL type IMP
        //types包含了函数返回值，参数编码的字符串。
        NSLog(@"%s",@encode(int));//i
        NSLog(@"%s",@encode(float));//f
        NSLog(@"%s",@encode(id));//@
        NSLog(@"%s",@encode(SEL));//:
    

    }
    return self;
}

- (void)setTall:(BOOL)tall
{
    if (tall) {
        _tallRichHandsome.bits |= TallMask;
    } else {
        _tallRichHandsome.bits &= ~TallMask;
    }
}
- (void)setRich:(BOOL)rich
{
    if (rich) {
        _tallRichHandsome.bits |= RichMask;
    } else {
        _tallRichHandsome.bits &= ~RichMask;
    }
}
- (void)setHandsome:(BOOL)handsome
{
    if (handsome) {
        _tallRichHandsome.bits |= HandsomeMask;
    } else {
        _tallRichHandsome.bits &= ~HandsomeMask;
    }
}

- (BOOL)tall
{
    return !!(_tallRichHandsome.bits & TallMask);
}
- (BOOL)rich
{
    return !!(_tallRichHandsome.bits & RichMask);
}
- (BOOL)handsome
{
    return !!(_tallRichHandsome.bits & HandsomeMask);
}


/* 位域 的方法 可读性高
-(void)setTall:(BOOL)tall
{
    _tallRichHandsome.tall = tall;
}

- (BOOL)tall
{
    return !!_tallRichHandsome.tall;
}


- (void)setRich:(BOOL)rich
{
    _tallRichHandsome.rich = rich;
}
- (BOOL)rich
{
    return !!_tallRichHandsome.rich;
}


- (void)setHandsome:(BOOL)handsome
{
    _tallRichHandsome.handsome = handsome;
}
- (BOOL)handsome
{
    return !!_tallRichHandsome.handsome;
}
 
 上述代码中使用结构体的位域则不在需要使用掩码，使代码可读性增强了很多，
 但是效率相比直接使用 位运算的方式 来说差很多，如果想要高效率的进行数据的
 读取与存储同时又有较强的可读性就需要使用到共用体了。
 
 */



// 下面是位运算，可读性较差，但是 位运算的 数据存取的效率 最高，

//- (void)setTall:(BOOL)tall
//{
//    if (tall) { // 如果需要将值置为1  // 按位或掩码
//        _tallRichHandsome |= TallMask;
//    }else{ // 如果需要将值置为0 // 按位与（按位取反的掩码）
//        _tallRichHandsome &= ~TallMask;
//    }
//}
//
//- (BOOL)tall
//{
//    return !!(_tallRichHandsome & TallMask);//使用两个!!（非）来将值改为bool类型
//}
//
//
//- (void)setRich:(BOOL)rich
//{
//    if (rich) {
//        _tallRichHandsome |= RichMask;
//    } else {
//        _tallRichHandsome &= ~RichMask;
//    }
//}
//- (BOOL)rich
//{
//    return !!(_tallRichHandsome & RichMask);
//}
//
//
//
//- (void)setHandsome:(BOOL)handsome
//{
//    if (handsome) {
//        _tallRichHandsome |= HandsomeMask;
//    } else {
//        _tallRichHandsome &= ~HandsomeMask;
//    }
//}
//- (BOOL)handsome
//{
//    return !!(_tallRichHandsome & HandsomeMask);
//}



- (void)test
{
    NSLog(@"test print name is %@",self.name);
}



@end
