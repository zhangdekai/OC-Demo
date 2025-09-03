#import <UIKit/UIKit.h>

@interface RACUserListViewController : UIViewController

@end

/*
 这个完整的 Demo 使用 ReactiveCocoa 2.5 框架实现了 MVVM 架构，主要特点如下：
 架构组成

 1. Model 层：
 RACUserModel：存储用户数据模型
 RACNetworkManager：处理网络请求，模拟数据获取
 RACDataRepository：数据仓库，协调网络请求和数据处理
 
 2. ViewModel 层：
 RACUserListViewModel：列表视图模型，处理业务逻辑
 RACUserCellViewModel：单元格视图模型，负责数据转换
 
 3. View 层：
 RACUserListView：列表视图，包含表格和添加按钮
 RACUserCell：用户列表单元格，展示用户信息
 
 4. Controller 层：
 RACUserListViewController：负责信号绑定，连接 ViewModel 和 View
 响应式数据流程

 * ViewController 初始化时，将 ViewModel 的信号与 View 的 UI 更新逻辑绑定
 * 调用loadUserList后，ViewModel 通过数据仓库发起网络请求
 * 网络请求过程中，ViewModel 发送加载状态信号（isLoading = YES）
 数据返回后，经过数据仓库处理，通过信号传递给 ViewModel
 * ViewModel 将原始数据转换为 CellViewModel，通过cellViewModelsSignal发送
 * Controller 接收到数据信号，通知 View 更新表格
 * 用户点击添加按钮时，按钮点击事件通过 RAC 信号传递给 ViewModel
 * ViewModel 处理添加逻辑，完成后通过信号通知 UI 更新
 
 ReactiveCocoa 优势体现

 * 信号驱动：所有数据流转通过信号实现，逻辑清晰
 * 声明式编程：只需定义 "什么情况做什么事"，无需关心 "如何做"
 * 自动线程管理：网络请求在后台，UI 更新在主线程，无需手动切换
 * 减少模板代码：替代了传统的代理、Block 回调，代码更简洁
 * 强大的信号操作：可轻松实现信号过滤、转换、组合等复杂操作
 */
