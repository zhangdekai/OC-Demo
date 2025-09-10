//
//  iOSAlgorithmTest.cpp
//  Test
//
//  Created by zhang dekai on 2019/12/14.
//  Copyright © 2019 张德凯. All rights reserved.
//

#include <stdio.h>
#include <stdbool.h>
#include <assert.h>
#include <string.h>
#include <vector>

//// 使用std命名空间，避免每次都写std::
//using namespace std;

#pragma mark 1.求最大公约数
//1.求最大公约数
int maxCommonDivisor(int a, int b) {
    
    int max = 0;
    for (int i = 1; i <= b; i++) {
        if (a % i == 0 && b % i == 0) {
            max = i;
        }
    }
    return max;
}

/** 2.辗转相除法 */
int maxCommonDivisor1(int a, int b) {
    int r;
    while(a % b > 0) {
        r = a % b;
        a = b;
        b = r;
    }
    return b;
}

#pragma mark - 模拟栈，特点：先进后出
//模拟栈，特点：先进后出
static int data[1024];
static int count = 0;
static int maxSize = 1024;

bool full() {//栈满
    if (count >= maxSize) {
        return true;
    }
    return false;
}

void push(int x) {
    //    if (x > count) {
    //        return;
    //    }
    assert(!full());
    data[count++] = x;
}

bool empty() {
    if (count == 0) {
        return true;
    }
    return false;
}

int pop() {
    assert(!empty());
    return data[--count];
}

int top() {
    return data[count - 1];
}

void testStack() {
    //入栈
    for (int i = 0; i < 10; i++) {
        push(i);
    }
    //出栈
    
    while (!empty()) {
        pop();
    }
}
#pragma mark -  二分查找 最适合快速查找 O(log2n)

/* 原理：https://blog.csdn.net/NathanniuBee/article/details/83096258
 
 其基本思想是通过不断将搜索区间减半来快速定位目标元素，时间复杂度为 O (log n)。
 
 
 *  折半查找：优化查找时间（不用遍历全部数据）
 *
 *  折半查找的原理：
 *   1> 数组必须是有序的
 *   2> 必须已知min和max（知道范围）
 *   3> 动态计算mid的值，取出mid对应的值进行比较
 *   4> 如果mid对应的值大于要查找的值，那么max要变小为mid-1
 *   5> 如果mid对应的值小于要查找的值，那么min要变大为mid+1
 */

// 二分查找函数
// 参数：
//   arr: 已排序的数组（升序）
//   target: 要查找的目标值
// 返回值：
//   找到则返回目标值在数组中的索引
//   未找到则返回 -1
int binarySearch(const std::vector<int>& arr, int target) {
    
    
    // 定义搜索区间的左右边界
    int left = 0;                  // 左边界初始化为数组第一个元素的索引
    int right = arr.size() - 1;    // 右边界初始化为数组最后一个元素的索引
    
    // 当左边界小于等于右边界时，继续搜索
    while (left <= right) {
        // 计算中间元素的索引，避免溢出的写法（等价于 (left + right) / 2）
        int mid = left + (right - left) / 2;
        
        // 如果中间元素等于目标值，找到并返回索引
        if (arr[mid] == target) {
            return mid;
        }
        // 如果中间元素大于目标值，说明目标值在左半部分
        else if (arr[mid] > target) {
            right = mid - 1;  // 调整右边界，搜索区间变为 [left, mid-1]
        }
        // 如果中间元素小于目标值，说明目标值在右半部分
        else {
            left = mid + 1;   // 调整左边界，搜索区间变为 [mid+1, right]
        }
    }
    
    // 循环结束仍未找到，返回 -1 表示目标值不存在
    return -1;
}

int findKeyIndex(int *arr, int length, int key) {
    
    //要求数组必须为有序的
    
    
    int left = 0, right = length - 1, mid;
    
    while (left <= right) {
        
        mid = (left + right) / 2;
        
        if (key < arr[mid]) {
            // 调整数组 索引边界
            right = mid - 1;
        } else if (key > arr[mid]) {
            left = mid + 1;
        } else {
            return mid;
        }
    }
    
    while (left < right) {
        mid = (left + right)  /2;
        if(arr[mid] == key){
            return mid;
        } else if (arr[mid] < key){
            left = mid + 1;
        }else {
            right = mid - 1;
        }
    }
    
    return -1;
}

#pragma mark - 字符串反转
/*
 给定字符串 "hello,world",实现将其反转。输出结果：dlrow,olleh
 
 前后双指针法移动，交换。
 
 */

void char_reverse(char *cha) {
    
    //指向第一个字符
    char *begin = cha;
    
    //指向最后一个字符
    char *end = cha + strlen(cha) - 1;
    
    while (begin < end) {// begin == end 时结束
        //交换前后两个字符串，同时移动指针
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
    
    //    char *b = cha;
    //    char *e = cha + strlen(cha) - 1;
    //
    //    while (b < e) {
    //        char t = *b;
    //        *(b++)  = *e;
    //        *(e--) = t;
    //    }
    
}

#pragma mark - 合并有序数组
/*
 
 https://leetcode.cn/problems/merge-sorted-array/?envType=study-plan-v2&envId=top-interview-150
 
 给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，
 使得 num1 成为一个有序数组。
 
 说明:
 
 初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
 
 作者：力扣官方题解
 链接：https://leetcode.cn/problems/merge-sorted-array/solutions/666608/he-bing-liang-ge-you-xu-shu-zu-by-leetco-rrb0/
 来源：力扣（LeetCode）
 著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。
 
 */

/*
 
 双指针法 合并数组
 
 复杂度分析：
 时间复杂度：O(m+n)。
 指针移动单调递增，最多移动 m+n 次，因此时间复杂度为 O(m+n)。
 
 空间复杂度：O(m+n)。
 需要建立长度为 m+n 的中间数组 sorted。
 
 */

///  双指针法 合并数组
void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n){
    
    int result[m+n],i=0,q=0,p=0;
    
    /// 双指针法 p q
    /// 1. 比较大小，直接合并
    while(p < m && q < n) {
        if (nums1[p] < nums2[q]) {
            result[i++] = nums1[p++];
        } else {
            result[i++] = nums2[q++];
        }
    }
    //2. 如果nums1数组有剩余，将a数组剩余部分拼接到合并结果数组的后面
    while(p < m) {
        result[i++] = nums1[p++];
    }
    //3. 如果nums2数组有剩余，将b数组剩余部分拼接到合并结果数组的后面
    while(q < n) {
        result[i++] = nums2[q++];
    }
    
    // 4. 装载到 nums1
    for (int j = 0; j< (m + n); j++) {
        nums1[j] = result[j];
    }
    
}

///  双指针法 合并数组
void merge(std::vector<int>& nums1, int m,std:: vector<int>& nums2, int n) {
    int p1 = 0, p2 = 0;
    int sorted[m + n];
    int cur;
    
    // 优化上边 还是双指针法
    while (p1 < m || p2 < n) {
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

/*
 2. 逆向双指针
 复杂度分析
 
 时间复杂度：O(m+n)。
 指针移动单调递减，最多移动 m+n 次，因此时间复杂度为 O(m+n)。
 
 空间复杂度：O(1)。
 直接对数组 nums1
 ​    
 原地修改，不需要额外空间。
 */
void merge2(std::vector<int>& nums1, int m, std::vector<int>& nums2, int n) {
    // 倒着取值， 直接赋值给num1
    int p1 = m - 1, p2 = n - 1;
    int tail = m + n - 1;
    int cur;
    while (p1 >= 0 || p2 >= 0) {
        if (p1 == -1) {
            cur = nums2[p2--];
        } else if (p2 == -1) {
            cur = nums1[p1--];
        } else if (nums1[p1] > nums2[p2]) {
            cur = nums1[p1--];
        } else {
            cur = nums2[p2--];
        }
        // 直接赋值给num1 tail
        nums1[tail--] = cur;
    }
}

/// 3. 直接合并后排序
void merge1(std::vector<int>& nums1, int m, std:: vector<int>& nums2, int n) {
    for (int i = 0; i != n; ++i) {
        nums1[m + i] = nums2[i];
    }
    sort(nums1.begin(), nums1.end());
    
    /*
     复杂度分析
     
     时间复杂度：O((m+n)log(m+n))。
     排序序列长度为 m+n，套用快速排序的时间复杂度即可，平均情况为 O((m+n)log(m+n))。
     
     空间复杂度：O(log(m+n))。
     排序序列长度为 m+n，套用快速排序的空间复杂度即可，平均情况为 O(log(m+n))。
     
     */
}

