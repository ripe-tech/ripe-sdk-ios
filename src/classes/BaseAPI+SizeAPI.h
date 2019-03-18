#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI (SizeAPI)

- (void)getSizes:(void (^)(NSDictionary *response))callback;
- (void)getSizes:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (Promise *)getSizesP;
- (Promise *)getSizesP:(NSDictionary *)options;
- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary *response))callback;
- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (Promise *)sizeToNativeP:(NSString *)scale value:(double)value gender:(NSString *)gender;
- (Promise *)sizeToNativeP:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options;
- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray *response))callback;
- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray *response))callback;
- (Promise *)sizeToNativeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders;
- (Promise *)sizeToNativeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options;
- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary *response))callback;
- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
- (Promise *)nativeToSizeP:(NSString *)scale value:(double)value gender:(NSString *)gender;
- (Promise *)nativeToSizeP:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options;
- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray *response))callback;
- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray *response))callback;
- (Promise *)nativeToSizeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders;
- (Promise *)nativeToSizeBP:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
