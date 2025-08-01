//
//  NSObject+HashTable.m
//  Test
//
//  Created by zhang dekai on 2025/7/31.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "NSObject+HashTable.h"


/*
 
 两数之和
 
 作者：力扣官方题解
 链接：https://leetcode.cn/problems/two-sum/solutions/434597/liang-shu-zhi-he-by-leetcode-solution/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 
 给定一个整数数组 nums 和一个整数目标值 target，
 请你在该数组中找出,和为目标值 target  的那两个整数，并返回它们的数组下标。
 
 你可以假设每种输入只会对应一个答案，并且你不能使用两次相同的元素。
 
 你可以按任意顺序返回答案。
 
 
 示例 1：
 
 输入：nums = [2,7,11,15], target = 9
 输出：[0,1]
 解释：因为 nums[0] + nums[1] == 9 ，返回 [0, 1] 。
 示例 2：
 
 输入：nums = [3,2,4], target = 6
 输出：[1,2]
 示例 3：
 
 输入：nums = [3,3], target = 6
 输出：[0,1]
 
 
 提示：
 
 2 <= nums.length <= 10^4
 -10^9 <= nums[i] <= 10^9
 -10^9 <= target <= 10^9
 只会存在一个有效答案
 
 
 进阶：你可以想出一个时间复杂度小于 O(n^2) 的算法吗？
 
 */



@implementation NSObject (HashTable)

+(void)testCase {
    
    NSObject *temp = [[NSObject alloc]init];
    
    [temp test01];
    
}

- (void)test01 {
    
    NSObject *temp = [[NSObject alloc]init];
    
    int nums[3] = {3,2,4};
    int targget = 6;
    
    [temp targgetSumIndex:nums targetNum:targget];
    
    NSArray *nums1 = @[@2, @7, @11, @15];
    
    [temp targgetSumIndex1:nums1 targetNum:9];
    
}

/*
 方法一：暴力枚举
 
 思路及算法
 
 最容易想到的方法是枚举数组中的每一个数 x，寻找数组中是否存在 target - x。
 
 当我们使用遍历整个数组的方式寻找 target - x 时，需要注意到每一个位于 x 之前的元素都已经和 x 匹配过，因此不需要再进行匹配。而每一个元素不能被使用两次，所以我们只需要在 x 后面的元素中寻找 target - x。
 
 复杂度分析
 
 时间复杂度：O(N^2)，其中 N 是数组中的元素数量。最坏情况下数组中任意两个数都要被匹配一次。
 
 空间复杂度：O(1)。
 
 */
- (int*)targgetSumIndex:(int *) nums targetNum:(int) targetNum {
    
    int len = sizeof(nums);
    for (int i = 0; i < len; i++) {
        for (int j = i+1; j < len; j++) {
            
            if(nums[i] + nums[j] == targetNum){
                
                int *result = malloc(sizeof(int) * 2);
                
                result[0] = i;
                result[1] = j;
                
                NSLog(@"targgetSumIndex ===  %d , %d", i,j);
                return result;
            }
            
        }
    }
    
    return nil;
    
}

/*
 这种实现利用了 NSDictionary 的哈希表特性，通过空间换时间的方式，高效解决了两数之和问题。
 核心思路：
 1: 遍历数组时，用 NSMutableDictionary 存储已访问过的数字（key）和其索引（value）
 2: 对每个数字计算与目标值的差值（target - 当前数字）
 3: 检查哈希表中是否存在该差值：若存在，直接返回差值的索引和当前索引；若不存在，将当前数字存入哈希表
 
 优势：
 
 时间复杂度 O (n)：只需遍历一次数组，哈希表的查找操作平均为 O (1)
 空间复杂度 O (n)：最多存储 n-1 个元素
 
 */

- (void)targgetSumIndex1:(NSArray<NSNumber*> *) nums targetNum:(NSInteger) targetNum {
    
    int len = sizeof(nums);
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    
    for (int i = 0; i < len; i++) {
        
        NSNumber *currentNum = nums[i];
        
        // 计算目标差值（target - 当前元素）
        NSInteger temp = targetNum - currentNum.intValue;
        
        NSNumber *complementNum = @(temp);
        
        // 检查哈希表中是否存在该差值
        if([dic.allKeys containsObject:@(temp)]){
            
            // 存在则返回两个索引（差值的索引和当前索引）
            
            NSLog(@"targgetSumIndex NSMutableDictionary ===  %@ , %d", dic[complementNum],i);
            
            return ;
            
        }
        // 不存在则将当前元素和索引存入哈希表
        dic[currentNum] = @(i);
        
    }
    
}

@end
