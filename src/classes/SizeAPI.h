NS_ASSUME_NONNULL_BEGIN

/**
 * The protocol for the Size API.
 */
@protocol SizeAPI <NSObject>

@optional

/**
 * Provides a list of all the available size scales.
 * This can be used to know what scales are available for size conversions.
 *
 * @param callback A block that receives the size scales list as parameter.
 */
- (void)getSizes:(void (^)(NSDictionary *response))callback;

/**
 * Provides a list of all the available size scales.
 * This can be used to know what scales are available for size conversions.
 *
 * @param options A map with options to configure the request.
 * @param callback A block that receives the size scales list as parameter.
 */
- (void)getSizes:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;

/**
 * Converts a size value from the native scale to the corresponding value in the specified scale.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scale The scale which one wants to convert to.
 * @param value The value which one wants to convert.
 * @param gender The gender of the scale and value to be converted.
 * @param callback A block that receives the converted value as parameter.
 */
- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary *response))callback;

/**
 * Converts a size value from the native scale to the corresponding value in the specified scale.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scale The scale which one wants to convert to.
 * @param value The value which one wants to convert.
 * @param gender The gender of the scale and value to be converted.
 * @param options A map with options to configure the request.
 * @param callback A block that receives the converted value as parameter.
 */
- (void)sizeToNative:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;

/**
 * Converts multiple size values from the native scale to the corresponding values in the specified scales.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scales A list of scales to convert to.
 * @param values A list of values to convert.
 * @param genders A list of genders corresponding to the values.
 * @param callback A block that receives a list with the converted values as an argument.
 */
- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray *response))callback;

/**
 * Converts multiple size values from the native scale to the corresponding values in the specified scales.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scales A list of scales to convert to.
 * @param values A list of values to convert.
 * @param genders A list of genders corresponding to the values.
 * @param options A map with options to configure the request.
 * @param callback A block that receives a list with the converted values as an argument.
 */
- (void)sizeToNativeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray *response))callback;

/**
 * Converts a size value in the specified scale to the corresponding native size.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scale The scale which one wants to convert from.
 * @param value The value which one wants to convert.
 * @param gender The gender of the scale and value to be converted.
 * @param callback A block that receives the native value as parameter.
 */
- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender callback:(void (^)(NSDictionary *response))callback;

/**
 * Converts a size value in the specified scale to the corresponding native size.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scale The scale which one wants to convert from.
 * @param value The value which one wants to convert.
 * @param gender The gender of the scale and value to be converted.
 * @param callback A block that receives the native value as parameter.
 */
- (void)nativeToSize:(NSString *)scale value:(double)value gender:(NSString *)gender options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;

/**
 * Converts multiple size values to the corresponding native size.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scales A list of scales to convert from.
 * @param values A list of values to convert.
 * @param genders A list of genders corresponding to the values.
 * @param callback A block that receives a list with the native values as an argument.
 */
- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders callback:(void (^)(NSArray *response))callback;

/**
 * Converts multiple size values to the corresponding native size.
 * The available scales, genders and sizes can be obtained with the method `-[SizeAPI getSizes:]`
 *
 * @param scales A list of scales to convert to.
 * @param values A list of values to convert.
 * @param genders A list of genders corresponding to the values.
 * @param options A map with options to configure the request.
 * @param callback A block that receives a list with the converted values as an argument.
 */
- (void)nativeToSizeB:(NSArray *)scales values:(NSArray *)values genders:(NSArray *)genders options:(NSDictionary *)options callback:(void (^)(NSArray *response))callback;

@end

NS_ASSUME_NONNULL_END
