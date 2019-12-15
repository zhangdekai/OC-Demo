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

#pragma mark 1.求最大公约数
//1.求最大公约数
int maxCommonDivisor(int a, int b) {
    
    int max = 0;
    for (int i = 1; i <=b; i++) {
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
#pragma mark 模拟栈，特点：先进后出
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
#pragma mark 二分查找 最适合快速查找 O(log2n)

/* 原理：https://blog.csdn.net/NathanniuBee/article/details/83096258
 *  折半查找：优化查找时间（不用遍历全部数据）
  *
  *  折半查找的原理：
  *   1> 数组必须是有序的
  *   2> 必须已知min和max（知道范围）
  *   3> 动态计算mid的值，取出mid对应的值进行比较
  *   4> 如果mid对应的值大于要查找的值，那么max要变小为mid-1
  *   5> 如果mid对应的值小于要查找的值，那么min要变大为mid+1
 */
int findKeyIndex(int *arr, int length, int key) {
    
    //要求数组必须为有序的
    
    int left = 0, right = length - 1, mid;
    
    while (left <= right) {
        
        mid = (left + right) / 2;
        
        if (key < arr[mid]) {
            right = mid - 1;
        } else if (key > arr[mid]) {
            left = mid + 1;
        } else {
            return mid;
        }
    }
    
    return -1;
}

#pragma mark 字符串反转
/*
 给定字符串 "hello,world",实现将其反转。输出结果：dlrow,olleh
 */

void char_reverse(char *cha) {
    
    //指向第一个字符
    char *begin = cha;
    
     //指向最后一个字符
    char *end = cha + strlen(cha) - 1;
    
    while (begin < end) {
        //交换前后两个字符串，同时移动指针
        char temp = *begin;
        *(begin++) = *end;
        *(end--) = temp;
    }
    
}
#pragma mark 合并有序数组
/*
 给定两个有序整数数组 nums1 和 nums2，将 nums2 合并到 nums1 中，使得 num1 成为一个有序数组。

 说明:

 初始化 nums1 和 nums2 的元素数量分别为 m 和 n。
 你可以假设 nums1 有足够的空间（空间大小大于或等于 m + n）来保存 nums2 中的元素。
 */
void merge(int* nums1, int nums1Size, int m, int* nums2, int nums2Size, int n){
    
    int result[m+n],i=0,q=0,p=0;
    
    while(p < m && q < n) {
        if (nums1[p] < nums2[q]) {
            result[i++] = nums1[p++];
        } else {
            result[i++] = nums2[q++];
        }
    }
    //如果nums1数组有剩余，将a数组剩余部分拼接到合并结果数组的后面
    while(p < m) {
        result[i++] = nums1[p++];
    }
    //如果nums2数组有剩余，将b数组剩余部分拼接到合并结果数组的后面
    while(q < n) {
         result[i++] = nums2[q++];
    }
    for (int j = 0; j< (m + n); j++) {
        nums1[j] = result[j];
    }

}

