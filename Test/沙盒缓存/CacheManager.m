//
//  CacheManager.m
//  Test
//
//  Created by zhang dekai on 2025/9/1.
//  Copyright © 2025 张德凯. All rights reserved.
//

#import "CacheManager.h"

/*
 
 ✅ 特性总结：

 支持 内存缓存 + 磁盘缓存 双层机制。

 支持 过期时间，过期自动清理。

 支持 缓存大小上限，自动删除最旧缓存。

 提供 同步/异步缓存统计接口，可直接用于 UI 展示。

 详细注释，便于维护。
 
 */

@implementation CacheManager

/// 静态缓存 (内存缓存)
static NSCache *_memoryCache;
/// 缓存大小上限（字节）
static NSUInteger _maxCacheSize = 50 * 1024 * 1024; // 默认 50MB

#pragma mark - 公共方法

+ (void)initialize {
    if (self == [CacheManager self]) {
        _memoryCache = [[NSCache alloc] init];
    }
}

+ (void)saveData:(id<NSObject>)data
          forKey:(NSString *)key
   validDuration:(NSTimeInterval)duration {
    if (!key || !data) return;
    
    // 1. 包装数据和过期时间
    NSDictionary *wrapper = @{
        @"data": data,
        @"expire": @([[NSDate date] timeIntervalSince1970] + duration)
    };
    
    // 2. 保存到内存缓存
    [_memoryCache setObject:wrapper forKey:key];
    
    // 3. 序列化存储到磁盘
    NSString *filePath = [self filePathForKey:key];
    [NSKeyedArchiver archiveRootObject:wrapper toFile:filePath];
    
    // 4. 检查磁盘缓存是否超出限制
    [self enforceCacheLimit];
}

+ (id)loadDataForKey:(NSString *)key {
    if (!key) return nil;
    
    // 1. 先读内存缓存
    NSDictionary *wrapper = [_memoryCache objectForKey:key];
    
    // 2. 如果内存没有，从磁盘读取
    if (!wrapper) {
        NSString *filePath = [self filePathForKey:key];
        wrapper = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
        if (wrapper) {
            [_memoryCache setObject:wrapper forKey:key]; // 放回内存
        }
    }
    
    if (!wrapper) return nil;
    
    // 3. 检查过期
    NSTimeInterval expireTime = [wrapper[@"expire"] doubleValue];
    if ([[NSDate date] timeIntervalSince1970] > expireTime) {
        [self clearCacheForKey:key];
        return nil;
    }
    
    return wrapper[@"data"];
}

+ (void)clearCacheForKey:(NSString *)key {
    if (!key) return;
    
    // 移除内存缓存
    [_memoryCache removeObjectForKey:key];
    
    // 移除磁盘缓存
    NSString *filePath = [self filePathForKey:key];
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
}

+ (void)clearAllCache {
    // 清理内存
    [_memoryCache removeAllObjects];
    
    // 清理磁盘
    NSString *cacheDir = [self cacheDirectory];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cacheDir error:nil];
    
    for (NSString *file in files) {
        if ([file hasPrefix:@"cache_"]) {
            NSString *path = [cacheDir stringByAppendingPathComponent:file];
            [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        }
    }
}

+ (void)setMaxCacheSize:(NSUInteger)maxSize {
    _maxCacheSize = maxSize;
}

+ (NSDictionary *)cacheStats {
    NSString *cacheDir = [self cacheDirectory];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cacheDir error:nil];
    
    unsigned long long totalSize = 0;
    NSUInteger fileCount = 0;
    
    for (NSString *file in files) {
        if (![file hasPrefix:@"cache_"]) continue;
        
        NSString *path = [cacheDir stringByAppendingPathComponent:file];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        totalSize += [attrs fileSize];
        fileCount++;
    }
    
    return @{
        @"totalSize": @(totalSize),
        @"fileCount": @(fileCount),
        @"formattedSize": [self humanReadableSize:totalSize]
    };
}

+ (void)cacheStatsAsync:(void(^)(NSDictionary *stats))completion {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *stats = [self cacheStats];
        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(stats);
            });
        }
    });
}

#pragma mark - 私有方法

/// 获取缓存目录路径
+ (NSString *)cacheDirectory {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

/// 根据 key 生成文件路径
+ (NSString *)filePathForKey:(NSString *)key {
    NSString *cacheDir = [self cacheDirectory];
    return [cacheDir stringByAppendingPathComponent:[NSString stringWithFormat:@"cache_%@", key]];
}

/// 格式化字节大小为可读字符串
+ (NSString *)humanReadableSize:(unsigned long long)size {
    if (size < 1024) {
        return [NSString stringWithFormat:@"%llu B", size];
    } else if (size < 1024 * 1024) {
        return [NSString stringWithFormat:@"%.2f KB", size / 1024.0];
    } else if (size < 1024 * 1024 * 1024) {
        return [NSString stringWithFormat:@"%.2f MB", size / 1024.0 / 1024.0];
    } else {
        return [NSString stringWithFormat:@"%.2f GB", size / 1024.0 / 1024.0 / 1024.0];
    }
}

/// 检查并执行缓存大小限制策略
+ (void)enforceCacheLimit {
    NSDictionary *stats = [self cacheStats];
    unsigned long long totalSize = [stats[@"totalSize"] unsignedLongLongValue];
    
    if (totalSize <= _maxCacheSize) return;
    
    // 超出上限 → 按修改时间排序，删除最旧的文件
    NSString *cacheDir = [self cacheDirectory];
    NSArray *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:cacheDir error:nil];
    NSMutableArray *fileInfos = [NSMutableArray array];
    
    for (NSString *file in files) {
        if (![file hasPrefix:@"cache_"]) continue;
        
        NSString *path = [cacheDir stringByAppendingPathComponent:file];
        NSDictionary *attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil];
        
        [fileInfos addObject:@{
            @"path": path,
            @"size": attrs[NSFileSize],
            @"date": attrs[NSFileModificationDate]
        }];
    }
    
    // 按修改时间升序（最旧的排前面）
    [fileInfos sortUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]]];
    
    unsigned long long currentSize = totalSize;
    for (NSDictionary *info in fileInfos) {
        if (currentSize <= _maxCacheSize) break;
        
        NSString *path = info[@"path"];
        unsigned long long fileSize = [info[@"size"] unsignedLongLongValue];
        [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
        
        currentSize -= fileSize;
    }
}

@end


//#import "CacheManager.h"
//
//@interface CacheManagerTests : XCTestCase
//@end
//
//@implementation CacheManagerTests
//
//- (void)setUp {
//    [super setUp];
//    // 每个测试前先清空缓存
//    [CacheManager clearAllCache];
//}
//
//- (void)tearDown {
//    [CacheManager clearAllCache];
//    [super tearDown];
//}
//
///// ✅ 测试保存和读取
//- (void)testSaveAndLoad {
//    NSDictionary *data = @{@"name": @"Bruce", @"age": @30};
//    [CacheManager saveData:data forKey:@"userInfo" validDuration:60]; // 有效期 60s
//
//    NSDictionary *result = [CacheManager loadDataForKey:@"userInfo"];
//
//    XCTAssertNotNil(result, @"缓存数据不应为空");
//    XCTAssertEqualObjects(result[@"name"], @"Bruce");
//    XCTAssertEqualObjects(result[@"age"], @30);
//}
//
///// ✅ 测试过期
//- (void)testExpiration {
//    NSDictionary *data = @{@"token": @"123456"};
//    [CacheManager saveData:data forKey:@"session" validDuration:1]; // 有效期 1s
//
//    sleep(2); // 等待过期
//
//    NSDictionary *result = [CacheManager loadDataForKey:@"session"];
//    XCTAssertNil(result, @"缓存应该过期被清理");
//}
//
///// ✅ 测试清除指定缓存
//- (void)testClearSpecificKey {
//    [CacheManager saveData:@[@"A", @"B", @"C"] forKey:@"list" validDuration:60];
//
//    XCTAssertNotNil([CacheManager loadDataForKey:@"list"]);
//
//    [CacheManager clearCacheForKey:@"list"];
//
//    XCTAssertNil([CacheManager loadDataForKey:@"list"], @"清除后应返回 nil");
//}
//
///// ✅ 测试清除所有缓存
//- (void)testClearAll {
//    [CacheManager saveData:@1 forKey:@"k1" validDuration:60];
//    [CacheManager saveData:@2 forKey:@"k2" validDuration:60];
//
//    [CacheManager clearAllCache];
//
//    XCTAssertNil([CacheManager loadDataForKey:@"k1"]);
//    XCTAssertNil([CacheManager loadDataForKey:@"k2"]);
//}
//
///// ✅ 测试缓存统计
//- (void)testCacheStats {
//    [CacheManager saveData:@{@"a":@"1"} forKey:@"stats1" validDuration:60];
//    [CacheManager saveData:@{@"b":@"2"} forKey:@"stats2" validDuration:60];
//
//    NSDictionary *stats = [CacheManager cacheStats];
//    XCTAssertTrue([stats[@"fileCount"] integerValue] >= 2, @"缓存文件数应大于等于 2");
//    XCTAssertTrue([stats[@"totalSize"] integerValue] > 0, @"缓存大小应大于 0");
//    XCTAssertNotNil(stats[@"formattedSize"]);
//}
//
///// ✅ 测试异步统计
//- (void)testCacheStatsAsync {
//    XCTestExpectation *expectation = [self expectationWithDescription:@"异步统计完成"];
//
//    [CacheManager saveData:@{@"x":@"y"} forKey:@"async" validDuration:60];
//
//    [CacheManager cacheStatsAsync:^(NSDictionary *stats) {
//        XCTAssertTrue([stats[@"totalSize"] integerValue] > 0, @"异步统计结果应包含大小");
//        [expectation fulfill];
//    }];
//
//    [self waitForExpectationsWithTimeout:3 handler:nil];
//}
//
///// ✅ 测试缓存大小上限（例如 1KB）
//- (void)testMaxCacheSize {
//    [CacheManager setMaxCacheSize:1024]; // 1KB
//
//    // 存入超过 1KB 的数据（大字符串）
//    NSMutableString *bigString = [NSMutableString string];
//    for (int i = 0; i < 2000; i++) {
//        [bigString appendString:@"x"];
//    }
//
//    [CacheManager saveData:bigString forKey:@"bigData" validDuration:60];
//
//    NSDictionary *stats = [CacheManager cacheStats];
//    XCTAssertTrue([stats[@"totalSize"] integerValue] <= 1024, @"缓存总大小应不超过上限");
//}
//
//@end
