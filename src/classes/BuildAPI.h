NS_ASSUME_NONNULL_BEGIN

/**
 * Protocol of the Build API methods
 */
@protocol BuildAPI <NSObject>

@optional

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
 * - **brand** - the brand of the model.
 * - **model** - the name of the model.
 * - **locale** - the locale of the translations.
 * - **compatibility** - if compatibility mode should be enabled.
 * - **prefix** - a prefix to prepend to the locale keys (defaults to `builds`).
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
 * - **brand** - the brand of the model.
 * - **model** - the name of the model.
 * - **locale** - the locale of the translations.
 * - **compatibility** - if compatibility mode should be enabled.
 * - **prefix** - a prefix to prepend to the locale keys (defaults to `builds`).
 *
 * @param options A map of options to configure the request.
 * @return A Promise that will be resolved with the locale bundle.
 */
- (Promise *)getLocaleModelP:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
