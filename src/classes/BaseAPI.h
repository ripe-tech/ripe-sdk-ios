#import "Dependencies.h"
#import "RipeAPI.h"
#import "BrandAPI.h"
#import "BuildAPI.h"
#import "Base.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI : NSObject <RipeAPI, BrandAPI, BuildAPI, SizeAPI>

@property Ripe *owner;
@property NSDictionary *options;

- (id)initWithOwner:(Ripe *)owner options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
