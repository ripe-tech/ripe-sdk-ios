#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Observable.h"
#import "RipeAPI.h"

@class BaseAPI;
@class Interactable;
@class Image;

NS_ASSUME_NONNULL_BEGIN

@interface Ripe : Observable <RipeAPI>

@property BaseAPI *api;
@property NSString *brand;
@property NSString *model;
@property NSDictionary *options;
@property NSMutableArray *children;
@property NSString *initials;
@property NSString *engraving;
@property NSMutableDictionary *parts;
@property NSDictionary *loadedConfig;
@property NSString *country;
@property NSString *currency;
@property NSString *locale;
@property NSString *flag;
@property BOOL ready;
@property BOOL useDefaults;
@property BOOL usePrice;

-(id)initWithOptions:(NSDictionary *)options;
-(id)initWithBrand:(NSString *)brand andModel: (NSString *)model;
-(id)initWithBrand:(NSString * _Nullable)brand andModel: (NSString * _Nullable)model andOptions:(NSDictionary *)options;
-(void)configWithBrand:(NSString *)brand andModel: (NSString *)model;
-(void)configWithBrand:(NSString *)brand andModel: (NSString *)model andOptions:(NSDictionary *)options;
-(Interactable *)bindInteractable:(Interactable *)interactable;
-(Image *)bindImageWithImageView:(UIImageView *)imageView;
-(Image *)bindImageWithImageView:(UIImageView *)imageView andOptions:(NSDictionary *)options;
-(void)unbindInteractable:(Interactable *)interactable;
-(void)unbindImage:(Image *)image;
-(void)update;
-(void)update:(NSDictionary *)state;
-(NSDictionary *)_getstate;

@end

NS_ASSUME_NONNULL_END
