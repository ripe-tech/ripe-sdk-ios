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

- (void)triggerEvent:(NSString *)event withArgs:(NSDictionary *)args {
    NSArray *callbacks = self.callbacks[event];
    for (id value in callbacks) {
        void (^callback)(NSDictionary *response) = value;
        callback(args);
    }
}

- (void)triggerEvent:(NSString *)event {
    [self triggerEvent:event withArgs:nil];
}

@end
