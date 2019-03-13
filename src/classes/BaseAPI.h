#import "Dependencies.h"
#import "RipeAPI.h"
#import "BrandAPI.h"
#import "BuildAPI.h"
#import "Base.h"

NS_ASSUME_NONNULL_BEGIN

/**
 This class contains the main API class that should be extended by other APIs.
 */
@interface BaseAPI : NSObject <RipeAPI, BrandAPI, BuildAPI, SizeAPI>

/**
 The Ripe instance that is using the API.
 */
@property Ripe *owner;

/**
 An options map that can be used to configure the API.
 */
@property NSDictionary *options;

/**
 Base constructor for the API.

 @param owner The Ripe instance that will use this API.
 @param options An options map that can be used to configure the API.
 @return The API instance created.
 */
- (id)initWithOwner:(Ripe *)owner options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
