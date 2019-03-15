NS_ASSUME_NONNULL_BEGIN

/**
 * The protocol for the main API class.
 */
@protocol RipeAPI <NSObject>


/**
 * The base API URL to be used by the API methods.
 */
@property (readonly) NSString *url;

@optional

/**
 * Retrieves the price for the current customization.
 * This operation is asynchronous and the provided callback will be called with the result.
 * To retrieve the price of a specific customization the method `-[RipeAPI getPrice:callback:]` should be used.
 *
 * @param callback A block that accepts the price response as a parameter.
 * @see `-[RipeAPI getPrice:callback:]`
 */
- (void)getPrice:(void (^)(NSDictionary * ))callback;

/**
 * Retrieves the price of a specific customization.
 * This operation is asynchronous and the provided callback will be called with the result. 
 * If no options are set the current customization of the owner will be used. The **options** map accepts the following keys:
 * - **brand** - the brand of the model.
 * - **model** - the name of the model.
 * - **variant** - the variant of the the specified model.
 * - **product_id** - the model's unique identification (ID).
 * - **currency** - the *ISO 4217* currency code.
 * - **country** - the *ISO 3166-2* code of the country.
 * - **initials** - the initials used to personalize the model.
 * - **engraving** - the engraving of the personalization.
 * - **p** - the customization parts, as triplets in the form of *part:material:color*.
 * 
 * @param options A map with options to specify a model.
 * @param callback A block that accepts the price response as a parameter.
 */
- (void)getPrice:(NSDictionary *)options callback:(void (^)(NSDictionary *))callback;

/// :nodoc:
- (NSURLSessionDataTask *)_cacheURL:(NSString *)url options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
/// :nodoc:
- (NSURLSessionDataTask *)_requestURL:(NSString *)url options:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;
/// :nodoc:
- (NSString *)_getImageUrl:(NSDictionary *)options;
/// :nodoc:
- (NSDictionary *)_getPriceOptions:(NSDictionary *)options;
/// :nodoc:
- (NSDictionary *)_getImageOptions:(NSDictionary *)options;
/// :nodoc:
- (NSDictionary *)_getQueryOptions:(NSDictionary *)options;
/// :nodoc:
- (NSString *)_buildQuery:(NSDictionary *)params;
/// :nodoc:
- (NSDictionary *)_build:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
