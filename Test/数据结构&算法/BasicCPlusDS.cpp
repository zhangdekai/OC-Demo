//
//  BasicCPlusDS.cpp
//  Test
//
//  Created by zhang dekai on 2025/9/15.
//  Copyright © 2025 张德凯. All rights reserved.
//

#include "BasicCPlusDS.hpp"
#include <array>
#include <vector>


void createArray(){
    
    // 1. 传统 C 风格数组（固定大小）
    // 声明并初始化（指定大小）
    int arr1[5] = {1, 2, 3, 4, 5};

    // 声明并部分初始化（未初始化元素为0）
    int arr2[5] = {1, 2};  // 元素为 1, 2, 0, 0, 0

    // 不指定大小，由初始化列表决定
    int arr3[] = {10, 20, 30};  // 自动推断大小为3

    // 字符数组（字符串）
    char str1[10] = "hello";
    char str2[] = "world";  // 自动包含结束符'\0'

}

void createArray1(){
    // 2. new 一个动态数组
    int n = 5;
    int *arr = new int[n];  // 动态分配大小为n的int数组

    // 初始化动态数组
    for (int i = 0; i < n; i++) {
        arr[i] = i + 1;
    }

    // 使用完后必须释放内存，避免内存泄漏
    delete[] arr;
}

// 固定大小数组，带有边界检查和迭代器支持
void createArray2(){
    
    array<int, 5> arr = {1,2,3};
    // 声明并初始化
    array<int, 5> arr1 = {1, 2, 3, 4, 5};

    // 访问元素
    int value = arr1[2];  // 下标访问
    int size = arr1.size();  // 获取大小（5）
}

void createArray3(){
    // 声明并初始化
    vector<int> vec1 = {1, 2, 3};

    // 声明空数组，后续添加元素
    vector<int> vec2;
    
    vec2.push_back(4);  // 添加元素
    vec2.push_back(5);

    // 获取大小
    int size = vec2.size();  // 结果为2
    
    sort(vec1.begin(), vec1.end());
}
