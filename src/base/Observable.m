#import "Observable.h"

@implementation Observable

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.callbacks = [NSMutableDictionary new];
    }
    return self;
}

- (void (^)(NSDictionary *response))bindToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback {
    NSMutableArray *_callbacks = [self.callbacks objectForKey:event] ?: [NSMutableArray new];
    [_callbacks addObject:callback];
    [self.callbacks setObject:_callbacks forKey:event];
    return callback;
}

- (void)unbindFromEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback {
    NSMutableArray *_callbacks = [self.callbacks objectForKey:event] ?: [NSMutableArray new];
    [_callbacks removeObject:callback];
}

@end
