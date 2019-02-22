#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BrandAPI <NSObject>

- (void)getConfigWithCallback:(void (^)(NSDictionary *response))callback;
- (void)getConfigWithOptions:(NSDictionary * _Nullable)options andCallback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END
