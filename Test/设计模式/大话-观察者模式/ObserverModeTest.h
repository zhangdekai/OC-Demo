#import <Foundation/Foundation.h>
#import "NewsAgency.h"
#import "Newspaper.h"
#import "NewsApp.h"

int testObserveModeMain(void) {
    @autoreleasepool {
        // 创建新闻机构（被观察者）
        NewsAgency *agency = [[NewsAgency alloc] init];
        
        // 创建观察者
        Newspaper *dailyNews = [[Newspaper alloc] initWithName:@"每日新闻"];
        Newspaper *techTimes = [[Newspaper alloc] initWithName:@"科技时报"];
        NewsApp *newsApp = [[NewsApp alloc] initWithAppID:@"头条新闻"];
        
        // 注册观察者
        [agency addObserver:dailyNews];
        [agency addObserver:techTimes];
        [agency addObserver:newsApp];
        
        // 发布第一条新闻
        NSLog(@"\n--- 发布第一条新闻 ---");
        [agency publishNews:@"新一代人工智能技术取得重大突破" category:@"科技"];
        
        // 移除一个观察者
        [agency removeObserver:dailyNews];
        
        // 发布第二条新闻
        NSLog(@"\n--- 发布第二条新闻 ---");
        [agency publishNews:@"国家经济形势持续向好" category:@"财经"];
    }
    return 0;
}
