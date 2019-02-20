#import <Foundation/Foundation.h>
#import "Observable.h"
#import "RipeAPI.h"
#import "BaseAPI.h"

@class Interactable;
@class Image;

NS_ASSUME_NONNULL_BEGIN

@interface Ripe : Observable <RipeAPI>

@property NSString *brand;
@property NSString *model;
@property NSDictionary *options;
@property BaseAPI *api;
@property NSMutableArray *children;

-(id)initWithBrand:(NSString *)brand andModel: (NSString *)model andOptions:(NSDictionary *)options;
-(void)configWithBrand:(NSString *)brand andModel: (NSString *)model andOptions:(NSDictionary *)options;
-(void)bindInteractable:(Interactable *)interactable;

@end

NS_ASSUME_NONNULL_END
