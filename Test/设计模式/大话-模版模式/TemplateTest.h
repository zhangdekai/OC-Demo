#import <Foundation/Foundation.h>
#import "Coffee.h"
#import "Tea.h"

int testTemplateMain(void) {
    @autoreleasepool {
        // 制作咖啡
        Beverage *coffee = [[Coffee alloc] init];
        NSLog(@"--- 制作咖啡 ---");
        [coffee prepareRecipe];
        
        // 制作茶
        Beverage *tea = [[Tea alloc] init];
        NSLog(@"\n--- 制作茶 ---");
        [tea prepareRecipe];
    }
    return 0;
}
    
