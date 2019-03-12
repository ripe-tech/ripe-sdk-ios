#import "Dependencies.h"
#import "Observable.h"
#import "BrandAPI.h"
#import "BuildAPI.h"
#import "RipeAPI.h"
#import "SizeAPI.h"

@class BaseAPI;
@class Interactable;
@class Image;

NS_ASSUME_NONNULL_BEGIN

@interface Ripe : Observable <RipeAPI, BrandAPI, BuildAPI, SizeAPI>

@property BaseAPI *api;
@property NSString *brand;
@property NSString *model;
@property NSDictionary *options;
@property NSMutableArray *children;
@property NSMutableArray *history;
@property int historyPointer;
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
-(Promise *)config:(NSString *)brand model: (NSString *)model options:(NSDictionary *)options callback: (void(^_Nullable)(NSDictionary * _Nullable))callback;
-(void)setPart:(NSString *)part material:(NSString * _Nullable)material color:(NSString * _Nullable)color;
-(void)setPart:(NSString *)part material:(NSString * _Nullable)material color:(NSString * _Nullable)color noEvents:(BOOL)noEvents;
-(void)setPart:(NSString *)part material:(NSString * _Nullable)material color:(NSString * _Nullable)color noEvents:(BOOL)noEvents options:(NSDictionary *)options;
-(void)setParts:(NSDictionary *)parts noEvents:(BOOL)noEvents;
-(void)setParts:(NSDictionary *)parts noEvents:(BOOL)noEvents options:(NSDictionary *)options;
-(void)setPartsList:(NSArray *)partsList;
-(void)setPartsList:(NSArray *)partsList noEvents:(BOOL)noEvents;
-(void)setPartsList:(NSArray *)partsList noEvents:(BOOL)noEvents options:(NSDictionary *)options;
-(void)setInitials:(NSString *)initials engraving: (NSString *)engraving;
-(void)setInitials:(NSString *)initials engraving: (NSString *)engraving noUpdate: (BOOL)noUpdate;
-(Interactable *)bindInteractable:(Interactable *)interactable;
-(Image *)bindImage:(UIImageView *)imageView;
-(Image *)bindImage:(UIImageView *)imageView options:(NSDictionary *)options;
-(void)unbindInteractable:(Interactable *)interactable;
-(void)unbindImage:(Image *)image;
-(void)selectPart:(NSString *)part;
-(void)selectPart:(NSString *)part options:(NSDictionary *)options;
-(void)deselectPart:(NSString *)part;
-(void)deselectPart:(NSString *)part options:(NSDictionary *)options;
-(void)undo;
-(void)redo;
-(BOOL)canUndo;
-(BOOL)canRedo;
-(void)update;
-(void)update:(NSDictionary *)state;
-(NSDictionary *)_getstate;

@end

NS_ASSUME_NONNULL_END
