#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI (BuildAPI)

- (void)getLocaleModel:(void (^)(NSDictionary *response))callback;
- (void)getLocaleModel:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END