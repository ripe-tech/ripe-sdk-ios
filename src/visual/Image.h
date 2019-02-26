#import "Visual.h"

NS_ASSUME_NONNULL_BEGIN

@interface Image : Visual

@property (nonatomic, weak) UIImageView *imageView;

-(id)initWithImageView:(UIImageView *)imageView andOwner:(Ripe *)owner andOptions:(NSDictionary *)options;

@end

NS_ASSUME_NONNULL_END
