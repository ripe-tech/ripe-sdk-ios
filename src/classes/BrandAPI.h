NS_ASSUME_NONNULL_BEGIN

@protocol BrandAPI <NSObject>

@optional

- (void)getConfig:(void (^)(NSDictionary *response))callback;
- (void)getConfig:(NSDictionary * _Nullable)options callback:(void (^)(NSDictionary *response))callback;
- (Promise *)getConfigP;
- (Promise *)getConfigP:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
