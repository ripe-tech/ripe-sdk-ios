#import "Ripe.h"

NS_ASSUME_NONNULL_BEGIN

@protocol Interactable

@property (nonatomic, weak) Ripe *owner;

- (void)update:(NSDictionary *)state;

@end

NS_ASSUME_NONNULL_END
