#import <Foundation/Foundation.h>
#import "Observable.h"
#import "Interactable.h"

NS_ASSUME_NONNULL_BEGIN

@interface Visual : Observable <Interactable>

@property (nonatomic, weak) Ripe *owner;
@property (nonatomic) NSDictionary *options;

- (id)initWithOwner:(Ripe *)owner andOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END