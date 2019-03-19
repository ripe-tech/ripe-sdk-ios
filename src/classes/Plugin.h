#import "Observable.h"

@class Ripe;

NS_ASSUME_NONNULL_BEGIN

/**
 * Base class of a Ripe plugin.
 */
@interface Plugin : Observable

/**
 * The ripe instance that will use this plugin.
 */
@property (nonatomic, weak) Ripe * _Nullable owner;

/**
 * A map with options to configure the instance.
 */
@property (nonatomic) NSDictionary *options;

/**
 * Base constructor for Plugin instances.
 */
- (id)initWithOptions:(NSDictionary *)options;

/**
 * Registers this plugin to the provided Ripe instance.
 *
 * @param owner The Ripe instance to register to.
 */
- (void)register:(Ripe *)owner;

/**
 * Unregisters this plugin from its owner.
 */
- (void)unregister;

@end

NS_ASSUME_NONNULL_END
