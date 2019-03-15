#import "Visual.h"

NS_ASSUME_NONNULL_BEGIN

/**
 * Reactively updates the image of an UIImageView whenever the state of its owner changes.
 * An Image can be configured with the following options:
 *
 * - **showInitials** - A *Boolean* indicating if the owner's personalization should be shown (defaults `TRUE`).
 * - **initialsBuilder** - A method that receives the *initials* and *engraving* as Strings and the ImageView that will be used and returns a map with the initials and a profile list (defaults the following method)
 *
 * ```
 *^NSDictionary *(NSString *initials, NSString *engraving, UIImageView *imageView) {
 *    NSString *initialsS = initials ?: @"";
 *    NSArray *profile = engraving != nil ? @[engraving] : @[];
 *    return @{
 *       @"initials": initialsS ?: @"",
 *       @"profile": profile
 *    };
 *};
 *```
 */
@interface Image : Visual

/**
 * Represents a method that returns a dictionary with initials and profiles for a given personalization.
 *
 * @param initials The initials of the personalization.
 * @param engraving The engraving of the personalization.
 * @param image The UIImageView where the personalization will be shown.
 * @return A Dictionary with the **initials** as NSString and **profile** as an NSArray of NSString.
 */
typedef NSDictionary *(^InitialsBuilder)(NSString *initials, NSString *engraving, UIImageView *image);

/**
 * A *Boolean* indicating if the owner's personalization should be shown (defaults to `TRUE`).
 */
@property BOOL showInitials;

/**
 * A method that returns a dictionary with initials and profiles for a given personalization.
 */
@property InitialsBuilder initialsBuilder;
/**
 * Initials to be shown. Overrides the owner's personalization.
 */
@property NSString *initials;
/**
 * Initials to be shown. Overrides the owner's personalization.
 */
@property NSString *engraving;
/**
 * The current URL of the image.
 */
@property NSString *url;
/**
 * The UIImageView where the image will be displayed.
 */
@property (nonatomic, weak) UIImageView *imageView;

/**
 * Constructor for an Image instance.
 *
 * @param imageView The UIImageView where the image will be displayed.
 * @param owner The Ripe instance that will be presented.
 * @param options An options map that allows the configuration of the Image instance.
 * @return The Image instance created.
 */
-(id)initWithImageView:(UIImageView *)imageView owner:(Ripe *)owner options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
