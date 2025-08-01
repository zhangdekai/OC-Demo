//
//  test01.cpp
//  Leetcode_practice
//
//  Created by zhang dekai on 2021/5/22.
//  Copyright © 2021 mr dk. All rights reserved.
//

#include <stdio.h>
#include <iostream>
#include <set>
#include <vector>
#include <unordered_map>
#include <stack>
#include <map>

using namespace std;


#pragma mark 1：只出现一次的数字
/*
 
 leetcode:https://leetcode-cn.com/problems/single-number/
 
 给定一个非空整数数组，除了某个元素只出现一次以外，其余每个元素均出现两次。
 找出那个只出现了一次的元素。
 
 说明：
 
 你的算法应该具有线性时间复杂度。 你可以不使用额外空间来实现吗？
 
 示例 1:
 输入: [2,2,1]
 输出: 1
 
 示例 2:
 输入: [4,1,2,1,2]
 输出: 4
 
 */

/*
 思路：
 
 不使用额外空间，要求空间复杂度 O(1)，不申请额外空间
 
 异或解法：
 使用位运算。对于这道题，可使用异或运算 ⊕。异或运算有以下三个性质。

 1:任何数和 0 做异或运算，结果仍然是原来的数，即 a⊕0=a。
 2:任何数和其自身做异或运算，结果是 0，即 a⊕a=0。
 3: 异或运算满足交换律和结合律，即 a⊕b⊕a=b⊕a⊕a=b⊕(a⊕a)=b⊕0=b。
 
 因此ans相当于nums[0]^nums[1]^nums[2]^nums[3]^nums[4].....
 然后再根据交换律把相等的合并到一块儿进行异或（结果为0），
 然后再与只出现过一次的元素进行异或，这样最后的结果就是，只出现过一次的元素
 
 （0^任意值=任意值）
 */

int singleNumber(int* nums, int numsSize) {
    int temp = nums[0];
    if(numsSize > 1) {
        for(int i = 1; i < numsSize; i++) {
            temp = temp ^ nums[i];// 二进制式 异或操作
        }
    }
    return temp;
}
/*
 如果不考虑时间复杂度和空间复杂度的限制，这道题有很多种解法，可能的解法有如下几种。

 1:使用集合存储数字。遍历数组中的每个数字，如果集合中没有该数字，则将该数字加入集合，如果集合中已经有该数字，则将该数字从集合中删除，最后剩下的数字就是只出现一次的数字。

 2:使用哈希表存储每个数字和该数字出现的次数。遍历数组即可得到每个数字出现的次数，并更新哈希表，最后遍历哈希表，得到只出现一次的数字。

 3: 使用集合存储数组中出现的所有数字，并计算数组中的元素之和。由于集合保证元素无重复，因此计算集合中的所有元素之和的两倍，即为每个元素出现两次的情况下的元素之和。由于数组中只有一个元素出现一次，其余元素都出现两次（有异），因此用集合中的元素之和的两倍减去数组中的元素之和，剩下的数就是数组中只出现一次的数字。
 
 上述三种解法都需要额外使用 O(n) 的空间，其中 n 是数组长度。

 作者：力扣官方题解
 链接：https://leetcode.cn/problems/single-number/solutions/242211/zhi-chu-xian-yi-ci-de-shu-zi-by-leetcode-solution/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 */


// 利用C++ set容器，元素一加入，自动排序（升序），去重 特性
// 需要引入 #include<set>

int singleNumber1(vector<int>& nums){
    
    set<int> s1;
    int sum1 = 0,sum2 = 0;
    
    for (int i = 0; i < nums.size(); i++) {
        
        s1.insert(nums[i]);// insert nums 元素，会排序，去重
        
        sum1 = sum1 + nums[i];//计算 nums 元素之和
    }
    
    // 计算set中，非重复集合的元素之和
    for (set<int>::iterator t = s1.begin(); t != s1.end(); t++) {
        printf("%d \n",*t);
        sum2 += *t;
    }
    
    return 2 * sum2 - sum1;// 差值为非重复的那一个
}

void testSingleNumber1() {
    
    vector<int>nums = {2,2,34,3,3};
    
    int num = singleNumber1(nums);
    
    printf("只出现一次的数字是:%d\n",num);
}


void testSingleNumber(){
    
    int nums[5] = {2,2,34,3,3};
    
    int num = singleNumber(nums, 5);
    
    printf("只出现一次的数字是:%d\n",num);
    
    testSingleNumber1();
    
}




#pragma mark 2: 多数元素
/*
 
 leetcode:https://leetcode-cn.com/problems/majority-element/solution/duo-shu-yuan-su-by-leetcode-solution/
 
 给定一个大小为 n 的数组，找到其中的多数元素。
 多数元素是指在数组中出现次数大于 ⌊ n/2 ⌋ 的元素。
 
 你可以假设数组是非空的，并且给定的数组总是存在多数元素。
 
 
 示例 1:
 
 输入: [3,2,3]
 输出: 3
 示例 2:
 
 输入: [2,2,1,1,1,2,2]
 输出: 2
 */

int majorityElement(vector<int>& nums) {
    
    set<int> s1;
    
    for (int i = 0; i < nums.size(); i++) {
        
        s1.insert(nums[i]);
        
    }
    
    int *temp1 = (int*)malloc(sizeof(int)*s1.size());
    int j = 0;
    int count =  int(nums.size() / 2);
    
    for (set<int>::iterator t = s1.begin(); t != s1.end(); t++) {
        int temp = 0;
        for (int i = 0; i < nums.size(); i++) {
            if (*t == nums[i]) {
                temp++;
            }
        }
        if (temp > count) {
            return *t;
        }
        temp1[j] = temp;
        j++;
    }
    
    
    return 0;
    
}

int majorityElement1(int* nums, int numsSize){
    
    set<int> s1;
    
    for (int i = 0; i < numsSize; i++) {
        
        s1.insert(nums[i]);
        
    }
    
    int *temp1 = (int*)malloc(sizeof(int)*s1.size());
    int j = 0;
    int count = numsSize / 2;
    
    for (set<int>::iterator t = s1.begin(); t != s1.end(); t++) {
        int temp = 0;
        for (int i = 0; i < numsSize; i++) {
            if (*t == nums[i]) {
                temp++;
            }
        }
        if (temp > count) {
            return *t;
        }
        temp1[j] = temp;
        j++;
    }
    
    
    return 0;
}

int majorityElement2(vector<int>& nums) {
    
    unordered_map<int,int> counts;

    set<int> aa;
    
    aa.insert(12);

    int temp = 0, cnts = 0;
    
    for (int i = 0 ; i < nums.size(); i++) {
        
        counts[nums[i]]++;
        
        if (counts[nums[i]] > cnts) {
            temp = nums[i];//key
            cnts = counts[nums[i]];//value 次数
        }
    }
    
    if (cnts > (nums.size() / 2)) {
        return temp;
    }
    
    return 0;
}

void testmajorityElement(){
    
    int a[3] = {3,2,3};
    int temp = majorityElement1(a, 3);
    
    printf("1:最多的数字是:%d \n",temp);
    
    
    vector<int>s1 = {2,2,1,1,1,2,2};
    
    
    //    int temp1 =  majorityElement1(s1);
    int temp1 =  majorityElement2(s1);
    
    printf("2:最多的数字是:%d \n",temp1);
}

//MARK: - 3：合并两个有序数组
/*
 
 链接：https://leetcode-cn.com/problems/merge-sorted-array/solution/he-bing-liang-ge-you-xu-shu-zu-by-leetco-qn2i/
 */
// 先合并，后排序
void mergeArray(vector<int>& nums1, int m, vector<int>& nums2, int n) {
    
    for (int i = 0; i != n; ++i) {// 1：先直接合并成一个
        nums1[m + i] = nums2[i];
    }
    sort(nums1.begin(), nums1.end());// 2：再排序
    // O(m+n)  O(m+n)
}

// 双指针法遍历 取其中小的 加入到新数组中。
void mergeArray01(vector<int>& nums1, int m, vector<int>& nums2, int n) {
    int p1 = 0, p2 = 0;
    int sorted[m + n];
    int cur;
    while (p1 < m || p2 < n) {// p1 p2 代表两个指针
        if (p1 == m) {
            cur = nums2[p2++];
        } else if (p2 == n) {
            cur = nums1[p1++];
        } else if (nums1[p1] < nums2[p2]) {
            cur = nums1[p1++];
        } else {
            cur = nums2[p2++];
        }
        sorted[p1 + p2 - 1] = cur;
    }
    for (int i = 0; i != m + n; ++i) {
        nums1[i] = sorted[i];
    }
}

