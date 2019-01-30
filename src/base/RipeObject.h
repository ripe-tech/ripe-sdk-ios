#import <Foundation/Foundation.h>
#import "Observable.h"
#import "BaseAPI.h"
#import "RipeAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface RipeObject : Observable <RipeAPI>

@property NSString *brand;
@property NSString *model;
@property NSDictionary *options;
@property BaseAPI *api;

-(id)initWithBrand:(NSString *)brand andModel: (NSString *)model andOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
