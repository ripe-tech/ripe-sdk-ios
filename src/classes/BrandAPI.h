NS_ASSUME_NONNULL_BEGIN

/**
 * Protocol of the Brand API methods.
 */
@protocol BrandAPI <NSObject>

@optional

/**
 * Returns the configuration information of the owner's current model.
 * To retrieve the configuration of a specific model the method `-[BrandAPI getConfig:callback:]` should be used.
 *
 * @param callback A Block that will the receive the configuration as parameter.
 */
- (void)getConfig:(void (^)(NSDictionary *response))callback;

/**
 * Returns the configuration information of a specific brand and model. If no model is provided
 * then returns the information of the owner's current model.
 * The **options** map accepts the following keys:
 *  - **brand** - the brand of the model
 *  - **model** - the name of the model
 *  - **country** - the country where the model will be provided, some materials/colors might not be available.
 *  - **flag** - a specific flag that may change the provided materials/colors available.
 *  - **filter** - if the configuration should be filtered by the country and/or flag. `true` by default.
 *
 * @param options A map with options.
 * @param callback A Block that will the receive the configuration as parameter.
 */
- (void)getConfig:(NSDictionary * _Nullable)options callback:(void (^)(NSDictionary *response))callback;

/**
 * Returns the configuration information of the owner's current model.
 * To retrieve the configuration of a specific model the method `-[BrandAPI getConfigP:callback:]` should be used.
 *
 * @return A Promise that will be resolved with the configuration.
 */
- (Promise *)getConfigP;

/**
 * Returns the configuration information of a specific brand and model. If no model is provided
 * then returns the information of the owner's current model.
 * The **options** map accepts the following keys:
 *  - **brand** - the brand of the model
 *  - **model** - the name of the model
 *  - **country** - the country where the model will be provided, some materials/colors might not be available.
 *  - **flag** - a specific flag that may change the provided materials/colors available.
 *  - **filter** - if the configuration should be filtered by the country and/or flag. `true` by default.
 *
 * @param options A map with options.
 * @return A Promise that will be resolved with the configuration.
 */
- (Promise *)getConfigP:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
