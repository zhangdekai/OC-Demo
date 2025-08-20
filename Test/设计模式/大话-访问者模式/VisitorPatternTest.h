#import <Foundation/Foundation.h>
#import "Zoo.h"
#import "Lion.h"
#import "Elephant.h"
#import "Monkey.h"
#import "Veterinarian.h"
#import "Tourist.h"

int testVisitorPatternMain(void) {
    @autoreleasepool {
        // 创建动物园
        Zoo *zoo = [[Zoo alloc] init];
        
        // 添加动物
        [zoo addAnimal:[[Lion alloc] initWithName:@"辛巴" age:5]];
        [zoo addAnimal:[[Elephant alloc] initWithName:@"敦敦" weight:5000]];
        [zoo addAnimal:[[Monkey alloc] initWithName:@"悟空" height:90]];
        
        // 兽医访问动物园
        NSLog(@"===== 兽医开始检查动物 =====");
        Veterinarian *vet = [[Veterinarian alloc] init];
        [zoo accept:vet];
        
        // 游客访问动物园
        NSLog(@"\n===== 游客开始参观动物 =====");
        Tourist *tourist = [[Tourist alloc] init];
        [zoo accept:tourist];
    }
    return 0;
}
