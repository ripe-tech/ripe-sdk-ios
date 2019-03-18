#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI (BrandAPI)

- (void)getConfig:(void (^)(NSDictionary *response))callback;
- (void)getConfig:(NSDictionary * _Nullable)options callback:(void (^)(NSDictionary *response))callback;
- (Promise *)getConfigP;
- (Promise *)getConfigP:(NSDictionary *)options;
- (NSDictionary *)_getConfigOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
