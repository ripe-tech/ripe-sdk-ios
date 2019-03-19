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

/// Represents a customizable model.
@interface Ripe : Observable <RipeAPI, BrandAPI, BuildAPI, SizeAPI>

/// The API instance to be used.
@property BaseAPI *api;

/// The brand of the model-
@property NSString *brand;

/// The name of the model.
@property NSString *model;

/// A map with options to customise the Ripe instance.
@property NSDictionary *options;

/// A list of Interactable instances that represent this Ripe instance.
@property NSMutableArray *children;

/// A list with all the customization changes.
@property NSMutableArray *history;

/// An index indicating the current point in the customization history. Used for undo and redo operations.
@property int historyPointer;

/// The current initials of the model.
@property NSString *initials;

/// The current engraving of the model.
@property NSString *engraving;

/// The variant of the model.
@property NSString *variant;

/// The current customization of the model.
@property NSMutableDictionary *parts;

/// The configuration information of the current model.
@property NSDictionary *loadedConfig;

/// The country where the model will be delivered.
@property NSString *country;

/// The currency to use when calculating the price.
@property NSString *currency;

/// The default locale to use when localizing values.
@property NSString *locale;

/// A specific attribute of the model.
@property NSString *flag;

/// If the instance is ready for interactions.
@property BOOL ready;

/// If the default parts of the model should be used when no initials parts are set.
@property BOOL useDefaults;

/// If the price should be automatically retrieved whenever there is a customization change.
@property BOOL usePrice;

/**
 * Constructs a Ripe instance without an initial brand and model.
 * The **options** map supports the following keys:
 *  - **variant** - The variant of the model.
 *  - **parts** - The initial parts of the model.
 *  - **country** - The country where the model will be sold.
 *  - **currency** - The currency that should be used to calculate the price.
 *  - **locale** - The locale to be used by default when localizing values.
 *  - **flag** - A specific attribute of the model.
 *  - **useDefaults** - If the default parts of the model should be used when no initials parts are set.
 *  - **usePrice** - If the price should be automatically retrieved whenever there is a customization change.
 *  - **plugins** - A list of plugins to be registered to the Ripe instance.
 *
 * @param options A map with options to configure the Ripe instance.
 * @return The Ripe instance created.
 */
- (id)initWithOptions:(NSDictionary *)options;

/**
 * Constructs a Ripe instance with the provided brand and model.
 *
 * @param brand The brand of the model.
 * @param model The name of the model.
 * @return The Ripe instance created.
 */
- (id)initWithBrand:(NSString *)brand model: (NSString *)model;

/**
 * Constructs a Ripe instance without an initial brand and model.
 * The **options** map supports the following keys:
 *  - **variant** - The variant of the model.
 *  - **parts** - The initial parts of the model.
 *  - **country** - The country where the model will be sold.
 *  - **currency** - The currency that should be used to calculate the price.
 *  - **locale** - The locale to be used by default when localizing values.
 *  - **flag** - A specific attribute of the model.
 *  - **useDefaults** - If the default parts of the model should be used when no initials parts are set.
 *  - **usePrice** - If the price should be automatically retrieved whenever there is a customization change.
 *  - **plugins** - A list of plugins to be registered to the Ripe instance.
 *
 * @param brand The brand of the model.
 * @param model The name of the model.
 * @param options A map with options to configure the Ripe instance.
 * @return The Ripe instance created.
 */
- (id)initWithBrand:(NSString *)brand model: (NSString *)model options:(NSDictionary *)options;

/**
 * Sets the model to be customised.
 *
 * @param brand The brand of the model.
 * @param model The name of the model.
 * @return A Promise that will resolve when the configuration of the new model has finished.
 */
- (Promise *)config:(NSString *)brand model: (NSString *)model;

/**
 * Sets the model to be customised.
 * The **options** map supports the following keys:
 *  - **variant** - The variant of the model.
 *  - **parts** - The initial parts of the model.
 *  - **country** - The country where the model will be sold.
 *  - **currency** - The currency that should be used to calculate the price.
 *  - **locale** - The locale to be used by default when localizing values.
 *  - **flag** - A specific attribute of the model.
 *  - **useDefaults** - If the default parts of the model should be used when no initials parts are set.
 *  - **usePrice** - If the price should be automatically retrieved whenever there is a customization change.
 *
 * @param brand The brand of the model.
 * @param model The name of the model.
 * @param options A map with options to configure the Ripe instance.
 * @return A Promise that will resolve when the configuration of the new model has finished.
 */
- (Promise *)config:(NSString *)brand model: (NSString *)model options:(NSDictionary *)options;

/**
 * Sets the model to be customised.
 * The **options** map supports the following keys:
 *  - **variant** - The variant of the model.
 *  - **parts** - The initial parts of the model.
 *  - **country** - The country where the model will be sold.
 *  - **currency** - The currency that should be used to calculate the price.
 *  - **locale** - The locale to be used by default when localizing values.
 *  - **flag** - A specific attribute of the model.
 *  - **useDefaults** - If the default parts of the model should be used when no initials parts are set.
 *  - **usePrice** - If the price should be automatically retrieved whenever there is a customization change.
 *
 * @param brand The brand of the model.
 * @param model The name of the model.
 * @param options A map with options to configure the Ripe instance.
 * @param callback A callback that will be called when the configuration of the new model has finished.
 * @return A Promise that will resolve when the configuration of the new model has finished.
 */
- (Promise *)config:(NSString *)brand model: (NSString *)model options:(NSDictionary *)options callback: (void(^_Nullable)(NSDictionary * _Nullable))callback;
/**
 * Changes the customization of a part.
 *
 * @param part The part to be changed.
 * @param material The material to change to.
 * @param color The color to change to.
 */
- (void)setPart:(NSString *)part material:(NSString * _Nullable)material color:(NSString * _Nullable)color;

/**
 * Changes the customization of a part.
 *
 * @param part The part to be changed.
 * @param material The material to change to.
 * @param color The color to change to.
 * @param noEvents If the parts events shouldn't be triggered (defaults `False`).
 */
- (void)setPart:(NSString *)part material:(NSString * _Nullable)material color:(NSString * _Nullable)color noEvents:(BOOL)noEvents;

/**
 * Changes the customization of a part.
 *
 * @param part The part to be changed.
 * @param material The material to change to.
 * @param color The color to change to.
 * @param noEvents If the parts events shouldn't be triggered (defaults `False`).
 * @param options A map with options to configure the operation (for internal use).
 */
- (void)setPart:(NSString *)part material:(NSString * _Nullable)material color:(NSString * _Nullable)color noEvents:(BOOL)noEvents options:(NSDictionary *)options;

/**
* Allows changing the customization of a set of parts in bulk.
*
* @param parts A NSDictionary with a set of parts to be changed.
* @param noEvents If the parts events shouldn't be triggered (defaults `False`).
*/
- (void)setParts:(NSDictionary *)parts noEvents:(BOOL)noEvents;

/**
 * Allows changing the customization of a set of parts in bulk.
 *
 * @param parts A NSDictionary with a set of parts to be changed.
 * @param noEvents If the parts events shouldn't be triggered (defaults `False`).
 * @param options A map with options to configure the operation (for internal use).
 */
- (void)setParts:(NSDictionary *)parts noEvents:(BOOL)noEvents options:(NSDictionary *)options;

/**
 * Allows changing the customization of a set of parts in bulk.
 *
 * @param partsList A NSArray with a set of parts to be changed.
 */
- (void)setPartsList:(NSArray *)partsList;

/**
 * Allows changing the customization of a set of parts in bulk.
 *
 * @param partsList A NSArray with a set of parts in triplet form to be changed.
 * @param noEvents If the parts events shouldn't be triggered (defaults `False`).
 */
- (void)setPartsList:(NSArray *)partsList noEvents:(BOOL)noEvents;

/**
 * Allows changing the customization of a set of parts in bulk.
 *
 * @param partsList A NSArray with a set of parts in triplet form to be changed.
 * @param noEvents If the parts events shouldn't be triggered (defaults `False`).
 * @param options A map with options to configure the operation (for internal use).
 */
- (void)setPartsList:(NSArray *)partsList noEvents:(BOOL)noEvents options:(NSDictionary *)options;

/**
 * Changes the personalization of the model.
 *
 * @param initials The initials to be set.
 * @param engraving The engraving to be set.
 *
 */
- (void)setInitials:(NSString *)initials engraving: (NSString *)engraving;

/**
 * Changes the personalization of the model.
 *
 * @param initials The initials to be set.
 * @param engraving The engraving to be set.
 * @param noUpdate If the update operation shouldn't be triggered (defaults `False`).
 *
 */
- (void)setInitials:(NSString *)initials engraving: (NSString *)engraving noUpdate: (BOOL)noUpdate;

/**
 * Binds an `Interactable` to this Ripe instance.
 *
 * @param interactable The `Interactable` instance to be bound to the Ripe instance.
 * @return The `Interactable` instance created.
 */
- (Interactable *)bindInteractable:(Interactable *)interactable;

/**
 * Binds an `Image` to this Ripe instance.
 *
 * @param imageView The `UIImageView` to be used by the Ripe instance.
 * @return The `Image` instance created.
 */
- (Image *)bindImage:(UIImageView *)imageView;

/**
 * Binds an `Image` to this Ripe instance.
 *
 * @param imageView The `UIImageView` to be used by the Ripe instance.
 * @param options A map with options to configure the Image instance.
 * @return The `Image` instance created.
 */
- (Image *)bindImage:(UIImageView *)imageView options:(NSDictionary *)options;

/**
 * Unbinds an `Interactable` from this Ripe instance.
 *
 * @param interactable The `Interactable` instance to be unbound.
 */
- (void)unbindInteractable:(Interactable *)interactable;

/**
 * Unbinds an `Image` from this Ripe instance.
 *
 * @param image The `Image` instance to be unbound.
 */
- (void)unbindImage:(Image *)image;

/**
 * Selects a part of the model. Triggers a "selected_part" event with the part.
 *
 * @param part The name of the part to be selected.
 */
- (void)selectPart:(NSString *)part;

/**
 * Selects a part of the model. Triggers a "selected_part" event with the part.
 *
 * @param part The name of the part to be selected.
 * @param options A map with options to configure the operation.
 */
- (void)selectPart:(NSString *)part options:(NSDictionary *)options;

/**
 * Deselects a part of the model. Triggers a "deselected_part" event with the part.
 *
 * @param part The name of the part to be selected.
 */
- (void)deselectPart:(NSString *)part;

/**
 * Deselects a part of the model. Triggers a "deselected_part" event with the part.
 *
 * @param part The name of the part to be selected.
 * @param options A map with options to configure the operation.
 */
- (void)deselectPart:(NSString *)part options:(NSDictionary *)options;

/**
 * Reverses the last change to the parts. It is possible
 * to undo all the changes done from the initial state.
 */
- (void)undo;

/**
 * Reapplies the last change to the parts that was undone.
 * Notice that if there's a change when the history pointer
 * is in the middle of the stack the complete stack forward
 * is removed (history re-written).
 */
- (void)redo;

/**
 * Indicates if there are part changes to undo.
 *
 * @return If there are changes to reverse in the
 * current parts history stack.
 */
- (BOOL)canUndo;

/**
 * Indicates if there are part changes to redo.
 *
 * @return If there are changes to reapply pending
 * in the history stack.
 */
- (BOOL)canRedo;

/**
 * Triggers the update of the children so that they represent the current state of the model.
 */
- (void)update;

/**
 * Triggers the update of the children so that they represent the current state of the model.
 *
 * @param state A map with the current customization and personalization.
 */
- (void)update:(NSDictionary *)state;

@end

NS_ASSUME_NONNULL_END
