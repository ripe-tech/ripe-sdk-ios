#import "Base.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Protocol for an entity that reactively represents a Ripe instance
 */
@protocol Interactable

/**
 * The ripe instance that will be represented.
 */
@property (nonatomic, weak) Ripe *owner;

/**
 * This method is called by the owner whenever its state changes so that the instance can update itself for the new state.
 *
 * @param state A map containing the new state of the owner.
 */
- (void)update:(NSDictionary *)state;

@end

NS_ASSUME_NONNULL_END
