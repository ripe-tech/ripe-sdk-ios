#import "Dependencies.h"
#import "Promise.h"

NS_ASSUME_NONNULL_BEGIN

@interface Observable : NSObject

typedef Promise * (^Callback)(NSDictionary *response);

@property (nonatomic, strong) NSMutableDictionary *callbacks;

- (Callback)bindToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;
- (Callback)bindSyncToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;
- (Callback)bindAsyncToEvent:(NSString *)event withCallback:(Callback)callback;
- (void)unbindFromEvent:(NSString *)event withCallback:(Callback)callback;
- (Promise *)triggerEvent:(NSString *)event withArgs:(NSDictionary * _Nullable)args;
- (Promise *)triggerEvent:(NSString *)event;

@end

NS_ASSUME_NONNULL_END
