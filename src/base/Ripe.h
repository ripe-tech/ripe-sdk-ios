#import "Dependencies.h"
#import "Observable.h"
#import "RipeAPI.h"
#import "BrandAPI.h"

@class BaseAPI;
@class Interactable;
@class Image;

NS_ASSUME_NONNULL_BEGIN

@interface Ripe : Observable <RipeAPI, BrandAPI>

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
-(id)initWithBrand:(NSString *)brand model: (NSString *)model;
-(id)initWithBrand:(NSString * _Nullable)brand model: (NSString * _Nullable)model options:(NSDictionary *)options;
-(Promise *)config:(NSString *)brand model: (NSString *)model;
-(Promise *)config:(NSString *)brand model: (NSString *)model options:(NSDictionary *)options;
-(Promise *)config:(NSString *)brand model: (NSString *)model options:(NSDictionary *)options callback: (void(^_Nullable)(NSDictionary * _Nullable))callback ;
-(void)setInitials:(NSString *)initials engraving: (NSString *)engraving;
-(void)setInitials:(NSString *)initials engraving: (NSString *)engraving noUpdate: (BOOL)noUpdate;
-(Interactable *)bindInteractable:(Interactable *)interactable;
-(Image *)bindImage:(UIImageView *)imageView;
-(Image *)bindImage:(UIImageView *)imageView options:(NSDictionary *)options;
-(void)unbindInteractable:(Interactable *)interactable;
-(void)unbindImage:(Image *)image;
-(void)update;
-(void)update:(NSDictionary *)state;
-(NSDictionary *)_getstate;

@end

NS_ASSUME_NONNULL_END
