#import <UIKit/UIKit.h>

@interface MVVMUserListViewController : UIViewController

@end
/*
 
 这个完整的 MVVM 用户列表 Demo 包含以下几个核心部分：

 1. Model 层：
 MVVMUserModel：存储用户数据模型
 MVVMNetworkManager：处理网络请求，模拟数据获取
 MVVMDataRepository：数据仓库，协调网络层和模型层
 
 2. ViewModel 层：
 MVVMUserCellViewModel：处理单元格的数据转换逻辑
 MVVMUserListViewModel：处理列表的业务逻辑和数据管理
 
 3. View 层：
 MVVMUserCell：用户列表单元格，负责单个用户信息展示
 MVVMUserListView：用户列表视图，包含表格和添加按钮
 
 4. Controller 层：
 MVVMUserListViewController：作为 View 和 ViewModel 的桥梁
 
 weak代理的方式 进行数据传递，完全解耦 view 和 model。

 
 */
