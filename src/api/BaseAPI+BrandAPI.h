#import <Foundation/Foundation.h>
#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI (BrandAPI)

- (void)getConfigWithCallback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END
