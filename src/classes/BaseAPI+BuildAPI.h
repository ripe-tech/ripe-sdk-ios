#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Extension of the Build API.
 */
@interface BaseAPI (BuildAPI)

/**
 * Retrieves the bundle of part, materials and colors translations of the owner's current model and locale.
 * To retrieve the bundle of a specific model the method `-[BuildAPI getLocaleModel:callback:]` should be used.
 *
 * @param callback The block to be called when the translations bundle is retrieved.
 */
- (void)getLocaleModel:(void (^)(NSDictionary *response))callback;

/**
 * Retrieves the bundle part, materials and colors translations of a specific brand and model.
 * The **options** map accepts the following keys:
 * - **brand** - The brand of the model.
 * - **model** - The name of the model.
 * - **locale** - The locale of the translations.
 * - **compatibility** - If compatibility mode should be enabled.
 * - **prefix** - A prefix to prepend to the locale keys (defaults to `builds`).
 *
 * @param options A map of options to configure the request.
 * @param callback The block to be called when the translations bundle is retrieved.
 */
- (void)getLocaleModel:(NSDictionary *)options callback:(void (^)(NSDictionary *response))callback;

/**
 * Retrieves the bundle of part, materials and colors translations of the owner's current model and locale.
 * To retrieve the bundle of a specific model the method `-[BuildAPI getLocaleModelP:callback:]` should be used.
 *
 * @return A Promise that will be resolved with the locale bundle.
 */
- (Promise *)getLocaleModelP;

/**
 * Retrieves the bundle part, materials and colors translations of a specific brand and model.
 * The **options** map accepts the following keys:
 * - **brand** - The brand of the model.
 * - **model** - The name of the model.
 * - **locale** - The locale of the translations.
 * - **compatibility** - If compatibility mode should be enabled.
 * - **prefix** - A prefix to prepend to the locale keys (defaults to `builds`).
 *
 * @param options A map of options to configure the request.
 * @return A Promise that will be resolved with the locale bundle.
 */
- (Promise *)getLocaleModelP:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
