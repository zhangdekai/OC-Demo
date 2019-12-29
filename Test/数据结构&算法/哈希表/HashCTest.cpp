//
//  HashCTest.cpp
//  Test
//
//  Created by zhang dekai on 2019/12/23.
//  Copyright © 2019 张德凯. All rights reserved.
//

#include "HashCTest.hpp"
#include <vector>

using namespace std;
/*
 不使用任何内建的哈希表库设计一个哈希集合

 具体地说，你的设计应该包含以下的功能

 add(value)：向哈希集合中插入一个值。
 contains(value) ：返回哈希集合中是否存在这个值。
 remove(value)：将给定值从哈希集合中删除。如果哈希集合中没有这个值，什么也不做。
 
 注意：
 所有的值都在 [0, 1000000]的范围内。
 操作的总数目在[1, 10000]范围内。
 不要使用内建的哈希集合库。
 */
#pragma mark - 设计哈希集合
struct HashNode {
    int val;
    HashNode *next;
    HashNode(int val): val(val),next(nullptr){}
};

const int len = 100;

class MyHashSet {
    
public:
    vector<HashNode*> arr;
    
    MyHashSet(){
        HashNode *node = new HashNode(-1);
        arr = vector<HashNode*>(len, node);
        
    }
    
    void add(int key) {
        
        int haval = key % len;
        HashNode *temp = arr[haval];
        
        if (temp->val != -1) {
            
            while (temp) {
                if (temp->val == key) {
                    return;
                }
                
                if (!temp->next) {
                    HashNode *node  = new HashNode(key);
                    temp->next = node;
                    return;
                }
                
                temp = temp->next;
            }
            
        } else {
            temp->val = key;
            return;
        }
    }
    
    void remove(int key) {
        
        int haval = key % len;
        HashNode *temp = arr[haval];
        if (temp->val != -1) {
            while (temp) {
                if (temp->val == key) {
                    temp->val = -1;
                    return;
                }
                temp = temp->next;
            }
        }
    }
    
    bool contains(int key) {
        
        int haval = key % len;
        
        HashNode *temp = arr[haval];
        
        while (temp) {
            if (temp->val == key) {
                return true;
            }
            temp = temp->next;
        }
        
        return false;
    }
    
};

/*
 不使用任何内建的哈希表库设计一个哈希映射

 具体地说，你的设计应该包含以下的功能

 put(key, value)：向哈希映射中插入(键,值)的数值对。如果键对应的值已经存在，更新这个值。
 get(key)：返回给定的键所对应的值，如果映射中不包含这个键，返回-1。
 remove(key)：如果映射中存在这个键，删除这个数值对。
 
 注意：

 所有的值都在 [1, 1000000]的范围内。
 操作的总数目在[1, 10000]范围内。
 不要使用内建的哈希库。
 */
#pragma mark - 设计一个哈希映射
struct HashNode1 {
    int key;
    int val;
    HashNode1 *next;
    HashNode1(int key, int val): key(key),val(val),next(nullptr){}
};

const int len1 = 1000;

class MyHashMap {
    
public:
    vector<HashNode1*>arr;
    
    MyHashMap(){
        arr = vector<HashNode1*>(len1, new HashNode1(-1,-1));
    }
    
    void put(int key, int val) {
        
        int index = key % len1;
        HashNode1 *node = arr[index];
        HashNode1 *tempNode = nullptr;
        
        while (node) {
            if (node->key == key) {
                node->val = val;
                return;
            }
            tempNode = node;
            node = node->next;
        }
        
        HashNode1 *node1 = new HashNode1(key,val);
        tempNode->next = node1;
        
    }
    
    int get(int key) {
        
        int index = key % len1;
        HashNode1 *h = arr[index];
        
        while (h) {
            if (h->key == key) {
                return h->val;
            }
            h = h->next;
        }
        
        return -1;
    }
    
    void remove(int key) {
        int index = key % len1;
        HashNode1 *h = arr[index];
        while (h) {
            if (h->key == key) {
                h->val = -1;
            }
            h = h->next;
        }
    }
};
