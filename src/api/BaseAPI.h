#import <Foundation/Foundation.h>
#import "RipeAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseAPI : NSObject <RipeAPI>

@property NSDictionary *options;

- (id)initWithOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
