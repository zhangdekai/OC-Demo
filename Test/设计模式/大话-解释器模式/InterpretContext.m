#import "InterpretContext.h"

@implementation InterpretContext {
    NSMutableDictionary<NSString *, NSNumber *> *_variables;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _variables = [NSMutableDictionary dictionary];
    }
    return self;
}

- (void)setVariable:(NSString *)name value:(NSInteger)value {
    _variables[name] = @(value);
}

- (NSInteger)getVariable:(NSString *)name {
    return [_variables[name] integerValue];
}

@end
