#import "Visual.h"

NS_ASSUME_NONNULL_BEGIN

@interface Image : Visual

typedef NSDictionary *(^InitialsBuilder)(NSString *initials, NSString *engraving, UIImageView *image);

@property BOOL showInitials;
@property InitialsBuilder initialsBuilder;
@property NSString *initials;
@property NSString *engraving;
@property NSString *url;
@property (nonatomic, weak) UIImageView *imageView;

-(id)initWithImageView:(UIImageView *)imageView owner:(Ripe *)owner options:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
