#import <UIKit/UIKit.h>

@interface MVCUserListViewController : UIViewController

@end
    
/*
 这个 Demo 严格遵循 MVC 架构，并增加了独立的网络层，各组件职责如下：

 1. 模型层（Model）
 * MVCUserModel：用户数据模型，存储用户的姓名、年龄、地址、爱好等信息
 * MVCDataManager：数据管理层，负责业务逻辑处理，调用网络层获取数据并解析为模型对象
 
 2. 视图层（View）
 * MVCUserListView：列表视图，负责展示用户列表和添加按钮
 * MVCUserCell：列表单元格，负责展示单个用户的详细信息
 * 视图层不处理业务逻辑，通过代理将用户交互事件传递给控制器
 
 3. 控制器层（Controller）
 *MVCUserListViewController：协调模型和视图，接收视图的事件并调用模型层处理，接收模型层的数据更新并通知视图刷新
 
 4. 网络层
 * MVCNetworkManager：独立的网络工具类，封装了 GET 和 POST 请求
 * 模拟网络请求延迟和返回数据，实际项目中可替换为真实网络请求
 * 网络层不依赖于任何业务逻辑，可在整个应用中复用
 
 代理（Delegate）是实现组件间通信的核心机制之一，尤其在 "Model→Controller→View" 的数据传递链路中发挥关键作用。
 代理的核心作用是解耦通知关系（Model 通知 Controller 数据就绪），而数据最终通过 Controller 主动调用 View 的接口完成传递。
 
 通过代理传递数据的核心设计

 * 代理是间接传递的桥梁：数据不会从 Model 直接到 View，必须经过 Controller 中转（Model→Controller→View），严格遵守 MVC 的分层原则。
 * View 层不持有代理数据：View 层通过 Controller 主动传递的方法（如updateWithUserList:）接收数据，而非通过代理直接获取数据，确保 View 层的被动性。
 * 代理仅用于 "通知" 而非 "取数"：Model 层的代理是为了通知 Controller"数据已更新"，而 Controller 向 View 传递数据是直接调用方法，两者协作完成链路。
 
 */
