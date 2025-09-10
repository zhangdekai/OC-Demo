//
//  SortTest.cpp
//  Test
//
//  Created by zhang dekai on 2019/11/5.
//  Copyright © 2019 张德凯. All rights reserved.
//

/*
 
 常见十大(内部)排序算法 - Sorting Algorithms C++
 ：https://blog.csdn.net/real_lisa/article/details/82685407
 
 算法稳定度 定义：如果排序算法并不改变两个相同值的元素的相对位置，则此算法稳定度高。

 */

#include <stdio.h>
#include <iostream>
#include <stack>
using namespace std;

#pragma mark 交换swap 三种
//MARK: - temp 交换
void swap(int &a, int &b) {
    int temp;
    temp = a;
    a = b;
    b = temp;
}

//MARK: -加法交换化
void swap1(int a, int b) {
    a = a + b;
    b = a - b;
    a = a - b;
}

//MARK: - 异或交换（相同为0，不同为1. 可以理解为不进位加法）
void swap2(int a, int b) {// 3 , 5  ==> 5 , 3
    //转为二进制
    //011 = 3 = a
    //101 = 5 = b
    //110 = a
    //101 = b
    //011 = b = 3
    //110 = a
    //101 = a = 5
    a = a ^ b;
    b = a ^ b;
    a = a ^ b;
}

#pragma mark 冒泡排序：O(n^2)  O(1)
/*
 冒泡排序：O(n^2)  O(1)
 从第一个元素开始遍历，比较当前元素跟下一个元素的大小，
 如果不符合排序，交换位置。
 结束最后一个元素后，再从头开始不断遍历，直到完成排序。
 
  *  【冒泡排序】：相邻元素两两比较，比较完一趟，最值出现在末尾
  *  第1趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第n个元素位置
  *  第2趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第n-1个元素位置
  *   ……   ……
  *  第n-1趟：依次比较相邻的两个数，不断交换（小数放前，大数放后）逐个推进，最值最后出现在第2个元素位置
 */
void buddle_sort(int a[], int n) {
    
//    int n = sizeof(a)/sizeof(a[0]);
    
    for (int i=0; i<n-1; i++) {
        
        for (int j=0; j<n-1-i; j++) {
            
            if (a[j] > a[j+1]) {
                
                swap(a[j], a[j+1]);
            }
        }
    }
}

#pragma mark 选择排序：O(n^2) O(1)
/*
 选择排序：O(n^2) O(1)
 
 维护一段有序数列，同时遍历待排序的数列，
 通常找最小的元素插入到有序数列中。
 重复直到待排序数列没有剩余元素。
 
  *  【选择排序】：最值出现在起始端
  *
  *  第1趟：在n个数中找到最小(大)数与第一个数交换位置
  *  第2趟：在剩下n-1个数中找到最小(大)数与第二个数交换位置
  *  重复这样的操作...依次与第三个、第四个...数交换位置
  *  第n-1趟，最终可实现数据的升序（降序）排列。
 */

void select(int arr[], int s){
//    int s = arr.size();
    
    for(int i = 0; i < s; i++){
        int m = arr[i];
        int index = i;
        for(int j=i+1; j < s; j++) {
            if(arr[j] < m) {//选出最大值
                m = arr[j];
                index = j;
            }
        }
        swap(arr[i], arr[index]);
    }

}
#pragma mark - 快速排序：O(n^2) O(log n)
/*
 快速排序：最差：O(n^2) O(log n)
 
 利用了 divide & conquer 的思想。（分而治之）

 1:在序列中任意选择一个数作为key值，
 2:然后把序列分成比这个数大的和比这个数小的两个子序列。
 3:不断重复以上步骤完成排序。
 */

//快速排序
int partition(int arr[], int low, int high) {
    int key;
    key = arr[low];
    while (low < high) {
        while (low < high && arr[high] >= key) {
            high--;
        }
        if (low < high) {
            arr[low++] = arr[high];
        }
        while (low < high && arr[low] <= key) {
            low++;
        }
        if (low < high) {
            arr[high--] = arr[low];
        }
    }
    arr[low] = key;
    return low;
}

#pragma mark - 快速排序：递归试
//快速排序：递归试
void quick_sort(int arr[], int low, int high) {
    int pos;
    if (low < high) {
        pos = partition(arr, low, high);
        quick_sort(arr, low, pos-1);
        quick_sort(arr, pos+1, high);
    }
}
/*
 时间复杂度：
 平均情况：O (n log n)
 最坏情况：O (n²)（当数组已经有序且每次选择最边上的元素作为基准时）
 可以通过随机选择基准元素来避免最坏情况
 空间复杂度：O (log n)（主要是递归调用栈的开销）
 
 */

// 划分函数：选择基准元素，将数组分为两部分
// 返回基准元素最终的位置索引
int partition1(vector<int>& arr, int low, int high) {
    // 选择最右边的元素作为基准
    int pivot = arr[high];
    
    // i是小于基准区域的边界索引
    int i = low - 1;
    
    // 遍历数组，将小于基准的元素放到左边
    for (int j = low; j <= high - 1; j++) {
        // 如果当前元素小于或等于基准
        if (arr[j] <= pivot) {
            i++;  // 扩展小于基准的区域
            swap(arr[i], arr[j]);  // 将当前元素放入小于基准的区域
        }
    }
    
    // 将基准元素放到正确的位置（小于基准区域的后面）
    swap(arr[i + 1], arr[high]);
    
    // 返回基准元素的索引
    return i + 1;
}

// 快速排序函数
// 参数：
//   arr: 要排序的数组
//   low: 排序区间的起始索引
//   high: 排序区间的结束索引
void quickSort(vector<int>& arr, int low, int high) {
    // 当区间有效（low < high）时才进行排序
    if (low < high) {
        // 进行划分，获取基准元素的位置
        int pi = partition1(arr, low, high);
        
        // 递归排序基准元素左边的子数组
        quickSort(arr, low, pi - 1);
        
        // 递归排序基准元素右边的子数组
        quickSort(arr, pi + 1, high);
    }
}

// 打印数组元素
void printArray(const vector<int>& arr) {
    for (int num : arr) {
        cout << num << " ";
    }
    cout << endl;
}

int mainTestQuickSort() {
    // 测试数组
    vector<int> arr = {10, 7, 8, 9, 1, 5};
    int n = arr.size();
    
    cout << "排序前的数组: ";
    printArray(arr);
    
    // 调用快速排序函数
    quickSort(arr, 0, n - 1);
    
    cout << "排序后的数组: ";
    printArray(arr);
    
    return 0;
}

#pragma mark - 快速排序：非递归
//快速排序：非递归
void quick_sort2(int num[], int low, int high) {
    stack<int> s;
    if (low < high) {
        int pos = partition(num, low, high);
        if (pos - 1 > low) {
            s.push(pos - 1);
            s.push(low);
        }
        if (pos + 1 < high) {
            s.push(high);
            s.push(pos + 1);
        }
        while (!s.empty()) {
            int l = s.top();
            s.pop();
            int r = s.top();
            s.pop();
            pos = partition(num, l, r);
            if (pos - 1 > l) {
                s.push(pos - 1);
                s.push(l);
            }
            if (pos + 1 < r) {
                s.push(r);
                s.push(pos + 1);
            }
        }
    }
}

#pragma mark - 插入排序
/*
 插入排序：最优情况是正向排序 -- O(n) 最差是逆向排序 O(n^2)  O(1)
 
 维护一段有序数列，同时遍历待排序的数列，在有序数列里找到合适的位置，插入元素。
 
 */
void insert_sort(int a[], int n) {
    for (int i = 1; i < n; i++) {
        int j = 0;
        while ((j < i) && (a[i] > a[j])) {
            j++;
        }
        if (i != j) {
            int tmp = a[i];
            for (int k = i; k > j; k--) {
                a[k] = a[k-1];
            }
            a[j] = tmp;
        }
    }
}
#pragma mark - 希尔排序：
/*
 希尔排序：
 
 简单插序的改进版，选择先插入距离远的元素。

 选择一个间距，将序列分成很多子序列并进行插入排序。
 降低间距并重复插入排序，直到间距降为1完成排序。
 
 */

void shell_sort(int a[], int n) {
    int gap;
    for( gap = n/2; gap > 0; gap /= 2){
        for(int i = gap; i < n; i ++){
            for(int j = i - gap; j >= 0 && a[j] < a[j + gap]; j-=gap){//每个元素与自己组内的元素进行插入排序
                swap(a[j], a[j + gap]);
            }
        }
    }
}

#pragma mark - 归并排序
/*
 归并排序: O(n log n)  空间：O(n)
 利用了 divde & conquer 的思维方式，有时候也称为合并排序。

 将序列不断分解为子序列直到只剩于0或1位。
 再将子序列不断按大小合并，最终恢复为原来序列的长度。
 
 */
void merge(int a[], int low ,int mid, int high,int tmp[]) {
    int i,j,k;
    i = low;
    j = mid + 1;
    k = 0;
    while (i<=mid&&j<=high) {
        if (a[i]<a[j]) {
            tmp[k++] = a[i++];
        } else {
            tmp[k++] = a[j++];
        }
    }
    
    while (i<=mid)
        tmp[k++] = a[i++];
    while(j<=high)
        tmp[k++] = a[j++];
    for (i = 0; i<k; i++) {
        a[low+i] = tmp[i];
    }
}

void merge_sort(int a[],int low, int high, int tmp[]) {
    if (low < high) {
        int mid = (low + high) / 2;
        merge_sort(a, low, mid, tmp);
        merge_sort(a, mid + 1, high, tmp);
        merge(a, low, mid, high, tmp);
    }
}


/*
 内部和外部排序

 内部排序在这里指的是只用到了电脑内存而不使用外存的排序方式。相对的，外部排序就是同时动用了电脑内存和外存的排序方式。本文在这里只讨论内部排序。

 分类

 比较和非比较排序

 比较在这里指的是需要比较两个元素的大小(前后)才能进行的排序。难道有排序算法不需要比较吗？的确有，但是不多。常见的有三种：计数排序，桶排序，基数排序。它们用统计的方法规避了比较，详细的可查看之后讲到的这些算法。

 转换

 每次只调换两个元素之间的位置。

 插入

 遍历到的元素放入之前维护的已完成排序的序列中。

 选择

 选择剩余元素中最大或最小的元素。
  
 */
