#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Extension of the Brand API.
 */
@interface BaseAPI (BrandAPI)

 /**
  * Returns the configuration information of the owner's current model. To retrieve the configuration of a specific model the method getConfig:callback: should be used.
  * To retrieve the configuration of a specific model the method `-[BrandAPI getConfig:callback:]` should be used.
  *
  * @param callback A callback that will be called with the configuration as argument.
  */
- (void)getConfig:(void (^)(NSDictionary *response))callback;

/**
 * Returns the configuration information of a specific brand and model. If no model is provided
 * then returns the information of the owner's current model.
 * The **options** map accepts the following parameters:
 * - **brand** - The brand of the model
 * - **model** - The name of the model
 * - **country** - The country where the model will be provided, some materials/colors might not be available.
 * - **flag** - A specific flag that may change the provided materials/colors available.
 * - **filter** - If the configuration should be filtered by the country and/or flag (defaults `TRUE`).
 *
 * @param options A map with options
 * @param callback A callback that will be called with the configuration as argument.
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
 *  - **brand** - The brand of the model.
 *  - **model** - The name of the model.
 *  - **country** - The country where the model will be provided, some materials/colors might not be available.
 *  - **flag** - A specific flag that may change the provided materials/colors available.
 *  - **filter** - If the configuration should be filtered by the country and/or flag (defaults `TRUE`).
 *
 * @param options A map with options.
 * @return A Promise that will be resolved with the configuration.
 */
- (Promise *)getConfigP:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
