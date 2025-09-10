platform :ios, '14.0'
inhibit_all_warnings!


# flutter setup 增加一个 flutter_main module
# 只初始化一个flutter 引擎，共用一个。

flutter_application_path = './flutter_main_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')
#eval(File.read(File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')), binding)


# 定义 Flutter Modules 路径
# PS： 此种方式不太好，多个flutter引擎加载进项目耗费内存资源性能
# 官方 Flutter 团队并 不推荐多个独立 module（因为它们会重复带来 Flutter.framework、插件依赖冲突、二进制体积膨胀），推荐的是 一个统一的 Flutter module，内部用多 package/插件拆分
#def flutter_module_paths
#  {
#    user_module: '../flutter_modules/user_module',
#    order_module: '../flutter_modules/order_module',
#    common_module: '../flutter_modules/common_module'
#  }
#end



target 'Test' do
  
  install_all_flutter_pods(flutter_application_path)

## 导入每个 Flutter Module 的 podspec
#  flutter_module_paths.each do |name, path|
#    pod name.to_s, :path => path
#  end
  
  pod 'AFNetworking' # 2023 年 1 月 17 日存档,不再维护
  pod 'SDWebImage', '5.2.3'
  pod 'MMKV', '~> 1.1.2'
  pod 'Masonry' #https://github.com/SnapKit/Masonry
  # AsyncDisplayKit ==> Texture https://texturegroup.org/docs/installation.html
  # 异步渲染kit
  pod "Texture"
  #pod "MBProgressHUD"
  #pod 'ReactiveCocoa', '~2.5.0'
  pod 'ReactiveObjC'


end

#预编译 Flutter Module 脚本
post_install do |installer|
  flutter_post_install(installer)   # 🔑 这一行很关键

#  flutter_module_paths.each do |name, path|
#    # 编译 Flutter Module 为 Framework
#    system("cd #{path} && flutter build ios-framework --output=../ios/FlutterFrameworks/#{name}")
#  end
end
