#import <objc/runtime.h>
#import "NSObject+Observable.h"

static void *ObservableCallbackstKey;

@implementation NSObject (Observable)

@dynamic callbacks;

- (NSMutableDictionary *) callbacks {
    NSMutableDictionary *result = objc_getAssociatedObject(self, &ObservableCallbackstKey);
    if (result == nil) {
        // do a lot of stuff
        result = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &ObservableCallbackstKey, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
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
