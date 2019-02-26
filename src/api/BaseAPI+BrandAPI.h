#import "Dependencies.h"
#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI (BrandAPI)

- (void)getConfigWithCallback:(void (^)(NSDictionary *response))callback;
- (void)getConfigWithOptions:(NSDictionary * _Nullable)options andCallback:(void (^)(NSDictionary *response))callback;
- (NSDictionary *)_getConfigOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
