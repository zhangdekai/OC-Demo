//
//  test02.cpp
//  Test
//
//  Created by zhang dekai on 2025/9/15.
//  Copyright © 2025 张德凯. All rights reserved.
//

#include "test02.hpp"
#include <stdio.h>
#include <unordered_map>
#include <vector>

using namespace std;

#pragma mark 两数之和

/*
 
 给定一个整数数组 nums 和一个整数目标值 target，请你在该数组中找出 和为目标值 target  的那 两个 整数，并返回它们的数组下标。
 
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
 
 2 <= nums.length <= 104
 -109 <= nums[i] <= 109
 -109 <= target <= 109
 只会存在一个有效答案
 
 */

/*
 作者：力扣官方题解
 链接：https://leetcode.cn/problems/two-sum/solutions/434597/liang-shu-zhi-he-by-leetcode-solution/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 */

vector<int> twoSumHash(vector<int>& nums, int target) {
    
    int len = nums.size();
    
    unordered_map<int , int> map ;
    
    for (int i = 0; i < len; ++i) {
        auto temp = map.find(target - nums[i]);// 如果未找到键 key，返回容器的 end() 迭代器
        if (temp != map.end()) {// 找到了
            return {temp->second,i};
        }
        map[nums[i]] = i;
    }
    return {};
}


/// 暴力遍历 O(n^2)  O(1)
vector<int> twoSumForce(vector<int>& nums, int target) {
    
    int n = nums.size();
    
    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            if (nums[i] + nums[j] == target) {
                return {i, j};
            }
        }
    }
    return {};
}



#pragma mark - 三数之和

/*

 
 假设我们有一个数组 nums = [-1, 0, 1, 2, -1, -4]。
 判断是否存在三元组 [nums[i], nums[j], nums[k]] 满足 i != j、i != k 且 j != k ，
 同时还满足 nums[i] + nums[j] + nums[k] == 0 。请你返回所有和为 0 且不重复的三元组。
 
 复杂度分析
 
 时间复杂度：O(N
 2
 )，其中 N 是数组 nums 的长度。
 
 空间复杂度：O(logN)。我们忽略存储答案的空间，额外的排序的空间复杂度为 O(logN)。然而我们修改了输入的数组 nums，在实际情况下不一定允许，因此也可以看成使用了一个额外的数组存储了 nums 的副本并进行排序，空间复杂度为 O(N)。
 
 作者：力扣官方题解
 链接：https://leetcode.cn/problems/3sum/solutions/284681/san-shu-zhi-he-by-leetcode-solution/
 
 */

/// O(n^2)  O(log n)
vector<vector<int>> threeSum(vector<int>& nums) {
    int n = nums.size();
    sort(nums.begin(), nums.end());
    vector<vector<int>> ans;
    // 枚举 a
    for (int first = 0; first < n; ++first) {
        // 跳过重复元素
        if (first > 0 && nums[first] == nums[first - 1]) {
            continue;
        }
        // c 对应的指针初始指向数组的最右端
        int end = n - 1;
        int start = first + 1;
        int target = -nums[first];
        
        // 1. 方法1
        while (start < end) {
            int sum = nums[start] + nums[end];
            if(sum == target){
                ans.push_back({nums[first], nums[start], nums[end]});
                start++;
                end--;
                
                // 跳过重复元素
                while (start < end && nums[start] == nums[start -1]) {
                    start++;
                }
                while (start < end && nums[end] == nums[end +1]) {
                    end--;
                }
                
            }else if( sum > target){
                end--;
            }else {
                start++;
            }
            
        }
        
        // 方法2
        // 枚举 b
        for (int start = first + 1; start < n; ++start) {
            // 需要和上一次枚举的数不相同
            if (start > first + 1 && nums[start] == nums[start - 1]) {
                continue;
            }
            // 需要保证 b 的指针在 c 的指针的左侧
            while (start < end && nums[start] + nums[end] > target) {
                --end;
            }
            // 如果指针重合，随着 b 后续的增加
            // 就不会有满足 a+b+c=0 并且 b<c 的 c 了，可以退出循环
            if (start == end) {
                break;
            }
            if (nums[start] + nums[end] == target) {
                ans.push_back({nums[first], nums[start], nums[end]});
            }
        }
    }
    return ans;
    /*
     作者：力扣官方题解
     链接：https://leetcode.cn/problems/3sum/solutions/284681/san-shu-zhi-he-by-leetcode-solution/
     来源：力扣（LeetCode）
     著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
     
     */
}



/// 暴力法不提倡
vector<vector<int>> outPutThree(vector<int> &nums){
    
    int len = nums.size();
    if (len < 3) {
        return {};
    }
    
    vector<vector<int>> result;
    
    for (int i = 0; i < len; i++) {
        for (int j = 1; j < len; j++) {
            for (int k = 2; k< len; k++) {
                
                bool indexOk = i != j & i != k & j != k;
                
                bool resOk = nums[i] + nums[j] + nums[k] == 0;
                
                if(indexOk & resOk){
                    vector<int> indexRes = {i,j,k};
                    //
                    //                    if(!result.empty()){
                    //                        for(int m = 0; m < result.size(); m++){
                    //                            if (indexRes == result[m]) {
                    //                                return;
                    //                            }
                    //                        }
                    //
                    //                    }
                    result.push_back(indexRes);
                }
            }
        }
    }
    
    
    return result;
}


