//
//  FlutterChannelBridge.m
//  Test
//
//  Created by zhangdekai on 2025/10/3.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "FlutterChannelBridge.h"

@implementation FlutterChannelBridge


- (void)registerFlutterChanel:(FlutterViewController *) flutterVC {
    
    // 原生端发送消息到 Flutter
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"com.example/channel" binaryMessenger:flutterVC];
    
    [channel invokeMethod:@"nativeToFlutter" arguments:@{@"message": @"Hello from OC"} result:^(id  _Nullable result) {
        NSLog(@"Flutter 返回结果: %@", result);
    }];

    // 原生端接收 Flutter 消息
    [channel setMethodCallHandler:^(FlutterMethodCall * _Nonnull call, FlutterResult  _Nonnull result) {
        if ([call.method isEqualToString:@"flutterToNative"]) {
            NSLog(@"收到 Flutter 消息: %@", call.arguments);
            result(@"已收到消息");
        } else {
            result(FlutterMethodNotImplemented);
        }
    }];
}

@end
