NS_ASSUME_NONNULL_BEGIN

@protocol SizeAPI <NSObject>

@optional

- (void)getSizes:(void (^)(NSDictionary *response))callback;
- (void)getSizes:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary *response))callback;
- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray *response))callback;
- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray *response))callback;
- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary *response))callback;
- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray *response))callback;
- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray *response))callback;

@end

NS_ASSUME_NONNULL_END
