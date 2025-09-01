//
//  CacheManager.h
//  Test
//
//  Created by zhang dekai on 2025/9/1.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CacheManager : NSObject

/// 保存缓存数据
/// @param data 需要缓存的数据（支持 NSDictionary / NSArray / 自定义对象，只要遵循 NSCoding）
/// @param key 缓存的唯一键
/// @param duration 有效时长（秒），超过时间则视为过期
+ (void)saveData:(id<NSObject>)data
          forKey:(NSString *)key
   validDuration:(NSTimeInterval)duration;

/// 读取缓存
/// @param key 缓存的唯一键
/// @return 缓存数据，如果过期或不存在则返回 nil
+ (id)loadDataForKey:(NSString *)key;

/// 清理指定缓存
/// @param key 缓存的唯一键
+ (void)clearCacheForKey:(NSString *)key;

/// 清理所有缓存（仅清理 CacheManager 产生的缓存文件）
+ (void)clearAllCache;

/// 设置缓存大小上限
/// @param maxSize 上限大小（单位：字节），超过后会清理旧文件
+ (void)setMaxCacheSize:(NSUInteger)maxSize;

/// 获取缓存统计信息（同步）
/// @return 字典，包含:
///   - totalSize: @(总字节数)
///   - fileCount: @(文件数量)
///   - formattedSize: @"12.3MB"（人类可读格式）
+ (NSDictionary *)cacheStats;

/// 获取缓存统计信息（异步）
/// @param completion 异步回调，结果在主线程返回
+ (void)cacheStatsAsync:(void(^)(NSDictionary *stats))completion;

@end



NS_ASSUME_NONNULL_END
