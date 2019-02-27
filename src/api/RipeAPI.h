#import "Dependencies.h"

NS_ASSUME_NONNULL_BEGIN

@protocol RipeAPI <NSObject>

@property (readonly) NSString *url;

@optional
- (void)getPrice:(void (^)(NSDictionary *response))callback;
- (void)getPrice:(NSDictionary * _Nullable)options callback:(void (^)(NSDictionary *response))callback;
- (NSURLSessionDataTask *)_cacheURL:(NSString *)url options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (NSURLSessionDataTask *)_requestURL:(NSString *)url options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (NSString *)_getImageUrl:(NSDictionary *)options;
- (NSDictionary *)_getPriceOptions:(NSDictionary *)options;
- (NSDictionary *)_getImageOptions:(NSDictionary *)options;
- (NSDictionary *)_getQueryOptions:(NSDictionary *)options;
- (NSString *)_buildQuery:(NSDictionary *)params;
- (NSDictionary *)_build:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
