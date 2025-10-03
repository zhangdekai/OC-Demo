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
#include <unordered_map>

using namespace std;


#pragma mark - Array

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

#pragma mark - Array

/// unordered_map 的 API 设计与其他容器类似，核心围绕键值对的增删查改。
/// 其优势是哈希表的 O (1) 平均查找效率，适合需要快速根据键访问值的场景
///
void createMap(){
    
    unordered_map<string, int> map;
    
    

    
    // 默认构造
//    std::unordered_map<std::string, int> map1;
    unordered_map<string, int> map1;
    

    // 初始化列表构造
//    std::unordered_map<std::string, int> map2 = {{"a", 1}, {"b", 2}};
    unordered_map<string, int> map2 = {{"a", 1}, {"b",2}};

    // 拷贝构造
    std::unordered_map<std::string, int> map3(map2);
    unordered_map<string, int> map31(map2); // copy

    // 移动构造
    std::unordered_map<std::string, int> map4(std::move(map2));
    
    
    /// operator[]：访问或插入键值对（若键不存在则插入默认值）
    map1["key"] = 10;       // 插入或修改键 "key" 的值
    int value = map1["key"]; // 访问键 "key" 的值（若不存在则插入默认值 0）
    
    try {
        int val = map.at("key");
    } catch (const std::out_of_range& e) {
        // 处理键不存在的情况
    }
    
    
    /// insert(...)：插入键值对（若键已存在则不插入）
    // 插入单对键值
    map.insert({"c", 3});
    map.insert(std::make_pair("d", 4));

    // 插入范围
    map.insert(map2.begin(), map2.end());
    
    /// emplace(...)：就地构造键值对（效率更高，避免拷贝）
    map.emplace("e", 5); // 直接构造键 "e"、值 5 的键值对
    
    /// emplace_hint(...)：带位置提示的插入（可能优化插入效率）
    map.emplace_hint(map.begin(), "f", 6);
    
    
    /// erase(...)：删除指定键或迭代器位置的元素
    map.erase("a");               // 按键删除，返回删除的元素数（0 或 1）
    map.erase(map.begin());       // 按迭代器删除，返回下一个迭代器
    map.erase(map.begin(), map.end()); // 删除范围内的元素
    
    /// clear()：清空所有元素

    map.clear(); // 容器变为空，size() 为 0
    
    /// find(key)：查找键，返回对应迭代器（不存在则返回 end()）
    auto it = map.find("key");
    if (it != map.end()) {
        // 找到键，访问值：it->second
    }
    
    /// count(key)：返回键的存在次数（由于键唯一，返回 0 或 1）

    if (map.count("key") > 0) {
        // 键存在
    }
    
    /// size()：返回元素个数
    int n = map.size();
    
    /// empty()：判断容器是否为空
    if (map.empty()) {
        // 容器为空
    }

    /// reserve(n)：预分配存储空间，避免多次扩容
    map.reserve(100); // 预留至少能存 100 个元素的空间
    
    
    /// begin() / end()：返回正向迭代器（遍历所有元素）
    for (auto it = map.begin(); it != map.end(); ++it) {
//        std::cout << it->first << ": " << it->second << std::endl;
        
        // cbegin() / cend()：返回 const 正向迭代器（不能修改元素）
        // rbegin() / rend()：返回反向迭代器（从尾部开始遍历）

    }
    
    /// 哈希桶相关（特有）
    /// bucket_count()：返回哈希桶的数量
    /// load_factor()：返回当前负载因子（元素数 / 桶数）
    /// max_load_factor()：获取或设置最大负载因子（超过则自动扩容）
    ///
    map.max_load_factor(0.8); // 设置最大负载因子为 0.8
    
    
    
    
    
}
