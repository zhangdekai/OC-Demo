//
//  KVOExploreViewController.h
//  Test
//
//  Created by 张德凯 on 2018/7/31.
//  Copyright © 2018年 张德凯. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface KVOExploreViewController : UIViewController

@end

/*
 应用：
 * 数据绑定
     * 例如，UI 控件（如 UILabel）可以监听数据模型的属性变化，自动更新显示内容，实现视图与数据的联动。
 * 状态监控
     * 监听对象的状态属性（如网络连接状态、播放进度等），在状态变化时执行相应逻辑（如更新 UI、触发回调）。
 * 依赖属性更新
     * 当一个属性的变化依赖另一个属性时，可通过 KVO 自动触发依赖属性的更新。

 KVO 的注意事项

 1. 必须移除观察者：若观察者被释放前未移除，会导致崩溃。
 2. 线程安全：observeValueForKeyPath:ofObject:change:context: 的调用线程与属性修改的线程一致，需注意 UI 操作需在主线程执行。
 3. 集合观察：观察集合（如 NSArray）时，需通过 KVC 方法（如 mutableArrayValueForKey:）修改集合才能触发 KVO。
 4. Swift 中的使用：Swift 类需标记为 @objc dynamic 才能支持 KVO（因 Swift 默认不生成动态 setter）。

 */
