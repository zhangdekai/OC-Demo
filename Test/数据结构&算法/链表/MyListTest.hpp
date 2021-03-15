//
//  MyListTest.hpp
//  Test
//
//  Created by zhang dekai on 2019/12/25.
//  Copyright © 2019 张德凯. All rights reserved.
//

#ifndef MyListTest_hpp
#define MyListTest_hpp

#include <stdio.h>

struct MListNode;

class MyLinkedList {
    MListNode *head;//头
    MListNode *tail;//尾
    int list_size;
    
public:
    
    /** Initialize your data structure here. */
    MyLinkedList();
    int get(int index);
    
};

#endif /* MyListTest_hpp */
