//
//  BinaryTreeNode.h
//  Test
//
//  Created by zhang dekai on 2019/10/21.
//  Copyright © 2019 张德凯. All rights reserved.
//

/*
 数据结构之二叉树（iOS）:https://blog.csdn.net/weixin_33704591/article/details/88002022
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BinaryTreeNode : NSObject

@property(nonatomic, assign)NSInteger keyValue;         //值
@property(nonatomic, strong)BinaryTreeNode *leftNode;   //左节点
@property(nonatomic, strong)BinaryTreeNode *rightNode;  //右节点


/**
创建二叉排序树
 
@param values 数组
@return 二叉树结点
*/

+ (BinaryTreeNode *)createBinaryTreeNodeWithValues:(NSArray *)values;


/**
 查找二叉树某个位置的结点
 
 @param index 按层次便利树是的位置（从0开始）
 @param rootNode 树根结点
 @return 结点
 */
+ (BinaryTreeNode *)findTreeNodeAtIndex:(NSInteger)index withTree:(BinaryTreeNode *)rootNode;

/**
寻找最小结点
 
@param treeNode 树
@return 树中最小的结点
*/
+ (BinaryTreeNode *)findMinTreeNode:(BinaryTreeNode *)treeNode;

/**
 先序遍历
 先访问根，再遍历左子树，最后遍历右子树（递归）
 
 @param rootNode 根结点
 @param handler 访问结点处理函数
 */
+ (void)preOrderTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler;

/**
中序遍历
先遍历左子树，再访问根，最后遍历右子树（递归）
 
@param rootNode 根节点
@param handler 访问节点处理函数
*/
+ (void)inOrderTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler;


/**
 后序遍历
 先遍历左子树，再遍历右子树，最后访问根（递归）
 
 @param rootNode 根节点
 @param handler 访问节点处理函数
 */
+ (void)postOrderTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler;


/**
 层次遍历（广度优先）
 
 @param rootNode 树根节点
 @param handler 访问节点处理函数
 */
+ (void)levelTraverseBinaryTree:(BinaryTreeNode *)rootNode handle:(void(^)(BinaryTreeNode *treeNode))handler;



/**
 二叉树的深度
 
 @param rootNode 根节点
 @return 二叉树的深度
 */
+ (NSInteger)depthOfBinaryTree:(BinaryTreeNode *)rootNode;

/**
 二叉树的宽度
 
 @param rootNode 根节点
 @return 二叉树的宽度
 */
+ (NSInteger)widthOfBinaryTree:(BinaryTreeNode *)rootNode;

/**
 二叉树所有节点数（递归）
 
 @param rootNode 根节点
 @return 所有节点数
 */
+ (NSInteger)numberOfBinaryTree:(BinaryTreeNode *)rootNode;

/**
 二叉树中某层中的节点数
 
 @param level 层数
 @param rootNode 根节点
 @return 层中的节点数
 */
+ (NSInteger)numberOfBinaryTreeNodesOnLevel:(NSInteger)level inBinaryTree:(BinaryTreeNode *)rootNode;

/**
 翻转二叉树（镜像）
 
 @param rootNode 根节点
 @return 翻转后的树的根节点（就是原二叉树的根节点）
 */
+ (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode;

/**
 翻转二叉树（非递归）
 
 @param rootNode 根结点
 @return 翻转后的二叉树
 */
+ (BinaryTreeNode *)invertBinaryTreeNotRecursive:(BinaryTreeNode *)rootNode;

/**
 判断是否是完全二叉树
 完全二叉树：若设二叉树的高度为h，除第h层外，其它各层的节点数都达到最大个数，第h层有叶子节点，并且叶子节点都是从左到右依次排布
 
 @param rootNode 根节点
 @return 是否是完全二叉树
 */
+ (BOOL)isCompleteBinaryTree:(BinaryTreeNode *)rootNode;

/**
 是否是满二叉树
 满二叉树：除了叶节点外每一个节点都有左右子叶且叶节点都处在最底层的二叉树
 
 @param rootNode 根节点
 @return 是否是满二叉树
 */
+ (BOOL)isFullBinaryTree:(BinaryTreeNode *)rootNode;

/**
 是否是AVL树（平衡二叉树）
 AVL树：是一颗空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一颗平衡二叉树
 @param rootNode 根节点
 @return 是否是AVL树
 */
+ (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode;



@end

NS_ASSUME_NONNULL_END

