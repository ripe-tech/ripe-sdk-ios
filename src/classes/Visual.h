#import "Interactable.h"

NS_ASSUME_NONNULL_BEGIN

@interface Visual : Observable <Interactable>

@property (nonatomic) NSDictionary *options;

- (id)initWithOwner:(Ripe *)owner options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
