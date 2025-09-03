#import "MVCUserModel.h"

@implementation MVCUserModel

- (instancetype)initWithDictionary:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.userId = dict[@"userId"];
        self.name = dict[@"name"];
        self.age = [dict[@"age"] integerValue];
        self.address = dict[@"address"];
        self.hobby = dict[@"hobby"];
    }
    return self;
}

- (NSDictionary *)toDictionary {
    return @{
        @"userId": self.userId ?: @"",
        @"name": self.name ?: @"",
        @"age": @(self.age),
        @"address": self.address ?: @"",
        @"hobby": self.hobby ?: @""
    };
}

@end
    