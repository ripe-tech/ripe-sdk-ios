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

- (Callback)addCallback:(NSString *)event callback:(Callback)callback {
    NSMutableArray *_callbacks = [self.callbacks objectForKey:event] ?: [NSMutableArray new];
    [_callbacks addObject:callback];
    [self.callbacks setObject:_callbacks forKey:event];
    return callback;
}

- (Callback)bind:(NSString *)event callback:(void (^)(NSDictionary *response))callback {
    return [self bindSync:event callback:callback];
}

- (Callback)bindSync:(NSString *)event callback:(void (^)(NSDictionary *))callback {
    Callback _callback = ^Promise *(NSDictionary *response) {
        callback(response);
        Promise *promise = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
            resolve([NSDictionary new]);
        }];
        return promise;
    };
    return [self addCallback:event callback:_callback];
}

- (Callback)bindAsync:(NSString *)event callback:(Callback)callback {
    return [self addCallback:event callback:callback];
}

- (void)unbind:(NSString *)event callback:(Callback)callback {
    NSMutableArray *_callbacks = [self.callbacks objectForKey:event] ?: [NSMutableArray new];
    [_callbacks removeObject:callback];
}

- (Promise *)trigger:(NSString *)event args:(NSDictionary *)args {
    NSArray *callbacks = self.callbacks[event];
    NSMutableArray *promises = [NSMutableArray arrayWithCapacity:callbacks.count];
    for (id value in callbacks) {
        Callback callback = (Callback) value;
        Promise *promise = callback(args);
        [promises addObject:promise];
    }
    return [Promise all:promises];
}

- (Promise *)trigger:(NSString *)event {
    return [self trigger:event args:nil];
}

@end
