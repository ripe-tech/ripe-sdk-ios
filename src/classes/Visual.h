#import "Interactable.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * This is a superclass for visual representations of a Ripe instance.
 */
@interface Visual : Observable <Interactable>

/**
 * A map with options to configure the instance.
 */
@property (nonatomic) NSDictionary *options;

/**
 * Base constructor for Visual instances.
 *
 * @param owner The Ripe instance to be represented.
 * @param options A map with options to configure the instance.
 * @return The Visual instance created.
 */
- (id)initWithOwner:(Ripe *)owner options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
