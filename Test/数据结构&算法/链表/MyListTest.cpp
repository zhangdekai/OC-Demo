//
//  MyListTest.cpp
//  Test
//
//  Created by zhang dekai on 2019/12/25.
//  Copyright © 2019 张德凯. All rights reserved.
//

#include "MyListTest.hpp"
#include <unordered_set>

using namespace std;

//MARK: - 简书：https://www.jianshu.com/p/39dceb9e30b5

//MARK: - 1：设计链表的实现
/*
 
 LeetCode：https://leetcode-cn.com/explore/learn/card/linked-list/193/singly-linked-list/741/
 
 
 您可以选择使用单链表或双链表。单链表中的节点应该具有两个属性：val 和 next。val 是当前节点的值，next 是指向下一个节点的指针/引用。如果要使用双向链表，则还需要一个属性 prev 以指示链表中的上一个节点。假设链表中的所有节点都是 0-index 的。
 
 在链表类中实现这些功能：
 
 get(index)：获取链表中第 index 个节点的值。如果索引无效，则返回-1。
 addAtHead(val)：在链表的第一个元素之前添加一个值为 val 的节点。插入后，新节点将成为链表的第一个节点。
 addAtTail(val)：将值为 val 的节点追加到链表的最后一个元素。
 addAtIndex(index,val)：在链表中的第 index 个节点之前添加值为 val  的节点。如果 index 等于链表的长度，则该节点将附加到链表的末尾。如果 index 大于链表长度，则不会插入节点。如果index小于0，则在头部插入节点。
 deleteAtIndex(index)：如果索引 index 有效，则删除链表中的第 index 个节点。
 
 示例：
 
 MyLinkedList linkedList = new MyLinkedList();
 linkedList.addAtHead(1);
 linkedList.addAtTail(3);
 linkedList.addAtIndex(1,2);   //链表变为1-> 2-> 3
 linkedList.get(1);            //返回2
 linkedList.deleteAtIndex(1);  //现在链表是1-> 3
 linkedList.get(1);            //返回3
 
 提示：
 
 所有val值都在 [1, 1000] 之内。
 操作次数将在  [1, 1000] 之内。
 请不要使用内置的 LinkedList 库。
 */

struct MListNode {//节点
    int val;
    MListNode *next;
    MListNode(int val): val(val),next(nullptr){}
    
};

#pragma mark - 链表的实现
class MyLinkedList {
    MListNode *head;//头
    MListNode *tail;//尾
    int list_size;
    
public:
    
    /** Initialize your data structure here. */
    MyLinkedList() {
        list_size = 0;
        head = new MListNode(-1);
        tail = new MListNode(-1);
        head->next = tail;//初始化外部不可见节点，后续节点插入头尾之间。
        
    }
    
    /** Get the value of the index-th node in the linked list. If the index is invalid, return -1. */
    int get(int index) {
        
        if (index < 0 || index > list_size) {
            return -1;
        }
        MListNode *node = findPre(index);
        
        return node->next->val;
    }
    
    /** Add a node of value val before the first element of the linked list. After the insertion, the new node will be the first node of the linked list. */
    void addAtHead(int val) {
        
        insert(0, val);
        
    }
    
    /** Append a node of value val to the last element of the linked list. */
    void addAtTail(int val) {
        insert(list_size, val);
    }
    
    /** Add a node of value val before the index-th node in the linked list. If index equals to the length of linked list, the node will be appended to the end of linked list. If index is greater than the length, the node will not be inserted. */
    void addAtIndex(int index, int val) {
        if (index > list_size) {
            return;
        }
        
        if (index < 0) {
            index = 0;
        }
        insert(index, val);
    }
    
    /** Delete the index-th node in the linked list, if the index is valid. */
    void deleteAtIndex(int index) {
        
        if (index < 0 || index > list_size-1) {
            return;
        }
        
        MListNode *pre = findPre(index);
        MListNode *cur = pre->next;
        pre->next = pre->next->next;
        list_size--;
        
        delete cur;
        
    }
    
private:
    
    MListNode* findPre(int index) {
        MListNode *p = head;
        while (index != 0) {
            p = p->next;
            index--;
        }
        return p;
    }
    
    void insert(int index, int val) {
        
        MListNode *pre = findPre(index);
        
        MListNode *nextNode = pre->next;
        
        MListNode *currntNode = new MListNode(-1);
        
        //插入
        pre->next = currntNode;
        currntNode->next = nextNode;
        currntNode->val = val;
        
        list_size++;
    }
};

//MARK: - 链表上判断有环
/*
 * 1:哈希表：遍历，存储元素，遇到重复的 hash.contain()，便说明是链表有环 O(n), O(n)。
 * 2:快慢指针：while 循环，快指针从head->next开始，每次都两步，
            慢指针从head开始，每次走一步，如果是环的话，肯定会相遇。
   链接：https://leetcode-cn.com/problems/linked-list-cycle/solution/huan-xing-lian-biao-by-leetcode-solution/
   */
class MyLinkListWithCycle {
    //instance variables
    
public:
    // 快慢指针
    bool hasCycle(MListNode* head) {
        if (head == nullptr || head->next == nullptr) {
            return false;
        }
        MListNode* slow = head;
        MListNode* fast = head->next;
        while (slow != fast) {
            if (fast == nullptr || fast->next == nullptr) {
                return false;
            }
            slow = slow->next;//走一步
            fast = fast->next->next;//走两步
        }
        return true;
    }
    
    //哈希表实现
    bool hasCycle1(MListNode *head) {
        
        unordered_set<MListNode*> seen;
        
        while (head != nullptr) {
            if (seen.count(head)) {
                return true;
            }
            seen.insert(head);
            head = head->next;
        }
        return false;
    }

    /*
    链接：https://leetcode-cn.com/problems/reverse-linked-list/solution/fan-zhuan-lian-biao-by-leetcode-solution-d1k2/
     */
    
    //MARK: - 反转链表  1→2→3→∅，我们想要把它改成 ∅←1←2←3
    MListNode * reverseList(MListNode *head) {
        
        MListNode *p = NULL;
        MListNode *curr = head;
        
        while (curr) {
            MListNode *temp = curr->next;
            curr->next = p;
            p = curr;
            curr = temp;
        }
        return p;
    }
    
    //MARK: - 删除排序链表中的重复元素
     MListNode * deleteDuplicates(MListNode *head) {
        
        MListNode *current = head;
        
        while (current && current->next) {
            if (current->next->val == current->val) {
                current->next = current->next->next;
            } else {
                current = current->next;
            }
        }
        return head;
    }

    /*
     
    链接：https://leetcode-cn.com/problems/remove-duplicates-from-sorted-list/solution/shan-chu-pai-xu-lian-biao-zhong-de-zhong-fu-yuan-s/
    */
    
    
    
};

