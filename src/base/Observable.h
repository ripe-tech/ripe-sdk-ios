#import "Dependencies.h"

NS_ASSUME_NONNULL_BEGIN

@interface Observable : NSObject

@property (nonatomic, strong) NSMutableDictionary *callbacks;

- (void (^)(NSDictionary *response))bindToEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;
- (void)unbindFromEvent:(NSString *)event withCallback:(void (^)(NSDictionary *response))callback;
- (void)triggerEvent:(NSString *)event withArgs:(NSDictionary * _Nullable)args;
- (void)triggerEvent:(NSString *)event;

@end

NS_ASSUME_NONNULL_END
