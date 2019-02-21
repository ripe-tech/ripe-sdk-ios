#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BrandAPI <NSObject>

- (void)getConfigWithCallback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END
