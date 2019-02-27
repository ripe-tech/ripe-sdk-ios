#import "Dependencies.h"
#import "RipeAPI.h"
#import "BrandAPI.h"
#import "Ripe.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI : NSObject <RipeAPI, BrandAPI>

@property Ripe *owner;
@property NSDictionary *options;

- (id)initWithOwner:(Ripe *)owner options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
