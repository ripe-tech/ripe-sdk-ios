#import <Foundation/Foundation.h>
#import "Observable.h"
#import "BaseAPI.h"

NS_ASSUME_NONNULL_BEGIN

@interface Ripe : NSObject <Observable, RipeAPI>

@property NSString *brand;
@property NSString *model;
@property NSDictionary *options;
@property BaseAPI *api;

-(id)initWithBrand:(NSString *)brand andModel: (NSString *)model andOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
