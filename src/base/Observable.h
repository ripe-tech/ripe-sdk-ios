#import "Promise.h"

NS_ASSUME_NONNULL_BEGIN

@interface Observable : NSObject

typedef Promise * (^Callback)(NSDictionary *response);

@property (nonatomic, strong) NSMutableDictionary *callbacks;

- (Callback)bind:(NSString *)event callback:(void (^)(NSDictionary *response))callback;
- (Callback)bindSync:(NSString *)event callback:(void (^)(NSDictionary *response))callback;
- (Callback)bindAsync:(NSString *)event callback:(Callback)callback;
- (void)unbind:(NSString *)event callback:(Callback)callback;
- (Promise *)trigger:(NSString *)event args:(NSDictionary * _Nullable)args;
- (Promise *)trigger:(NSString *)event;

@end

NS_ASSUME_NONNULL_END
