#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RipeAPI <NSObject>

@property (readonly) NSString *url;

- (NSDictionary *)getPriceWithCallback:(void (^)(NSDictionary *response))callback;
- (NSDictionary *)getPriceWithOptions:(NSDictionary *)options andCallback:(void (^)(NSDictionary *response))callback;
- (NSURLSessionDataTask *)_cacheURL:(NSString *)url withOptions:(NSDictionary *)options andCallback:(void (^)(NSDictionary *response))callback;
- (NSURLSessionDataTask *)_requestURL:(NSString *)url withOptions:(NSDictionary *)options andCallback:(void (^)(NSDictionary *response))callback;
- (NSString *)_getImageUrl:(NSDictionary *)options;
- (NSDictionary *)_getImageOptions:(NSDictionary *)options;
- (NSDictionary *)_getQueryOptions:(NSDictionary *)options;
- (NSString *)_buildQuery:(NSDictionary *)params;
- (NSDictionary *)_build:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
