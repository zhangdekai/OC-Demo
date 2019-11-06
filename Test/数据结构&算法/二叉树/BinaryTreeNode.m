//
//  BinaryTreeNode.m
//  Test
//
//  Created by zhang dekai on 2019/10/21.
//  Copyright © 2019 张德凯. All rights reserved.
//

#import "BinaryTreeNode.h"

@implementation BinaryTreeNode

/**
 创建二叉排序树
 
 @param values 数组
 @return 二叉树结点
 */

+ (BinaryTreeNode *)createBinaryTreeNodeWithValues:(NSArray *)values {
    BinaryTreeNode *rootNode = nil;
    for (NSInteger i = 0; i < values.count; i ++) {
        NSInteger value = [[values objectAtIndex:i] integerValue];
        rootNode = [BinaryTreeNode addBinaryTreeNode:rootNode andValue:value];
    }
    return rootNode;
}


/**
 向树结点添加结点
 
 @param treeNode 根结点
 @param value 结点值
 @return 根结点
 */
+ (BinaryTreeNode *)addBinaryTreeNode:(BinaryTreeNode *)treeNode andValue:(NSInteger)value {
    if (!treeNode) {
        // 结点不存在，创建新结点
        treeNode = [[BinaryTreeNode alloc]init];
        treeNode.keyValue = value;
    }else if (value < treeNode.keyValue) {
        // 生成左子树
        treeNode.leftNode = [BinaryTreeNode addBinaryTreeNode:treeNode.leftNode andValue:value];
    }else {
        // 生成右子树
        treeNode.rightNode = [BinaryTreeNode addBinaryTreeNode:treeNode.rightNode andValue:value];
    }
    return treeNode;
}

/**
 查找二叉树某个位置的结点(二叉树从根节点，按层级 自上而下遍历索取那个位置的 节点)
 
 @param index 按层次便利树是的位置（从0开始）
 @param rootNode 树根结点
 @return 结点
 */
+ (BinaryTreeNode *)findTreeNodeAtIndex:(NSInteger)index withTree:(BinaryTreeNode *)rootNode {
    // 结点不存在，查找的位置不符合规范
    if (!rootNode || index < 0) {
        return nil;
    }
    
    //    NSMutableArray *queueArray = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *queueArray = [NSMutableArray array];
    
    // 压入根结点
    [queueArray addObject:rootNode];
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        if (index == 0) {
            return node;
        }
        [queueArray removeObjectAtIndex:0];     // 仿照队列FIFO，t移除最前面的结点
        index--;
        
        // 按照从左到右依次压入结点
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
    
    //  遍历完，还没有找到位置，返回nil
    return nil;
}
/**
 寻找最小结点
 
 @param treeNode 树
 @return 树中最小的结点
 */
+ (BinaryTreeNode *)findMinTreeNode:(BinaryTreeNode *)treeNode {
    if (!treeNode) {
        return nil;
    }
    if (!treeNode.leftNode) {//第一个没有左节点的 节点
        return treeNode;
    } else {
        return [BinaryTreeNode findMinTreeNode:treeNode.leftNode];
    }
}


/**
 先序遍历
 先访问根，再遍历左子树，最后遍历右子树（递归）
 
 @param rootNode 根结点
 @param handler 访问结点处理函数
 */
+ (void)preOrderTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        if (handler) {
            handler(rootNode);
        }
        
        [self preOrderTraverseBinaryTree:rootNode.leftNode handle:handler];
        [self preOrderTraverseBinaryTree:rootNode.rightNode handle:handler];
    }
}

/**
 中序遍历
 先遍历左子树，再访问根，最后遍历右子树（递归）
 
 @param rootNode 根节点
 @param handler 访问节点处理函数
 */
+ (void)inOrderTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        
        [self inOrderTraverseBinaryTree:rootNode.leftNode handle:handler];
        
        if (handler) {
            handler(rootNode);
        }
        
        [self inOrderTraverseBinaryTree:rootNode.rightNode handle:handler];
    }
}

/**
 后序遍历
 先遍历左子树，再遍历右子树，最后访问根（递归）
 
 @param rootNode 根节点
 @param handler 访问节点处理函数
 */
+ (void)postOrderTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler {
    if (rootNode) {
        [self postOrderTraverseBinaryTree:rootNode.leftNode handle:handler];
        [self postOrderTraverseBinaryTree:rootNode.rightNode handle:handler];
        
        if (handler) {
            handler(rootNode);
        }
    }
}

/**
 层次遍历（广度优先）
 
 @param rootNode 树根节点
 @param handler 访问节点处理函数
 */
+ (void)levelTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler {
    if (!rootNode) {
        return;
    }
    
    NSMutableArray *queueArray = [NSMutableArray arrayWithCapacity:0];      // 数组当作队列
    [queueArray addObject:rootNode];    // 压入根节点
    
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        
        if (handler) {
            handler(node);
        }
        
        [queueArray removeObjectAtIndex:0];
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];   // 压入左节点
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];  // 压入右节点
        }
    }
}

/**
 二叉树的深度
 
 @param rootNode 根节点
 @return 二叉树的深度
 */
+ (NSInteger)depthOfBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return 1;
    }
    
    // 左子树的深度
    NSInteger leftDepth = [self depthOfBinaryTree:rootNode.leftNode];
    // 右子树的深度
    NSInteger rightDepth = [self depthOfBinaryTree:rootNode.rightNode];
    
    return MAX(leftDepth, rightDepth) + 1;
}


/**
 二叉树的宽度
 
 @param rootNode 根节点
 @return 二叉树的宽度
 */
+ (NSInteger)widthOfBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    
    NSMutableArray *queueArray = [NSMutableArray arrayWithCapacity:0];
    
    [queueArray addObject:rootNode];
    
    NSInteger maxWidth = 1;     // 初始化最大宽度 1
    NSInteger curWidth = 0;     // 当前层数的宽度
    
    while (queueArray.count > 0) {
        
        curWidth = queueArray.count;
        
        for (int i = 0; i < curWidth; i ++) {
            
            BinaryTreeNode *node = [queueArray firstObject];
            
            [queueArray removeObjectAtIndex:0];
            
            if (node.leftNode) {
                [queueArray addObject:node.leftNode];
            }
            if (node.rightNode) {
                [queueArray addObject:node.rightNode];
            }
        }
        // 宽度 = 当前层节点数
        maxWidth = MAX(maxWidth, queueArray.count);
    }
    return maxWidth;
}

/**
 二叉树所有节点数（递归）
 
 @param rootNode 根节点
 @return 所有节点数
 */
+ (NSInteger)numberOfBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    
    NSInteger leftNumber = [self numberOfBinaryTree:rootNode.leftNode];
    NSInteger rightNumber = [self numberOfBinaryTree:rootNode.rightNode];
    
    // 节点数 = 左子树节点数 + 右子树节点数 + 1（根节点）
    return leftNumber + rightNumber + 1;
}

/**
 二叉树中某层中的节点数
 
 @param level 层数
 @param rootNode 根节点
 @return 层中的节点数
 */
+ (NSInteger)numberOfBinaryTreeNodesOnLevel:(NSInteger)level inBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode || level < 1) {
        return 0;
    }
    if (level == 1) {   // 根节点
        return 1;
    }
    
    // 递归：level层节点数 = 左子树level-1层节点数 + 右子树level-1层节点数
    NSInteger leftNodes = [self numberOfBinaryTreeNodesOnLevel:level - 1 inBinaryTree:rootNode.leftNode];
    NSInteger rightNodes = [self numberOfBinaryTreeNodesOnLevel:level - 1 inBinaryTree:rootNode.rightNode];
    
    return leftNodes + rightNodes;
}

/**
 翻转二叉树（镜像）
 
 @param rootNode 根节点
 @return 翻转后的树的根节点（就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    [self invertBinaryTree:rootNode.leftNode];
    [self invertBinaryTree:rootNode.rightNode];
    
    BinaryTreeNode *tempNode = rootNode.leftNode;
    rootNode.leftNode = rootNode.rightNode;
    rootNode.rightNode = tempNode;
    
    return rootNode;
}

/**
 翻转二叉树（非递归）
 
 @param rootNode 根结点
 @return 翻转后的二叉树
 */
+ (BinaryTreeNode *)invertBinaryTreeNotRecursive:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return nil;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return rootNode;
    }
    
    NSMutableArray *queueArray = [NSMutableArray arrayWithCapacity:0];
    [queueArray addObject:rootNode];
    
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        [queueArray removeObjectAtIndex:0];
        
        BinaryTreeNode *tempNode = node.leftNode;
        node.leftNode = node.rightNode;
        node.rightNode = tempNode;
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
    return rootNode;
}


/**
 判断是否是完全二叉树
 完全二叉树：若设二叉树的高度为h，除第h层外，其它各层的节点数都达到最大个数，第h层有叶子节点，并且叶子节点都是从左到右依次排布
 
 @param rootNode 根节点
 @return 是否是完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        return YES;
    }
    if (!rootNode.leftNode && rootNode.rightNode) {
        return NO;
    }
    /**
     按层次遍历节点，找到满足完全二叉树的条件：
     条件1：如果某个节点的右子树不为空，则它的左子树必须不为空
     条件2：如果某个节点的右子树为空，则排在它后面的节点必须没有孩子节点
     排在该节点后面的节点有2种：1）同层次的后面的节点 2）同层次的前面的节点的孩子节点
     */
    NSMutableArray *queueArray = [NSMutableArray arrayWithCapacity:0];
    [queueArray addObject:rootNode];
    BOOL isComplete = NO;   // 是否是完全二叉树
    
    while (queueArray.count > 0) {
        BinaryTreeNode *node = [queueArray firstObject];
        [queueArray removeObjectAtIndex:0];
        
        // 左子树为空且右子树不为空，则不是完全二叉树
        if (!node.leftNode && node.rightNode) {
            return NO;
        }
        
        // 前面的节点已满足完全二叉树，如果还有孩子节点，则不是完全二叉树
        if (isComplete && (node.leftNode || node.rightNode)) {
            return NO;
        }
        
        // 右子树为空，则已满足完全二叉树
        if (!node.rightNode) {
            isComplete = YES;
        }
        
        if (node.leftNode) {
            [queueArray addObject:node.leftNode];
        }
        if (node.rightNode) {
            [queueArray addObject:node.rightNode];
        }
    }
    return isComplete;
}

/**
 是否是满二叉树
 满二叉树：除了叶节点外每一个节点都有左右子叶且叶节点都处在最底层的二叉树
 
 @param rootNode 根节点
 @return 是否是满二叉树
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return NO;
    }
    
    // 深度
    NSInteger depth = [self depthOfBinaryTree:rootNode];
    // 二叉树叶子节点数
    NSInteger leafNum = [self numberOfBinaryTree:rootNode];
    
    // 是否满足：叶子树 = 2^(深度 - 1)
    if (leafNum == pow(2, depth - 1)) {
        return YES;
    }
    return NO;
}

/**
 是否是AVL树（平衡二叉树）
 AVL树：是一颗空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一颗平衡二叉树
 @param rootNode 根节点
 @return 是否是AVL树
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode {
    //static修饰局部变量时，在程序中只有一份内存，并延长其生命周期
    static NSInteger height;
    if (!rootNode) {
        height = 0;
        return YES;
    }
    if (!rootNode.leftNode && !rootNode.rightNode) {
        height = 1;
        return YES;
    }
    
    // 左子树是否是AVL树
    BOOL isAVLLeftTree = [self isAVLBinaryTree:rootNode.leftNode];
    NSInteger heightLeft = height;
    // 右子树是否是AVL树
    BOOL isAVLRightTree = [self isAVLBinaryTree:rootNode.rightNode];
    NSInteger heightRight = height;
    
    height = MAX(heightLeft, heightRight) + 1;
    
    // 左右两颗子树的高度差的绝对值不超过1且两个子树都是AVL树
    if (isAVLLeftTree && isAVLRightTree && ABS(heightLeft - heightRight) <= 1) {
        return YES;
    }
    return NO;
}
@end
