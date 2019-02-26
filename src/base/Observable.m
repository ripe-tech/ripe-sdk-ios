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

- (Callback)addCallbackForEvent:(NSString *)event withCallback:(Callback)callback {
    NSMutableArray *_callbacks = [self.callbacks objectForKey:event] ?: [NSMutableArray new];
    [_callbacks addObject:callback];
    [self.callbacks setObject:_callbacks forKey:event];
    return callback;
}

- (Callback)bindToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback {
    return [self bindSyncToEvent:event withCallback:callback];
}

- (Callback)bindSyncToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *))callback {
    Callback _callback = ^Promise *(NSDictionary *response) {
        callback(response);
        Promise *promise = [[Promise alloc] initWithExecutor:^(Resolve resolve, Reject reject) {
            resolve([NSDictionary new]);
        }];
        return promise;
    };
    return [self addCallbackForEvent:event withCallback:_callback];
}

- (Callback)bindAsyncToEvent:(NSString *)event withCallback:(Callback)callback {
    return [self addCallbackForEvent:event withCallback:callback];
}

- (void)unbindFromEvent:(NSString *)event withCallback:(Callback)callback {
    NSMutableArray *_callbacks = [self.callbacks objectForKey:event] ?: [NSMutableArray new];
    [_callbacks removeObject:callback];
}

- (Promise *)triggerEvent:(NSString *)event withArgs:(NSDictionary *)args {
    NSArray *callbacks = self.callbacks[event];
    NSMutableArray *promises = [NSMutableArray arrayWithCapacity:callbacks.count];
    for (id value in callbacks) {
        Callback callback = (Callback) value;
        Promise *promise = callback(args);
        [promises addObject:promise];
    }
    return [Promise all:promises];
}

- (Promise *)triggerEvent:(NSString *)event {
    return [self triggerEvent:event withArgs:nil];
}

@end
