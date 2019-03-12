#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI (BrandAPI)

 /**
  Returns the configuration information of the owner's current model. To retrieve the configuration of a specific model the method getConfig:callback: should be used.
 
  @param callback A callback that will be called with the configuration as argument.
 */
- (void)getConfig:(void (^)(NSDictionary *response))callback;

/**
  Returns the configuration information of a specific brand and model. If no model is provided
  then returns the information of the owner's current model.
  The **options** map accepts the following parameters:
   - **brand** - the brand of the model
   - **model** - the name of the model
   - **country** - the country where the model will be provided, some materials/colors might not be available.
   - **flag** - a specific flag that may change the provided materials/colors available.
   - **filter** - if the configuration should be filtered by the country and/or flag. `true` by default.
 
  @param options A map with options
  @param callback A callback that will be called with the configuration as argument.
 */
- (void)getConfig:(NSDictionary * _Nullable)options callback:(void (^)(NSDictionary *response))callback;

@end

NS_ASSUME_NONNULL_END
