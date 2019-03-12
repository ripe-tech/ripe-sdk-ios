NS_ASSUME_NONNULL_BEGIN

@protocol BuildAPI <NSObject>

@optional

- (void)getLocaleModel:(void (^)(NSDictionary *response))callback;
- (void)getLocaleModel:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END
