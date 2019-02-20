#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
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

-(id)initWithBrand:(NSString *)brand andModel: (NSString *)model;
-(id)initWithBrand:(NSString *)brand andModel: (NSString *)model andOptions:(NSDictionary *)options;
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
